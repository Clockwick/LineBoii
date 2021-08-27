//
//  StretchyFoodViewController.swift
//  LineBoii
//
//  Created by Paratthakorn Sribunyong on 27/8/2564 BE.
//

import UIKit
import GSKStretchyHeaderView

class StretchyFoodViewController: UIViewController{
    
    
    private var stretchyFoodHeaderView: StretchyFoodHeaderView?
    private var viewModel: FoodViewModel?
    
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupStretchyHeader()
        
    }
    
    private func setupStretchyHeader() {
        let headerSize = CGSize(width: self.view.width, height: 400)
        self.stretchyFoodHeaderView = StretchyFoodHeaderView(frame: CGRect(x: 0, y: 0, width: headerSize.width, height: headerSize.height))
        guard let stretchyFoodHeaderView = self.stretchyFoodHeaderView, let viewModel = self.viewModel else {
            return
        }
        stretchyFoodHeaderView.expansionMode = .immediate
        stretchyFoodHeaderView.maximumContentHeight = CGFloat(400)
        stretchyFoodHeaderView.minimumContentHeight = CGFloat(75)
        stretchyFoodHeaderView.initialize(with: viewModel, vc: self)
        
        tableView.addSubview(stretchyFoodHeaderView)
    }
    
    
    @objc private func didTapQuit() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    func configure(with viewModel: FoodViewModel) {
        self.viewModel = viewModel
    }
    
}


extension StretchyFoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}
