import { PluginListenerHandle } from "@capacitor/core";

declare module "@capacitor/core" {
  interface PluginRegistry {
    IBeacon: IBeaconPlugin;
  }
}

export type UUID = string;

export interface IBeaconRegion {
  identifier: string,
  uuid: UUID,
  major?: number,
  minor?: number,
};

export type AuthorizationStatus = 'notDetermined' | 'restricted' | 'denied' | 'authorizedAlways' | 'authorizedWhenInUse';

export type LocationErrorType = 'error' | 'rangingError' | 'monitoringError';

export type RegionState = 'unknown' | 'inside' | 'outside';

export interface IBeaconError {
  /** the error message */
  error: string,
  /** the error type */
  type: LocationErrorType,
  /** the region or constraint related to the error */
  region?: IBeaconPlugin,
}

export interface IBeaconPlugin {
  isMonitoringAvailable(): Promise<{value:boolean}>;
  isRangingAvailable(): Promise<{value:boolean}>;
  locationServicesEnabled(): Promise<{value:boolean}>;
  requestWhenInUseAuthorization(): Promise<{value:boolean}>;
  requestAlwaysAuthorization(): Promise<{value:boolean}>;
  startMonitoringForRegion(region:IBeaconRegion): Promise<{value:boolean}>;
  stopMonitoringForRegion(region:IBeaconRegion): Promise<{value:boolean}>;
  startRangingForRegion(region:IBeaconRegion): Promise<{value:boolean}>;
  stopRangingForRegion(region:IBeaconRegion): Promise<{value:boolean}>;
  getMonitoredRegions(): Promise<{regions: [IBeaconRegion]}>;
  getRangedRegions(): Promise<{regions: [IBeaconRegion]}>;


  /**
   * Listen for authorization status events
   */
  addListener(eventName: 'didChangeAuthorization', listenerFunc: (result: { status: AuthorizationStatus }) => void): PluginListenerHandle;

  /**
   * Listen for region state changes
   */
  addListener(eventName: 'didDetermineState', listenerFunc: (result: { state: RegionState }) => void): PluginListenerHandle;

  /**
   * Listen for "entered region" events
   */
  addListener(eventName: 'didEnterRegion', listenerFunc: (result: { region: IBeaconRegion }) => void): PluginListenerHandle;

  /**
   * Listen for "exited region" events
   */
  addListener(eventName: 'didExitRegion', listenerFunc: (result: { region: IBeaconRegion }) => void): PluginListenerHandle;

  /**
   * Listen for "ranged beacons" events (iOS 13+)
   */
  addListener(eventName: 'didRange', listenerFunc: (result: { regions: [IBeaconRegion] }) => void): PluginListenerHandle;

  /**
   * Listen for "started monitoring" events
   */
  addListener(eventName: 'didStartMonitoringFor', listenerFunc: (result: { region: IBeaconRegion }) => void): PluginListenerHandle;

  /**
   * Listen for errors
   */
  addListener(eventName: 'error', listenerFunc: (result: IBeaconError) => void): PluginListenerHandle;
}
