import UIKit

struct Restaurant {
    var name: String
    var subtext: String
    var address: String
    var status: String
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    /// Sample data for restaurants
    var restaurants: [Restaurant] = {
        let first = Restaurant(name: "Yummy Chinese", subtext: "Drinks are complimentary",
                               address: "Brooklyn, New York", status: "CLOSED")
        let second = Restaurant(name: "Paprika - Premium Italian Cuisine", subtext: "Free Wine",
                                address: "Manhattan, New York", status: "OPEN")
        let third = Restaurant(name: "Dugout", subtext: "Drinks at a flat rate of $10",
                               address: "Manhattan, New York", status: "OPEN")
        let restaurants = [first, second, third]
        return restaurants
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RestaurantCell", bundle: nil),
                           forCellReuseIdentifier: "rCell")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Table view data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rCell",
                                                 for: indexPath) as! RestaurantCell
        let row = indexPath.row
        cell.nameLabel.text = restaurants[row].name
        cell.subtextLabel.text = restaurants[row].subtext
        cell.addressLabel.text = restaurants[row].address
        cell.statusLabel.text = restaurants[row].status
        cell.configure()
        return cell
    }
}

