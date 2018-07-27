//
//  PageViewController.swift
//  Sketch Weather
//
//  Created by user on 7/26/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC(viewController: "WeatherView"),self.newVC(viewController: "WeekView")]
    }()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController)
            else {
                return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0
            else{
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex
            else {
                return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController)
            else {
                return nil
        }
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex
            else{
                return orderedViewControllers.first
        }
        
        guard orderedViewControllers.count > nextIndex
            else {
                return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
       if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func newVC(viewController: String) ->UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
}
