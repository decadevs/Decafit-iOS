
import UIKit

class ProgressBar: UIView {
    let shapeLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let timer = CATextLayer()
        timer.alignmentMode = .left
        timer.font = decaFont(size: 20, font: .poppinsMedium)
        timer.foregroundColor = DecaColor.decafitBlack.color.cgColor
        timer.backgroundColor = DecaColor.decafitPalePurple.color.cgColor
        timer.string = "00:02"
        timer.contentsScale = UIScreen.main.scale
        timer.frame = CGRect(x: 20, y: 50, width: 100, height: 35)
        layer.addSublayer(timer)
        
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(
            arcCenter: self.center, radius: 65,
            startAngle: -CGFloat.pi / 2, endAngle: 2*CGFloat.pi,
            clockwise: true)
        // create track layer
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = DecaColor.decafitLightGray.color.cgColor
        trackLayer.lineWidth = 6
        trackLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(trackLayer)

        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = DecaColor.decafitPurple.color.cgColor
        shapeLayer.lineWidth = 6
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        layer.addSublayer(shapeLayer)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.65
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basic")
    }
    
    @objc func handleTap() {
        animateCircle()
    }
}
