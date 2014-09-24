//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, FilterViewControllerDelegate {
    var client: YelpClient!
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "tV5P2vNd5sfezo9Zg5ehJQ"
    let yelpConsumerSecret = "NOFcGIHf-If1VJQu8XZgfXV0xOg"
    let yelpToken = "IkhVgqrQxnvpPYJKTDZl2MvhOAQTUpjO"
    let yelpTokenSecret = "riI7XSxllbE3L2I7Oj_A2JjBLCo"
    
    var searchBar:UISearchBar = UISearchBar(frame: CGRectZero)
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    
    var searchResults: NSArray?
    var imageCache = [String : UIImage]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var errorValue: NSError? = nil
        
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.text = "sushi"
        self.filterBarButton.title = "Filter"
        self.filterBarButton.style = .Plain
        
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        self.doSearch(searchBar.text, options: NSDictionary())
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        println("about to call segue")
//        println(sender)
//        println(segue)
    }

    func doSearch(query: String, options: NSDictionary) {
        client.searchWithTerm(query, options: options, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("got a response")
            
            let dictionary = JsonHelper.JSONParseDict(JsonHelper.JSONStringify(response))
            self.searchResults = (dictionary["businesses"] as? NSArray)
            self.searchResultsTableView!.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    func searchBarSearchButtonClicked( searchBar: UISearchBar!)
    {
        println("searching \(searchBar.text)")
        self.doSearch(searchBar.text, options: NSDictionary())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults != nil {
            println(searchResults!.count)
            return searchResults!.count
        }
        println(0)
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("row")
        println(indexPath.row)
        let cell = searchResultsTableView.dequeueReusableCellWithIdentifier("com.codepath.yelpclient.searchresulttableviewcell") as SearchResultTableViewCell
        
        let searchResult = SearchResultModel(fromNSDictionary: self.searchResults![indexPath.row] as NSDictionary)
        
        cell.addressLabelView.text = searchResult.address
        cell.addressLabelView.sizeToFit()
        cell.businessNameLabelView.text = searchResult.name
        cell.businessNameLabelView.sizeToFit()
        cell.categoriesLabelView.text = ", ".join(searchResult.categories)
        
        println("displaying \(searchResult.name) at \(indexPath)")
        
        var image = self.imageCache[searchResult.imageUrl]
//
        if( image == nil ) {
            // If the image does not exist, we need to download it
            var imgURL: NSURL = NSURL(string: searchResult.imageUrl)
            
            // Download an NSData representation of the image at the URL
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    image = UIImage(data: data)
                    
                    // Store the image in to our cache
                    self.imageCache[searchResult.imageUrl] = image
                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                        cellToUpdate.imageView?.image = image
                        self.searchResultsTableView!.reloadData()
                    }
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) {
                    cellToUpdate.imageView?.image = image
                }
            })
        }
        
        return cell
    }
    
    func filtersSet(controller: FilterViewController, sortBy: Int, radius: Int, deals: Bool) {
        let options = NSMutableDictionary()
        options["sort"] = sortBy
        options["radius"] = radius
        options["deals"] = deals
    }
}

