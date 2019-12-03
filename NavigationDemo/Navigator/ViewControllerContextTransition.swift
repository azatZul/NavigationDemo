//
//  ViewControllerContextTransition.swift
//  NavigationDemo
//
//  Created by Azat Zulkarnyaev on 18/11/2019.
//  Copyright © 2019 MagicLab. All rights reserved.
//

import UIKit

protocol ViewControllerContextTransition {
    func navigate(from source: UIViewController?,
                  to destination: UIViewController,
                  animated: Bool)
}
