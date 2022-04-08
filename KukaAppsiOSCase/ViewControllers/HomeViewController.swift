//
//  ViewController.swift
//  KukaAppsiOSCase
//
//  Created by Veysel Bozkurt on 7.04.2022.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    @IBOutlet weak var pilotsTableView: UITableView!
    
    var networkService = NetworkService()
    var homeViewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchPilots()
    }

    func configureTableView() {
        pilotsTableView.delegate = self
        pilotsTableView.dataSource = self
        pilotsTableView.register(PilotsCustomCell.nib, forCellReuseIdentifier: PilotsCustomCell.identifier)
    }
    
    
    func fetchPilots(){
        networkService = NetworkService()
        homeViewModel.getPilots(networkService: networkService) {
            DispatchQueue.main.async {
                self.pilotsTableView.reloadData()
            }
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.pilots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PilotsCustomCell.identifier, for: indexPath) as? PilotsCustomCell else {
            fatalError("xib doesn't exist")
        }
        cell.setupCell(pilot: homeViewModel.pilots[indexPath.row])
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "detailScreen") as! PilotDetailViewController
        detailVC.pilotID = String(homeViewModel.pilots[indexPath.row].id!)
        detailVC.pilotNameText = homeViewModel.pilots[indexPath.row].name!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * 0.0725
    }
   
   
    
    
    
    
}
