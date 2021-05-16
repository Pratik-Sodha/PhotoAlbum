//
//  PhotoPageController.swift
//  MediaAlbumApp
//
//  Created by APPLE on 16/05/21.
//

import UIKit
protocol ParentretrivalDelegate : class {
    var gestures : [UIGestureRecognizer] { get }
}

class PhotoPageController: BaseController {

    //-----------------------------------------------------
    //MARK: IBOutlets
    
    
    //-----------------------------------------------------
    //MARK: Properties
    var viewModel : PhotoPageViewModel!
    lazy var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let controller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,
                                              options: [:])
        controller.delegate = self
        controller.dataSource = self
        return controller
    }()
    
    //-----------------------------------------------------
    //MARK: Custom Methods
    func setupView() {

        setupSubviews()
        pageViewController.didMove(toParent: self)
        let controller = loadCurrentPhotoController()
        updateNavigationTitle()
        pageViewController.setViewControllers([controller],
                                              direction: .forward, animated: true, completion: nil)
    }
    
    func setupSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(pageViewController.view)
        makeConstraints()
    }
    
    func makeConstraints() {
        containerView.edgeToSuperView()
        pageViewController.view.edgeToSuperView()
    }
    
    func updateNavigationTitle() {
        guard let index = viewModel.index else {
            navigationItem.title = "Photo"
            return
        }
        navigationItem.title = "Photo(\(index + 1))"
    }
    func loadCurrentPhotoController() -> PhotoDetailController {
        let controller = PhotoDetailController.loadController(photo: viewModel.currentPhoto)
        controller.parentRetrival = self
        return controller
    }
    //-----------------------------------------------------
    //MARK: Actions
    
    
    //-----------------------------------------------------
    //MARK: Memory management
    
    
    //-----------------------------------------------------
    //MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    static func loadController(currentIndex : Int,
                               photos : [PhotoDM]) -> PhotoPageController {

        let controller =  PhotoPageController()
        controller.viewModel = PhotoPageViewModel(photos: photos,
                                                  currentPhoto: photos[currentIndex])
        return controller
    }

}
//-----------------------------------------------------
extension PhotoPageController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let index = viewModel.index else {
            return nil
        }

        if index == 0 {
            return nil
        }
        
        let prevIndex = abs((index - 1) % viewModel.photos.count)
        viewModel.updateCurrentIndex(index: prevIndex)
        return loadCurrentPhotoController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewModel.index else {
            return nil
        }
        
        //Remove Below condition to do circular page
        if index == viewModel.photos.count - 1 {
            return nil
        }
        
        let nextIndex = abs((index + 1) % viewModel.photos.count)
        viewModel.updateCurrentIndex(index: nextIndex)
        return loadCurrentPhotoController()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        if let viewController = pageViewController.viewControllers?[0] as? PhotoDetailController{
            guard let index = viewModel.getIndex(photoDM: viewController.photoDM) else {
                return
            }
            viewModel.updateCurrentIndex(index: index)
            updateNavigationTitle()
        }
    }
    
}

//FIXME: Working on gesture fails for scrollview and pageviewcontroller
extension PhotoPageController : ParentretrivalDelegate {
    var gestures: [UIGestureRecognizer] {
        pageViewController.gestureRecognizers
    }
}
