//
//  PageViewController.swift
//  ThePriceIsRight
//
//  Created by Yanunsey on 17/1/23.
//

import UIKit

class PageViewController: UIPageViewController {
    
    lazy var pageViewControllers : [UIViewController] = {
        return [self.createNewViewController(name: "RoomsVC"), self.createNewViewController(name: "BathsVC"), self.createNewViewController(name: "CarsVC"), self.createNewViewController(name: "YearVC"), self.createNewViewController(name: "SizeVC"), self.createNewViewController(name: "ConditionVC"), self.createNewViewController(name: "ResultVC") ]
    }()
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = self.pageViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        configurePageControl()
    }
    
    func configurePageControl() {
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 60, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = self.pageViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor(named: "PastelPuple")
        self.view.addSubview(pageControl)
    }
    
    //Método para gestionar un VC y otro respectivamente:
    func createNewViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // - MARK: - UIPageViewController Data Source Methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pageViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex >= 0 {
            return self.pageViewControllers[previousIndex]
        }
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pageViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        if nextIndex < self.pageViewControllers.count {
            return self.pageViewControllers[nextIndex]
        }
        return nil
    }
    
    // - MARK: - UIPageViewController Delegate Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let currentViewController = pageViewController.viewControllers?[0] {
            if let idx = self.pageViewControllers.firstIndex(of: currentViewController) {
                self.pageControl.currentPage = idx
            }
        }
        
    }
    
}
