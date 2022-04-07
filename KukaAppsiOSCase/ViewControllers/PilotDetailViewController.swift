//
//  PilotDetailViewController.swift
//  KukaAppsiOSCase
//
//  Created by Veysel Bozkurt on 8.04.2022.
//

import UIKit
import Kingfisher

class PilotDetailViewController: UIViewController {

    
    @IBOutlet weak var pilotImage: UIImageView!
    @IBOutlet weak var pilotName: UILabel!
    @IBOutlet weak var pilotAge: UILabel!
    @IBOutlet weak var pilotTeam: UILabel!
    
    var pilotID: String!
    var pilotDetailViewModel = DetailViewModel()
    var networkService = NetworkService()
    var pilotInfo: PilotInfo!
    var pilotNameText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        fetchPilotInfo()
    }
    
    
    func fetchPilotInfo() {
        
        pilotDetailViewModel.getPilots(pilotID: pilotID, networkService: networkService) {
            DispatchQueue.main.async {
                self.pilotInfo = self.pilotDetailViewModel.pilotInfo
                self.setLabelTexts()
                self.setupPilotImage()
            }
        }
        
    }
    
    
    func setupPilotImage() {
        pilotImage.contentMode = .scaleAspectFill
        let url = pilotInfo.image
        let processor = DownsamplingImageProcessor(size: self.pilotImage.bounds.size)
        self.pilotImage.kf.setImage(with: URL(string: url!), placeholder: .none, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage], completionHandler: .none)
        pilotImage.kf.indicatorType = .activity
    }
    
    func setLabelTexts() {
        pilotName.text = pilotNameText
        pilotAge.text = "\(String(describing: pilotInfo.age!))"
        pilotTeam.text = pilotInfo.team
    }
    
    func configureViews(){
        pilotImage.layer.cornerRadius = 12
        pilotName.layer.cornerRadius = 12
        pilotTeam.layer.cornerRadius = 12
        pilotAge.layer.cornerRadius = 12
        
        pilotName.layer.masksToBounds = true
        pilotAge.layer.masksToBounds = true
        pilotTeam.layer.masksToBounds = true
        
        pilotName.backgroundColor = .systemGray4
        pilotTeam.backgroundColor = .systemGray4
        pilotAge.backgroundColor = .systemGray4
        pilotImage.backgroundColor = .systemGray4
    }
    
}
