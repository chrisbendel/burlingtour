import UIKit

class LinksController: UITableViewController {
    
    // Default links
    var links = [
        Link(name: "UVM", url: "https://www.uvm.edu/"),
        Link(name: "Champlain", url: "https://www.champlain.edu/"),
        Link(name: "Goddard", url: "https://www.goddard.edu/")
    ]
    
    //the top right cretits button
    @IBOutlet weak var credits: UIBarButtonItem!
    
    // when a user wants to add a linl
    @IBAction func AddLink(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "OK!", message: "Whats the link you want to add:", preferredStyle: .alert)
        
        // make an alert with 2 text fields that saves a link
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let name = alertController.textFields![0] as UITextField
            let url = alertController.textFields![1] as UITextField
            
            if name.text != "", url.text != "" {
                self.links.append(Link(name:name.text!, url:url.text!))
                self.tableView.reloadData()
            }
        }))
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "name of site"
            textField.textAlignment = .center
        })
        
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "url"
            textField.textAlignment = .center
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // delete the extra lines
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkTableCell", for: indexPath) as! LinkTableCell
        let link = links[indexPath.row]
        cell.name.text = link.name
        return cell
    }
    
    // open external link
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = links[indexPath.row]
        UIApplication.shared.open(URL(string : link.url)!, options: [:], completionHandler: nil)
    }
}

