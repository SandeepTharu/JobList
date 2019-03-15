//
//  Job.swift
//  JobList
//
//  Created by TempAc on 3/15/19.
//  Copyright © 2019 TempAc. All rights reserved.
//

import Foundation

class Job : NSObject{
    
    //MARK: outlets
    var id : String?
    var jobTitle : String?
    var organization : String?
    var date : String?
    var locations : [String] = [""]
    var detailsUrl : String?
    
    //MARK: initialization
    init(dict : NSDictionary) {
        id = dict["id"] as? String
        jobTitle = dict["position_title"] as? String
        organization = dict["organization_name"] as? String
        
        if let dateInString = dict["start_date"] as? String{
            date = convertDate(dateString: dateInString)
        }
        
        if let locationArray = dict["locations"] as? [String]{
            locations.removeAll()
            for singleLocation in locationArray{
                locations.append(singleLocation)
            }
        }
        detailsUrl = dict["url"] as? String
    }
    
}


