//
//  EmptyBackGroundView.swift
//  MediaAlbumApp
//
//  Created by APPLE on 15/05/21.
//

import UIKit

class EmptyBackGroundView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private var btnAction : UIButton!
    @IBOutlet private var lblInfo : UILabel!

    typealias ActionButtonClickedBlock = (_ button: UIButton)->()
    var buttonClickedBlock: ActionButtonClickedBlock?
    
    
    //MARK:
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadViewFromNib()
    }
    
    init(message : String) {
        super.init(frame : .zero)
        loadViewFromNib()
        self.lblInfo.text = message
        
    }
    
    //MARK:
    func loadViewFromNib() {
        contentView = Bundle.main.loadNibNamed(EmptyBackGroundView.nibName, owner: self, options: nil)?[0] as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        addSubview(contentView)
    }
    
    //Custom Method
    @IBAction func btnActionClicked(_ sender: UIButton) {
        self.buttonClickedBlock?(sender)
    }
    
    func changeBackgroundColor(_ color : UIColor) {
        lblInfo.textColor = color
    }
    
    func change(message : String) {
        lblInfo.text = message
    }
}
