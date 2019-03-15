//
//  Globals.swift
//  JobList
//
//  Created by TempAc on 3/15/19.
//  Copyright © 2019 TempAc. All rights reserved.
//

import Foundation

func convertDate(dateString : String) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    let date = formatter.date(from: dateString)
    formatter.dateFormat = "dd/MM/YYYY"
    let returnString = formatter.string(from: date!)
    
    return returnString
}
