#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(IBeacon, "IBeacon",
           CAP_PLUGIN_METHOD(isMonitoringAvailable, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(isRangingAvailable, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(locationServicesEnabled, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(requestWhenInUseAuthorization, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(requestAlwaysAuthorization, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(startMonitoringForRegion, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(stopMonitoringForRegion, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(startRangingBeaconsInRegion, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(stopRangingBeaconsInRegion, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getMonitoredRegions, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getRangedRegions, CAPPluginReturnPromise);
)
