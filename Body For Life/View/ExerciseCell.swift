import Foundation
import UIKit

class ExerciseCell: UITableViewCell {
    
    var exercise : Exercise? {
        didSet{
            exerciseNameView.text = exercise?.title
            
            //Top Constraints
            addConstraint(NSLayoutConstraint(item: exerciseNameView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 16))
            
            addConstraint(NSLayoutConstraint(item: exerciseNameView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            
            //addConstraint(NSLayoutConstraint(item: editWorkoutView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -16))
            
            addConstraint(NSLayoutConstraint(item: exerciseNameView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            //addConstraint(NSLayoutConstraint(item: editWorkoutView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    let exerciseNameView: UILabel = {
        let label = UILabel()
        label.text = "Tester"
        label.textColor = UIColor(rgb: 0x64AB23)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    func setupViews() {
        addSubview(exerciseNameView)
        self.backgroundColor = UIColor(rgb: 0x2C4E86)
        //print("Edit Workout View: ", editWorkoutView.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
