import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import { i18n } from '@kit.LocalizationKit';

/** FlutterTimezonePlugin **/
export default class FlutterTimezonePlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;

  constructor() {
  }

  getUniqueClassName(): string {
    return "FlutterTimezonePlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), "flutter_timezone");
    this.channel.setMethodCallHandler(this)
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    switch (call.method) {
      case 'getLocalTimezone':
        result.success(this.getLocalTimezone());
        break;
      case 'getAvailableTimezones':
        result.success(this.getAvailableTimezones());
        break;
      case 'getPlatformVersion':
        result.success("OpenHarmony ^ ^ ")
        break;
      default:
        result.notImplemented();
    }

  }

  // 获取本地时区
  private getLocalTimezone(): string {
    const timezone = i18n.getTimeZone();
    return timezone.getID();
  }

  // 获取可用时区列表
  private getAvailableTimezones(): string[] {
    return i18n.TimeZone.getAvailableIDs();
  }
}