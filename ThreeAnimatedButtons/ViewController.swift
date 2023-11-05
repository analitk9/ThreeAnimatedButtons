//
//  ViewController.swift
//  ThreeAnimatedButtons
//
//  Created by Denis Evdokimov on 11/5/23.
//

import UIKit

class ViewController: UIViewController {
  
    var firstButton = CustomButton()
    var secondButton = CustomButton()
    var thirdButton = CustomButton()
   
    var vStackButtons = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 20.0
        return stack
    }()

    var animator: UIViewPropertyAnimator =  UIViewPropertyAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(vStackButtons)
        vStackButtons.addArrangedSubview(firstButton)
        vStackButtons.addArrangedSubview(secondButton)
        vStackButtons.addArrangedSubview(thirdButton)
        setupLayoutStackView()
        setupLayoutButton()
        setupConfigureButtons()
    }
    
    private func setupLayoutButton() {
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func  setupLayoutStackView(){
        NSLayoutConstraint.activate([
            vStackButtons.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            vStackButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            vStackButtons.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            vStackButtons.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func setupConfigureButtons() {
        firstButton.configuration = createConfiguration(title: "First Button")
        secondButton.configuration = createConfiguration(title: "Second Medium button")
        thirdButton.configuration = createConfiguration(title: "Thrid")
        thirdButton.tag = 3
        
        firstButton.addTarget(self, action: #selector(buttonUp), for: .touchUpInside)
        firstButton.addTarget(self, action: #selector(buttonUp), for: .touchUpOutside)
        firstButton.addTarget(self, action: #selector(buttonDown), for: .touchDown)
        
        secondButton.addTarget(self, action: #selector(buttonUp), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonUp), for: .touchUpOutside)
        secondButton.addTarget(self, action: #selector(buttonDown), for: .touchDown)
        
        thirdButton.addTarget(self, action: #selector(buttonUp), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(buttonUp), for: .touchUpOutside)
        thirdButton.addTarget(self, action: #selector(buttonDown), for: .touchDown)

    }
    
    private func createConfiguration(title: String) -> UIButton.Configuration {
        var conf = UIButton.Configuration.filled()
        conf.title = title
        conf.image = UIImage(systemName: "arrowshape.right.circle.fill")?.withRenderingMode(.alwaysTemplate)
        conf.imagePlacement = .trailing
        conf.baseBackgroundColor = .systemBlue
        conf.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        conf.imagePadding = 8.0
        return conf
    }
    
    private  func animateDown(_ button: UIButton) {
        if animator.state == .active  {
            animator.stopAnimation(true)
            if  animator.state != .inactive {
                animator.finishAnimation(at: .current)
            }
        }
        animator = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        animator.startAnimation()

    }
    
    private  func animateUp(_ button: UIButton) {

        animator = UIViewPropertyAnimator(duration: 0.1, curve: .linear) {
            button.transform =  .identity
        }
        animator.startAnimation()
    }
    
    
    @objc func buttonDown(_ sender: UIButton) {
        animateDown(sender)
    }
    
    @objc func buttonUp(_ sender: UIButton) {
        animateUp(sender)
        if sender.tag == 3 {
          presentModal()
        }
    }
    
    func presentModal() {
        let modalVC = ModalViewController()
        modalVC.modalPresentationStyle = .formSheet
        present(modalVC, animated: true)
    }
}

