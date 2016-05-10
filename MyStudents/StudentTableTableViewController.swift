//
//  StudentTableTableViewController.swift
//  MyStudents
//
//  Created by student on 5/10/16.
//  Copyright © 2016 student. All rights reserved.
//

import UIKit
import CoreData

class StudentTableTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var students = [Student] ()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addStudent:"), UIBarButtonItem(title: "Filter", style: .Plain, target: self, action: "selectFilter:")]
        
        reloadData()
    }
    
    func reloadData(courseFilter: String? = nil) {
        let fetchRequest = NSFetchRequest(entityName: "Student")
        
        if let courseFilter = courseFilter {
            let coursePredicate = NSPredicate(format: "course = [c]%@", courseFilter)
            fetchRequest.predicate = coursePredicate
        }
        
        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Student] {
                students = results
                tableView.reloadData()
            }
        } catch {
            fatalError("There was an error fetching students!")
        }
    }
    
    func addStudent(sender: AnyObject?) {
        if let itemsTableViewController = storyboard?.instantiateViewControllerWithIdentifier("StudentDetails") as? StudentDetailViewController {
            itemsTableViewController.managedObjectContext = managedObjectContext
            navigationController?.pushViewController(itemsTableViewController, animated: true)
        }
        
    }
    
    func selectFilter(sender: AnyObject?) {
        let alert = UIAlertController(title: "Filter", message: "Students", preferredStyle: .Alert)
        
        let filterAction = UIAlertAction(title: "Filter", style: .Default) {
            (action) -> Void in
            if let courseTextField = alert.textFields?[0], course = courseTextField.text {
                self.reloadData(course)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (action) -> Void in
            self.reloadData()
        }
        
        alert.addTextFieldWithConfigurationHandler{ (textField) in
            textField.placeholder = "Course" }
        
        alert.addAction(filterAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //This gets called when we push the back button from the view controller :3
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentCell", forIndexPath: indexPath)
        let student = students[indexPath.row]
        cell.textLabel?.text = student.first + " " + student.last
        cell.detailTextLabel?.text = student.course

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let itemsTableViewController = storyboard?.instantiateViewControllerWithIdentifier("StudentDetails") as? StudentDetailViewController {
            let list = students[indexPath.row]
            itemsTableViewController.managedObjectContext = managedObjectContext
            itemsTableViewController.selectedStudent = list
            navigationController?.pushViewController(itemsTableViewController, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
