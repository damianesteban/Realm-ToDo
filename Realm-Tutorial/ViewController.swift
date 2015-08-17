//
//  ViewController.swift
//  Realm-Tutorial
//
//  Created by Damian Esteban on 8/17/15.
//  Copyright (c) 2015 Damian Esteban. All rights reserved.
//

import UIKit
import Realm

class ViewController: UITableViewController, AddViewControllerDelegate {
    
    // Fetch our ToDoItems as an array...how convenient!
    var todos: RLMResults {
        get {
            return ToDoItem.allObjects()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        // Do any additional setup after loading the view, typically from a nib.
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonAction")
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func addButtonAction() {
        let addViewController = AddViewController(nibName: nil, bundle: nil)
        addViewController.delegate = self
        let navController = UINavigationController(rootViewController: addViewController)
        presentViewController(navController, animated: true, completion: nil)
    }
    
    func didFinishTypingText(typedText: String?) {
        if count(typedText!.utf16) > 0 {
            let newTodoItem = ToDoItem()
            newTodoItem.name = typedText!
            
            let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            realm.addObject(newTodoItem)
            realm.commitWriteTransaction()
            tableView.reloadData()
        }
    }


    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(todos.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        let index = UInt(indexPath.row)
        let todoItem = todos.objectAtIndex(index) as! ToDoItem
        cell.textLabel!.text = todoItem.name
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

