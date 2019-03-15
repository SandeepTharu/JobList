//
//  JobListTableViewCell.swift
//  JobList
//
//  Created by TempAc on 3/15/19.
//  Copyright © 2019 TempAc. All rights reserved.
//

import UIKit

class JobListTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var organizationName: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var location: UILabel!
    
    //MARK: override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: private functions
    func populateCell(job : Job){
        
        self.jobTitle.text = job.jobTitle != nil ? job.jobTitle! : "n/a"
        self.organizationName.text = job.organization != nil ? job.organization! : "n/a"
        self.postedDate.text = job.date != nil ? "Posted On : " + job.date! : "Posted On : n/a"
        self.location.text =  "Location : " + job.locations.joined(separator: ", ")
    }
}
