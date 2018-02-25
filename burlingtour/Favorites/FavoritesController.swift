//
//  FavoritesController.swift
//  burlingtour
//
//  Created by Chris Bendel on 2/25/18.
//  Copyright © 2018 Chris Bendel. All rights reserved.
//

import UIKit

class FavoritesController: UITableViewController {
    var favorites = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelectionDuringEditing = true
        
        //Get sights from disk
        if let favoriteSights: [Sight] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFavoritePath(favoritePath: "favoriteSights")) as? [Sight] {
            print(favoriteSights)
//            sections.append(Category(name: "Sights", items: favoriteSights))
        }
        //Get tours from disk
        
        //Get Notes from disk
        
        //Store all in sections
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getFavoritePath(favoritePath: String) -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent(favoritePath).path)
        }
        
        return filePath
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteCell
        let items = self.favorites
        let item = items[indexPath.row]
        print(item)
        
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
