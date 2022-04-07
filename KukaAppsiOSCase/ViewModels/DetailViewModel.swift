//
//  DetailViewModel.swift
//  KukaAppsiOSCase
//
//  Created by Veysel Bozkurt on 7.04.2022.
//

import Foundation

class DetailViewModel {
    
    var networkService: NetworkService!
    var pilotInfo: PilotInfo!
    
    func getPilots(pilotID: String, networkService: NetworkService, completion: @escaping() -> ()) {
        
        self.networkService = networkService
        networkService.getPilotInfo(pilotID: pilotID, service: .pilotInfo) { pilotInfo, error in
            guard let pilotInfo = pilotInfo else {
                return
            }
            self.pilotInfo = pilotInfo
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    
    
}
