//
//  ViewController.swift
//  CoreDataRelationship
//
//  Created by Palanichamy Padmanabhan on 17/08/18.
//  Copyright © 2018 Palanichamy Padmanabhan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnOneToOneClicked(_ sender: UIButton) {
        let context = appDelegate.persistentContainer.viewContext
        
        let person = Person(context: context)
        person.firstName = "John"
        person.lastName = "Doe"
        
        let phone = Phone(context: context)
        phone.brand = "Apple"
        phone.model = "iPhone-X"
        phone.os = "iOS"
        person.phone = phone
        
        do {
            try context.save()
        }
        catch
        {
            print("Failed")
        }
    }
    
    @IBAction func OneToManyClicked(_ sender: UIButton) {
        let context = appDelegate.persistentContainer.viewContext
        
        let person = Person(context: context)
        person.firstName = "John"
        person.lastName = "Doe"
        
        let friend1 = Friends(context: context)
        friend1.firstName = "Friend"
        friend1.lastName = "One"
        person.addToFriends(friend1)
        
        let friend2 = Friends(context: context)
        friend2.firstName = "Friend"
        friend2.lastName = "Two"
        person.addToFriends(friend2)
        
        do {
            try context.save()
        }
        catch {
            print("Failed")
        }
    }
    @IBAction func btnFetchClicked(_ sender: UIButton) {
        let request1 = NSFetchRequest<NSFetchRequestResult>(entityName:"Person")
        do {
            let context = appDelegate.persistentContainer.viewContext
            let result1 = try context.fetch(request1)
            for data in result1 as! [NSManagedObject]
            {
                print(data.value(forKey: "firstName") as! String)
                print(data.value(forKey: "lastName") as! String)
            }
        }
        catch {
            print("Failed fetching")
        }
        
        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName:"Phone")
        do {
            let context = appDelegate.persistentContainer.viewContext
            let result2 = try context.fetch(request2)
            for data in result2 as! [NSManagedObject]
            {
                print(data.value(forKey: "brand") as! String)
                print(data.value(forKey: "model") as! String)
                print(data.value(forKey: "os") as! String)
            }
        }
        catch {
            print("Failed fetching")
        }
        
        let request3 = NSFetchRequest<NSFetchRequestResult>(entityName:"Friends")
        do {
            let context = appDelegate.persistentContainer.viewContext
            let result3 = try context.fetch(request3)
            for data in result3 as! [NSManagedObject]
            {
                print(data.value(forKey: "firstName") as! String)
                print(data.value(forKey: "lastName") as! String)
            }
        }
        catch {
            print("Failed fetching")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

