//
//  ViewController.swift
//  CoreTDataLogin
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
   
    var ExitsingUserList = [String]()
    var User:[UserInfo]? = nil
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var StackView: UIStackView!
    
    @IBOutlet weak var LoginTableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        error.isHidden = true
        
        User = CoreDataHandler.fetchObject()
        for i in User!
        {
            print(i.username!)
            ExitsingUserList.insert("\(i.username!)", at: 0)
            print("array--> \(ExitsingUserList)")
        }
            
        self.LoginTableVIew.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        print(User!)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        password.resignFirstResponder()
        username.resignFirstResponder()
    }
    
    @IBAction func login(_ sender: UIButton) {
        print("Clicked..")
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
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
                        ExitsingUserList.insert("\(temp)", at: 0)
                        LoginTableVIew.isHidden = false
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ExitsingUserList.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected...")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.LoginTableVIew.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = ExitsingUserList[indexPath.row]

        return cell
    }
}
