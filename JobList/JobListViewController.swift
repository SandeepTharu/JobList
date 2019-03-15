//
//  JobListViewController.swift
//  JobList
//
//  Created by TempAc on 3/15/19.
//  Copyright © 2019 TempAc. All rights reserved.
//

import UIKit

class JobListViewController: UIViewController {

    //MARK: properties
    var jobLists : [Job] = []
    let toJobDetailsSegueIdentifier = "toJobDetails"
    
    //MARK: outlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var jobListTable: UITableView!
    @IBOutlet weak var blurrView: UIVisualEffectView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: override functions
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getJobListings(params: "")
        self.setDelegates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toJobDetailsSegueIdentifier{
            let destinationVC = segue.destination as! JobDetailsViewController
            
            let selectedIndexPath = self.jobListTable.indexPathForSelectedRow
            let selectedJob = self.jobLists[(selectedIndexPath?.row)!]
            destinationVC.detailsURL = selectedJob.detailsUrl
        }
    }
    
    //MARK: actions
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        if !(self.searchTextField.text?.isEmpty)!{
            let replacedString = self.searchTextField.text!.replacingOccurrences(of: " ", with: "+")

        self.getJobListings(params: replacedString)
        }
    }
    
    
    //MARK: private functions
    private func setDelegates(){
        jobListTable.dataSource = self
        jobListTable.delegate = self

    }
    
    private func getJobListings(params : String){
        let api = JobsAPI()
        self.spinActivityIndicator(spin: true)
        api.getJobListings(params: params, successBlock: { (joblist) in
           self.jobLists = joblist
            DispatchQueue.main.async {
                self.jobListTable.reloadData()
                self.spinActivityIndicator(spin: false)
            }
        }) { (errorMessage) in
            print(errorMessage)
            DispatchQueue.main.async {
                self.spinActivityIndicator(spin: false)

            }
        }
    }
    
    private func spinActivityIndicator(spin : Bool){
        self.activityIndicator.isHidden = !spin
        self.blurrView.isHidden = !spin
        if spin{
            self.activityIndicator.startAnimating()
        }else{
            self.activityIndicator.stopAnimating()
        }
    }
    

}

extension JobListViewController : UITableViewDataSource, UITableViewDelegate{
    
    //MARK: table view datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "JobListTableViewCell") as! JobListTableViewCell
        tableCell.populateCell(job: self.jobLists[indexPath.row])
        return tableCell
    }
    
    //MARK: table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: toJobDetailsSegueIdentifier, sender: nil)
    }
}
