import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    self.contentViewController = flutterViewController

    // Вікно завжди відкривається з типовим розміром, без відновлення кадру.
    self.isRestorable = false
    self.contentMinSize = NSSize(width: 600, height: 500)
    self.setContentSize(NSSize(width: 1280, height: 800))
    self.center()

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
