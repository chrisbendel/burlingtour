import UIKit

class EditNote: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var note: Note!
    var favoriteNotes: [Note]!
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var contentInput: UITextField!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var removePhoto: UIButton!
    
    func getFavoritePath() -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("favoriteNotes").path)
        }
        
        return filePath
    }
    
    func getNotesPath() -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("notes").path)
        }
        
        return filePath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let notes: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFavoritePath()) as? [Note] {
            self.favoriteNotes = notes
            if favoriteNotes.first(where: {$0.name == note.name}) != nil {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "UnFavorite", style: .plain, target: self, action: #selector(unfavorite))
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
            }
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
        }
        
        self.nameInput.text = self.note.name
        self.contentInput.text = self.note.desc
        self.noteImage.image = self.note.image
    }
    
    @objc func favorite() {
        self.favoriteNotes.append(self.note)
        NSKeyedArchiver.archiveRootObject(self.favoriteNotes, toFile: self.getFavoritePath())
        self.viewDidLoad()
    }
    
    @objc func unfavorite() {
        self.favoriteNotes = self.favoriteNotes.filter {$0.name != note.name}
        NSKeyedArchiver.archiveRootObject(self.favoriteNotes, toFile: self.getFavoritePath())
        self.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if var notes: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getNotesPath()) as? [Note] {
            let updatedNoteIndex = notes.index(where: {$0.name == self.note.name})
            self.note = notes[updatedNoteIndex!]
            notes[updatedNoteIndex!].name = self.nameInput.text!
            notes[updatedNoteIndex!].desc = self.contentInput.text!
            notes[updatedNoteIndex!].image = self.noteImage.image!
            
            NSKeyedArchiver.archiveRootObject(notes, toFile: self.getNotesPath())
            self.viewDidLoad()
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func removePhoto(_ sender: Any) {
        self.noteImage.image = UIImage()
    }
    
    @IBAction func selectPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        noteImage.image = chosenImage
        
        dismiss(animated:true, completion: nil)
    }
}
