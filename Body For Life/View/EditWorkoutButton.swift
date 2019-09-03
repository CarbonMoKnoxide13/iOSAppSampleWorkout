//
//  editWorkoutButton.swift
//  Body For Life
//
//  Created by Aramis Knox on 6/23/19.
//  Copyright © 2019 Aramis Knox. All rights reserved.
//

import UIKit

class EditWorkoutButton: UIButton {
    
    var workout: Workout?
    
    convenience init(workout: Workout) {
        self.init()
        self.workout = workout
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
