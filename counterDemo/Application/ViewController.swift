//
//  ViewController.swift
//  counterDemo
//
//  Created by Chanon Latt on 23/3/23.
//  Copyright © 2023 pich. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

// MARK: - Apply with ReactorKit

/** Notes:  Importance ReactorKit parts in ViewController
 + func bind(reactor: ): executed after you initialize the reactor variable from viewDidLoad or set by outside
 */

/** Notes:  View Controller ReatorKit implementation
 1.  import ReactorKit
 2.  conform to protocol View or StoryboardView
 + implement property disposeBag
 + implement method bind():
 - bind your action from view controller to Action enum in view model
 - bind your state in view model with you view that you want to display
 3. initialze reactor: can be initialize from viewDidLoad or set by outside
 */

class ViewController: UIViewController, View {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = ViewModel()
    }
    
    func bind(reactor: ViewModel) {
        increaseButton.rx
            .tap
            .map({ViewModel.Action.tapIncrease})
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        clearButton.rx
            .tap
            .map({ViewModel.Action.tapClear})
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map({String($0.currentNumber)})
            .bind(to: numberLabel.rx.text)
            .disposed(by: disposeBag)
    }
}



// MARK: - Apply with Normal ViewModel
//class ViewController: UIViewController {
//
//    @IBOutlet weak var numberLabel: UILabel!
//    @IBOutlet weak var increaseButton: UIButton!
//    @IBOutlet weak var clearButton: UIButton!
//
//    private let viewModel = ViewModel()
//    private let disposeBag = DisposeBag()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        bindViewModel()
//    }
//
//    private func bindViewModel() {
//        viewModel.currentNumber
//            .map({String($0)})
//            .bind(to: numberLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        increaseButton.rx
//            .tap
//            .subscribe { [unowned self] _ in
//                let increasedValue = viewModel.currentNumber.value + 1
//                viewModel.currentNumber.accept(increasedValue)
//            }
//            .disposed(by: disposeBag)
//
//        clearButton.rx
//            .tap
//            .subscribe { [unowned self] _ in
//                viewModel.currentNumber.accept(.zero)
//            }
//            .disposed(by: disposeBag)
//    }
//}
