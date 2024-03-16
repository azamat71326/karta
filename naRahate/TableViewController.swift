import UIKit

class TableViewController: UITableViewController {
    
    var arrayNames = ["Kfc", "Burgerking", "Kazburger"]
    var arrayImage = ["1", "2", "3"]
    var arrayLatitude = [47.11187448579876, 48.123456, 49.987654] // Координаты для каждого места
    var arrayLongitude = [51.90455360968121, 52.654321, 53.135792]
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = arrayNames[indexPath.row]
        
        let imageview = cell.viewWithTag(1001) as! UIImageView
        imageview.image = UIImage(named: arrayImage[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! ViewController
        
        detailVc.name = arrayNames[indexPath.row]
        detailVc.imageName = arrayImage[indexPath.row]
        detailVc.latitude = arrayLatitude[indexPath.row] // Передача координат
        detailVc.longitude = arrayLongitude[indexPath.row]
        
        navigationController?.pushViewController(detailVc, animated: true)
    }
}

