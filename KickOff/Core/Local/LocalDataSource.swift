//
//  LocalDataSource.swift
//  KickOff
//
//  Created by Abdelrahman on 30/05/2025.
//

import Foundation
import CoreData
import UIKit

class LocalDataSource{
    
    static let instance = LocalDataSource()
    
    private let context: NSManagedObjectContext
       
       private init() {
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           context = appDelegate.persistentContainer.viewContext
       }
    
    
    
    func addLeague(_ league: LocalLeague) {
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeague")
           fetchRequest.predicate = NSPredicate(format: "league_key == %d", league.league_key)
           
           do {
               let result = try context.fetch(fetchRequest)
               if result.isEmpty {
                   let entity = NSEntityDescription.entity(forEntityName: "FavLeague", in: context)!
                   let leagueObject = NSManagedObject(entity: entity, insertInto: context)
                   leagueObject.setValue(Int32(league.league_key), forKey: "league_key")
                   leagueObject.setValue(league.league_name, forKey: "league_name")
                   leagueObject.setValue(league.league_logo, forKey: "league_logo")
                   leagueObject.setValue(league.isFav, forKey: "isFav")
                   leagueObject.setValue(league.sport.rawValue, forKey: "sportType")
                   try context.save()
               }
           } catch {
               print("Failed to add league: \(error.localizedDescription)")
           }
       }
    
    
    func getFavLeagues() -> [LocalLeague] {
        let request = NSFetchRequest<NSManagedObject>(entityName: "FavLeague")
        request.predicate = NSPredicate(format: "isFav == %@", NSNumber(value: true))
        var leagues: [LocalLeague] = []
        
        do {
            let results = try context.fetch(request)
            for obj in results {
                let league = LocalLeague(
                    league_key: Int(obj.value(forKey: "league_key") as? Int32 ?? 0),
                    league_name: obj.value(forKey: "league_name") as? String ?? "",
                    league_logo: obj.value(forKey: "league_logo") as? String ?? "",
                    isFav: obj.value(forKey: "isFav") as? Bool ?? false,
                    sport: SportType(rawValue: obj.value(forKey: "sportType") as? String ?? "") ?? .football
                )
                leagues.append(league)
            }
        } catch {
            print("Failed to fetch leagues: \(error.localizedDescription)")
        }

        return leagues
    }
    
    
    func removeLeague(byKey key: Int,completion:()->()) {
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeague")
           fetchRequest.predicate = NSPredicate(format: "league_key == %d", key)
           
           do {
               let result = try context.fetch(fetchRequest)
               for obj in result {
                   if let obj = obj as? NSManagedObject {
                       context.delete(obj)
                   }
               }
               try context.save()
               completion()
           } catch {
               print("Failed to remove league: \(error.localizedDescription)")
           }
       }
    
    
    func getAllLeagues() -> [LocalLeague] {
           let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavLeague")
           var leagues: [LocalLeague] = []

           do {
               let results = try context.fetch(fetchRequest)
               for obj in results {
                   let league = LocalLeague(
                       league_key: Int(obj.value(forKey: "league_key") as? Int32 ?? 0),
                       league_name: obj.value(forKey: "league_name") as? String ?? "",
                       league_logo: obj.value(forKey: "league_logo") as? String ?? "",
                       isFav: obj.value(forKey: "isFav") as? Bool ?? false,
                       sport: SportType(rawValue: obj.value(forKey: "sportType") as? String ?? "") ?? .football
                   )
                   leagues.append(league)
               }
           } catch {
               print("Failed to fetch leagues: \(error.localizedDescription)")
           }

           return leagues
       }
    
    
    func isFav(key: Int) -> Bool {
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavLeague")
           fetchRequest.predicate = NSPredicate(format: "league_key == %d AND isFav == true", key)
           
           do {
               let count = try context.count(for: fetchRequest)
               return count > 0
           } catch {
               print("Failed to check favorite status: \(error.localizedDescription)")
               return false
           }
       }
    
    
    
    
}
