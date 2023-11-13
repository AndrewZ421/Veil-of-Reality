//
//  CircularProgressBarView.swift
//  Veil-of-Reality
//
//  Created by Andrew Zhao on 11/10/23.
//

import Foundation
import UIKit

@IBDesignable
class CircularProgressBarView: UIView {
    
    @IBInspectable var progress: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var additionalText: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 获取绘制上下文
        let context = UIGraphicsGetCurrentContext()
        
        // 计算圆心和半径
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let radius = min(centerX, centerY) - 5
        
        // 计算绘制的起始角度和结束角度
        let startAngle = -CGFloat.pi / 2
        let endAngle = 2 * CGFloat.pi * progress + startAngle
        
        // 创建圆弧的路径
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY),
                                radius: radius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        // 设置圆弧的线宽和颜色
        context?.setLineWidth(10)
        let color = #colorLiteral(red: 0.9989838004, green: 0.7470145822, blue: 0.6491046548, alpha: 1)
        
//        context?.setStrokeColor(UIColor.blue.cgColor)
        context?.setStrokeColor(color.cgColor)
        
        // 绘制圆弧
        context?.addPath(path.cgPath)
        context?.strokePath()
        
        // 在圆心显示文本和进度值
        let textAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        
        let text = additionalText + "\n" + String(Int(progress * 100)) + "%"
        let textSize = text.size(withAttributes: textAttributes)
        
        // 计算文本的绘制区域
        let textRect = CGRect(x: centerX - textSize.width / 2, y: centerY - textSize.height / 2, width: textSize.width, height: textSize.height)
        
        // 设置文本绘制的方式为居中对齐
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributedText = NSAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle
        ])
        
        // 绘制文本
        attributedText.draw(in: textRect)
    }

}
