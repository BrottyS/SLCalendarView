import UIKit

class SimpleViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var calendarView: SLSimpleCalendarView!
    
    private var calendar: Calendar!
    private var dateFormatter: DateFormatter!
    private var date: Date! {
        didSet {
            if let date = date {
                updateTitle()
                calendarView.date = date
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupGradientView()
        setupCalendarView()
        
        calendar = Calendar.current
        dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.dateFormat = "LLLL yyyy"
        
        //let locale = Locale(identifier: "ru_RU")
        //calendar.locale = locale
        //dateFormatter.locale = locale
        
        date = Date()
    }
    
    private func setupNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        }
    }
    
    private func setupGradientView() {
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor(red: 0.11, green: 0.56, blue: 0.63, alpha: 1.0).cgColor,
                           UIColor(red: 0.37, green: 0.80, blue: 0.48, alpha: 1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientView.layer.insertSublayer(gradient, at: 0)
    }

    private func setupCalendarView() {
        calendarView.backgroundColor = .clear
        calendarView.weekdayFont = UIFont.boldSystemFont(ofSize: 13)
        calendarView.dayFont = UIFont.systemFont(ofSize: 13)
        calendarView.weekdayTextColor = .white
        calendarView.dayTextColor = .white
        calendarView.eventCircleViewColor = .white
        calendarView.dataSource = self
    }
    
    private func updateTitle() {
        title = dateFormatter.string(from: date)
    }
    
    @IBAction func btnPrevClick(_ sender: Any) {
        date = calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    @IBAction func btnNextClick(_ sender: Any) {
        date = calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
}

extension SimpleViewController: SLSimpleCalendarViewDataSource {
    
    func hasEventForDate(_ date: Date) -> Bool {
        return arc4random_uniform(2) == 0
    }
    
}
