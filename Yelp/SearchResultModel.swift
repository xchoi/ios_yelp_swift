//
//  SearchResultModel.swift
//  Yelp
//
//  Created by Alex Choi on 9/20/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import Foundation

class SearchResultModel {
    var rawHash: NSDictionary
    var name: String
    var address: String
    var categories: [String]
    var imageUrl: String
    
    init(fromNSDictionary dictionary: NSDictionary) {
        rawHash = dictionary
        name = rawHash["name"] as String
        address = ""
        if let locationHash = rawHash["location"] as? NSDictionary {
            if let addressArray = locationHash["address"] as? NSArray {
                if addressArray.count > 0 {
                    address = addressArray[0] as String
                }
            }
        }
//        let categoryNsArray = rawHash["categories"] as? NSArray ?? []
        categories = []
//        for (object) in categoryNsArray {
//            categories.append(object as String)
//        }
        self.imageUrl = rawHash["image_url"] as String
    }

}

//import Foundation
//
//class MovieModel {
//    var rawHash: NSDictionary
//    var title: String
//    var score: Int
//    var description: String
//    var rating: String
//    
//    init(fromNSDictionary dictionary: NSDictionary) {
//        rawHash = dictionary
//        title = rawHash["title"] as String
//        description = rawHash["synopsis"] as String
//        rating = rawHash["mpaa_rating"] as String
//        if let scoreHash = rawHash["score"] as? NSDictionary {
//            score = scoreHash["critics_score"] as Int
//        } else {
//            score = 0
//        }
//    }
//    
//    func criticsScore() -> NSString {
//        return String((rawHash["ratings"] as NSDictionary)["critics_score"] as NSInteger)
//    }
//    
//    func posterThumbnailUrl() -> NSString {
//        return String(((rawHash["posters"] as NSDictionary)["thumbnail"] as String).stringByReplacingOccurrencesOfString("tmb", withString: "ori"))
//    }
//    
//}

//[
//    {
//    "categories": [
//    [
//    "Local Flavor",
//    "localflavor"
//    ],
//    [
//    "Mass Media",
//    "massmedia"
//    ]
//    ],
//    "display_phone": "+1-415-908-3801",
//    "id": "yelp-san-francisco",
//    "is_claimed": true,
//    "is_closed": false,
//    "image_url": "http://s3-media2.ak.yelpcdn.com/bphoto/7DIHu8a0AHhw-BffrDIxPA/ms.jpg",
//    "location": {
//    "address": [
//    "140 New Montgomery St"
//    ],
//    "city": "San Francisco",
//    "country_code": "US",
//    "cross_streets": "3rd St & Opera Aly",
//    "display_address": [
//    "140 New Montgomery St",
//    "(b/t Natoma St & Minna St)",
//    "SOMA",
//    "San Francisco, CA 94105"
//    ],
//    "neighborhoods": [
//    "SOMA"
//    ],
//    "postal_code": "94105",
//    "state_code": "CA"
//    },
//    "mobile_url": "http://m.yelp.com/biz/4kMBvIEWPxWkWKFN__8SxQ",
//    "name": "Yelp",
//    "phone": "4159083801",
//    "rating_img_url": "http://media1.ak.yelpcdn.com/static/201012161694360749/img/ico/stars/stars_3.png",
//    "rating_img_url_large": "http://media3.ak.yelpcdn.com/static/201012161053250406/img/ico/stars/stars_large_3.png",
//    "rating_img_url_small": "http://media1.ak.yelpcdn.com/static/201012162337205794/img/ico/stars/stars_small_3.png",
//    "review_count": 3347,
//    "snippet_image_url": "http://s3-media2.ak.yelpcdn.com/photo/LjzacUeK_71tm2zPALcj1Q/ms.jpg",
//    "snippet_text": "Sometimes we ask questions without reading an email thoroughly as many of us did for the last event.  In honor of Yelp, the many questions they kindly...",
//    "url": "http://www.yelp.com/biz/yelp-san-francisco",
//    "menu_provider": "yelp",
//    "menu_date_updated": 1317414369
//    }
//    ],
