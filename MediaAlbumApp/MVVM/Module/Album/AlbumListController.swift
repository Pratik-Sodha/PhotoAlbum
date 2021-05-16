//
//  AlbumListController.swift
//  MediaAlbumApp
//
//  Created by APPLE on 14/05/21.
//

import UIKit

class AlbumListController: BaseController {

    //-----------------------------------------------------
    //MARK: IBOutlets
    @IBOutlet weak var tableView : UITableView!
    
    //-----------------------------------------------------
    //MARK: Properties
    var viewModel : AlbumViewModel!
    
    
    //-----------------------------------------------------
    //MARK: Custom Methods
    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Albums"
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AlbumTableCell.nib(), forCellReuseIdentifier: AlbumTableCell.cellIdentifier)
    }
    
    func viewModelSetup() {
        loadAlbums()
        
        viewModel.datasource.bind { (albums) in
            self.tableView.reloadData()
        }
        
        viewModel.apiResponseFailure.bind { (error) in
            self.tableView.backgroundView =  self.emptyBackgroundViewIfNeeded(message: error?.localizedDescription)
        }
    }
    
    func loadAlbums() {
        showLoader()
        viewModel.loadAlbums {[weak self] (success, error) in
            self?.stopLoader()
        }
    }
    
    func emptyBackgroundViewIfNeeded(message : String?) -> EmptyBackGroundView? {
        tableView.isScrollEnabled = viewModel.datasource.value.count != 0
        
        guard viewModel.datasource.value.count == 0 , let message = message else {
            return nil
        }
        
        let viewEmptyBackGround = EmptyBackGroundView(message: message)
        viewEmptyBackGround.buttonClickedBlock = { [weak self] button in
            self?.loadAlbums()
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
    
    static func loadController() -> AlbumListController {
        let controller : AlbumListController = UIStoryboard(storyboard: .main).instantiateViewController()
        controller.viewModel = AlbumViewModel()
        return controller
    }
}

//-----------------------------------------------------
extension AlbumListController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataAtIndexPath = viewModel.datasource.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableCell.cellIdentifier) as! AlbumTableCell
        
        cell.album = dataAtIndexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.datasource.value[indexPath.row]
        navigateToPhotoList(album: album)

    }
}
//-----------------------------------------------------
//MARK:- Navigation
extension AlbumListController {
    func navigateToPhotoList(album : AlbumDM) {
        let controller = ImageListController.loadController(album: album)
        navigationController?.pushViewController(controller, animated: true)
    }
}
