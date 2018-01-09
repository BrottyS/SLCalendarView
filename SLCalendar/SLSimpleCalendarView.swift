import UIKit

protocol SLSimpleCalendarViewDataSource {
    func hasEventForDate(_ date: Date) -> Bool
}

class SLSimpleCalendarView: UIView, UICollectionViewDataSource {

    var dataSource: SLSimpleCalendarViewDataSource?
    
    var weekdayFont = UIFont.systemFont(ofSize: 13)
    var dayFont = UIFont.systemFont(ofSize: 13)
    var weekdayTextColor = UIColor.black
    var dayTextColor = UIColor.black
    var eventCircleViewColor = UIColor.black
    
    var date: Date! {
        didSet {
            calcOffset()
            collectionView?.reloadData()
        }
    }
    
    private var calendar: Calendar!
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Private constants
    
    private let rows = 7
    private let columns = 7
    
    private var dateFormatter: DateFormatter!
    
    private var offset = 0
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        setupCalendar()
        setupCollectionView()
    }
    
    private func setupCalendar() {
        calendar = Calendar.current
        calendar.firstWeekday = 2 // monday
        dateFormatter = DateFormatter()
        
        //let locale = Locale(identifier: "ru_RU")
        //calendar.locale = locale
        //dateFormatter.locale = locale
        
        date = Date()
    }
    
    private func setupCollectionView() {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: frame.width / CGFloat(columns), height: frame.height / CGFloat(rows))
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(SLSimpleCalendarCell.self, forCellWithReuseIdentifier: "\(SLSimpleCalendarCell.self)")
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = false
        
        addSubview(collectionView)
        
        let top = NSLayoutConstraint(item: collectionView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: self,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: 0)
        let left = NSLayoutConstraint(item: collectionView,
                                      attribute: .leading,
                                      relatedBy: .equal,
                                      toItem: self,
                                      attribute: .leading,
                                      multiplier: 1,
                                      constant: 0)
        let right = NSLayoutConstraint(item: self,
                                       attribute: .trailing,
                                       relatedBy: .equal,
                                       toItem: collectionView,
                                       attribute: .trailing,
                                       multiplier: 1,
                                       constant: 0)
        let bottom = NSLayoutConstraint(item: self,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: collectionView,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: 0)
        addConstraints([top, left, right, bottom])
    }
    
    override func layoutSubviews() {
        flowLayout.itemSize = CGSize(width: frame.width / CGFloat(columns), height: frame.height / CGFloat(rows))
        
        super.layoutSubviews()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendar.numberOfDaysIn(month: date) + columns + offset
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SLSimpleCalendarCell
        
        if let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SLSimpleCalendarCell.self)", for: indexPath) as? SLSimpleCalendarCell {
            cell = dequeuedCell
        } else {
            cell = SLSimpleCalendarCell()
        }
        
        if indexPath.item < columns { // weekdays header
            // TODO: Take a look at calendar.weekdaySymbols way
            var dateComps = calendar.dateComponents([.day], from: Date())
            dateComps.day = indexPath.item + 1
            let day = calendar.date(from: dateComps)!
            dateFormatter.dateFormat = "E"
            cell.dateLabel.text = "\(dateFormatter.string(from: day).uppercased().first!)"
            
            cell.dateLabel.font = weekdayFont
            cell.dateLabel.textColor = weekdayTextColor
            cell.eventCircleView.backgroundColor = eventCircleViewColor
            
            cell.eventCircleView.isHidden = true
        } else {
            let day = dateForIndexPath(indexPath)
            if let day = day {
                dateFormatter.dateFormat = "d"
                cell.dateLabel.text = dateFormatter.string(from: day)
                if let dataSource = dataSource {
                    cell.eventCircleView.isHidden = !dataSource.hasEventForDate(day)
                } else {
                    cell.eventCircleView.isHidden = true
                }
            } else {
                cell.dateLabel.text = ""
                cell.eventCircleView.isHidden = true
            }
            
            cell.dateLabel.font = dayFont
            cell.dateLabel.textColor = dayTextColor
            cell.eventCircleView.backgroundColor = eventCircleViewColor
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    private func dateForIndexPath(_ indexPath: IndexPath) -> Date? {
        guard indexPath.item + 1 > columns + offset else { return nil }
        
        var dateComps = calendar.dateComponents([.day, .month, .year], from: date)
        dateComps.day = indexPath.item + 1 - columns - offset
        return calendar.date(from: dateComps)!
    }
    
    private func calcOffset() {
        let firstDay = calendar.firstDayOfMonthForDate(date)
        let weekdayNumber = calendar.weekdayNumber(of: firstDay)
        offset = weekdayNumber - 1
    }

}
