//
//  PomodoroService.swift
//  PomodoroApp
//
//  Created by Douglas Taquary on 28/08/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import Foundation
import CoreData

public struct Section {
    var name: String
    var items: [NSManagedObject]
}


@available(iOS 10.0, *)
public struct PomodoroService: PomodoroRepository {

    public enum Error: Swift.Error {
        case unableToSave
        case nothingError
    }
    
    var currentSamples: [NSManagedObject] = []
    
    var sections: [Section] = [Section(name: "Today", items: []),
                               Section(name: "Yesterday", items: [])]
    
    let managedContext = DatabaseManager().persistentContainer.viewContext

    
    //MARK: Fetch
    
    public mutating func fetch(_ completion: @escaping ([Section]) -> Void) {
        
        clearSections()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pomodoro")

        do{
            
            let samples = try managedContext.fetch(fetchRequest)
            
            currentSamples = samples as! [NSManagedObject]
            
            for sample in currentSamples {
                
                guard let newDate = sample.value(forKey: "relativeTime") as? Date else { return }
            
                if Date().isToday(to: newDate) {
                    
                    sections[0].items.append(sample)
                    
                } else {
                    
                    sections[1].items.append(sample)
                }
            }

        } catch {
           
            fatalError("Error is retriving titles items")
        }

        completion(sections)
    }
    
    
    mutating func clearSections() {
        sections[0].items.removeAll()
        sections[1].items.removeAll()
    }
    
    
    //MARK: Save
    
    public func save(_ object: Sample,
              completion: @escaping (_ error: Swift.Error?) -> Void) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Pomodoro", in: managedContext)!
        let sample = NSManagedObject(entity: entity, insertInto: managedContext)

        let dateNow = Date()
        
        print(dateNow)

        sample.setValue(object.newTimer, forKey: "timer")
        sample.setValue(dateNow, forKey: "relativeTime")
        sample.setValue(object.newState, forKey: "state")
        
        do {
            
            try managedContext.save()

        } catch let error as NSError {
            
            print("Could not save. \(error), \(error.userInfo)")
            
        }

        completion(Error.nothingError)
    }
}

