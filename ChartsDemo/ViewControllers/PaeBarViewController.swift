//
//  PaeBarViewController.swift
//  ChartsDemo
//
//  Created by Sergey Leskov on 6/22/18.
//  Copyright © 2018 Sergey Leskov. All rights reserved.
//

import UIKit
import Charts

class PaeBarViewController: UIViewController {
    
    @IBOutlet weak var chartView: PieChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self
        
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription?.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView.drawCenterTextEnabled = true
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        
        chartView.legend.enabled = false
        chartView.setExtraOffsets(left: 20, top: 0, right: 20, bottom: 0)
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        
        self.updateChartData()
    }
    
    
    func updateChartData() {
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        self.setDataCount(count: 4)
    }
    
    
    func setDataCount(count: Int) {
        
        var colors: [UIColor] = []
        
        var entries:[PieChartDataEntry] = []
        
        entries.append(PieChartDataEntry(value: Double(Int(arc4random_uniform(100)))))
        colors.append(UIColor.yellow)
        
        entries.append(PieChartDataEntry(value: Double(arc4random_uniform(100))))
        colors.append(UIColor.blue)
        
        entries.append(PieChartDataEntry(value: Double(arc4random_uniform(100))))
        colors.append(UIColor.green)
        
        entries.append(PieChartDataEntry(value: Double(arc4random_uniform(100))))
        colors.append(UIColor.red)
        
        entries.append(PieChartDataEntry(value: Double(arc4random_uniform(100))))
        colors.append(UIColor.brown)
       
        let set = PieChartDataSet(values: entries, label: "Election Results")
        set.sliceSpace = 2

        set.colors = colors
        
        set.valueLinePart1OffsetPercentage = 0.8
        set.valueLinePart1Length = 0.2
        set.valueLinePart2Length = 0.4
        //set.xValuePosition = .outsideSlice
        set.yValuePosition = .outsideSlice
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 20, weight: .light))
        data.setValueTextColor(.black)
        
        chartView.data = data
        chartView.highlightValues(nil)
    }
    
    
    @IBAction func updateAction(_ sender: Any) {
        
        updateChartData()
    }
    
}


extension PaeBarViewController: ChartViewDelegate  {
    
}

