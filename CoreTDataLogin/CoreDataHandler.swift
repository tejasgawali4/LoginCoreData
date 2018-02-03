//
//  CoreDataHandler.swift
//  CoreTDataLogin
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {

    private class func getContext()  -> NSManagedObjectContext{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(username: String, password: String) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "UserInfo", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(username, forKey: "username")
        manageObject.setValue(password, forKey: "password")
        
        do{
            try context.save()
            return true
        }catch
        {
            return false
        }
    }
    
    class func fetchObject() -> [UserInfo]?
    {
        let context = getContext()
        var User:[UserInfo]? = nil
        do{
            User = try context.fetch(UserInfo.fetchRequest())
            return User
        }catch{
            return User
        }
    }
    
    class func searchdata(username: String) -> [UserInfo]? {
        let context = getContext()
        let fetchRQ : NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        var User:[UserInfo]? = nil
        
        let predicate = NSPredicate(format: "username contains[c] %@", username)
        fetchRQ.predicate = predicate
        
        do{
            User = try context.fetch(fetchRQ)
            return User
        }catch{
            return User
        }
    }
    
    
}
