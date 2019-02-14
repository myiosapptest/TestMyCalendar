/*
 * CalendarDayCell.swift
 * Created by Michael Michailidis on 02/04/2015.
 * http://blog.karmadust.com/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit

open class CalendarDayCell: UICollectionViewCell {
    let textLabel   = UILabel()
    let dotsView    = UIView()
    let bgView      = UIView()
    
    override open var description: String {
        let dayString = self.textLabel.text ?? " "
        return "<DayCell (text:\"\(dayString)\")>"
    }
    
    var eventsCount = 0 {
        didSet {
            self.dotsView.isHidden = (eventsCount == 0)
            self.setNeedsLayout()
        }
    }
    
    
    var isToday : Bool = false {
        didSet {
            switch isToday {
            case true:
                self.bgView.backgroundColor = CalendarView.Style.cellColorToday
                self.textLabel.textColor    = CalendarView.Style.cellTextColorToday
//                self.textLabel.text    = "Test"
            case false:
//                self.bgView.backgroundColor = CalendarView.Style.cellColorDefault
                self.bgView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                self.textLabel.textColor = CalendarView.Style.cellTextColorDefault
                
                self.textLabel.text    = (self.textLabel.text ?? "") + ""
//                self.textMoonLabel.text    = (self.textMoonLabel.text ?? "") + "(s)"
//                self.textMoonLabel.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
        }
    }
    
    var isWeekend: Bool = false {
        didSet {
            if self.isToday { return }
            switch isWeekend {
            case true:
                self.textLabel.textColor = CalendarView.Style.cellTextColorWeekend
            case false:
                self.textLabel.textColor = CalendarView.Style.cellTextColorDefault
                self.textMoonLabel.text    = (self.textMoonLabel.text ?? "") + "(s)"
//                self.textMoonLabel.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
        }
    }
    
    override open var isSelected : Bool {
        didSet {
            switch isSelected {
            case true:
                self.bgView.layer.borderColor = CalendarView.Style.cellSelectedBorderColor.cgColor
                self.bgView.layer.borderWidth = CalendarView.Style.cellSelectedBorderWidth
            case false:
                self.bgView.layer.borderColor = CalendarView.Style.cellBorderColor.cgColor
                self.bgView.layer.borderWidth = CalendarView.Style.cellBorderWidth
            }
        }
    }
    
    
    
    
    let textMoonLabel = UILabel()
    
    override init(frame: CGRect) {
        self.textLabel.textAlignment = NSTextAlignment.center
        self.textMoonLabel.textAlignment = NSTextAlignment.left
        
        self.dotsView.backgroundColor = CalendarView.Style.cellEventColor
        
        super.init(frame: frame)
        
        self.addSubview(self.bgView)
        self.addSubview(self.textLabel)
        
        self.addSubview(self.dotsView)
        self.addSubview(self.textMoonLabel)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        var elementsFrame = self.bounds.insetBy(dx: 3.0, dy: 3.0)
        
        if CalendarView.Style.cellShape.isRound { // square of
            let smallestSide = min(elementsFrame.width, elementsFrame.height)
            elementsFrame = elementsFrame.insetBy(
                dx: (elementsFrame.width - smallestSide) / 2.0,
                dy: (elementsFrame.height - smallestSide) / 2.0
            )
        }
        
        self.bgView.frame           = elementsFrame
        self.textLabel.frame        = elementsFrame
        self.textMoonLabel.frame        = elementsFrame
        
        let size                            = self.bounds.height * 0.08 // always a percentage of the whole cell
        self.dotsView.frame                 = CGRect(x: 0, y: 0, width: size, height: size)
        self.dotsView.center                = CGPoint(x: self.textLabel.center.x, y: self.bounds.height - (2.5 * size))
        self.dotsView.layer.cornerRadius    = size * 0.5 // round it
        
//        self.dotsView.center                = CGPoint(x: self.textMoonLabel.center.x, y: self.bounds.height - (2.5 * size))
        
        switch CalendarView.Style.cellShape {
        case .square:
            self.bgView.layer.cornerRadius = 0.0
        case .round:
            self.bgView.layer.cornerRadius = elementsFrame.width * 0.5
        case .bevel(let radius):
            self.bgView.layer.cornerRadius = radius
        }
        
        
    }
    
}


