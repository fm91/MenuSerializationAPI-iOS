
// Some elements from SCLAlertView were used in this view, values were edited for customized appearance but not the functions nor the classes conformally to The MIT License (MIT)

//  SampleViewController.swift
//  MenuSerializationAPI
//
//  Created by Fouad Medjekdoud on 9/6/15.
//  Copyright (c) 2015 TheWebAppRookie. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView



class SampleViewController: UIViewController{
    // let formatter = NSDateFormatter()
    
  
    
    var menu : UIView = UIView(frame: CGRectMake(0,0, 0, 0))
    
    var menuViewCounter : Int = 0
    
    
    
    override func viewWillAppear(animated: Bool) {
        if(menuViewCounter % 2 != 0){
            menuViewCounter++
            var menuFrame: CGRect = CGRectMake (self.view.frame.width, self.view.frame.height, 0, 0)
            menu.frame = menuFrame
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting up NSUserDefaults data
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if(isLoggedIn == 0){
            println("Not Logged In")
        }
        if(prefs.stringForKey("data1") == nil){
            prefs.setObject("100", forKey: "data1")}
        if(prefs.stringForKey("data2") == nil){
            prefs.setObject("200", forKey: "data2")}
        
        prefs.synchronize()
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        let enProject = NSEntityDescription.entityForName("Projects", inManagedObjectContext: context)
        
        var newProject = Project(entity: enProject!, insertIntoManagedObjectContext: context)
        newProject.project_name = "a chosen name"
        newProject.username = "you"
        newProject.data1 = "100"
        newProject.data2 = "200"
        context.save(nil)
        
        println("Data On Device\n\(newProject)")
        
        
        
           }
    
    
    
    

    
    //////////////////////
 
    
    @IBAction func menuPopUp(sender: AnyObject) {
        menuViewCounter++
        if(menuViewCounter % 2 == 0){
            var menuFrame: CGRect = CGRectMake (self.view.frame.width, self.view.frame.height, 0, 0)
            menu.frame = menuFrame }
        else{
            var menuFrame: CGRect = CGRectMake (self.view.frame.width - 160, self.view.frame.height - 264, 160, 264)
            menu.frame = menuFrame
            menu.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
          //  menu.layer.cornerRadius = 10
            menu.layer.masksToBounds = true
            menu.layer.borderWidth = 0.5
            menu.layer.borderColor = UIColor.darkGrayColor().CGColor
            //reset calendar contents to 0
            var deleteAllCalendar = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            deleteAllCalendar.frame = CGRectMake(5, 10, 150, 25)
            deleteAllCalendar.setTitle("Clear Objects", forState: UIControlState.Normal)
            deleteAllCalendar.titleLabel?.font = UIFont(name: "Futura", size: 14)
            
            setBorderForMenuButton(deleteAllCalendar)
            deleteAllCalendar.addTarget(self, action: "deleteAllCalendar:", forControlEvents: UIControlEvents.TouchUpInside)
            //send to server button
            var sendServerButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            sendServerButton.frame = CGRectMake(5, 45, 150, 25)
            sendServerButton.setTitle("Backup to Server", forState: UIControlState.Normal)
            sendServerButton.titleLabel?.font = UIFont(name: "Futura", size: 14)
            
            setBorderForMenuButton(sendServerButton)
            sendServerButton.addTarget(self, action: "sendToServer:", forControlEvents: UIControlEvents.TouchUpInside)
            //get from server button
            var getServerButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            getServerButton.frame = CGRectMake(5, 80, 150, 25)
            getServerButton.setTitle("Restore from Server", forState: UIControlState.Normal)
            getServerButton.titleLabel?.font = UIFont(name: "Futura", size: 14)
            
            setBorderForMenuButton(getServerButton)
            getServerButton.addTarget(self, action: "getFromServer:", forControlEvents: UIControlEvents.TouchUpInside)
            // aboutButton
            var aboutButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            aboutButton.frame = CGRectMake(5, 115, 150,25)
            aboutButton.titleLabel?.font = UIFont(name: "Futura", size: 14)
            aboutButton.setTitle("About", forState: UIControlState.Normal)
            
            setBorderForMenuButton(aboutButton)
            //aboutButton.setImage(UIImage(named: "icon_information"), forState: .Normal)
            aboutButton.addTarget(self, action: "aboutButtonTap:", forControlEvents: UIControlEvents.TouchUpInside)
            // logoutButton
            var logoutButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            logoutButton.frame = CGRectMake(5, 185, 150, 25)
            logoutButton.setTitle("Logout", forState: UIControlState.Normal)
            logoutButton.titleLabel?.font = UIFont(name: "Futura", size: 14)
            
            setBorderForMenuButton(logoutButton)
            logoutButton.addTarget(self, action: "logoutButtonTap:", forControlEvents: UIControlEvents.TouchUpInside)
                    // helpButton
            var helpButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            helpButton.frame = CGRectMake(5, 150, 150, 25)
            helpButton.setTitle("Help", forState: UIControlState.Normal)
                        helpButton.titleLabel?.font = UIFont(name: "Futura", size: 14)
            setBorderForMenuButton(helpButton)
            helpButton.addTarget(self, action: "helpButtonTap:", forControlEvents: UIControlEvents.TouchUpInside)
            // aboutButton.backgroundColor = UIColor.lightGrayColor()
            
            
            menu.addSubview(aboutButton)
            menu.addSubview(helpButton)
            menu.addSubview(logoutButton)
            menu.addSubview(sendServerButton)
            menu.addSubview(getServerButton)
            menu.addSubview(deleteAllCalendar)
            
            
            //menu.delete(self)
            
            self.view.addSubview(menu)
            
        }
        
    }
    //method that defines the borders of the menu buttons
    func setBorderForMenuButton(myTxtButt: UIButton){
        myTxtButt.layer.cornerRadius = 6.0
        myTxtButt.layer.masksToBounds = true
        var borderColor: UIColor = UIColor(red: 0x7F/255.0, green: 0x4C/255.0, blue: 0x76/255.0, alpha: 1.0)
        myTxtButt.layer.borderWidth = 1.0
        myTxtButt.layer.borderColor = borderColor.CGColor
        myTxtButt.backgroundColor = borderColor
        myTxtButt.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
    }

    
    func deleteAllCalendar(sender: UIButton!){   // resets the calendar section to 0
        
        let alertDeleteCalendar = SCLAlertView()
        alertDeleteCalendar.addButton("Yes, Delete all"){
             var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context: NSManagedObjectContext = appDel.managedObjectContext!
            
            //fetch from the entities to delete data from
            var frequestNotes = NSFetchRequest(entityName: "Projects")
           
            
            //delete the objects in the NotesTracker entity
            var delProjects = context.executeFetchRequest(frequestNotes, error: nil) as! [Project]
            for project in delProjects{
                context.deleteObject(project)
            }
            
                     context.save(nil)
            
            //Instantiate an NSUserDefaults reference and remove stored data
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let appDomain: NSString = NSBundle.mainBundle().bundleIdentifier!
            prefs.removePersistentDomainForName(appDomain as String)
            
            // clear NSUserDefaults data
            self.resetCounters(prefs)
            
            let alertConfirmation = SCLAlertView()
           alertConfirmation.showInfo("Cleared!", subTitle: "Calendar data deleted.", closeButtonTitle: "OK", colorStyle: 0x7F4C76)
            self.navigationController?.popToRootViewControllerAnimated(true)
            
            
        }
        
        
         alertDeleteCalendar.showTitle("Clear Calendar!", subTitle: "Are you sure you want to delete all existing data linked to the Calendar including goals, days and notes?",style: .Warning, closeButtonTitle: "No", colorStyle: 0x7F4C76)
        
        
        
    }
    //function to reset the values from the UserDefaults
 
    
    
    //a function that serialize the data and send it over the wire
    func sendToServer(sender:UIButton!)
    { //sendToServerHTTP
       
        
        let alertBackUp = SCLAlertView()
        alertBackUp.addButton("Yes, BackUp"){
            
            
            
            //creating a function that transforms the data into JSON
            
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            //initializers
            let data1 = prefs.stringForKey("data1")
            let data2 = prefs.stringForKey("data2")
            
             ////////////TRANSFORMING ALL THE DATA INTO A JSON STRING BEFORE SENDING IT THROUGH THE WIRE ///////
            
            let jsonStart = "{"
            let jsonEnd = "}"
            let constantArray = "'constants': {'data1': '\(data1)', 'data2': '\(data2)'}"
            var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            var context: NSManagedObjectContext = appDel.managedObjectContext!
            var projects = [Project]()
            var frequestProject = NSFetchRequest(entityName: "Projects")
            var frequestNotes = NSFetchRequest(entityName: "NotesTracker")
            var frequestDay = NSFetchRequest(entityName: "WriteDay")
            
            frequestProject.returnsObjectsAsFaults=false
            frequestNotes.returnsObjectsAsFaults=false
            frequestDay.returnsObjectsAsFaults=false
            
    
            var stringBuilder: String = "" // I will be transforming all the data into a JSON string
            var stringBuilderProjects: String = ""
            var num: Int = 0
            //excecute fetch for Projects
            projects = context.executeFetchRequest(frequestProject, error: nil) as! [Project]
            var err: NSError?
            if(projects.count > 0){
                stringBuilder += ", 'Projects': {"
                for project in projects{
                    if (num == projects.count-1){  // if the last project in storage is reached
                        
                        
                        ////treating special characters that can corrupt the data (i.e: \, " and ' )////////
                        
                        //the case of an apustrophe on a stored string (')
                        var name = project.project_name.stringByReplacingOccurrencesOfString("'", withString: "Xxapustrophe-storage-solutionxX") //replaced it with a a string that will not interfear with the data.
                        
                        //the case of an doublequotes on a stored string (")
                        name = name.stringByReplacingOccurrencesOfString("\"", withString: "Xxdoublequotes-storage-solutionxX") //replaced it with a a string that will not interfear with the data.
                        
                        //the case of a backslash on a stored string (\)
                        name = name.stringByReplacingOccurrencesOfString("\\", withString: "Xxslash-storage-solutionxX")
                        
                        
                        //Building up the string to have JSON structure
                        stringBuilderProjects += "'\(num)': {'username': '\(project.username)', 'project_name': '\(name)', 'data1': '\(project.data1)', 'data2': '\(project.data2)'}}" //closed with }} because there is an open { a little above ( 'Projects': { )
                        
                    }else{
                        
                        //same as above but end the string with "}," instead of "}}" to add the next data
                        var name = project.project_name.stringByReplacingOccurrencesOfString("'", withString: "Xxapustrophe-storage-solutionxX")
                        
                        name = name.stringByReplacingOccurrencesOfString("\"", withString: "Xxdoublequotes-storage-solutionxX")
                        
                        name = name.stringByReplacingOccurrencesOfString("\\", withString: "Xxslash-storage-solutionxX")
                       
                        
                        stringBuilderProjects += "'\(num)': {'username': '\(project.username)', 'project_name': '\(name)', 'data1': '\(project.data1)', 'data2': '\(project.data2)'}, "
                    }
                    //counter of the number of objects serialized
                    num++
                }
                
            }
            
            stringBuilder += stringBuilderProjects
            
            stringBuilderProjects = "" // initialize to use for next fetch
            
            num = 0 // initialize for next fetch
            
            //excecute fetch for NotesTracker
            
            
            stringBuilder += stringBuilderProjects
            
            // In my case, the storage on the server was in the form (Storage: storedString) where stored string contains all the data of a user.
            let preJSON: String = "{\"storage\": \""
            let afterJSON: String = "\"}"
            var finalJson = preJSON + jsonStart + constantArray + stringBuilder + jsonEnd + afterJSON
            println(finalJson)
            let paramsNSstring: NSString = finalJson as NSString
            let params = paramsNSstring.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            
            
            var url:NSURL = NSURL(string:"API_URL")!
            
            var session = NSURLSession.sharedSession()
          
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            //var err: NSError?
            
            request.HTTPMethod = "POST"
            request.HTTPBody = params
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let token = KeychainWrapper.stringForKey("API_TOKEN") //securing the Token using KeychainWrapper
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
            //show loading...
            let alertWaiting = SCLAlertView()
            alertWaiting.showWait("Connecting!", subTitle: "Please wait...", closeButtonTitle: nil, colorStyle: 0x7F4C76)
            var alertMessage: String = ""
            
            
            var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                dispatch_async(dispatch_get_main_queue(),
                    {
                        println("Response: \(response)")
                        if(response != nil){
                            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                            println("Body: \(strData)")
                            var err: NSError?
                           
                            
                            let res = response as! NSHTTPURLResponse!
                            ///success
                            if (res.statusCode >= 200 && res.statusCode < 300)
                            {
                                alertMessage = "Data sent successfully"
                                
                                
                                
                            }else{
                                alertMessage = "Unable to send data!"
                               
                                
                            }
                            alertWaiting.hideView()
                            let alertConfirmation = SCLAlertView()
                            alertConfirmation.showInfo("Connection!", subTitle: "\(alertMessage)", closeButtonTitle: "OK", colorStyle: 0x7F4C76)
                            
                            self.navigationController?.popToRootViewControllerAnimated(true)
                        } else{
                            alertWaiting.hideView()
                            let alertConfirmation = SCLAlertView()
                            alertConfirmation.showInfo("Failed!", subTitle: "Could not connect to the server", closeButtonTitle: "OK", colorStyle: 0x7F4C76)
                            
                        }
                })
            })
            
            task.resume()
        }
        //
        
        
        alertBackUp.showTitle("Backup!", subTitle: "The data on your device will replace the previous online Backup. Are you sure you want to proceed?",style: .Warning, closeButtonTitle: "Cancel", colorStyle: 0x7F4C76)
        
        
        println("sendToServerTapped")
        // println("just a try {" + "{another one")
    }
    
    
    //get the data from the server and store it into CoreData
    func getFromServer(sender:UIButton!)
    {//getFromServerHTTP
        
        
        
        
        
        let alertRestore = SCLAlertView()
        
        
        
        
        alertRestore.addButton("Yes, Restore"){
            
            var url:NSURL = NSURL(string:"API_URL")!
        
            
            var session = NSURLSession.sharedSession()
          
            
            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            //var err: NSError?
            
            request.HTTPMethod = "GET"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //call the token for a secure location
            let token = KeychainWrapper.stringForKey("API_TOKEN")
            request.addValue("Token \(token)", forHTTPHeaderField: "Authorization")
            //show loading...
           
            let alertWaiting = SCLAlertView()
            alertWaiting.showWait("Connecting!", subTitle: "Please wait...", closeButtonTitle: nil, colorStyle: 0x7F4C76)
            var alertMessage: String = "No Data!"
            
            var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                dispatch_async(dispatch_get_main_queue(),
                    {
                        println("Response: \(response)")
                        
                        
                        if (response != nil){
                            let res = response as? NSHTTPURLResponse
                            
                            ///success
                            if (res!.statusCode >= 200 && res!.statusCode < 300){
                                var strData : NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                                println("Body: \(strData)")
                                var err: NSError?
                                let string: String = strData as! String
                                
                                
                                //the data coming from the server has the form of "{'column': {'row1', 'row2'...}}" But I want it to have JSON format so
                                //first I replace all the ' with "
                                var replacement = string.stringByReplacingOccurrencesOfString("'", withString: "\"")
                                
                                //then I take away the " at the beginning of the string
                                replacement = dropFirst(replacement)
                                
                                //then I take away the " at the end of the string
                                replacement = dropLast(replacement)
                                
                                //now that the string has JSON structure, convert it inot NSData
                                var newData: NSString = replacement
                                println(newData)
                                let data2 = newData.dataUsingEncoding(NSUTF8StringEncoding)
                                
                                //then serialize it
                                let json = NSJSONSerialization.JSONObjectWithData(data2!, options: nil, error: &err) as! NSDictionary
                                
                                // distributing the data to the CoreData
                                var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                                var context: NSManagedObjectContext = appDel.managedObjectContext!
                                var frequestProject = NSFetchRequest(entityName: "Projects")
                                
                                //deleting the previous content from entities
                                var delProjects = context.executeFetchRequest(frequestProject, error: nil) as! [Project]
                                for project in delProjects{
                                    context.deleteObject(project)
                                    
                                }
                                
                                context.save(nil)
                                
                                let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                                let appDomain: NSString = NSBundle.mainBundle().bundleIdentifier!
                                prefs.removePersistentDomainForName(appDomain as String)
                                //initializers
                                //reset the login tools
                                //deploying constants
                                
                                self.resetCounters(prefs)
                                
                                //deserialization
                                if let jsonT: AnyObject = json.objectForKey("Projects")
                                {
                                    let projList = json.objectForKey("Projects") as! NSDictionary
                                    println(projList)
                                    for (var i = 0; i < projList.count; i++)
                                    {
                                        
                                        let enProject = NSEntityDescription.entityForName("Projects", inManagedObjectContext: context)
                                        
                                        var newProject = Project(entity: enProject!, insertIntoManagedObjectContext: context)
                                        
                                        let formatter = NSDateFormatter()
                                        newProject.username = (projList.objectForKey("\(i)") as! NSDictionary).valueForKey("username") as! String
                                        var replacementName = ((projList.objectForKey("\(i)") as! NSDictionary).valueForKey("project_name") as! String
                                        )
                                        
                                        //Restoring the \, ', " to their original values
                                        replacementName = replacementName.stringByReplacingOccurrencesOfString("Xxapustrophe-storage-solutionxX", withString: "'")
                                        replacementName = replacementName.stringByReplacingOccurrencesOfString("Xxslash-storage-solutionxX", withString: "\\")
                                                                                
                                        replacementName = replacementName.stringByReplacingOccurrencesOfString("Xxdoublequotes-storage-solutionxX", withString: "\"")
                                        
                                        println("replacementName: \(replacementName)")
                                        newProject.project_name = replacementName
                                        newProject.data1 = (projList.objectForKey("\(i)") as! NSDictionary).valueForKey("data1") as! String
                                        newProject.data2 = (projList.objectForKey("\(i)") as! NSDictionary).valueForKey("data2") as! String
                                        
                                       
                                    }
                                }
                             
                                context.save(nil)
                                
                                //self.viewDidAppear(true)
                                //self.viewDidLoad()
                                //;;
                                
                                alertMessage = "Data received successfully!"
                              
                                
                                
                            }
                            
                            
                            alertWaiting.hideView()
                            let alertConfirmation = SCLAlertView()
                            alertConfirmation.showInfo("Connection!", subTitle: "\(alertMessage)", closeButtonTitle: "OK", colorStyle: 0x7F4C76)
                            self.navigationController?.popToRootViewControllerAnimated(true)
                            
                        }
                        else{
                            alertWaiting.hideView()
                            let alertConfirmation = SCLAlertView()
                            alertConfirmation.showInfo("Failure!", subTitle: "Could not connect to the server", closeButtonTitle: "OK", colorStyle: 0x7F4C76)
                            
                        }})
            })
            
            
            
            task.resume()
        }
        
       alertRestore.showTitle("Restore!", subTitle: "The data on your device will be erased and replaced by the previous online Backup. Are you sure you want to proceed?",style: .Warning, closeButtonTitle: "No", colorStyle: 0x7F4C76)
        println("getFromServerTapped")
    }

    
    func aboutButtonTap(sender:UIButton!)
    {
        println("about tapped")
    }
    func helpButtonTap(sender:UIButton!)
    {
        println("help tapped")
    }
    func logoutButtonTap(sender:UIButton!)
    {
        
        let alertConfirmation = SCLAlertView()
        
        alertConfirmation.addButton("Yes, Log out"){
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removeObjectForKey("ISLOGGEDIN")
        
        println("logged out")
        self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
        alertConfirmation.showInfo("Log out!", subTitle: "Are you sure you want to log out?", closeButtonTitle: "No", colorStyle: 0x7F4C76)
        
        
        println("logout tapped")
    }
    
    //function depends on what data do you use
    func resetCounters(prefs : NSUserDefaults){
        prefs.setInteger(1, forKey: "ISLOGGEDIN")
        prefs.setObject(String(0), forKey: "data")
        prefs.setObject(String(0), forKey: "data2")
        
        
        prefs.synchronize()

    }
    
}







