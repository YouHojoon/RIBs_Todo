//
//  TodoListViewController.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import RxCocoa
import RxDataSources
import RxViewController
protocol TodoListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func registeredTodo(title: String, detail: String)
}

final class TodoListViewController: UIViewController, TodoListPresentable, TodoListViewControllable {

    weak var listener: TodoListPresentableListener?
    var data = BehaviorRelay<[String]>(value: [])
    
    var disposeBag = DisposeBag()
    
    init(email: String, password: String){
        self.email = email
        self.password = password
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.loadData()
        self.initTableView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.disposeBag = DisposeBag()
    }
    
    func loadData(){
        let data = UserDefaultManager.todoList
        self.data.accept(data)
    }
    //MARK: - Private
    private let email: String
    private let password: String
    
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = self.email
        self.view.addSubview(label)
        
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        view.addSubview(button)
        
        button.rx.tap
        .subscribe(onNext: { [weak self] in
            self?.alertWithTF()
        }).disposed(by: disposeBag)
        
        return button
    }()
    
    private lazy var topContainerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        self.view.addSubview(view)

        view.snp.makeConstraints{
            $0.top.equalTo(self.view.snp.top)
            $0.leading.trailing.equalTo(self.view)
            $0.height.equalTo(50)
        }

        self.emailLabel.snp.makeConstraints{
            $0.centerY.centerX.equalTo(view)
        }

        self.addButton.snp.makeConstraints{
            $0.centerY.equalTo(view)
            $0.trailing.equalTo(view.snp.trailing).inset(12)
        }
        
        return view
    }()
 
    private var tableView: UITableView?
    
    private func initTableView(){
        self.tableView = {
            let tableView = UITableView()

            _ =  self.data.bind(to: tableView.rx.items(cellIdentifier: "tableViewCell", cellType: UITableViewCell.self)){index, item, cell in
                 cell.textLabel?.text = item
            }.disposed(by: disposeBag)

            self.view.addSubview(tableView)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")

            tableView.snp.makeConstraints{
                $0.top.equalTo(self.topContainerView.snp.bottom)
                $0.leading.bottom.trailing.equalTo(self.view)
            }

            return tableView
        }()
    }
    private func alertWithTF() {
             let alert = UIAlertController(title: "메모", message: "메모를 입력해주세요", preferredStyle: UIAlertController.Style.alert )
             let save = UIAlertAction(title: "저장", style: .default) {[weak self] _ in
                 let textField1 = alert.textFields![0] as UITextField
                 let textField2 = alert.textFields![1] as UITextField
                 let title = textField1.text ?? ""
                 let description = textField2.text ?? ""

                 UserDefaultManager.todoList.append(title)
                 UserDefaultManager.detail.append(description)
                self?.data.accept(UserDefaultManager.todoList)
                self?.listener?.registeredTodo(title: title, detail: description)
             }

             alert.addTextField { (textField) in
                 textField.placeholder = "타이틀 입력"
                 textField.textColor = .black
             }
             alert.addTextField { (textField) in
                 textField.placeholder = "세부내용 입력"
                 textField.textColor = .darkGray
             }
             alert.addAction(save)

             let cancel = UIAlertAction(title: "취소", style: .default) { (alertAction) in }
             alert.addAction(cancel)
             self.present(alert, animated:true, completion: nil)
         }
}

