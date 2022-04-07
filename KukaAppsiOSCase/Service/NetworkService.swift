//
//  NetworkService.swift
//  KukaAppsiOSCase
//
//  Created by Veysel Bozkurt on 7.04.2022.
//

import Foundation
import Alamofire

enum ServiceType: String {
    case pilot = "drivers"
    case pilotInfo = "driverDetail/"
}

//      https://my-json-server.typicode.com/oguzayan/kuka/ drivers
//      https://my-json-server.typicode.com/oguzayan/kuka/ driverDetail/2

class NetworkService {
    
    let baseUrl = "https://my-json-server.typicode.com/oguzayan/kuka/"
    
    
    func getFormulaPilots(service: ServiceType, completion: @escaping([Pilot]?, String?) -> Void) {
        
        let endUrl = baseUrl + service.rawValue
        
        let request = AF.request(endUrl)
        request.validate().responseDecodable(of: FormulaPilots.self) { response in
            switch response.result{
            case .success(let pilotsf):
                completion(pilotsf.items, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func getPilotInfo(pilotID: String, service: ServiceType, completion: @escaping(PilotInfo?, String?) -> Void) {
        
        let endUrl = baseUrl + service.rawValue + pilotID
        
        let request = AF.request(endUrl)
        request.validate().responseDecodable(of: PilotInfo.self) { response in
            
            switch response.result{
            case .success(let pilotInfo):
                completion(pilotInfo, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    
    
}
