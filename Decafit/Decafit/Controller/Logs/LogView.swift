import UIKit
class LogView: UIView {
    var logHeader = LogHeader()
    var viewModel = LogViewModel()
    weak var delegate: LogViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logHeader)
        addSubview(tableView)
        setupSubviews()
        viewModel.getLogs()
        viewModel.extractWorkoutName()
        viewModel.workoutNameCompletion = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Create Table View
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(LogTableCell.self,
                      forCellReuseIdentifier: LogTableCell.identifier)
        return view
    }()
}
extension LogView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.logs.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LogTableCell.identifier, for: indexPath)
                as? LogTableCell else { return UITableViewCell()}
        let log = viewModel.logs[indexPath.row]
        cell.logCell = log
//        viewModel.workoutObjectArr.forEach({
//            print("workoutObjectArr", $0)
//            cell.workoutTitleLabel.text = $0.name
//            cell.workoutImageView.image = UIImage(named: $0.image)
//
//        })
        viewModel.workoutNameCompletion = {
            DispatchQueue.main.async { [weak self] in
                self?.viewModel.workoutObjectArr.forEach({
                    print("workoutObjectArr", $0)
                    cell.workoutTitleLabel.text = $0.name
                    cell.workoutImageView.image = UIImage(named: $0.image)
                    
                })
                tableView.reloadData()
            }
        }

        return cell
    }    
    
}
extension LogView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get sidemenu to push details view
        let controller = LogDetailViewController()
        delegate?.displayDetailView(screen: controller)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
}
extension LogView {
    func setupSubviews() {
        NSLayoutConstraint.activate([
            logHeader.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            logHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            logHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            logHeader.heightAnchor.constraint(equalToConstant: 100),

            tableView.topAnchor.constraint(equalTo: logHeader.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: logHeader.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: logHeader.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
