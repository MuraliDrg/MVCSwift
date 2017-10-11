//
//  MVCPopUp.swift
//  MVCSwift
//
//  Created by Sanginadam, Muralimohan on 11/10/17.
//  Copyright © 2017 DRG. All rights reserved.
//

import UIKit

class MVCPopUp: UIView,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var popUpArray:[LocationModel]? {
        didSet {
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
        }
    }
    
    private var arrayCount:Int{
        if let count = popUpArray?.count {
            return count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        let locationModel:LocationModel? = popUpArray?[indexPath.row]
        cell.textLabel?.text = locationModel?.longName;
        
        return cell
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    

}
