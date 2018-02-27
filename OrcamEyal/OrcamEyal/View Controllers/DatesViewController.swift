//
//  DatesViewController.swift
//  OrcamEyal
//
//  Created by Eyal Silberman on 27/02/2018.
//  Copyright © 2018 Eyal Silberman. All rights reserved.
//

import UIKit

class DatesViewController: ShowDataViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = DatesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
       tableView.dataSource = self
    }

    override func showData() {
        viewModel.loadData()
        tableView.reloadData()
    }
}

extension DatesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.StoryboardIdentifiers.datesCell) as! DatesTableViewCell
        cell.label.text = viewModel.data[indexPath.row].toString()
        return cell
    }
}

extension DatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfDaysInMonth()
    }
}
