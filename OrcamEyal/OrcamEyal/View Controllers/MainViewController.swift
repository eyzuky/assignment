//
//  MainViewController.swift
//  OrcamEyal
//
//  Created by Eyal Silberman on 27/02/2018.
//  Copyright © 2018 Eyal Silberman. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    
    enum SegmentIndices: Int {
        case Vc1 = 0
        case Vc2 = 1
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var selectedViewController: ShowDataViewController?
    
    //Mark: Child view controllers
    
    lazy var vc1: DatesViewController? = {
        let storyboard = UIStoryboard(name: AppConstants.StoryboardIdentifiers.mainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: AppConstants.StoryboardIdentifiers.vc1) as? DatesViewController
        return vc
    }()
    lazy var vc2: BluetoothViewController? = {
        let storyboard = UIStoryboard(name: AppConstants.StoryboardIdentifiers.mainStoryboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: AppConstants.StoryboardIdentifiers.vc2) as? BluetoothViewController
        return vc
    }()
    
    var containedViewController: UIViewController?

    //Mark: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        showCorrectView()
    }
    
    //Mark: Segment control implementations
    func showCorrectView() {
        let segment = SegmentIndices.init(rawValue: segmentedControl.selectedSegmentIndex) ?? SegmentIndices.Vc1
        switch segment {
        case .Vc1:
            selectedViewController = vc1
        case .Vc2:
            selectedViewController = vc2
        }
        vc1?.view.isHidden = segmentedControl.selectedSegmentIndex != 0
        vc2?.view.isHidden = segmentedControl.selectedSegmentIndex != 1
    }

    private func setupSegmentedControl() {
        //initialize the segment control
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "VC1", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "VC2", at: 1, animated: true)
        segmentedControl.addTarget(self, action: #selector(selectionChanged(sender:)), for: .valueChanged)
        //default value
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc func selectionChanged(sender: UISegmentedControl) {
        showCorrectView()
    }
    
    //load current vc data
    @IBAction func showDataTapped(_ sender: UIButton) {
        selectedViewController?.showData()
    }
    
    //setup the container view in prepare to segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        if identifier == AppConstants.SegueIdentifiers.container {
            containedViewController = segue.destination
            let vc1 = self.vc1
            let vc2 = self.vc2
            guard
                let vc1View = vc1?.view,
                let vc2View = vc2?.view
            else {return}
            containedViewController?.view.addSubview(vc1View)
            containedViewController?.view.addSubview(vc2View)
        }
    }
    
    
}
