//
//  LoggedOutViewController.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import RxCocoa

protocol LoggedOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func didLogin(withEmail: String?, _ password: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    var disposeBag = DisposeBag()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.borderStyle = .line
        view.addSubview(textField)
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.borderStyle = .line
        view.addSubview(textField)
        
        return textField
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        view.addSubview(button)
        button.rx.tap.subscribe(onNext: {_ in self.listener?.didLogin(withEmail: self.emailTextField.text, self.passwordTextField.text)})
            .disposed(by: disposeBag)
        return button
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disposeBag = DisposeBag()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout(){
        self.emailTextField.snp.makeConstraints{
            $0.top.equalTo(view).offset(120)
            $0.leading.trailing.equalTo(view).inset(40)
            $0.height.equalTo(40)
        }
        
        self.passwordTextField.snp.makeConstraints{
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(emailTextField)
        }
        
        self.confirmButton.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.trailing.height.equalTo(passwordTextField)
        }
    }
    
}
