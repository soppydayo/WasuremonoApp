






import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let text = textField.text ?? ""
        let selectedDate = datePicker.date
        saveData(text: text, date: selectedDate)
        
        textField.text = ""
        
    }

    func saveData(text: String, date: Date) {
        let item = Item(text: text, date: date)
        var items = fetchAllItems()
        items.append(item)
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "savedItems")
        }
    }

    private func fetchAllItems() -> [Item] {
        if let savedData = UserDefaults.standard.object(forKey: "savedItems") as? Data {
            if let loadedItems = try? JSONDecoder().decode([Item].self, from: savedData) {
                return loadedItems
            }
        }
        return []
    }
}

