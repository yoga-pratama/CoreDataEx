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
    
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Name", message: "Add Movie  Name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                        style: .default){
        [unowned self] action in
                                        
        guard let textField = alert.textFields?.first,
            let nameToSave = textField.text else {
            return
        }
        self.names.append(nameToSave)
        print("nama adalah : \(nameToSave)" )
        print(self.names)
        self.tableView.reloadData()
        }
        
        let cancAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancAction)
        
        present(alert, animated:  true)
    }
    
    

}

/// ui table view extension
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("itung \(movList.count)")
        return movList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    
}



