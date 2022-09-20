import Foundation
final class ObservableObject<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }
//    private var listener1: [ ((T) -> Void)? ]
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    func bind(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listener = listener
    }

}
