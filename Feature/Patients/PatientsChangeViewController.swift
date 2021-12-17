//
//  PatientsChangeViewController.swift
//  Alodokter_bootcamp
//
//  Created by Ricky Austin on 17/12/21.
//

import UIKit

class PatientsChangeViewController: BaseViewController {
    @IBOutlet weak var pcTable: UITableView!
    @IBOutlet weak var pcAddButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Ganti Pasien"
        setTable()
        // Do any additional setup after loading the view.
    }
    
    func setTable(){
        pcTable.dataSource = self
        pcTable.delegate = self
        pcTable.register(UINib(nibName: "PatientsChangeTableCell", bundle: nil), forCellReuseIdentifier: "PatientsChangeTableCell")
    }

}

extension PatientsChangeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientsChangeTableCell", for: indexPath) as! PatientsChangeTableCell
        return cell
    }
    
}
