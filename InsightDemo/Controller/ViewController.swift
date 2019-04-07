//
//  ViewController.swift
//  InsightDemo
//
//  Created by AhemadAbbas Vagh on 06/04/19.
//  Copyright © 2019 AhemadAbbas Vagh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sightWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var sightView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var insightStatusSwitch: UISwitch!
    @IBOutlet weak var insightTableView: UITableView! {
        didSet {
            insightTableView.estimatedRowHeight = 100
            insightTableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    var shouldShowReadMore = false
    
    var expandedCells = Set<Int>()
    
    var colors: [UIColor] = [UIColor.green,UIColor.red,UIColor.gray,UIColor.purple,UIColor.yellow,UIColor.blue,UIColor.brown,UIColor.black,UIColor.green,UIColor.red,UIColor.gray,UIColor.purple,UIColor.yellow,UIColor.blue,UIColor.brown,UIColor.black,UIColor.green,UIColor.red,UIColor.gray,UIColor.purple,UIColor.yellow,UIColor.blue,UIColor.brown,UIColor.black]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        toggleInsight()
    }

    func registerCell() {
        mainTableView.register(UINib(nibName: "tableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        insightTableView.register(UINib(nibName: "InsightTableViewCell", bundle: nil), forCellReuseIdentifier: "InsightTableViewCell")
    }
    
    func toggleInsight() {
    mainTableView.scrollToTop()
      insightTableView.scrollToTop()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            if InsightManager.shared.isInsightOpen {
                self.sightView.isHidden = false
                self.insightStatusSwitch.isOn = true
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
                    
                    self.sightView.frame = CGRect(x: self.mainTableView.frame.width / 2.0, y: self.mainTableView.frame.origin.y, width: self.mainTableView.frame.width / 2.0, height: self.mainTableView.frame.height)
                    self.sightWidthConstant.constant = self.mainTableView.frame.width / 2
                    self.sightView.layoutIfNeeded()
                    
                }, completion: nil)
            } else {
               
                UIView.animate(withDuration: 0.3, delay: 0.0,options: .curveEaseOut, animations: {
                    self.sightWidthConstant.constant = 0
                    self.sightView.layoutIfNeeded()
                }, completion: { (_) in
                     self.sightView.isHidden = true
                    self.insightStatusSwitch.isOn = false
                })
                
            }
        }
       
    }
    
    @IBAction func insightSwitchTapped(_ sender: UISwitch) {
        InsightManager.shared.isInsightOpen = sender.isOn ? true : false
            toggleInsight()
    }
    
    @IBAction func swipeToToggleMenu(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizer.Direction.left {
            InsightManager.shared.isInsightOpen =  true
        } else {
            InsightManager.shared.isInsightOpen =  false
        }
        
        toggleInsight()
    }
    
    override func viewDidLayoutSubviews() {
        insightTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == mainTableView {
            insightTableView.contentOffset = scrollView.contentOffset
        } else {
            mainTableView.contentOffset = scrollView.contentOffset
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == mainTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! tableViewCell
             cell.viewColor.backgroundColor = colors[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InsightTableViewCell", for: indexPath) as! InsightTableViewCell
         //   cell.textView.shouldTrim = !expandedCells.contains(indexPath.row)
            cell.textView.setNeedsUpdateTrim()
            cell.textView.layoutIfNeeded()
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
    /*
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == insightTableView {
            let cell = tableView.cellForRow(at: indexPath) as? InsightTableViewCell
        cell?.textView.onSizeChange = { [unowned tableView, unowned self] r in
                let point = tableView.convert(r.bounds.origin, from: r)
                guard let indexPath = tableView.indexPathForRow(at: point) else { return }
                if r.shouldTrim {
                    self.expandedCells.remove(indexPath.row)
                } else {
                    self.expandedCells.insert(indexPath.row)
                }
                tableView.reloadData()
            }
        }
    }
    */

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == insightTableView {
           
//            if shouldShowReadMore {
//                return UITableView.automaticDimension
//            } else {
                return 333.0
           // }
            
        }else {
            return 333.0
        }
        
    }
    
}

extension UITableView {
    func scrollToTop() {
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}


class InsightManager {
    
    static let shared = InsightManager()
    
    var isInsightOpen = false
    
    private init() {
        
    }
}
