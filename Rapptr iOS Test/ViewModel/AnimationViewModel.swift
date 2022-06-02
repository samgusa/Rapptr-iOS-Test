import Foundation
import Combine


struct AnimationViewModel {

  var activateFading = CurrentValueSubject<Bool, Never>(false)
  var changeBackgroundColor = PassthroughSubject<Void, Never>()
  var cancellable = Set<AnyCancellable>()

}
