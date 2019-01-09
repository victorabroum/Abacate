//
//  PlayerDAO.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 08/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PlayerDAO{
    private static var appDelegate:AppDelegate?
    private static var context:NSManagedObjectContext?
    private static var entityKeys:NSEntityDescription?
    private static var entityAchviements:NSEntityDescription?
    private static var entityStatus:NSEntityDescription?
    
    private static func getInstanceContext() -> NSManagedObjectContext{
        if(appDelegate == nil){
            appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            context = appDelegate?.persistentContainer.viewContext
        }
        return context!
    }
    
    //MARK:ENTITIES
    private static func getInstanceEntityKeys() -> NSEntityDescription{
        if(entityKeys == nil){
            entityKeys = NSEntityDescription.entity(forEntityName: "Keys", in: getInstanceContext())
        }
        return entityKeys!
    }
    private static func getInstanceEntityAchviements() -> NSEntityDescription{
        if(entityAchviements == nil){
            entityAchviements = NSEntityDescription.entity(forEntityName: "Achviement", in: getInstanceContext())
        }
        return entityAchviements!
    }

    private static func getInstanceEntityStatus() -> NSEntityDescription{
        if(entityAchviements == nil){
            entityStatus = NSEntityDescription.entity(forEntityName: "Status", in: getInstanceContext())
        }
        return entityStatus!
    }
    //MARK:ADDS
    
    static func addKey(key:String){
        let newUser = NSManagedObject(entity: getInstanceEntityKeys(), insertInto: getInstanceContext())
        newUser.setValue(key, forKey: "name")
        do {
            try getInstanceContext().save()
        } catch {
            print("Failed saving")
        }
    }
    
    static func addAchviement(key:String){
        let newUser = NSManagedObject(entity: getInstanceEntityAchviements(), insertInto: getInstanceContext())
        newUser.setValue(key, forKey: "name")
        do {
            try getInstanceContext().save()
        } catch {
            print("Failed saving")
        }
    }
    
    static func addStatus(status:PlayerStatus){
        if(getStatus().count==0){
            let newUser = NSManagedObject(entity: getInstanceEntityStatus(), insertInto: getInstanceContext())
            newUser.setValue(status.bom, forKey: "bom")
            newUser.setValue(status.medio, forKey: "medio")
            newUser.setValue(status.ruim, forKey: "ruim")
            do {
                try getInstanceContext().save()
            } catch {
                print("Failed saving")
            }
        }
    }
    
    //MARK:GETS
    
    static func getKeys()->[String]{
        
        var lista = Array<String>()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Keys")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try getInstanceContext().fetch(request)
                        for data in result as! [NSManagedObject] {
                            lista.append(data.value(forKey: "name") as! String)
                        }
        
        } catch {
            print("Failed")
        }
        return lista
    }

    static func getAchviements() -> [String]{
        var lista = Array<String>()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Achviement")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try getInstanceContext().fetch(request)
            for data in result as! [NSManagedObject] {
                lista.append(data.value(forKey: "name") as! String)
            }
        } catch {
            print("Failed")
        }
        return lista
    }
    
    static func getStatus() -> [PlayerStatus]{
        var lista = Array<PlayerStatus>()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try getInstanceContext().fetch(request)
            for data in result as! [NSManagedObject] {
                let s = PlayerStatus(bom:data.value(forKey: "bom") as! Float,medio:data.value(forKey: "medio") as! Float,ruim:data.value(forKey: "ruim") as! Float)
                lista.append(s)
            }
        } catch {
            print("Failed")
        }
        if(lista.isEmpty){
            lista.append(PlayerStatus(bom:0,medio:0,ruim:0))
        }
        return lista
    }
    //MARK:DELETES
    static func deleteAllKeys(){
        
        print("DELETE")
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Keys")
            //request.predicate = NSPredicate(format: "age = %@", "12")
            request.returnsObjectsAsFaults = false
            do {
                let result = try getInstanceContext().fetch(request)
                for data in result as! [NSManagedObject] {
                    getInstanceContext().delete(data)
                }
            } catch {
                print("Failed")
            }
    }
    static func deleteAllAchviements(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Achviement")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try getInstanceContext().fetch(request)
            for data in result as! [NSManagedObject] {
                getInstanceContext().delete(data)
            }
        } catch {
            print("Failed")
        }
    }
    static func deleteAllStatus(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try getInstanceContext().fetch(request)
            for data in result as! [NSManagedObject] {
                getInstanceContext().delete(data)
            }
        } catch {
            print("Failed")
        }
    }
    static func deleteEverything(){
        deleteAllKeys()
        deleteAllStatus()
        deleteAllAchviements()
    }
    static func updateStatus(status:PlayerStatus){
        if(getStatus().count==0){
            addStatus(status: PlayerStatus(bom:0,medio:0,ruim:0))
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Status")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try getInstanceContext().fetch(request)
            let data = result as! [NSManagedObject]
            let s = data[0]
            s.setValue(status.bom, forKey: "bom")
            s.setValue(status.medio, forKey: "medio")
            s.setValue(status.ruim, forKey: "ruim")
            do{
                try getInstanceContext().save()
            }
        } catch {
            print("Failed")
        }
    }
}

