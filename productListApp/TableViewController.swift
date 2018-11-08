//
//  TableViewController.swift
//  iOSHW01
//
//  Created by Snigdha Bose on 11/5/18.
//  Copyright © 2018 UNC Charlotte. All rights reserved.
//

import Alamofire
import SDWebImage
import UIKit
var array = [String:[dataObject]]()


class dataObject {
    var category :String!;
    var releaseDate :String!;
    var title :String!;
    var developer :String!;
    var price :String!;
    var link :String!;
    var squareIcon :String!;
    var summary :String!;
    var otherImage :String!;
   
    convenience init?(json: [String: Any]) {
        guard let categoryValue = json["category"] as? String
            else {
                return nil
        }
        //fetch json data
        let devValue = json["developer"] as? String
        let linkValue = json["link"] as? String
        let summaryValue = json["summary"] as? String
        let titleValue = json["title"] as? String
        let priceValue = json["price"] as? String
        let dateValue = json["releaseDate"] as? String
        let otherImageValue = json["otherImage"] as? String
        let iconValue = json["squareIcon"] as? String
        
        self.init(category:categoryValue,developer:devValue,link:linkValue,otherImage:otherImageValue,releaseDate:dateValue, squareIcon:iconValue, price:priceValue,summary:summaryValue,title:titleValue)
    }
    required init?(category: String, developer:String?,link:String?,otherImage:String?,releaseDate:String?,squareIcon:String?,price:String?,summary:String?,title:String?) {
        self.category = category
        self.developer = developer
        self.link = link
        self.summary = summary
        self.title = title
        self.price = price
        self.releaseDate = releaseDate
        self.otherImage = otherImage
        self.squareIcon = squareIcon
       
        
    }
}
class TableViewController: UITableViewController {
    
    struct Data {
        var titleSection : String!
        var sectionData : [dataObject]!
    }
    
    var objDataArray = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return objDataArray.count
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objDataArray[section].sectionData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objDataArray[section].titleSection
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.blue
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    //utility function:
    func parseDateFormat(indate : String) -> String {
        let parser = DateFormatter()
        parser.dateFormat = "yy-MM-dd'T'HH:mm:ss"
        
        let dateValue = DateFormatter()
        dateValue.dateFormat = "MM dd,yy"
        
        if let date = parser.date(from: indate) {
            return dateValue.string(from: date)
        } else {
            return "Error in conversion"
        }
    }
    
    func mapData() -> Void {
        Alamofire.request("http://dev.theappsdr.com/apis/apps.json").responseJSON { response in
            if let json = response.result.value {
                print("data recieved in expected format")
                var data = response.result.value
            }
            guard let value = response.result.value as? [String: Any],
                let rows = value["feed"] as? [[String: Any]] else {
                    print("data format error")
                    return
            }
            let apps = rows.map { json in
                return dataObject(json: json)
            }
            
            array = Dictionary(grouping: apps, by: { $0!.category }) as! [String : [dataObject]]
            
            for (key, value) in array {
                print("\(key) -> \(value)")
                self.objDataArray.append(Data(titleSection: key, sectionData: value))
            }
            self.tableView.reloadData()
        }
        
    }

    //Returning cell with details:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let hasSummaryDescription = objDataArray[indexPath.section].sectionData[indexPath.row].summary != nil
        let hasLargeImage = objDataArray[indexPath.section].sectionData[indexPath.row].otherImage != nil
        if hasSummaryDescription {
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! descriptionTableViewCell
           cell.summary.text = objDataArray[indexPath.section].sectionData[indexPath.row].summary
           cell.name.text = objDataArray[indexPath.section].sectionData[indexPath.row].title
           cell.dev.text = objDataArray[indexPath.section].sectionData[indexPath.row].developer
           cell.date.text = objDataArray[indexPath.section].sectionData[indexPath.row].releaseDate
            cell.smallimage.sd_setImage(with: URL(string: objDataArray[indexPath.section].sectionData[indexPath.row].squareIcon), placeholderImage: UIImage(named: "someimage.png"))
           cell.price.text = objDataArray[indexPath.section].sectionData[indexPath.row].price
            return cell
        }
        else if hasLargeImage{
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageViewCell", for: indexPath) as! imageTableViewCell
           cell.largeimage.sd_setImage(with: URL(string: objDataArray[indexPath.section].sectionData[indexPath.row].otherImage), placeholderImage: UIImage(named: "someimage.png"))
           cell.name.text = objDataArray[indexPath.section].sectionData[indexPath.row].title
           cell.dev.text = objDataArray[indexPath.section].sectionData[indexPath.row].developer
           cell.date.text = objDataArray[indexPath.section].sectionData[indexPath.row].releaseDate
            cell.smallimage.sd_setImage(with: URL(string: objDataArray[indexPath.section].sectionData[indexPath.row].squareIcon), placeholderImage: UIImage(named: "someimage.png"))
           cell.price.text = objDataArray[indexPath.section].sectionData[indexPath.row].price
           return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)  as! mainTableViewCell
            cell.name.text = objDataArray[indexPath.section].sectionData[indexPath.row].title
            cell.dev.text = objDataArray[indexPath.section].sectionData[indexPath.row].developer
            cell.date.text = objDataArray[indexPath.section].sectionData[indexPath.row].releaseDate
            cell.smallimage.sd_setImage(with: URL(string: objDataArray[indexPath.section].sectionData[indexPath.row].squareIcon), placeholderImage: UIImage(named: "someimage.png"))
            cell.price.text = objDataArray[indexPath.section].sectionData[indexPath.row].price
            return cell
        }
        
    }
    
    
}




