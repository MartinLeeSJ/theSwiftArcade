//
//  ShakyBellView.swift
//  Bankey
//
//  Created by Martin on 2023/05/27.
//

import UIKit

class ShakyBellView: UIView {
    
    let imageView = UIImageView()
    let countButtonView = UIButton()
    
    let buttonHeight: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

extension ShakyBellView {
    func setup() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_: )))
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        
        countButtonView.translatesAutoresizingMaskIntoConstraints = false
        countButtonView.backgroundColor = .systemRed
        countButtonView.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        countButtonView.layer.cornerRadius = buttonHeight / 2
        countButtonView.setTitle("9", for: .normal)
        countButtonView.setTitleColor(.white, for: .normal)
    }
    
    func layout() {
        addSubview(imageView)
        addSubview(countButtonView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24), 
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            countButtonView.widthAnchor.constraint(equalToConstant: buttonHeight),
            countButtonView.heightAnchor.constraint(equalToConstant: buttonHeight),
            countButtonView.topAnchor.constraint(equalTo: imageView.topAnchor),
            // countButtonView.leadingAnchor.constraint(equalToSystemSpacingAfter: self.centerXAnchor, multiplier: 1) 왜 여기서 오류가 나는 지
            countButtonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}

extension ShakyBellView {
    @objc func imageViewTapped(_ reconizer: UITapGestureRecognizer) {
        shakeBell(withDuration: 1.0, angle: .pi/8, yOffset: 0.0)
    }
    
    private func shakeBell(withDuration duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames: Double = 6
        let frameDuration = Double(1/numberOfFrames)
        
        imageView.setAnchorPoint(CGPoint(x:0.5, y: yOffset))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0) {
            for time in 0..<6 {
                UIView.addKeyframe(withRelativeStartTime: Double(time) * frameDuration, relativeDuration: frameDuration) {
                    if time == 5 {
                        self.imageView.transform = CGAffineTransform.identity
                    } else {
                        self.imageView.transform = CGAffineTransform(rotationAngle: time % 2 == 0 ? -angle : +angle)
                    }
                }
            }
        }
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
