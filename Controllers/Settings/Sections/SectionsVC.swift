//
//  SectionsVC.swift
//  Store Project
//
//  Created by Arwa Farag on 29/06/2021.
//

import UIKit

protocol SelectedSectionDelegate {
    func SelectedSection(Section : SectionObject)
}


class SectionsVC : UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var delegate : SelectedSectionDelegate!
    
    @IBAction func Done(_ sender: Any) {
        if let Section = self.SelectedSection {
        delegate.SelectedSection(Section: Section)
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    var SelectedSection : SectionObject?
    var Sections : [SectionObject] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SectionTableViewCell
        
        if Sections[indexPath.row].ID == SelectedSection?.ID {
            Cell.Label.backgroundColor = UIColor.green
            Cell.Label.textColor = UIColor.white
        }else {
            Cell.Label.backgroundColor = UIColor.white
            Cell.Label.textColor = UIColor.black
        }
        Cell.Label.text = Sections[indexPath.row].Name
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Sections[indexPath.row].Selected = true
        self.SelectedSection = Sections[indexPath.row]
        TableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
   
    
    @IBOutlet weak var TableView: UITableView! { didSet{
        TableView.delegate = self; TableView.dataSource = self }  }
    
    func SetUpTableView() {
        TableView.register(UINib(nibName: "SectionTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        GetSections()
    }
    func GetSections() {
        SectionApi.GetAllSections { (Section: SectionObject) in
            self.Sections.append(Section)
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpTableView()
        
        
    }
}
