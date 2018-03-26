import UIKit

class LinksController: UITableViewController {
    
    let links = [
        Link(name: "UVM", url: "https://www.uvm.edu/"),
        Link(name: "Champlain", url: "https://www.champlain.edu/"),
        Link(name: "Goddard", url: "https://www.goddard.edu/")
    ]
    
    @IBOutlet weak var credits: UIBarButtonItem!
    
    @IBAction func viewCredits(_ sender: Any) {
        
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
        let link = links[indexPath.row]
        UIApplication.shared.open(URL(string : link.url)!, options: [:], completionHandler: nil)
    }
}

