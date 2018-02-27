import UIKit

class CreateNote: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var note: Note!
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var contentInput: UITextField!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var removePhoto: UIButton!
    
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
        self.title = "New Note"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveNote(_ sender: Any) {
        if var notes: [Note] = NSKeyedUnarchiver.unarchiveObject(withFile: self.getNotesPath()) as? [Note] {

            let newNote = Note(name: self.nameInput.text!, desc: self.contentInput.text!, image: self.noteImage.image!)
            notes.append(newNote)
            self.note = newNote
            
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

