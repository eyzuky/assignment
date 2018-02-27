//
//  BluetoothViewController.swift
//  OrcamEyal
//
//  Created by Eyal Silberman on 27/02/2018.
//  Copyright © 2018 Eyal Silberman. All rights reserved.
//

import UIKit

class BluetoothViewController: ShowDataViewController {
    
    var viewModel = BluetoothViewModel()
   
    @IBOutlet weak var tableView: UITableView!
    //Mark: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.centralManager.delegate = viewModel
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: AppConstants.NotificationIdentifiers.foundBluetooth), object: nil)
    }

    
    @objc func reloadTable(){
        self.tableView.reloadData()
    }
    override func showData() {
        viewModel.loadData()
        
    }
    
}

extension BluetoothViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.StoryboardIdentifiers.bluetoothCell) as! BluetoothTableViewCell
        cell.label.text = viewModel.data[indexPath.row].toString()
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfDevices()
    }
}


