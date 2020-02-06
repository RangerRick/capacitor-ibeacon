import { PluginListenerHandle } from "@capacitor/core";
declare module "@capacitor/core" {
    interface PluginRegistry {
        IBeacon: IBeaconPlugin;
    }
}
export declare type UUID = string;
export interface IBeaconRegion {
    identifier: string;
    uuid: UUID;
    major?: number;
    minor?: number;
}
export interface IBeaconAdvertisement extends IBeaconRegion {
    measuredPower?: number;
}
export declare type AuthorizationStatusType = 'notDetermined' | 'restricted' | 'denied' | 'authorizedAlways' | 'authorizedWhenInUse';
export declare type LocationErrorType = 'error' | 'rangingError' | 'monitoringError';
export declare type RegionStateType = 'unknown' | 'inside' | 'outside';
export interface AuthorizationStatus {
    status: AuthorizationStatusType;
}
export interface RegionState {
    state: RegionStateType;
    region: IBeaconRegion;
}
export interface IBeaconError {
    /** the error message */
    message: string;
    /** the error type */
    type: LocationErrorType;
    /** the region or constraint related to the error */
    region?: IBeaconPlugin;
}
export interface IBeaconPlugin {
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
    startMonitoringForRegion(region: IBeaconRegion): Promise<{
        value: boolean;
    }>;
    stopMonitoringForRegion(region: IBeaconRegion): Promise<{
        value: boolean;
    }>;
    startRangingForRegion(region: IBeaconRegion): Promise<{
        value: boolean;
    }>;
    stopRangingForRegion(region: IBeaconRegion): Promise<{
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
    startAdvertising(advertisementData: IBeaconAdvertisement): Promise<{
        value: boolean;
    }>;
    stopAdvertising(): Promise<{
        value: boolean;
    }>;
    /**
     * Listen for authorization status events
     */
    addListener(eventName: 'authorizationStatusChanged', listenerFunc: (result: AuthorizationStatus) => void): PluginListenerHandle;
    /**
     * Listen for region state changes
     */
    addListener(eventName: 'determinedStateForRegion', listenerFunc: (result: RegionState) => void): PluginListenerHandle;
    /**
     * Listen for "entered region" events
     */
    addListener(eventName: 'enteredRegion', listenerFunc: (result: {
        region: IBeaconRegion;
    }) => void): PluginListenerHandle;
    /**
     * Listen for "exited region" events
     */
    addListener(eventName: 'leftRegion', listenerFunc: (result: {
        region: IBeaconRegion;
    }) => void): PluginListenerHandle;
    /**
     * Listen for "ranged beacons" events (iOS 13+)
     */
    addListener(eventName: 'ranged', listenerFunc: (result: {
        regions: [IBeaconRegion];
    }) => void): PluginListenerHandle;
    /**
     * Listen for "started monitoring" events
     */
    addListener(eventName: 'startedMonitoring', listenerFunc: (result: {
        region: IBeaconRegion;
    }) => void): PluginListenerHandle;
    /**
     * Listen for errors
     */
    addListener(eventName: 'error', listenerFunc: (result: IBeaconError) => void): PluginListenerHandle;
}
