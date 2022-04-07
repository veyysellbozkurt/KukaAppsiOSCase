//
//  PilotsCustomCell.swift
//  KukaAppsiOSCase
//
//  Created by Veysel Bozkurt on 7.04.2022.
//

import UIKit
import CoreData

class PilotsCustomCell: UITableViewCell {

    
    @IBOutlet weak var pilotName: UILabel!
    @IBOutlet weak var pilotPoint: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var defPilot: Pilot!
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLabels()
    }
    
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        sender.bounceButton()
                
        if isPilotFavorite(pilot: defPilot) {
            removeFromFavorites(pilot: defPilot)
        } else{
            addToFavorites(pilot: defPilot)
        }
                
        if favoritesButton.currentImage == UIImage(systemName: "heart") {
            favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    func setupCell(pilot: Pilot) {
        defPilot = pilot
        pilotName.text = pilot.name
        pilotPoint.text = "\(pilot.point!)"
        if isPilotFavorite(pilot: defPilot) {
            favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func configureLabels(){
        favoritesButton.setTitle("", for: .normal)
    }
    
    
    
    
    //    MARK: - CoreData
    func isPilotFavorite(pilot: Pilot) -> Bool {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PilotLocalData")
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(pilot.id!)")

        if let results = try? managedContext.fetch(fetchRequest) {
            for item in results {
                if item.value(forKey: "isFavorite") as! Bool {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }
    
    func addToFavorites(pilot: Pilot){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PilotLocalData", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        item.setValue(pilot.id, forKey: "id")
        item.setValue(true, forKey: "isFavorite")
        
        do {
            try managedContext.save()
        } catch let error {
            print("Datas couldn't be saved: \(error.localizedDescription)")
        }
    }
    
    func removeFromFavorites(pilot: Pilot){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PilotLocalData")
        fetchRequest.predicate = NSPredicate(format: "id=='\(pilot.id!)'")
        if let results = try? managedContext.fetch(fetchRequest){
            for item in results{
                managedContext.delete(item)
            }
            do{
                try managedContext.save()
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}
