# capacitor-ibeacon

A Capacitor plugin for transmitting and receiving iBeacon regions and ranging over Bluetooth.

Supports:

* [x] iOS
* [ ] Android
* [ ] Web

The web bluetooth standard seems to be [pretty dead in the water](https://github.com/WebBluetoothCG/web-bluetooth/blob/master/implementation-status.md), so it is unlikely web will ever be supported.

## Usage

```javascript
import { Plugins } from '@capacitor/core';
import { IBeaconRegion, IBeaconAdvertisement } from 'capacitor-ibeacon';

const { IBeacon } = Plugins;

await IBeacon.requestAlwaysAuthorization();
IBeacon.addListener('enteredRegion', (response) => {
  const region = response.region;
  console.log(`Entered region: ${region.identifier} (${region.uuid})`);
});
IBeacon.addListener('leftRegion', (response) => {
  const region = response.region;
  console.log(`Left region: ${region.identifier} (${region.uuid})`);
});
IBeacon.startMonitoringForRegion({
  uuid: 'DEADBEEF-0000-0000-0000-000000000000',
  identifier: 'Dead Beef',
});
```

## Installation

```
npm i capacitor-ibeacon
npx cap sync
```

## iOS Setup

You will need to add one or more options to your `Info.plist` to have permissions to use Bluetooth and location services.

### `NSLocationAlwaysAndWhenInUseUsageDescription`

This is for being able to get location events while in the foreground or background.
You will need to call `IBeacon.requestAlwaysAuthorization()` at runtime before ranging.

Note that even if you ask for background use, the user is still able to disable support
or allow only while in use in their phone settings.

`NSLocationAlwaysAndWhenInUseUsageDescription` is for iOS 13 and above.
If you wish to support iOS 12 or lower, include it _and_ `NSBluetoothPeripheralUsageDescription`.

```xml
<key>NSBluetoothPeripheralUsageDescription</key>
<string>This app would like to scan for iBeacons while in use and while in the background.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app would like to scan for iBeacons while in use and while in the background.</string>
```

### `NSLocationWhenInUseUsageDescription`

This is for being able to get location events only while in the foreground.
You will need to call `IBeacon.requestWhenInUseAuthorization()` at runtime before ranging.

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app would like to scan for iBeacons while in use.</string>
```

### `NSBluetoothAlwaysUsageDescription`

This is for being able to transmit or communicate with Bluetooth devices.

If you wish to support iOS 12 or lower, include it _and_ `NSBluetoothPeripheralUsageDescription`.

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app would like to transmit or communicate with Bluetooth devices.</string>
```

`NSBluetoothAlwaysUsageDescription` is for iOS 13 and above.
If you wish to support iOS 12 or lower, include it _and_ `NSBluetoothPeripheralUsageDescription`.

## Android Setup

TODO
