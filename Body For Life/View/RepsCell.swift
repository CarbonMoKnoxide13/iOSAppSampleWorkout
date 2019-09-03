import Foundation
import UIKit

class RepsCell: UITableViewCell {
    
    var rep : Rep? {
        didSet{
            weightView.text = ("Weight: " + String(rep!.weight))
            repView.text = ("Reps: " + String(rep!.reps))
            intensityView.text = ("Intensity: " + String(rep!.intensity))
            
            //Top Constraints
            addConstraint(NSLayoutConstraint(item: weightView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16))
            
            addConstraint(NSLayoutConstraint(item: repView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            
            addConstraint(NSLayoutConstraint(item: intensityView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -16))
            
            addConstraint(NSLayoutConstraint(item: weightView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: repView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            addConstraint(NSLayoutConstraint(item: intensityView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    let weightView: UILabel = {
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
    
    let repView: UILabel = {
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
    
    let intensityView: UILabel = {
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
        addSubview(weightView)
        addSubview(repView)
        addSubview(intensityView)
        
        self.backgroundColor = UIColor(rgb: 0x2C4E86)
        //print("Edit Workout View: ", editWorkoutView.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
