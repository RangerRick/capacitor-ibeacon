var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { WebPlugin } from '@capacitor/core';
export class IBeaconWeb extends WebPlugin {
    constructor() {
        super({
            name: 'IBeacon',
            platforms: ['web']
        });
        console.warn('IBeacon is not implemented for browsers.');
    }
    isMonitoringAvailable() {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: false };
        });
    }
    isRangingAvailable() {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: false };
        });
    }
    locationServicesEnabled() {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: false };
        });
    }
    requestWhenInUseAuthorization() {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: false };
        });
    }
    requestAlwaysAuthorization() {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: false };
        });
    }
    startMonitoringForRegion( /* region: IBeaconRegion */) {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: false };
        });
    }
    stopMonitoringForRegion( /* region: IBeaconRegion */) {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: true };
        });
    }
    startRangingForRegion( /* region: IBeaconRegion */) {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: false };
        });
    }
    stopRangingForRegion( /* region: IBeaconRegion */) {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: true };
        });
    }
    getMonitoredRegions() {
        return __awaiter(this, void 0, void 0, function* () {
            return { regions: [] };
        });
    }
    getRangedRegions() {
        return __awaiter(this, void 0, void 0, function* () {
            return { regions: [] };
        });
    }
    isAdvertising() {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: false };
        });
    }
    startAdvertising( /* advertisementData: IBeaconAdvertisement */) {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: false };
        });
    }
    stopAdvertising() {
        return __awaiter(this, void 0, void 0, function* () {
            return { value: true };
        });
    }
    addListener( /* eventName: string, listenerFunc: Function */) {
        return;
    }
}
const IBeacon = new IBeaconWeb();
export { IBeacon };
import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(IBeacon);
//# sourceMappingURL=web.js.map