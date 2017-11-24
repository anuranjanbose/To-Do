//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Anuranjan Bose on 29/06/17.
//  Copyright © 2017 Anuranjan Bose. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDataSource, elementDelegate {



    
    var confirm : Bool = false
    var tasks : [ToDoList] = []
    
    
    
    func delete() {
        
       
            
            if (mySegmentOutlet.selectedSegmentIndex == 0) {
                for task in tasks {
                    AppDelegate.shared().persistentContainer.viewContext.delete(task)
                    AppDelegate.shared().saveContext()
                    
                }
                fetchDataFor(check: "all")
                myTableView.reloadData()
            }
                
            else if (mySegmentOutlet.selectedSegmentIndex == 1) {
                for task in tasks {
                    if task.check == true {
                        AppDelegate.shared().persistentContainer.viewContext.delete(task)
                    }
                    AppDelegate.shared().saveContext()
                    
                }
                fetchDataFor(check: "true")
                myTableView.reloadData()
                
            }
                
            else if (mySegmentOutlet.selectedSegmentIndex == 2) {
                for task in tasks {
                    if task.check == false {
                        AppDelegate.shared().persistentContainer.viewContext.delete(task)
                    }
                    AppDelegate.shared().saveContext()
                    
                }
                fetchDataFor(check: "false")
                myTableView.reloadData()
            }
            
        
        
        
    }
    
    
    
    @IBAction func deleteAllButton(_ sender: UIButton) {
        if tasks.count != 0 {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "confirm_vc") as! ConfirmViewController
        vc.delegate = self
            if mySegmentOutlet.selectedSegmentIndex == 0 {
                vc.segment = 0
            }
            else if mySegmentOutlet.selectedSegmentIndex == 1 {
                vc.segment = 1
            }
            else {
                vc.segment = 2
            }
        present(vc, animated: true, completion: nil)
        }
        
}
    
    
    @IBOutlet weak var mySegmentOutlet: UISegmentedControl!
    
    @IBAction func mySegment(_ sender: UISegmentedControl) {
        
       if sender.selectedSegmentIndex == 0 {
           fetchDataFor(check: "all")
            myTableView.reloadData()
        }
        
        else if sender.selectedSegmentIndex == 1 {
            fetchDataFor(check: "true")
            myTableView.reloadData()
        }
        
       else if sender.selectedSegmentIndex == 2 {
           fetchDataFor(check: "false")
        myTableView.reloadData()
          }
    }
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var taskTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        fetchDataFor(check: "all")
    }
    
    
    

    @IBAction func addTaskButton(_ sender: UIButton) {
        
        if (taskTextField.text != "")
        {
            let taskObj = ToDoList(context: AppDelegate.shared().persistentContainer.viewContext)
            taskObj.task = taskTextField.text
            taskObj.check = false
            taskTextField.text = ""
            AppDelegate.shared().saveContext()
            
            fetchDataFor(check: "all")
            
            if (mySegmentOutlet.selectedSegmentIndex == 0) {
                self.myTableView.reloadData()
            }
            else if mySegmentOutlet.selectedSegmentIndex == 2 {
                fetchDataFor(check: "false")
                myTableView.reloadData()
                
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "my_cell_identifier")! as! cellTableViewCell
        cell.delegate = self
        cell.titleLabel.text = tasks[indexPath.row].task

        if(tasks[indexPath.row].check == true) {
            cell.mySwitchOutlet.setOn(false, animated: true)
            cell.backgroundColor = UIColor(red: 0.56, green : 0.94 , blue : 0.65, alpha : 1.0)
        }
        else {
            cell.mySwitchOutlet.setOn(true,animated: true)
            cell.backgroundColor = UIColor(red: 0.90, green : 0.26 , blue : 0.33, alpha : 1.0)
        }
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            let context = AppDelegate.shared().persistentContainer.viewContext
            context.delete(tasks[indexPath.row])
            AppDelegate.shared().saveContext()
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func change(title: String) -> Void {
        
        if (mySegmentOutlet.selectedSegmentIndex == 0) {
       
        fetchDataFor(check: "all")
        for task in tasks {
            if task.task == title {
                task.check = !(task.check)
            }
        }
        AppDelegate.shared().saveContext()
        self.myTableView.reloadData()
        }
            
        else if (mySegmentOutlet.selectedSegmentIndex == 1) {
            
            fetchDataFor(check: "all")
            for task in tasks {
                if task.task == title {
                    task.check = !(task.check)
                }
                
            }
            AppDelegate.shared().saveContext()
            
            fetchDataFor(check: "true")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.myTableView.reloadData()
                
            })
            
        }
            
        else if (mySegmentOutlet.selectedSegmentIndex == 2) {
            fetchDataFor(check: "all")
            
            for task in tasks  {
                if task.task == title {
                    task.check = !(task.check)
                }
                
            }
            AppDelegate.shared().saveContext()
            fetchDataFor(check : "false")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.myTableView.reloadData()
            })
            

        }
        
    }
    
    
   
    
    func fetchDataFor(check : String)
    {
        switch (check) {
        case "true" : do {
            let request:NSFetchRequest<ToDoList> = ToDoList.fetchRequest()
            request.predicate = NSPredicate(format : "check == %@", NSNumber(value : true))
            tasks  =  try AppDelegate.shared().persistentContainer.viewContext.fetch(request)
        } catch {
            // handle fetch failure
            }
            break
        case "false" :do {
            let request:NSFetchRequest<ToDoList> = ToDoList.fetchRequest()
            request.predicate = NSPredicate(format : "check == %@", NSNumber(value : false))
            tasks  =  try AppDelegate.shared().persistentContainer.viewContext.fetch(request)
        } catch {
            // handle fetch failure
            }
            break
        default : do {
            let request : NSFetchRequest<ToDoList> = ToDoList.fetchRequest()
            tasks = try AppDelegate.shared().persistentContainer.viewContext.fetch(request)
        } catch {
            //error handling code
            }

            
        }
    }
    
    func confirmDelete() {
        
       self.delete()
    }
    
    
    
    

}

protocol elementDelegate {
    
    func change(title : String) -> Void
    func confirmDelete()
    
    
    
}

