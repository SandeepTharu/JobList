//
//  JobsAPI.swift
//  JobList
//
//  Created by TempAc on 3/15/19.
//  Copyright © 2019 TempAc. All rights reserved.
//

import Foundation

class JobsAPI : NSObject{
    
    func getJobListings(params : String,
                        successBlock : @escaping (_ jobs : [Job]) -> (),
                        failureBlock : @escaping (_ errorMessage : String) -> ()
        ){
        
        
        let urlString = "https://jobs.search.gov/jobs/search.json?query=\(params)"
        let url = URL(string : urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                let dataArray = json as! NSArray
                
                if dataArray.count == 0{
                    failureBlock("Could not find job according to search text.")
                }else{
                   
                    var jobList : [Job] = []
                    
                    for data in dataArray{
                        let jobDict = data as! NSDictionary
                        let job = Job(dict: jobDict)
                        jobList.append(job)
                    }
                    
                    successBlock(jobList)
                }
                
            }catch{
                print("error")
            }
        }
        task.resume()
        
    }
}
