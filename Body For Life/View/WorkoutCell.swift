import Foundation
import UIKit

class WorkoutCell: UITableViewCell {
    
    var workout : Workout? {
        didSet{
            workoutNameView.text = workout?.title
            editWorkoutView.workout = workout!
            //Top Constraints
            addConstraint(NSLayoutConstraint(item: workoutNameView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 16))
            
            addConstraint(NSLayoutConstraint(item: workoutNameView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            
            addConstraint(NSLayoutConstraint(item: editWorkoutView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -16))
            
            addConstraint(NSLayoutConstraint(item: workoutNameView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: editWorkoutView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    let workoutNameView: UILabel = {
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
    
    let editWorkoutView : EditWorkoutButton = {
        let button = EditWorkoutButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor(rgb: 0x64AB23), for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Heavy", size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        addSubview(workoutNameView)
        addSubview(editWorkoutView)
        self.backgroundColor = UIColor(rgb: 0x2C4E86)
        print("Edit Workout View: ", editWorkoutView.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
