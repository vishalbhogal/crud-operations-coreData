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
        navigationController?.navigationBar.titleTextAttributes = [ .font: UIFont.monospacedSystemFont(ofSize: 16, weight: .semibold)]
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /// Create a table View
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    /// Create a RightBarButtonItem
    lazy var rightBarButtonItem: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                        style: .plain,
                        target: self,
                        action: #selector(tapActionForRightBarButton))
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
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
    }
}

// MARK: Read Data from Container
/// MARK: Table View DataSource methods
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reminders?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text = reminders?[indexPath.row].item
        cell.textLabel?.text = text
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
            let itemToRemove = self?.reminders?[indexPath.row]
            
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
}



