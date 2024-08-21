//
//  FullScreenViewController.swift
//  BookTalk
//
//  Created by RAFA on 8/20/24.
//

import UIKit

final class FullScreenViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let imageView = UIImageView()
    private let closeButton = UIButton(type: .system)
    
    var image: UIImage? {
        didSet { imageView.image = image }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        addGestureRecognizers()
    }
    
    // MARK: - Actions
    
    @objc private func dismissFullScreen() {
        dismiss(animated: true)
    }
    
    @objc private func handleTapGesture() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            imageView.transform = CGAffineTransform(
                translationX: 0,
                y: translation.y
            )
        case .ended:
            if abs(translation.y) > 100 || abs(velocity.y) > 500 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.imageView.transform = .identity
                })
            }
        default:
            break
        }
    }
    
    private func addTargets() {
        closeButton.addTarget(
            self,
            action: #selector(dismissFullScreen),
            for: .touchUpInside
        )
    }
    
    private func addGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(tapGesture)
        imageView.addGestureRecognizer(panGesture)
    }
    
    // MARK: - Set UI
    
    override func setViews() {
        imageView.do {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .black
            $0.isUserInteractionEnabled = true
        }
        
        closeButton.do {
            $0.setImage(
                UIImage(systemName: "xmark.circle.fill")?
                    .withTintColor(.white, renderingMode: .alwaysOriginal)
                    .applyingSymbolConfiguration(
                        UIImage.SymbolConfiguration(pointSize: 40, weight: .medium)
                    ),
                for: .normal
            )
        }
    }
    
    override func setConstraints() {
        view.addSubview(imageView)
        imageView.addSubview(closeButton)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.right.equalTo(-20)
        }
    }
}
