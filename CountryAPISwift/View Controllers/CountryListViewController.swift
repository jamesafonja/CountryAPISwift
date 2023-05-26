//
//  CountryListViewController.swift
//  CountryTest
//
//  Created by James Afonja on 5/26/23.
//

import UIKit

class CountryListViewController: UIViewController {
    @IBOutlet weak private var countryTableView: UITableView!
    @IBOutlet weak private var animationLoader: UIActivityIndicatorView!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    var viewModel: CountryListViewModel = CountryListViewModel(service: CountriesService.shared)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.register(UINib(nibName: K.countryCellId, bundle: nil), forCellReuseIdentifier: K.countryCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.current.userInterfaceIdiom == .pad {
            searchBar.searchTextField.font = UIFont(name: K.searchBarFontName, size: 30)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fecthCountriesList()
    }
    
    func fecthCountriesList() {
        viewModel.getCountries { [weak self] countries, error in
            DispatchQueue.main.async {
                
                self?.animationLoader.isHidden = true
                
                if countries.isEmpty {
                    self?.showAlertView(message: error?.description ?? "")
                }else {
                    self?.searchBar.isUserInteractionEnabled = true
                    self?.viewModel.countries = countries
                    self?.countryTableView.reloadData()
                }
            }
        }
    }
    
}

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.finalCountryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = countryTableView.dequeueReusableCell(withIdentifier: K.countryCellId, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        
        let country = viewModel.finalCountryArray[indexPath.row]

        cell.countryNameLabel.text = viewModel.nameAndRegion(for: country)
        cell.countryCodeLabel.text = viewModel.code(for: country)
        cell.countryCapitalLabel.text = viewModel.capital(of: country)
        
        return cell
    }
}

extension CountryListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CountryListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterNameAndRegionArray(targetText: searchText) { counteryList in
            viewModel.finalCountryArray = counteryList
            self.countryTableView.reloadData()
        }
    }
}

extension CountryListViewController {
    
    func showAlertView(message: String) {
        let alert = UIAlertController(title: K.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: K.alertButtonTitle, style: .default))
        self.present(alert, animated: true)
    }
    
}

