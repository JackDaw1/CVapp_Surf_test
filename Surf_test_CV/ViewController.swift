//
//  ViewController.swift
//  Surf_test_CV
//
//  Created by Galina Iaroshenko on 01.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //private var skillTextField: UITextField!
    var skillTextField: UITextField = UITextField()
    
    var skillsArray:[String] = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    func createSkillSet(OnView view: UIView, withArray data:[AnyObject]) {

        for tempView in view.subviews {
            if tempView.tag != 0 {
                tempView.removeFromSuperview()
            }
        }
        
        var xPos:CGFloat = 15.0
        var ypos: CGFloat = 500.0
        var tag: Int = 1
        for str in data  {
            let startstring = str as! String
            let width = startstring.widthOfString(usingFont: UIFont(name:"verdana", size: 13.0)!)
            let checkWholeWidth = CGFloat(xPos) + CGFloat(width) + CGFloat(13.0) + CGFloat(25.5 )//13.0 is the width between lable and cross button and 25.5 is cross button width and gap to righht
            if checkWholeWidth > UIScreen.main.bounds.size.width - 30.0 {
                //we are exceeding size need to change xpos
                xPos = 15.0
                ypos = ypos + 29.0 + 8.0
            }
            
            let bgView = UIView(frame: CGRect(x: xPos, y: ypos, width:width + 17.0 + 38.5 , height: 29.0))
            bgView.layer.cornerRadius = 14.5
            bgView.backgroundColor = UIColor(red: 33.0/255.0, green: 135.0/255.0, blue:199.0/255.0, alpha: 1.0)
            bgView.tag = tag
            
            let textlable = UILabel(frame: CGRect(x: 17.0, y: 0.0, width: width, height: bgView.frame.size.height))
            textlable.font = UIFont(name: "verdana", size: 13.0)
            textlable.text = startstring
            textlable.textColor = UIColor.white
            bgView.addSubview(textlable)
            
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: bgView.frame.size.width - 2.5 - 23.0, y: 3.0, width: 23.0, height: 23.0)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.setImage(UIImage(named: "CrossWithoutCircle"), for: .normal)
            button.tag = tag
            button.addTarget(self, action: #selector(removeSkill(_:)), for: .touchUpInside)
            bgView.addSubview(button)
            xPos = CGFloat(xPos) + CGFloat(width) + CGFloat(17.0) + CGFloat(43.0)
            view.addSubview(bgView)
            tag = tag  + 1
        }
        
    }
    
    @objc func removeSkill(_ sender: AnyObject) {
        skillsArray.remove(at: (sender.tag - 1))
        createSkillSet(OnView: self.view, withArray: skillsArray as [AnyObject])
    }
    
    @IBAction func addSkill(_ sender: Any) {
        
        let alert = UIAlertController(title: "Добавление навыка", message: "Введите название навыка, которым вы владеете", preferredStyle: .alert)
        present(alert, animated: true)
        
        //textfield
        alert.addTextField { field in
            field.placeholder = "Введите название"
        }
        
        //buttons
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [self] _ in
            let skillTextField = alert.textFields![0]
            self.skillTextField = skillTextField
//            else {
//                return
//            }
            self.skillsArray.append(skillTextField.text!)
            self.createSkillSet(OnView: self.view, withArray: skillsArray as [AnyObject])
        }))
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}

