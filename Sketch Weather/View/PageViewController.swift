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
           // return orderedViewControllers.last
                return nil
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
//                return orderedViewControllers.first
                return nil
        }
        
        guard orderedViewControllers.count > nextIndex
            else {
                return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
    }
    
    
    var pageControl = UIPageControl()
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 100, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        self.view.addSubview(pageControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.dataSource = self
//        self.delegate = self
//        configurePageControl()
//       if let firstViewController = orderedViewControllers.first {
//            setViewControllers([firstViewController], direction: .reverse, animated: true, completion: nil)
//        }
    }
    
    func newVC(viewController: String) ->UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
}
