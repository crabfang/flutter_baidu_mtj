#import "BaiduMtjPlugin.h"
#import <BaiduMobStatCodeless/BaiduMobStat.h>

@implementation BaiduMtjPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"BaiduMtj"
            binaryMessenger:[registrar messenger]];
  BaiduMtjPlugin* instance = [[BaiduMtjPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"PageStart" isEqualToString:call.method]) {
    NSString *pageName = call.arguments[@"pageName"];
    [self actionPageStart:pageName];
    result(@"ios start");
  } else if ([@"PageEnd" isEqualToString:call.method]) {
     NSString *pageName = call.arguments[@"pageName"];
     [self actionPageEnd:pageName];
     result(@"ios end");
   } else if ([@"LogEvent" isEqualToString:call.method]) {
     NSString *eventId = call.arguments[@"eventId"];
     NSDictionary *params = call.arguments[@"attributes"];
     [self actionLogEvent:eventId params: params];
     result(@"ios event");
   } else if ([@"LogError" isEqualToString:call.method]) {
     NSString *errorData = call.arguments[@"errorData"];
     [self actionLogError:errorData];
     result(@"ios error");
   } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)actionPageStart:(NSString *)pageName  {
    [[BaiduMobStat defaultStat] pageviewStartWithName:pageName];
}

- (void)actionPageEnd:(NSString *)pageName  {
    [[BaiduMobStat defaultStat] pageviewEndWithName:pageName];
}

- (void)actionLogEvent:(NSString *)eventId params:(nullable NSDictionary *)params  {
    [[BaiduMobStat defaultStat] logEvent:eventId attributes:params];
}

- (void)actionLogError:(NSString *)errorData {
    NSError *error = [NSError errorWithDomain:errorData code:-1 userInfo:nil];
    [[BaiduMobStat defaultStat] recordError:error];
}

@end
