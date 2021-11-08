//
//  ViewController.swift
//  Instagrid
//
//  Created by Clément Garcia on 08/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Var
    

    
    // MARK: - IBOutlet

    //UIButton collection for the button layout options
    @IBOutlet var buttonsLayoutsChoice: [UIButton]!
    //UIButton collection for the button in the 4x4 grids
    @IBOutlet var buttonsToAddPic: [UIButton]!
    
    
    
    
    // MARK: - IBAction
    
    //--- Related to the layout options that can be chosen by the user.
    @IBAction func didTapButtonLayoutOption(_ sender: UIButton) {
        changeLayoutType(sender)
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
            print(buttonLayout.tag)
            buttonsToAddPic[1].isHidden = true
            buttonsToAddPic[3].isHidden = false
        case 1:
            print(buttonLayout.tag)
            //Layout CenterButton
            buttonsToAddPic[1].isHidden = false
            buttonsToAddPic[3].isHidden = true
        case 2:
            print(buttonLayout.tag)
            //Layout RightButton
            for i in buttonsToAddPic {
                i.isHidden = false
            }
        default:
            print(buttonLayout.tag)
            //Default layout
            for i in buttonsToAddPic {
                i.isHidden = false
            }
        }
    }
    
    
}

