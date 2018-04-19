//
//  StudentsPlacesListViewController
//  OnTheMapApp
//
//  Created by Max Boguslavskiy on 30/03/2018.
//  Copyright © 2018 Max Boguslavskiy. All rights reserved.
//

import UIKit

class StudentsPlacesListViewController: UITableViewController {
    
    var locations = [StudentInformation]()
    
    @IBOutlet weak var uiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ParseClient.sharedInstance().getStudentLocations() { (students, error) in
            if let students = students {
                self.locations = students
                performUIUpdatesOnMain {
                    self.uiTableView.reloadData()
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension StudentsPlacesListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Get cell type */
        let cellReuseIdentifier = "StudentsMarksCell"
        let location = locations[(indexPath as NSIndexPath).row]
        print(location as Any)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?
        
        /* Set cell defaults */
        cell?.textLabel!.text = "\(location.firstName!) \(location.lastName!)"
        if let location = location.mediaUrl {
            cell?.detailTextLabel?.text = location 
        } else {
            cell?.detailTextLabel?.text = ""
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[(indexPath as NSIndexPath).row]
        if let url = location.mediaUrl {
            let udacityUrl = NSURL(string: url)! as URL
            UIApplication.shared.open(udacityUrl, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "No url provided", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
