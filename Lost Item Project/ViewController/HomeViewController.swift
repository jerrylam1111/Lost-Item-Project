//
//  HomeViewController.swift
//  Lost Item Project
//
//  Created by Hei Lok Keith Kong on 13/9/2022.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {
    
    var delegate: HomeViewControllerDelegate?
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupSegmentedControl()
        updateView()
    }
    
    // set up toggle button [Map / List]
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Map", at: 0, animated: false)
            segmentedControl.insertSegment(withTitle: "List", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    // switch from map to list / list to map
    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    // lazy: initialize the map view only when selected
    private lazy var mapViewController: MapViewController = {
        // get and add map view from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.add(asChildViewController: vc)
        return vc
    }()
    
    // lazy: initialize the map view only when selected/
    private lazy var listViewController: ListViewController = {
        // get and add list view from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "ListViewController") as!
            ListViewController
        self.add(asChildViewController: vc)
        return vc
    }()
    
    // add a subview from another View Controller
    func add(asChildViewController vc: UIViewController) {
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
    }
    
    // remove the current view from the current View Controller
    private func remove(asChildViewController vc:UIViewController) {
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            // map --> list
            remove(asChildViewController: listViewController)
            add(asChildViewController:  mapViewController)
        } else {
            // list --> map
            remove(asChildViewController: mapViewController)
            add(asChildViewController: listViewController)
        }
    }
    
    // side menu button pressed
    @IBAction func toggleLeft(_ sender: Any) {
        // handled in ContainerViewController
        delegate?.toggleSideView()
    }
}

// define mandatory functions to be handled in ContainerViewController
protocol HomeViewControllerDelegate {
  func toggleSideView()
}
