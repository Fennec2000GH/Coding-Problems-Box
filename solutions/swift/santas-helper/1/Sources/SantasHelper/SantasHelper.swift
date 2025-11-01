func getName(_ item: (name: String, amount: Int)) -> String {
  item.name
}

func createToy(name: String, amount: Int) -> (name: String, amount: Int) {
  (name: name, amount: amount)
}

func updateQuantity(_ items: [(name: String, amount: Int)], toy: String, amount: Int) ->  [(name: String, amount: Int)] {
  let i = items.firstIndex(where: { $0.name == toy }) ?? -1
  if i == -1 {
    return items
  }
  let updatedToy: (String, Int) = (name: toy, amount: amount)
  var _items = items
  _items[i] = updatedToy
  return _items
}

func addCategory(_ items: [(name: String, amount: Int)], category: String) -> [(name: String, amount: Int, category: String)] {
  Array(items.map { (name, amount) in (name: name, amount: amount, category: category)})
}
