//
//  PhotoDetailController.swift
//  MediaAlbumApp
//
//  Created by APPLE on 16/05/21.
//

import UIKit
protocol PhotoDetailRetrivalDelegate {
    var photoDM : PhotoDM { get }
}

class PhotoDetailController: BaseController {

    //-----------------------------------------------------
    //MARK: IBOutlets
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var scrollView : UIScrollView!
    //-----------------------------------------------------
    //MARK: Properties
    var viewModel : PhotoDetailViewModel!
    weak var parentRetrival : ParentretrivalDelegate?
    //-----------------------------------------------------
    //MARK: Custom Methods
    func setupView() {
        navigationItem.title = "Memory"

        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector( handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        scrollView.delegate = self 
        setZoomScale()
        
        //FIXME: Working on gesture disable issue
//        _ = parentRetrival?.gestures.compactMap({ (gesture) -> Void in
//            scrollView.panGestureRecognizer.require(toFail: gesture)
//        })
    }
    
    func viewModelSetup() {
     
        viewModel.photoURL.bind { (url) in
            self.imageView.set(url: url)
        }
        
    }
    var panGestureRecognizer: UIGestureRecognizer {
        scrollView.panGestureRecognizer
    }
    func setZoomScale() {
        scrollView.minimumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        
    }
    //-----------------------------------------------------
    //MARK: Actions
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale)
        {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    //-----------------------------------------------------
    //MARK: Memory management
    
    
    //-----------------------------------------------------
    //MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModelSetup()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setZoomScale()
    }
    static func loadController(photo : PhotoDM) -> PhotoDetailController {
        let controller : PhotoDetailController = UIStoryboard(storyboard: .main).instantiateViewController()
        controller.viewModel = PhotoDetailViewModel(photoDM: photo)
        return controller
    }
}

extension PhotoDetailController : UIScrollViewDelegate {

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        scrollView.isScrollEnabled = scrollView.zoomScale == 1
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}

//-----------------------------------------------------
extension PhotoDetailController : PhotoDetailRetrivalDelegate {
    var photoDM: PhotoDM {
        viewModel.photoDM
    }
}
