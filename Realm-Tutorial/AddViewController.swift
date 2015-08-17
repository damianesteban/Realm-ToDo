//
//  AddViewController.swift
//  Realm-Tutorial
//
//  Created by Damian Esteban on 8/17/15.
//  Copyright (c) 2015 Damian Esteban. All rights reserved.
//

import UIKit
import Realm

protocol AddViewControllerDelegate {
    func didFinishTypingText(typedText: String?)
}

class AddViewController: UIViewController, UITextFieldDelegate {
    
    var textField: UITextField?
    var newItemText: String?
    var delegate: AddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupTextField()
        setupNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textField?.becomeFirstResponder()
        
    }
    
    func setupTextField() {
        textField = UITextField(frame: CGRectZero)
        textField?.placeholder = "Type in item"
        textField?.delegate = self
        view.addSubview(textField!)
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneAction")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let padding = CGFloat(11)
        textField?.frame = CGRectMake(padding, self.topLayoutGuide.length + 50, view.frame.size.width - padding * 2, 100)
    }
    
    func doneAction() {
        let realm = RLMRealm.defaultRealm()
        let text = textField?.text
        if count(text!.utf16) > 0 {
            let newTodoItem = ToDoItem()
            newTodoItem.name = textField!.text
            realm.transactionWithBlock({ () -> Void in
                realm.addObject(newTodoItem)
            })
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        doneAction()
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
