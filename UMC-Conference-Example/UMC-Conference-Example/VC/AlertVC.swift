//
//  AlertVC.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import UIKit

final class AlertVC: UIViewController {
  private let containerView = UIView()
  private let titleLabel = UILabel()
  private let messageLabel = UILabel()
  private let actionButton = UIButton()
  
  public var alertTitle: String?
  public var message: String?
  public var buttonTitle: String?
  
  private let padding: CGFloat = 20
  
  init(
    alertTitle: String,
    message: String,
    buttonTitle: String
  ) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = alertTitle
    self.message = message
    self.buttonTitle = buttonTitle
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    createDismissGesture()
    configContainerView()
    configTitleLabel()
    configButton()
    configBodyLabel()
  }
  
  private func createDismissGesture() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
    view.addGestureRecognizer(tap)
  }
  
  @objc
  private func dismissVC() {
    dismiss(animated: true)
  }
  
  // MARK: - UI
  private func configContainerView() {
    view.addSubview(containerView)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.layer.borderWidth = 1
    containerView.layer.cornerRadius = 20
    containerView.layer.borderColor = UIColor.white.cgColor
    containerView.backgroundColor = .systemBackground
    
    NSLayoutConstraint.activate([
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 280),
      containerView.heightAnchor.constraint(equalToConstant: 220),
    ])
  }
  
  private func configTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.text = alertTitle
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    titleLabel.textAlignment = .center
    titleLabel.textColor = .label
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.90
    titleLabel.lineBreakMode = .byTruncatingTail
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 28)
    ])
  }
  
  private func configButton() {
    containerView.addSubview(actionButton)
    actionButton.setTitle(buttonTitle, for: .normal)
    
    if #available(iOS 14.0, *) {
      let dismissAction = UIAction { [weak self] _ in self?.dismissVC() }
      actionButton.addAction(dismissAction, for: .primaryActionTriggered)
    } else {
      actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    NSLayoutConstraint.activate([
      actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  private func configBodyLabel() {
    containerView.addSubview(messageLabel)
    messageLabel.text = message
    messageLabel.numberOfLines = 4
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    messageLabel.textAlignment = .center
    messageLabel.textColor = .label
    messageLabel.adjustsFontSizeToFitWidth = true
    messageLabel.minimumScaleFactor = 0.90
    messageLabel.lineBreakMode = .byTruncatingTail
    
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
    ])
  }
}
