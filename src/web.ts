import { WebPlugin, PluginListenerHandle } from '@capacitor/core';
import { IBeaconPlugin, IBeaconRegion } from './definitions';

export class IBeaconWeb extends WebPlugin implements IBeaconPlugin {
  constructor() {
    super({
      name: 'IBeacon',
      platforms: ['web']
    });
    console.warn('IBeacon is not implemented for browsers.');
  }

  async isMonitoringAvailable(): Promise<{value: boolean}> {
    return { value: false };
  }

  async isRangingAvailable(): Promise<{value: boolean}> {
    return { value: false };
  }

  async locationServicesEnabled(): Promise<{value: boolean}> {
    return { value: false };
  }

  async requestWhenInUseAuthorization(): Promise<{value: boolean}> {
    return { value: false };
  }

  async requestAlwaysAuthorization(): Promise<{value: boolean}> {
    return { value: false };
  }

  async startMonitoringForRegion(/* region: IBeaconRegion */): Promise<{value: boolean}> {
    return { value: false };
  }

  async stopMonitoringForRegion(/* region: IBeaconRegion */): Promise<{value: boolean}> {
    return { value: true };
  }

  async startRangingForRegion(/* region: IBeaconRegion */): Promise<{value: boolean}> {
    return { value: false };
  }

  async stopRangingForRegion(/* region: IBeaconRegion */): Promise<{value: boolean}> {
    return { value: true };
  }

  async getMonitoredRegions(): Promise<{regions: IBeaconRegion[]}> {
    return { regions: [] };
  }

  async getRangedRegions(): Promise<{regions: IBeaconRegion[]}> {
    return { regions: [] };
  }

  async isAdvertising(): Promise<{value: boolean}> {
    return { value: false };
  }

  async startAdvertising(/* advertisementData: IBeaconAdvertisement */): Promise<{value: boolean}> {
    return { value: false };
  }

  async stopAdvertising(): Promise<{value: boolean}> {
    return { value: true };
  }

  addListener(/* eventName: string, listenerFunc: Function */): PluginListenerHandle {
    return;
  }
}

const IBeacon = new IBeaconWeb();

export { IBeacon, IBeaconRegion };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(IBeacon);
