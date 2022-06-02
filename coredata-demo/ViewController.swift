//
//  ViewController.swift
//  coredata-demo
//
//  Created by Vishal, Bhogal (B.) on 01/06/22.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: Create Context
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    /// Data for TableView
    var reminders: [Reminders]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //Fetch Core Data
        fetchData()
    }
    
    // MARK: Update Data in Container
    private func fetchData() {
        do {
            reminders = try context?.fetch(Reminders.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.title = "Reminders"
        navigationController?.navigationBar.titleTextAttributes = [ .font: UIFont.monospacedSystemFont(ofSize: 16, weight: .heavy)]
        setupNavigationBarTitle()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.backgroundColor = .vistaraYellow
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNavigationBarTitle() {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.vistaraPurple
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attrs
    }
    
    /// Create a table View
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 48
        tableView.backgroundColor = .vistaraPurple
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    /// Create a RightBarButtonItem
    lazy var rightBarButtonItem: UIBarButtonItem = {
       let barButton =  UIBarButtonItem(image: UIImage(systemName: "plus.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal),
                        style: .plain,
                        target: self,
                        action: #selector(tapActionForRightBarButton))
        return barButton
    }()
    
    
    // MARK: Create Data in Container
    lazy var tapAlertController: UIAlertController = {
        let alertController = UIAlertController(title: "Add Item",
                                                message: "This Item will be added into your Reminders",
                                                preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Add new Item"
        }
        
        // Declaration And actions of confirm Button
        let confirmButton = UIAlertAction(title: "Confirm", style: .default) { alertaction in
            // Get Value From TextField
            let textField = alertController.textFields?[0]
            
            //Create A Reminders Entity
            let reminders = Reminders(context: self.context!)
            reminders.item = textField?.text
            
            // Save the data
            do {
                try  self.context?.save()
            } catch {
                
            }
           
            // Reload the View
            self.fetchData()
        }
        
        // Declaration of Cancel Button
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(cancelButton)
        alertController.addAction(confirmButton)
        return alertController
    }()
    
    /// Tap Action For Right Bar Button
    @objc func tapActionForRightBarButton() {
        self.present(tapAlertController, animated: true, completion: nil)
    }
    
    /// SetupView
    func setupView() {
        view.backgroundColor = .vistaraPurple
        view.addSubview(tableView)
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
    }
}

// MARK: Read Data from Container
/// MARK: Table View DataSource methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        let text = reminders?[indexPath.section].item
        cell.configureCell(itemText: text ?? "")
        return cell
    }
}

// MARK: Delete Data in Container
/// MARK: Table view Delegate Methods
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextActions = UIContextualAction(style: .destructive,
                                                title: "Delete") { [weak self] action, view, _ in
            // Item To Remove
            let itemToRemove = self?.reminders?[indexPath.section]
            
            // Remove Item using Context
            self?.context?.delete(itemToRemove!)
            
            // Save Data
            do {
                try self?.context?.save()
            } catch {
                
            }
            self?.fetchData()
        }
        // Reload TableView

        return UISwipeActionsConfiguration(actions: [contextActions])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        reminders?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
}



