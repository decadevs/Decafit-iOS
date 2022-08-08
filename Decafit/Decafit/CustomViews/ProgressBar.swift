import UIKit

class ProgressBar: UIView {
    let progressLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createProgressView()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    func createProgressView() {
        let circleLayer = CAShapeLayer()
        let circularPath = UIBezierPath(
            arcCenter: self.center, radius: 65,
            startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians,
            clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.strokeColor = DecaColor.decafitLightGray.color.cgColor
        circleLayer.lineWidth = 6
        circleLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(circleLayer)
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = DecaColor.decafitPurple.color.cgColor
        progressLayer.lineWidth = 6
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }
    func setProgress(duration: TimeInterval = 3) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        progressLayer.add(animation, forKey: "animationProgress")
    }
    func pauseAnimation() {
      let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
      layer.speed = 0.0
      layer.timeOffset = pausedTime
    }
    func resumeAnimation() {
      let pausedTime = layer.timeOffset
      layer.speed = 1.0
      layer.timeOffset = 0.0
      layer.beginTime = 0.0
      let timeSincePause = layer.convertTime(
        CACurrentMediaTime(), from: nil) - pausedTime
      layer.beginTime = timeSincePause
    }
}
