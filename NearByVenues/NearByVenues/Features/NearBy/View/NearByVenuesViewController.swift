//
//  ViewController.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import UIKit

class NearByVenuesViewController: UIViewController, NearByPlacesDelegate {
    
    @IBOutlet weak var placesTableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var aboutUsTextView: UITextView!
    
    var presenter = NearByPresenter()
    var places: [Place]?
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesTableView.register(UINib(nibName: "VenuesTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: VenuesTableViewCell.self))
        placesTableView.delegate = self
        placesTableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.getNearestVenues), for: .valueChanged)
        placesTableView.refreshControl = refreshControl
        presenter.delegate = self
    }
    @objc func getNearestVenues() {
        presenter
            .getNearByVenues()
    }
    func fetchedPlaces(result: [Place]) {
        DispatchQueue.main.async {
            self.places = result
            self.placesTableView.reloadData()
            self.placesTableView.refreshControl?.endRefreshing()
        }
    }
    func errorGettingPlaces(error: Error) {
        // show error
        self.placesTableView.refreshControl?.endRefreshing()
    }
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentController.selectedSegmentIndex {
        case 0:
            placesTableView.isHidden = false
            aboutUsTextView.isHidden = true
        default:
            placesTableView.isHidden = true
            aboutUsTextView.isHidden = false
        }
    }
}
extension NearByVenuesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VenuesTableViewCell", for: indexPath) as? VenuesTableViewCell {
            let place = places?[indexPath.row]
            cell.place = place
            return cell
        }
        return UITableViewCell()
    }
}

