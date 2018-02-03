//
//  ViewController.swift
//  CoreTDataLogin
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var User:[UserInfo]? = nil
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!

    
    @IBAction func login(_ sender: UIButton) {
        
        if(username.text != nil && password.text != nil)
        {
            let user: String = username.text!
            let pass: String = password.text!
            var User = CoreDataHandler.searchdata(username: user)
            print(User!)
            if(User == nil || (User?.isEmpty)!)
            {
                print("Insert User")
                if CoreDataHandler.saveObject(username: user, password: pass)
                {
                    User = CoreDataHandler.fetchObject()
                    
                    for i in User!
                    {
                        print(i.username!)
                    }
                }
            }
            else
            {
                for i in User!{
                    let temp = i.username!
                    if(user == temp)
                    {
                        error.isHidden = false
                        error.text = "User already Exits..\(temp)"
                    }
                }
            } 
        }
        else
        {
            error.isHidden = false
            error.text = "Please enter correct username and password"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        error.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

