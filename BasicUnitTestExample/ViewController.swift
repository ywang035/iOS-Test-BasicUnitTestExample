//
//  ViewController.swift
//  BasicUnitTestExample
//
//  Created by Joe Wang on 7/12/21.
//

import UIKit

class ViewController: UIViewController {

    private let dummyDatabase = [User(username: "Joewang", password: "1234567")]

    private let validationService: ValidationService

    init(validationService: ValidationService) {
        self.validationService = validationService
        super.init()
    }

    required init?(coder: NSCoder) {
        self.validationService = ValidationService()
        super.init(coder: coder)
    }


    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name:"ArialRoundedMTBold", size: 40.0)
        return label
    }()

    private let textfieldContainer: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fill
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()

    private let usernameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "username"
        textfield.backgroundColor = .white
        textfield.borderStyle = .roundedRect
        return textfield
    }()


    private let passwordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "password"
        textfield.backgroundColor = .white
        textfield.borderStyle = .roundedRect
        textfield.isSecureTextEntry = true
        return textfield
    }()


    private let submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 6
        button.setContentHuggingPriority(.defaultLow, for: .vertical)
        button.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        buildView()
        buildLayout()
    }

    private func buildView() {

        view.backgroundColor = .white

        textfieldContainer.addArrangedSubview(usernameTextfield)
        textfieldContainer.addArrangedSubview(passwordTextfield)

        view.addSubview(welcomeLabel)
        view.addSubview(textfieldContainer)
        view.addSubview(submitButton)

    }

    private func buildLayout() {

        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 70),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            textfieldContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textfieldContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textfieldContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            usernameTextfield.widthAnchor.constraint(equalTo: textfieldContainer.widthAnchor),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 50),

            passwordTextfield.widthAnchor.constraint(equalTo: textfieldContainer.widthAnchor),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 50),

            submitButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -70),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func didTapSubmitButton() {
        do {
            let username = try validationService.validateUsername(usernameTextfield.text)
            let password = try validationService.validatePassword(passwordTextfield.text)

            // login to database
            if let user = dummyDatabase.first(where: { user in
                user.username == username && user.password == password
            }) {
                let alert = UIAlertController(title: "Yeah!", message: "Login success as \(user.username)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
            } else {
                throw LoginError.invalidCredentials
            }
        } catch {
            let alert = UIAlertController(title: "Oops!", message: "\(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension ViewController {
    enum LoginError: LocalizedError {
        case invalidCredentials

        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Incorrect username or password. Plase try again.", comment: "")
            }
        }
    }
}

