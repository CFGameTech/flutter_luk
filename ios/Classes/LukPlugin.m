#import "LukPlugin.h"
#if __has_include(<luk/luk-Swift.h>)
#import <luk/luk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "luk-Swift.h"
#endif

@implementation LukPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLukPlugin registerWithRegistrar:registrar];
}
@end
