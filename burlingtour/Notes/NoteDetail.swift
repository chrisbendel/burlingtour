import UIKit

class NoteDetail: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveNote))
        if var notes: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFavoritePath()) as? [Note] {
            self.favoriteNotes = notes
            if favoriteNotes.first(where: {$0.name == note.name}) != nil {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "UnFavorite", style: .plain, target: self, action: #selector(unfavorite))
            } else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
            }
        } else {
//            self.favoriteNotes = [Note]()
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(favorite))
        }
        
        if self.note != nil {
            
        }
    }
    
    @objc func favorite() {
        if self.note != nil {
            self.favoriteNotes.append(self.note)
            
            NSKeyedArchiver.archiveRootObject(self.favoriteNotes, toFile: self.getFavoritePath())
            self.viewDidLoad()

        }
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
            notes.append(Note(name: self.nameInput.text!, text: self.contentInput.text!, image: self.noteImage.image))
            NSKeyedArchiver.archiveRootObject(notes, toFile: self.getNotesPath())
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func removePhoto(_ sender: Any) {
        if self.noteImage != nil {
            self.noteImage.image = nil
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
