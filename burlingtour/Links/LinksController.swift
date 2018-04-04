import UIKit

class LinksController: UITableViewController {
    
    var links = [
        Link(name: "UVM", url: "https://www.uvm.edu/"),
        Link(name: "Champlain", url: "https://www.champlain.edu/"),
        Link(name: "Goddard", url: "https://www.goddard.edu/")
    ]
    
    @IBOutlet weak var credits: UIBarButtonItem!
    
    @IBAction func viewCredits(_ sender: Any) {
        
    }
    
    @IBAction func AddLink(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "OK!", message: "Whats the link you want to add:", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            let name = alertController.textFields![0] as UITextField
            let url = alertController.textFields![1] as UITextField
            
            if name.text != "", url.text != "" {
            //TODO: Do something with this data
                self.links.append(Link(name:name.text!, url:url.text!))
                self.tableView.reloadData()
            } else {
            //TODO: Add error handling
            }
        }))
        //Section 2
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
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let link = links[indexPath.row]
//        UIApplication.shared.open(URL(string : link.url)!, options: [:], completionHandler: nil)
    }
}

