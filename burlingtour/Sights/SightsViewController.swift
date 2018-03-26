import UIKit

class SightsViewController: UITableViewController {

    let sights = [
        Sight(name: "Zero Gravity", desc: "Craft Brewery", emoji:"🍺", image: "zerog", lat: 44.45962100000001, lng: -73.21380299999998),
        Sight(name: "Switchback", desc: "Craft Brewery", emoji:"🍺", image: "switchback", lat: 44.4562079, lng: -73.22073999999998),
        Sight(name: "Hen of the Wood", desc: "Restaurant", emoji: "🧀", image: "hotw", lat: 44.4790471, lng: -73.21736090000002),
        Sight(name: "Petra Cliffs", desc: "Rock Climbing", emoji: "🧗🏽‍♀️", image: "petra", lat: 44.4523933, lng: -73.2183521),
        Sight(name: "Citizen Cider", desc: "Restaurant", emoji: "🧀", image: "cider", lat: 44.471431, lng: -73.214285),
        Sight(name: "Penny Cluse Cafe", desc: "Cafe", emoji: "☕️", image: "penny", lat: 44.479173, lng: -73.211386)
    ]
    
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
        return sights.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SightCell", for: indexPath) as! SightCell
        let sight = sights[indexPath.row]
        cell.desc.text = sight.desc
        cell.name.text = sight.name
        cell.emoji.text = sight.emoji

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sightDetail = segue.destination as! SightDetail
        let indexPath = tableView.indexPathForSelectedRow!
        sightDetail.sight = sights[indexPath.row]
    }

}
