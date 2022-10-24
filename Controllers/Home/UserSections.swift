//
//  UserSections.swift
//  Store Project
//
//  Created by Arwa Farag on 29/06/2021.
//



import UIKit

class UserSetions : UIViewController {
    
    var RefreshControl : UIRefreshControl = UIRefreshControl()
    var Sections : [SectionObject] = []
    
    @IBOutlet weak var Tableview : UITableView!  { didSet {
        Tableview.delegate = self
        Tableview.dataSource = self
        
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpRefresher()
        GetData()
        
        
        Tableview.register(UINib(nibName: "SectionTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(AdminSetions.Reloaddata), name: NSNotification.Name(rawValue: "ReloadSection"), object: nil)
    }
    @objc func Reloaddata(){
        self.Sections = []
        self.Tableview.reloadData()
        GetData()
    }
    
    func GetData (){
        SectionApi.GetAllSections { (Section : SectionObject) in
            self.Sections.append(Section)
            DispatchQueue.main.async {
                self.Tableview.reloadData()
            }
        }
   
    }
    
}


extension UserSetions : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SectionTableViewCell
        cell.UpDate(Section : self.Sections[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Next", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? ProductInSection {
            if let indexrow = sender as? Int {
                next.InSection = Sections[indexrow]
            }
        }
        
    }
    
}
extension UserSetions {
    func SetUpRefresher(){
        self.RefreshControl.addTarget(self, action: #selector(MyProductsVC.RefreshNow), for: .valueChanged)
        RefreshControl.tintColor = UIColor.gray
        self.Tableview.addSubview(self.RefreshControl)
    }
    @objc func RefreshNow(){
        self.Sections = []
        self.Tableview.reloadData()
        self.GetData()
        self.RefreshControl.endRefreshing()
    }
}

