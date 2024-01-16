//
//  ViewController.swift
//  WasuremonoApp
//
//  Created by 白川創大 on 2024/01/12.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var textFieldLabel: UILabel!
    
    var items: [(text: String, date: Date)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableView.dataSource = self
        loadDataForToday()
    }
    
    private func loadDataForToday() {
        // 保存されたデータから当日の日付に合致するものを抽出します
        let today = Calendar.current.startOfDay(for: Date())
        // ここで保存されたデータを取得し、今日の日付と比較するロジックを実装します
        items = fetchDataFor(date: today)
        tableView.reloadData()
    }
    
    private func fetchDataFor(date: Date) -> [(text: String, date: Date)] {
        let allItems = fetchAllItems()
        let calendar = Calendar.current
        let filteredItems = allItems.filter {
            calendar.isDate($0.date, inSameDayAs: date)
        }
        return filteredItems.map { ($0.text, $0.date) }
    }

    private func fetchAllItems() -> [Item] {
        if let savedData = UserDefaults.standard.object(forKey: "savedItems") as? Data {
            if let loadedItems = try? JSONDecoder().decode([Item].self, from: savedData) {
                return loadedItems
            }
        }
        return []
    }

    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            fatalError("Unable to dequeue CustomTableViewCell")
        }

        let item = items[indexPath.row]
        cell.dateLabel.text = formatDate(item.date)
        cell.textFieldLabel.text = item.text

        return cell
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }

    
}
