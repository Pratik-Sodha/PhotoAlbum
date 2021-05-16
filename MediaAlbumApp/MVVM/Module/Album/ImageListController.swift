//
//  ImageListController.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import UIKit

class ImageListController: BaseController {

    //-----------------------------------------------------
    //MARK: IBOutlets
    @IBOutlet weak var collectionView : UICollectionView!
    
    //-----------------------------------------------------
    //MARK: Properties
    private var viewModel : ImageListViewModel!
    
    private var flowLayout : UICollectionViewFlowLayout  {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
        return layout
    }
    
    private let cellSpacing : CGFloat = 10.0
    private var numberOfItem : CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad  {
            return 5
        } else {
            let orientation =  UIDevice.current.orientation
            switch orientation {
            case .faceDown, .faceUp, .portrait, .portraitUpsideDown, .unknown:
                return 3
            case .landscapeLeft, .landscapeRight:
            return 4
            @unknown default:
                return 3
            }
        }
    }
    //-----------------------------------------------------
    //MARK: Custom Methods
    func setupView() {
        navigationItem.title = "Memories"
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.register(PhotoCollectionCell.nib(),
                                forCellWithReuseIdentifier: PhotoCollectionCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = flowLayout
    }
    
    func viewModelSetup() {

        loadPhotos()
        
        viewModel.datasource.bind { (albums) in
            self.collectionView.reloadData()
        }
        
        viewModel.apiResponseFailure.bind { (error) in
            self.collectionView.backgroundView =  self.emptyBackgroundViewIfNeeded(message: error?.localizedDescription)
        }
    }
    
    func loadPhotos() {
        showLoader()
        viewModel.loadPhotos {[weak self] (success, error) in
            self?.stopLoader()
        }
    }
    
    func emptyBackgroundViewIfNeeded(message : String?) -> EmptyBackGroundView? {
        collectionView.isScrollEnabled = viewModel.datasource.value.count != 0
        
        guard viewModel.datasource.value.count == 0 , let message = message else {
            return nil
        }
        
        let viewEmptyBackGround = EmptyBackGroundView(message: message)
        viewEmptyBackGround.buttonClickedBlock = { [weak self] button in
            self?.loadPhotos()
        }
        viewEmptyBackGround.changeBackgroundColor(.lightGray)
        return viewEmptyBackGround
        
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
        viewModelSetup()
    }
    
    static func loadController(album : AlbumDM) -> ImageListController {
        let controller : ImageListController = UIStoryboard(storyboard: .main).instantiateViewController()
        controller.viewModel = ImageListViewModel(album: album)
        return controller
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

//-----------------------------------------------------
extension ImageListController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.datasource.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dataAtIndexPath = viewModel.datasource.value[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.cellIdentifier,
                                                      for: indexPath) as! PhotoCollectionCell
        cell.photo = dataAtIndexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.size.width - (numberOfItem + 1) * cellSpacing) / numberOfItem
        let height = width
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let photo = viewModel.datasource.value[indexPath.row]
//        navigateToPhotoDetail(photo: photo)
        navigateToPageController(currentIndex: indexPath.row)
    }
}
//-----------------------------------------------------
//MARK:- Navigation
extension ImageListController {
    func navigateToPhotoDetail(photo : PhotoDM) {
        let controller = PhotoDetailController.loadController(photo: photo)
        present(controller, animated: true, completion: nil)
    }
    
    func navigateToPageController(currentIndex : Int) {
        let controller = PhotoPageController.loadController(currentIndex: currentIndex, photos: viewModel.datasource.value)
        let navigationController = UINavigationController(presentController: controller)
        present(navigationController, animated: true, completion: nil)
    }
}
