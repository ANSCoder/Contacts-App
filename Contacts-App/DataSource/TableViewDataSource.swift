//
//  TableViewDataSource.swift
//  Contacts-App
//
//  Created by Anand Nimje on 07/11/19.
//  Copyright © 2019 Anand. All rights reserved.
//

import UIKit

class TableViewDataSource <Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource {

    typealias CellConfigurator = (Model, Cell) -> Void

    var models: [Model]
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model],
         reuseIdentifier: String,
         cellType: Cell.Type = Cell.self,
         cellConfigurator: @escaping CellConfigurator) {
        
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
            ) as! Cell
        
        cellConfigurator(model, cell)
        
        return cell
    }
    
}
