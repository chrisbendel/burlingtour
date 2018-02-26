import UIKit

class ToursViewController: UITableViewController {
    
    let tours = [
        Tour(name: "Ghost Tour", desc: "Spooooky Ghost Tour"),
        Tour(name: "Lake Champlain", desc: "History of Lake Champlain")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tours.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TourTableCell", for: indexPath) as! TourTableCell
        let tour = tours[indexPath.row]
        cell.desc.text = tour.desc
        cell.name.text = tour.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tourDetail = segue.destination as! TourDetail
        let indexPath = tableView.indexPathForSelectedRow!
        tourDetail.tour = tours[indexPath.row]
    }
    
}
