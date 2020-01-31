import { WebPlugin, PluginListenerHandle } from '@capacitor/core';
import { IBeaconPlugin, IBeaconRegion } from './definitions';

export class IBeaconWeb extends WebPlugin implements IBeaconPlugin {
  constructor() {
    super({
      name: 'IBeacon',
      platforms: ['web']
    });
  }

  async isMonitoringAvailable(): Promise<{value:boolean}> {
    throw new Error('Not yet implemented!');
  }

  isRangingAvailable(): Promise<{value:boolean}> {
    throw new Error('Not yet implemented!');
  }

  locationServicesEnabled(): Promise<{value:boolean}> {
    throw new Error('Not yet implemented: locationServicesEnabled');
  }

  requestWhenInUseAuthorization(): Promise<{value:boolean}> {
    throw new Error('Not yet implemented: requestWhenInUseAuthorization');
  }

  requestAlwaysAuthorization(): Promise<{value:boolean}> {
    throw new Error('Not yet implemented: requestAlwaysAuthorization');
  }

  startMonitoringForRegion(region:IBeaconRegion): Promise<{value:boolean}> {
    throw new Error(`Not yet implemented: startMonitoringForRegion(${region.uuid})`);
  }

  stopMonitoringForRegion(region:IBeaconRegion): Promise<{value:boolean}> {
    throw new Error(`Not yet implemented: stopMonitoringForRegion(${region.uuid})`);
  }

  startRangingForRegion(region:IBeaconRegion): Promise<{value:boolean}> {
    throw new Error(`Not yet implemented: startRangingForRegion(${region.uuid})`);
  }

  stopRangingForRegion(region:IBeaconRegion): Promise<{value:boolean}> {
    throw new Error(`Not yet implemented: stopRangingForRegion(${region.uuid})`);
  }

  getMonitoredRegions(): Promise<{regions: [IBeaconRegion]}> {
    throw new Error('Not yet implemented!');
  }

  getRangedRegions(): Promise<{regions: [IBeaconRegion]}> {
    throw new Error('Not yet implemented!');
  }

  addListener(eventName: string, listenerFunc: Function): PluginListenerHandle {
    throw new Error(`Not yet implemented: addListener(${eventName}, ${listenerFunc.name})`);
  }
}

const IBeacon = new IBeaconWeb();

export { IBeacon, IBeaconRegion };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(IBeacon);
