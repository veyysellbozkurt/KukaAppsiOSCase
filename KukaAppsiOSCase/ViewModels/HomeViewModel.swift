//
//  HomeViewModel.swift
//  KukaAppsiOSCase
//
//  Created by Veysel Bozkurt on 7.04.2022.
//

import Foundation

class HomeViewModel {
    
    var netwokService: NetworkService!
    var pilots = [Pilot]()
    
    func getPilots(networkService: NetworkService, completion: @escaping() -> ()){
        self.netwokService = networkService
        networkService.getFormulaPilots(service: .pilot) { pilots, error in
            guard let pilots = pilots else {
                return
            }
            self.pilots += pilots
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
