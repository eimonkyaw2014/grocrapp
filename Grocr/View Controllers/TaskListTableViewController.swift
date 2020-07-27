//
//  TaskListTableViewController.swift
//  Grocr
//
//  Created by eimonkyaw on 7/14/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import UIKit
import Firebase
class TaskListTableViewController: UITableViewController {
   private var documents :[DocumentSnapshot] = []
    public var tasks :[Task] = []
    private var listener : ListenerRegistration!
    var sellectedItem :Task!
    var valueToPass:String!
    fileprivate func baseQuery() -> Query {
        return Firestore.firestore().collection("Task").limit(to: 50)
    }
    
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.query = baseQuery()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
           self.listener = query?.addSnapshotListener{ (documents,err) in
               guard let snapshot = documents else {
                   print("Error\(err)")
                   return
               }
                let results = snapshot.documents.map { (document) -> Task in
                   if let task = Task(dictonary: document.data(), id: document.documentID) {
                                  return task
                              } else {
                                  fatalError("Unable to initialize type \(Task.self) with dictionary \(document.data())")
                              }
                          }
                   self.tasks = results
                   self.documents = snapshot.documents
                   self.tableView.reloadData()
               }
           
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.listener.remove()
       }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let item = tasks[indexPath.row]
        cell.textLabel?.text = item.name
        cell.textLabel?.textColor = item.done == false ? UIColor.black : UIColor.lightGray
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tasks[indexPath.row]
        sellectedItem = item
//        let indexPath = tableView.indexPathForSelectedRow!
//        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
//
//        valueToPass = currentCell.textLabel?.text
//        print(currentCell.textLabel?.text as Any)
//       performSegue(withIdentifier: "Detail", sender: item)
//        let collection = Firestore.firestore().collection("Task")
//        collection.document(item.id).updateData([
//            "done" : !item.done,
//        ]){ err in
//                if let err = err {
//                    print("Error updating document: \(err)")
//                } else {
//                    print("Document successfully updated")
//                }
//        }
//        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let item = tasks[indexPath.row]
            _ = Firestore.firestore().collection("Task").document(item.id).delete()
//            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if (segue.identifier == "Detail") {
//            // initialize new view controller and cast it as your view controller
//            let viewController = segue.destination as! DetailViewController
//            // your new view controller should have property that will store passed value
//            viewController.item = (sender as! Task)
//        }
        guard let detailViewController = segue.destination as? DetailViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
         
        detailViewController.item = tasks[index]
    }
    

    @IBAction func addButtonDidTouch(sender : Any) {
       let alert = UIAlertController(title: "New Task", message: "What to you want to remember ?", preferredStyle: .alert)
       alert.addTextField { (UITextField) in
           
       }
       let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       alert.addAction(cancelAction)
       
       let addAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) -> Void in
           let reminder = (alert.textFields?.first)! as UITextField
           let db = Firestore.firestore()
           var docRef : DocumentReference? = nil
           docRef = db.collection("Task").addDocument(data: [
               "name" : reminder.text ?? "empty task",
               "done" : false
           ]) { err in
                if let err = err {
                   print("Error adding document: \(err)")
               } else {
                   print("Document added with ID: \(docRef!.documentID)")
               }
           }
       }
       alert.addAction(addAction)
       present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func editItem(_ sender: Any) {
        let alert = UIAlertController(title: "Edit Task", message: "What to you want to remember ?", preferredStyle: .alert)
        alert.addTextField { (UITextField) in
            UITextField.text = self.sellectedItem.name
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Edit", style: .default) { (UIAlertAction) -> Void in
            let reminder = (alert.textFields?.first)! as UITextField
            
           let collection = Firestore.firestore().collection("Task")
            collection.document(self.sellectedItem.id).updateData([
                "name" : reminder.text as Any,
                       "done" : !self.sellectedItem.done,
                   ]){ err in
                           if let err = err {
                               print("Error updating document: \(err)")
                           } else {
                               print("Document successfully updated")
                           }
                   }
        }
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
}
