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
  if ([@"StartMtj" isEqualToString:call.method]) {
    NSString *appKey = call.arguments[@"appKey"];
    [self startMtj:appKey];
    result(@"ios start mtj");
  } else if ([@"SetChannel" isEqualToString:call.method]) {
     NSString *channel = call.arguments[@"channel"];
     [self setChannel:channel];
     result(@"ios channel");
   } else if ([@"SetUserId" isEqualToString:call.method]) {
     NSString *userId = call.arguments[@"userId"];
     [self setUserId:userId];
     result(@"ios userId");
   } else if ([@"SetDebug" isEqualToString:call.method]) {
      BOOL isDebug = call.arguments[@"isDebug"];
      [self setDebug:isDebug];
      result(@"ios debug");
    } else if ([@"PageStart" isEqualToString:call.method]) {
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

- (void)startMtj:(NSString *)appKey  {
    [[BaiduMobStat defaultStat] startWithAppId:appKey];
}

- (void)setChannel:(NSString *)channel  {
    [[BaiduMobStat defaultStat] setChannelId:channel];
}

- (void)setUserId:(NSString *)userId  {
    [[BaiduMobStat defaultStat] setUserId:userId];
}

- (void)setDebug:(BOOL)isDebug  {
    [[BaiduMobStat defaultStat] setEnableDebugOn:isDebug];
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
