import AppIntents
import Foundation

#if os(macOS)

@available(macOS 13.0, *)
enum ACIntentError: LocalizedError {
  case scriptNotFound(String)
  case commandFailed(String)

  var errorDescription: String? {
    switch self {
    case let .scriptNotFound(path):
      return "AC script was not found at \(path)."
    case let .commandFailed(message):
      return message
    }
  }
}

@available(macOS 13.0, *)
struct ACCommandRunner {
  private let scriptPath: String

  init(scriptPath: String = Self.defaultScriptPath) {
    self.scriptPath = scriptPath
  }

  static var defaultScriptPath: String {
    if let configuredPath = UserDefaults.standard.string(forKey: "ac_script_path"), !configuredPath.isEmpty {
      return configuredPath
    }
    return NSString(string: "~/repos/dotfiles/scripts/samsung_ac.rb").expandingTildeInPath
  }

  func turnOn(acNumber: Int) throws {
    try run(acNumber: acNumber, command: "on")
  }

  func turnOff(acNumber: Int) throws {
    try run(acNumber: acNumber, command: "off")
  }

  func setTemperature(acNumber: Int, temperature: Int) throws {
    try run(acNumber: acNumber, command: String(temperature))
  }

  private func run(acNumber: Int, command: String) throws {
    guard FileManager.default.fileExists(atPath: scriptPath) else {
      throw ACIntentError.scriptNotFound(scriptPath)
    }

    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = ["ruby", scriptPath, String(acNumber), command]

    let outputPipe = Pipe()
    let errorPipe = Pipe()
    process.standardOutput = outputPipe
    process.standardError = errorPipe

    try process.run()
    process.waitUntilExit()

    let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
    let errorText = String(data: errorData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    let outputText = String(data: outputData, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

    guard process.terminationStatus == 0 else {
      let details = [errorText, outputText].filter { !$0.isEmpty }.joined(separator: "\n")
      throw ACIntentError.commandFailed(details.isEmpty ? "Failed to control AC." : details)
    }
  }
}

@available(macOS 13.0, *)
struct TurnOnACIntent: AppIntent {
  static var title: LocalizedStringResource = "Turn On AC"
  static var description = IntentDescription("Turn on an AC unit.")
  static var openAppWhenRun = false

  @Parameter(title: "AC Number", default: 1)
  var acNumber: Int

  static var parameterSummary: some ParameterSummary {
    Summary("Turn on AC \(\.$acNumber)")
  }

  func perform() async throws -> some IntentResult & ProvidesDialog {
    try ACCommandRunner().turnOn(acNumber: acNumber)
    return .result(dialog: "Turned on AC \(acNumber).")
  }
}

@available(macOS 13.0, *)
struct TurnOffACIntent: AppIntent {
  static var title: LocalizedStringResource = "Turn Off AC"
  static var description = IntentDescription("Turn off an AC unit.")
  static var openAppWhenRun = false

  @Parameter(title: "AC Number", default: 1)
  var acNumber: Int

  static var parameterSummary: some ParameterSummary {
    Summary("Turn off AC \(\.$acNumber)")
  }

  func perform() async throws -> some IntentResult & ProvidesDialog {
    try ACCommandRunner().turnOff(acNumber: acNumber)
    return .result(dialog: "Turned off AC \(acNumber).")
  }
}

@available(macOS 13.0, *)
struct SetACTemperatureIntent: AppIntent {
  static var title: LocalizedStringResource = "Set AC Temperature"
  static var description = IntentDescription("Set the AC cooling temperature.")
  static var openAppWhenRun = false

  @Parameter(title: "AC Number", default: 1)
  var acNumber: Int

  @Parameter(
    title: "Temperature",
    default: 24,
    inclusiveRange: 16...30,
    requestValueDialog: IntentDialog("What temperature should I set?")
  )
  var temperature: Int

  static var parameterSummary: some ParameterSummary {
    Summary("Set AC \(\.$acNumber) to \(\.$temperature) degrees")
  }

  func perform() async throws -> some IntentResult & ProvidesDialog {
    try ACCommandRunner().setTemperature(acNumber: acNumber, temperature: temperature)
    return .result(dialog: "Set AC \(acNumber) to \(temperature) degrees.")
  }
}

@available(macOS 13.0, *)
struct ACAppShortcutsProvider: AppShortcutsProvider {
  static var appShortcuts: [AppShortcut] {
    [
      AppShortcut(
        intent: TurnOnACIntent(),
        phrases: [
          "Turn on AC in \(.applicationName)",
          "Switch on AC \(\.$acNumber) in \(.applicationName)"
        ],
        shortTitle: "Turn On AC",
        systemImageName: "power"
      ),
      AppShortcut(
        intent: TurnOffACIntent(),
        phrases: [
          "Turn off AC in \(.applicationName)",
          "Switch off AC \(\.$acNumber) in \(.applicationName)"
        ],
        shortTitle: "Turn Off AC",
        systemImageName: "poweroff"
      ),
      AppShortcut(
        intent: SetACTemperatureIntent(),
        phrases: [
          "Set AC to \(\.$temperature) degrees in \(.applicationName)",
          "Set AC \(\.$acNumber) to \(\.$temperature) in \(.applicationName)"
        ],
        shortTitle: "Set AC Temp",
        systemImageName: "thermometer.medium"
      )
    ]
  }
}

#endif
