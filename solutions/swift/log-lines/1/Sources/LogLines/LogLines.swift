// TODO: define the 'LogLevel' enum, its `init`, and its `shortFormat` method
enum LogLevel: Int {
  case trace = 0
  case debug = 1
  case info = 4
  case warning = 5
  case error = 6
  case fatal = 7
  case unknown = 42
  
  init?(_ input: String) {
    let logLevel = input.split(separator: ":").dropLast()
    switch(logLevel.first) {
      case "[TRC]":
        self = .trace
      case "[DBG]":
        self = .debug
      case "[INF]":
        self = .info
      case "[WRN]":
        self = .warning
      case "[ERR]":
        self = .error
      case "[FTL]":
        self = .fatal
      default:
        self = .unknown
        break
    }
  }

  func shortFormat(message: String) -> String {
    switch(self) {
        case .trace:
            return "0:" + message
        case .debug:
            return "1:" + message
        case .info:
            return "4:" + message
        case .warning:
            return "5:" + message
        case .error:
            return "6:" + message
        case .fatal:
            return "7:" + message
        case .unknown:
            return "42:" + message
    }
  }
}

