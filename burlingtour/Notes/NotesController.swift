import UIKit

class NotesController: UITableViewController {
    var notes = [Note]()
    
    func getNotesPath() -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("notes").path)
        }
        
        return filePath
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let notes: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getNotesPath()) as? [Note] {
            self.notes = notes
        } else {
            self.notes = [Note]()
            NSKeyedArchiver.archiveRootObject(self.notes, toFile: self.getNotesPath())
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let notes: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getNotesPath()) as? [Note] {
            self.notes = notes
        } else {
            self.notes = [Note]()
            NSKeyedArchiver.archiveRootObject(self.notes, toFile: self.getNotesPath())
        }
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        cell.name.text = note.name
        cell.desc.text = note.desc

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            NSKeyedArchiver.archiveRootObject(self.notes, toFile: self.getNotesPath())
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.notes[sourceIndexPath.row]
        notes.remove(at: sourceIndexPath.row)
        notes.insert(movedObject, at: destinationIndexPath.row)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (!self.tableView.isEditing) {
            if let editNote = segue.destination as? NoteDetail, let indexPath = tableView.indexPathForSelectedRow {
                print("hey sent!")
                editNote.note = notes[indexPath.row]
                editNote.editMode = true
            }
        }
    }
}
