//
//  CosViewController.swift
//  ChartsDemo
//
//  Created by Sergey Leskov on 6/21/18.
//  Copyright © 2018 Sergey Leskov. All rights reserved.
//

import UIKit
import Charts

class Cos2ViewController: UIViewController {
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var percentUI: UILabel!
    
    var percent = 20 {
        didSet {self.didChangePercent()}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = false
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.legend.enabled = false
        
        // xAxis
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.enabled = false
        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0

//        // y-axis
//        let ll1 = ChartLimitLine(limit: 0.2, label: "")
//        ll1.lineWidth = 0.5
//        //ll1.lineDashLengths = [5, 5]
//        //ll1.labelPosition = .rightTop
//        //ll1.valueFont = .systemFont(ofSize: 10)
//        ll1.lineColor = .red
//
//        let ll2 = ChartLimitLine(limit: -0.2, label: "")
//        ll2.lineWidth = 0.5
//        //ll2.lineDashLengths = [5,5]
//        //ll2.labelPosition = .rightBottom
//        //ll2.valueFont = .systemFont(ofSize: 10)
//        ll2.lineColor = .red
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
//        leftAxis.addLimitLine(ll1)
//        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 1
        leftAxis.axisMinimum = -1
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.labelCount = 4
        leftAxis.labelTextColor = UIColor.white
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawLabelsEnabled = false
        leftAxis.drawZeroLineEnabled = true
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        chartView.backgroundColor = UIColor.black
        
        
        chartView.animate(xAxisDuration: 1)
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
        var sinus:[ChartDataEntry] = []
        var zoneTop:[ChartDataEntry] = []
        var zoneBottom:[ChartDataEntry] = []
        var lineCenter:[ChartDataEntry] = []
        
        for x in stride(from: -count, to: count, by: 0.001) {
            let forCos = 6 * .pi * Double(x)
            let entry = ChartDataEntry(x: Double(x), y: (amplitude * cos(forCos)) )
            sinus.append(entry)
            
            zoneTop.append(ChartDataEntry(x: Double(x), y: 0.2 ))
            zoneBottom.append(ChartDataEntry(x: Double(x), y: -0.2 ))
            lineCenter.append(ChartDataEntry(x: Double(x), y: 0))
        }
        
        
        let setTopLine = LineChartDataSet(values: zoneTop, label: "")
        setTopLine.drawIconsEnabled = false
        setTopLine.setColor(UIColor.blue)
        setTopLine.setCircleColor(UIColor.blue)
        setTopLine.lineWidth = 1
        setTopLine.circleRadius = 1
        setTopLine.drawCircleHoleEnabled = false
        setTopLine.formLineWidth = 1
        setTopLine.fill = Fill(color: UIColor.blue)
        setTopLine.drawFilledEnabled = true
        setTopLine.fillAlpha = 1
        
        let setBottomLine = LineChartDataSet(values: zoneBottom, label: "")
        setBottomLine.drawIconsEnabled = false
        setBottomLine.setColor(UIColor.blue)
        setBottomLine.setCircleColor(UIColor.blue)
        setBottomLine.lineWidth = 1
        setBottomLine.circleRadius = 1
        setBottomLine.drawCircleHoleEnabled = false
        setBottomLine.formLineWidth = 1
        setBottomLine.fill = Fill(color: UIColor.blue)
        setBottomLine.drawFilledEnabled = true
        setBottomLine.fillAlpha = 1

        let setCenterLine = LineChartDataSet(values: lineCenter, label: "")
        setCenterLine.drawIconsEnabled = false
        setCenterLine.setColor(UIColor.gray)
        setCenterLine.setCircleColor(UIColor.gray)
        setCenterLine.lineWidth = 1
        setCenterLine.circleRadius = 1
        setCenterLine.drawCircleHoleEnabled = false
        setCenterLine.formLineWidth = 1
  
        
        let set1 = LineChartDataSet(values: sinus, label: "")
        set1.drawIconsEnabled = false
        
        //set1.lineDashLengths = [5, 2.5]
        //set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(UIColor.green)
        set1.setCircleColor(UIColor.green)
        set1.lineWidth = 2
        set1.circleRadius = 2
        set1.drawCircleHoleEnabled = false
        //set1.valueFont = .systemFont(ofSize: 9)
        //set1.formLineDashLengths = [5, 2.5]
        set1.formLineWidth = 1
        //set1.formSize = 15
        
        
        
        let data = LineChartData(dataSets: [setTopLine, setBottomLine, setCenterLine, set1])
        
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

extension Cos2ViewController: ChartViewDelegate  {
    
}



