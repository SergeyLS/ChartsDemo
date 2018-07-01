//
//  CosViewController.swift
//  ChartsDemo
//
//  Created by Sergey Leskov on 6/21/18.
//  Copyright © 2018 Sergey Leskov. All rights reserved.
//

import UIKit
import Charts

class CosViewController: UIViewController {
    
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var percentUI: UILabel!
    
    var percent = 20 {
        didSet {self.didChangePercent()}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        chartView.isUserInteractionEnabled = false
        
        chartView.chartDescription?.enabled = false
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        chartView.maxVisibleCount = 60
        
        
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        
        chartView.leftAxis.axisMaximum = 1
        chartView.leftAxis.axisMinimum = -1
        
        chartView.xAxis.axisMinimum = -0.5
        chartView.xAxis.axisMaximum = 0.5
        
        chartView.xAxis.enabled = false
        
        chartView.backgroundColor = UIColor.black
        
        chartView.animate(yAxisDuration: 1)
        self.percent = 20
        updateChartData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didChangePercent()  {
        self.percentUI.text = String(self.percent) + "%"
        self.updateChartData()
    }
    
    
    func updateChartData() {
        
        self.setDataCount(1)
    }
    
    func setDataCount(_ count: Double) {
        
        //y=g*cos(6*pi*x)
        let amplitude: Double = Double(self.percent) / 100
        
        var entries:[BarChartDataEntry] = []
        
        for x in stride(from: -count, to: count, by: 0.001) {
            let forCos = 6 * .pi * Double(x)
            let entry = BarChartDataEntry(x: Double(x), y: (amplitude * cos(forCos)) )
            entries.append(entry)
        }
        
        let set = BarChartDataSet(values: entries, label: "Sinus Function")
        set.setColor(UIColor.green)
        
        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
        data.setDrawValues(false)
        data.barWidth = 0.001
        
        chartView.data = data
    }
    
    @IBAction func updateAction(_ sender: Any) {
        chartView.animate(yAxisDuration: 1)
    }
    
    @IBAction func plusAction(_ sender: Any) {
        var new = self.percent + 5
        new = new > 100 ? 100 : new
        self.percent = new
        
    }
    
    @IBAction func minusAction(_ sender: Any) {
        var  new = self.percent - 5
        new = new < 0 ? 0 : new
        self.percent = new
    }
    
}

extension CosViewController: ChartViewDelegate  {
    
}



