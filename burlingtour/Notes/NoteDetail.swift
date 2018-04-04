import UIKit

class NoteDetail: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var note: Note!
    var favoriteNotes: [Note] = [Note]()
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var contentInput: UITextView!
    @IBOutlet weak var noteImage: UIButton!
    var photoPicked: Bool = false
    var editMode: Bool = false // set this true if editing, otherwise we assume we're creating a new note
    
    func getNotesPath() -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("notes").path)
        }
        return filePath
    }
    
    func getFavoritePath() -> String {
        var filePath: String {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            return (url!.appendingPathComponent("favoriteNotes").path)
        }
        return filePath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentInput.layer.borderColor = UIColor.lightGray.cgColor
        contentInput.layer.borderWidth = 0.5
        contentInput.layer.cornerRadius = 5.0;
        if !editMode {
            saveButton.isHidden = false
            self.title = "New Note"
        } else {
            saveButton.isHidden = true
            //editing mode
            print("editing")
            if let notes: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFavoritePath()) as? [Note] {
                print("hello?")
                self.favoriteNotes = notes
                if favoriteNotes.first(where: {$0.name == note.name}) != nil {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "UnFavorite", style: .plain, target: self, action: #selector(unfavorite))
                } else {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
                }
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
            }
            print("AAA\(note.name), \(note.desc)")
            
            self.nameInput.text = note.name
            self.contentInput.text = note.desc
            self.noteImage.imageView?.image = note.image
            
            self.title = note.name
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if var notes: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getNotesPath()) as? [Note] {
            let photo: UIImage
            if !photoPicked {
                photo = UIImage()
            } else {
                photo = (noteImage.imageView?.image)!
            }
            let newNote = Note(name: self.nameInput.text!, desc: self.contentInput.text!, image: photo)
            notes.append(newNote)
            self.note = newNote
            
            NSKeyedArchiver.archiveRootObject(notes, toFile: self.getNotesPath())
            self.viewDidLoad()
            _ = navigationController?.popViewController(animated: true)
        }
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
    
    
    @IBAction func selectPhoto(_ sender: UIButton) {
        if !photoPicked {
            pickPhoto()
            photoPicked = true
        } else {
            // ask if they want to pick a new photo or just remove it
            let optionMenu = UIAlertController(title: nil, message: "Do you want to", preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Remove photo", style: .destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("File Deleted")
                self.noteImage.imageView?.image = UIImage()
            })
            let saveAction = UIAlertAction(title: "Chose a different photo", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                print("pick")
                self.pickPhoto()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
                print("cancel")
            })
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(saveAction)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true, completion: nil)
        }
    }
    
    func pickPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //Fixme picker doesnt work
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("here")
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("heee \(chosenImage)")
//            noteImage.isHidden = true
            noteImage.imageView?.image = chosenImage
            noteImage.imageView?.setNeedsDisplay()
        }
        dismiss(animated:true, completion: nil)
    }
}

