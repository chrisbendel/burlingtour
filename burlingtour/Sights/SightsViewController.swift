import UIKit

class SightsViewController: UITableViewController {

    let sights = [
        Sight(name: "Zero Gravity", desc: "Craft Brewery", image: "zerog", lat: 44.45962100000001, lng: -73.21380299999998),
        Sight(name: "Switchback", desc: "Craft Brewery", image: "switchback", lat: 44.4562079, lng: -73.22073999999998),
        Sight(name: "Hen of the Wood", desc: "Restaurant", image: "hotw", lat: 44.4790471, lng: -73.21736090000002),
        Sight(name: "Petra Cliffs", desc: "Rock Climbing", image: "petra", lat: 44.4523933, lng: -73.2183521)
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
        return sights.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SightCell", for: indexPath) as! SightCell
        let sight = sights[indexPath.row]
        cell.desc.text = sight.desc
        cell.name.text = sight.name

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sightDetail = segue.destination as! SightDetail
        let indexPath = tableView.indexPathForSelectedRow!
        sightDetail.sight = sights[indexPath.row]
    }

}
