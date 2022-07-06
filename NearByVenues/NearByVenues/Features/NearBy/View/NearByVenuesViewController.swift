//
//  ViewController.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import UIKit

class NearByVenuesViewController: UIViewController {

    @IBOutlet weak var placesTableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var aboutUsTextView: UITextView!
    
    var viewModel = NearByViewModel()
    var places: [Place]?
    
    let dataManager = coreDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        placesTableView.register(UINib(nibName: "VenuesTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: VenuesTableViewCell.self))
        placesTableView.delegate = self
        placesTableView.dataSource = self
        viewModel
            .getNearByVenues(latitude: 29.978659, longitude: 31.280244) {[unowned self] (result: Result<[Place], Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.places = response
                    self.placesTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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

