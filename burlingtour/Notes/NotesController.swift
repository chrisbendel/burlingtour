import UIKit

class NotesController: UITableViewController {
    var notes = [Note]()
    
    // Find where our notes are
    func getNotesPath() -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("notes").path)
        }
        
        return filePath
    }
    
    // Load notes, or nothing
    func loadNotes() {
        if let notes: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getNotesPath()) as? [Note] {
            self.notes = notes
        } else {
            self.notes = [Note]()
            NSKeyedArchiver.archiveRootObject(self.notes, toFile: self.getNotesPath())
        }
    }
    
    // refresh
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNotes()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // Table View things~
    
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
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (!self.tableView.isEditing) {
            if let editNote = segue.destination as? NoteDetail, let indexPath = tableView.indexPathForSelectedRow {
                // the noteDetail has 2 states, if we are viewing/editing a note then you must give it a note
                // then you must give it a note and tell it that its in editing mode, otherwise
                // it will just assume its a new note
                editNote.note = notes[indexPath.row]
                editNote.editMode = true
            }
        }
    }
}
