
import UIKit

class ModalTopSwipeCell: UICollectionViewCell {
    static let identifier = Constants.workoutModalTopSwipeCell
    override init(frame: CGRect) {
        super.init(frame: frame)
        workoutModalImage.frame = contentView.frame
        contentView.addSubview(workoutModalImage)
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.requiredInit)
    }
    lazy var workoutModalImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = DecaColor.decafitLightGray.color
        return image
    }()
}
