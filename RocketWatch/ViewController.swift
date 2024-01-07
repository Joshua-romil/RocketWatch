//
//  ViewController.swift
//  TestGraphQL
//
//  Created by Joshua George on 2022-11-30.
//  The purpose of the app is to learn more about the whole process of publishing and
//  creating iOS-apps. 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var launchTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //var launchViewModel: LaunchViewModel = LaunchViewModel()
    var webViewController: WebViewController = WebViewController()
    
    private var appDelegate: AppDelegate {
           return UIApplication.shared.delegate as! AppDelegate
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        registerCell()
        fetchAPI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    private func fetchAPI(){
        self.loadingView.isHidden = false
        
        appDelegate.launchViewModel.delegate = self
        appDelegate.rocketViewModel.delegate = self
        appDelegate.launchViewModel.fetchLaunchList()
        appDelegate.rocketViewModel.fetchRocketList()
    }
    
    private func registerCell(){
        self.launchTableView.register(UINib(nibName: "LaunchTableViewCell", bundle: nil), forCellReuseIdentifier: "LaunchTableViewCell")
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as? LaunchTableViewCell{
            cell.configureTableViewCellLabels(item: appDelegate.launchViewModel.launchList[indexPath.section])
            cell.configureTableViewCellImage(item: appDelegate.launchViewModel.launchList[indexPath.section])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let videoLinkFromSelectedCell = appDelegate.launchViewModel.launchList[indexPath.section].links?.videoLink
        let rockets = appDelegate.rocketViewModel.rocketsList
        
        let storyboard = UIStoryboard(name: "WebStoryboard", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()! as WebViewController
        vc.videoLink = videoLinkFromSelectedCell!
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return appDelegate.launchViewModel.launchList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

extension ViewController: LaunchViewModelDelegate{
    
    func didReceiveData() {
        self.loadingView.isHidden = true
        self.activityIndicator.stopAnimating()
        self.launchTableView.reloadData()
    }
    
    func didFail(errorMessage: String) {
        self.loadingView.isHidden = true
        debugPrint(errorMessage)
    }
    
    
}

