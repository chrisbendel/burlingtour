import UIKit

protocol Favorite {
    var type: String {get}
    var sectionTitle: String {get}
}

class FavoritesController: UITableViewController {
    var favorites = [Favorite]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //refresh the favorites every time we check them
        favorites = [Favorite]()
        
        //Get sights from disk
        if let favoriteSights: [Favorite] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFavoritePath(favoritePath: "favoriteSights")) as? [Favorite] {
            for favorite in favoriteSights {
                favorites.append(favorite)
            }
        }
        
        //Get tours from disk
        if let favoriteTours: [Favorite] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFavoritePath(favoritePath: "favoriteTours")) as? [Favorite] {
            for favorite in favoriteTours {
                favorites.append(favorite)
            }
        }
        
        //Get Notes from disk
        if let favoriteNotes: [Favorite] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFavoritePath(favoritePath: "favoriteNotes")) as? [Favorite] {
            for favorite in favoriteNotes {
                favorites.append(favorite)
            }
        }
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func getFavoritePath(favoritePath: String) -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent(favoritePath).path)
        }
        
        return filePath
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = favorites[indexPath.row]
        switch(item.type) {
            case "note":
                if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell {
                    let note = favorites[indexPath.row] as! Note
                    cell.name.text = note.name
                    cell.desc.text = note.desc
                    return cell
                }
            case "sight":
                if let cell = tableView.dequeueReusableCell(withIdentifier: "SightCell", for: indexPath) as? SightCell {
                    let sight = favorites[indexPath.row] as! Sight
                    cell.name.text = sight.name
                    cell.desc.text = sight.desc
                    return cell
                }
            case "tour":
                if let cell = tableView.dequeueReusableCell(withIdentifier: "TourCell", for: indexPath) as? TourCell {
                    let tour = favorites[indexPath.row] as! Tour
                    cell.name.text = tour.name
                    cell.desc.text = tour.desc
                    return cell
                }
            default: break
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = favorites[indexPath.row]
            switch(item.type) {
                case "note":
                    let note = favorites[indexPath.row] as! Note
                    self.removeNote(note: note)
                case "sight":
                    let sight = favorites[indexPath.row] as! Sight
                    self.removeSight(sight: sight)
                case "tour":
                    let tour = favorites[indexPath.row] as! Tour
                    self.removeTour(tour: tour)
                default: break
            }
            
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.favorites[sourceIndexPath.row]
        favorites.remove(at: sourceIndexPath.row)
        favorites.insert(movedObject, at: destinationIndexPath.row)
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow!
        switch (segue.identifier) {
            case "note"?:
                let note = segue.destination as! EditNote
                note.note = favorites[indexPath.row] as! Note
            case "sight"?:
                let sight = segue.destination as! SightDetail
                sight.sight = favorites[indexPath.row] as! Sight
            case "tour"?:
                let tour = segue.destination as! TourDetail
                tour.tour = favorites[indexPath.row] as! Tour
            default: return
        }
    }
    
    private func removeNote(note: Note) {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("favoriteNotes").path)
        }
        
        var notes = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [Note]
        notes = notes.filter {$0.name != note.name}
        NSKeyedArchiver.archiveRootObject(notes, toFile: filePath)
    }
    
    private func removeSight(sight: Sight) {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("favoriteSights").path)
        }
        
        var sights = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [Sight]
        sights = sights.filter {$0.name != sight.name}
        NSKeyedArchiver.archiveRootObject(sights, toFile: filePath)
    }
    
    private func removeTour(tour: Tour) {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("favoriteTours").path)
        }
        
        var tours = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [Tour]
        tours = tours.filter {$0.name != tour.name}
        NSKeyedArchiver.archiveRootObject(tours, toFile: filePath)
    }
}
