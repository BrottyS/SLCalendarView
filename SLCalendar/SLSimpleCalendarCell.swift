import UIKit

class SLSimpleCalendarCell: UICollectionViewCell {
    
    // MARK: - Private constants
    
    var dateLabel: UILabel!
    var eventLabel: UILabel!
    var eventCircleView: UIView!
    
    private let defaultDateLabelFont = UIFont.systemFont(ofSize: 10)
    private let defaultEventLabelFont = UIFont.systemFont(ofSize: 10)
    private let defaultCircleViewSize = CGSize(width: 4, height: 4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        setupDateLabel()
        setupEventCircleView()
    }
    
    private func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = defaultDateLabelFont
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textAlignment = .center
        
        contentView.addSubview(dateLabel)
        
        let centerX = NSLayoutConstraint(item: dateLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: contentView,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        
        let centerY = NSLayoutConstraint(item: dateLabel,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: contentView,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        
        contentView.addConstraints([centerX, centerY])
    }
    
    private func setupEventLabel() {
        eventLabel = UILabel()
        eventLabel.backgroundColor = .blue
        eventLabel.font = defaultEventLabelFont
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        eventLabel.textAlignment = .center
        
        contentView.addSubview(eventLabel)
        
        let centerX = NSLayoutConstraint(item: eventLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: contentView,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        
        let centerY = NSLayoutConstraint(item: eventLabel,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: contentView,
                                         attribute: .centerY,
                                         multiplier: 3 / 2,
                                         constant: 0)
        
        contentView.addConstraints([centerX, centerY])
        
        eventLabel.font = UIFont.systemFont(ofSize: 13)
        eventLabel.text = "∙"
    }
    
    private func setupEventCircleView() {
        eventCircleView = UIView()
        eventCircleView.translatesAutoresizingMaskIntoConstraints = false
        eventCircleView.layer.cornerRadius = defaultCircleViewSize.width / 2
        eventCircleView.isHidden = true
        
        contentView.addSubview(eventCircleView)
        
        let centerX = NSLayoutConstraint(item: eventCircleView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: contentView,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        
        let centerY = NSLayoutConstraint(item: eventCircleView,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: contentView,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        
        let width = NSLayoutConstraint(item: eventCircleView,
                                       attribute: .width,
                                       relatedBy: .equal,
                                       toItem: nil,
                                       attribute: .width,
                                       multiplier: 1,
                                       constant: defaultCircleViewSize.width)
        
        let height = NSLayoutConstraint(item: eventCircleView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: defaultCircleViewSize.height)
        
        contentView.addConstraints([centerX, centerY, width, height])
    }
    
}
