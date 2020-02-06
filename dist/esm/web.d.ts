import { WebPlugin, PluginListenerHandle } from '@capacitor/core';
import { IBeaconPlugin, IBeaconRegion } from './definitions';
export declare class IBeaconWeb extends WebPlugin implements IBeaconPlugin {
    constructor();
    isMonitoringAvailable(): Promise<{
        value: boolean;
    }>;
    isRangingAvailable(): Promise<{
        value: boolean;
    }>;
    locationServicesEnabled(): Promise<{
        value: boolean;
    }>;
    requestWhenInUseAuthorization(): Promise<{
        value: boolean;
    }>;
    requestAlwaysAuthorization(): Promise<{
        value: boolean;
    }>;
    startMonitoringForRegion(): Promise<{
        value: boolean;
    }>;
    stopMonitoringForRegion(): Promise<{
        value: boolean;
    }>;
    startRangingForRegion(): Promise<{
        value: boolean;
    }>;
    stopRangingForRegion(): Promise<{
        value: boolean;
    }>;
    getMonitoredRegions(): Promise<{
        regions: IBeaconRegion[];
    }>;
    getRangedRegions(): Promise<{
        regions: IBeaconRegion[];
    }>;
    isAdvertising(): Promise<{
        value: boolean;
    }>;
    startAdvertising(): Promise<{
        value: boolean;
    }>;
    stopAdvertising(): Promise<{
        value: boolean;
    }>;
    addListener(): PluginListenerHandle;
}
declare const IBeacon: IBeaconWeb;
export { IBeacon, IBeaconRegion };
