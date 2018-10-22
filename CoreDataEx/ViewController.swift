//
//  ViewController.swift
//  CoreDataEx
//
//  Created by Yoga Pratama on 22/10/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController{
    
    var names: [String] = []
    var movList: [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title =  "Movie List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        
        do{
            movList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError{
            print("Error Fetching data . \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Name", message: "Add Movie  Name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                        style: .default){
        [unowned self] action in
                                        
        guard let textField = alert.textFields?.first,
            let nameToSave = textField.text else {
            return
        }
        print("judul : \(nameToSave)" )
        self.save(title : nameToSave)
        self.tableView.reloadData()
        }
        
        let cancAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancAction)
        
        present(alert, animated:  true)
    }
    
    
    
    func save(title: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
        
        let movTitle = NSManagedObject(entity: entity, insertInto: managedContext)
        
        movTitle.setValue(title, forKey: "title")
        
        do{
            try managedContext.save()
            movList.append(movTitle)
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
    }

    
}

/// ui table view extension
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("itung \(movList.count)")
        return movList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let title = movList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        cell.textLabel?.text = title.value(forKeyPath: "title") as? String
        return cell
    }
    
    
}


func fetchData(){
    

}





