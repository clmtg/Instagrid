//
//  ViewController.swift
//  Instagrid
//
//  Created by Clément Garcia on 08/11/2021.
//

import UIKit

class ViewController: UIViewController {
        
    // MARK: - Var
    
    //Temp data - Used to load user picked image as button background
    private var buttonBeingUsed: UIButton?
    
    //Declare gesture to share grid
    private var swipeToSharePicturesGrid = UISwipeGestureRecognizer()
    
    /// Function which does return the current device orienration status (Left/Right)
    var orientation: UIInterfaceOrientation? {
            return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
    // MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        swipeToSharePicturesGrid = UISwipeGestureRecognizer(target: self, action: #selector(pictureGridFromViewShared))
        gridPicturesViewCollage.addGestureRecognizer(swipeToSharePicturesGrid)
        gridPicturesViewCollage.isUserInteractionEnabled = true
        
    }
    
    // MARK: - IBOutlet

    //UIButton collection for the button layout options
    @IBOutlet var buttonsLayoutsChoice: [UIButton]!
    //UIButton collection for the button in the 4x4 grids
    @IBOutlet var buttonsToAddPic: [UIButton]!
    //UIView where the pictures grid will be build for collage
    @IBOutlet var gridPicturesViewCollage: UIView!
    //Label "Swipe up to share" above the collage
    @IBOutlet var labelSwipeToShare: UILabel!
    //Arrow asset to update based on device orentation
    @IBOutlet var arrowIcon: UIImageView!

    
    
    // MARK: - IBAction
    
    //--- Related to the layout options that can be chosen by the user.
        @IBAction func didTapButtonOptionLayout(_ sender: UIButton) {
            changeLayoutType(sender)
        }
    
    //--- Related to the feature to add picture to the layout selected.
    @IBAction func didTapButtonsToAddPics(_ sender: UIButton) {
        buttonBeingUsed = sender
        addPictures(sender)
    }
        
    // MARK: - Functions
    
    /// Change the layout type that will be used to create the grid
    /// - Parameter buttonLayout: button related to the layout tapped
    func changeLayoutType(_ buttonLayout: UIButton) {
    
        for i in buttonsLayoutsChoice {
            i.isSelected = false
        }
        buttonLayout.isSelected = true
        
        switch buttonLayout.tag {
        case 0:
            //Layout LeftButton
            buttonsToAddPic[1].isHidden = true
            buttonsToAddPic[3].isHidden = false
        case 1:
            //Layout CenterButton
            buttonsToAddPic[1].isHidden = false
            buttonsToAddPic[3].isHidden = true
        case 2:
            //Layout RightButton
            for i in buttonsToAddPic {
                i.isHidden = false
            }
        default:
            //Default layout
            for i in buttonsToAddPic {
                i.isHidden = false
            }
        }
    }
    
    
    /// Display the UIImagePickerController and "save" picture selected by the user
    /// - Parameter buttonAddPic: button tapped (should be from the layout grid)
    func addPictures(_ buttonAddPic: UIButton) {
        
        let imagePicker = UIImagePickerController()
        
        //Check if device is capable to provide picture from library
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
         
         imagePicker.delegate = self
         imagePicker.sourceType = .photoLibrary
         imagePicker.allowsEditing = false
         self.present(imagePicker, animated: true, completion: nil)
    }
    
    /// Function called when the view is updated (device rotate left/right)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        swipeGestureUpdate()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate { _ in
            self.swipeGestureUpdate()
        }
    }
    
    func swipeGestureUpdate() {
        guard let orientation = orientation else { return }
        if orientation.isPortrait {
            swipeToSharePicturesGrid.direction = .up
            labelSwipeToShare.text = "Swipe up to share"
            arrowIcon.image = UIImage(named: "arrow")
        } else {
            arrowIcon.image = UIImage(named: "arrowLeft")
            swipeToSharePicturesGrid.direction = .left
            labelSwipeToShare.text = "Swipe left to share"
        }
    }
    
    // To provide the ability to transform a view to a picture
    @objc
    private func pictureGridFromViewShared() {
                
        let activityVC = UIActivityViewController(activityItems: [gridPicturesViewCollage.image], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, success: Bool, returnedItems: [Any]?, error: Error?) in
            
        }
    }
}

// MARK: - Extensions

// To display images picker
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        buttonBeingUsed?.setImage(image, for: .normal)
        buttonBeingUsed?.contentMode = .scaleAspectFill
        picker.dismiss(animated: true, completion: nil)
    }
    
}
