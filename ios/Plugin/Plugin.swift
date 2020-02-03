import Foundation
import Capacitor
import CoreLocation
import CoreBluetooth

typealias JSObject = [String:Any]
typealias JSArray = [JSObject]

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(IBeacon)
public class IBeacon: CAPPlugin, CLLocationManagerDelegate, CBPeripheralManagerDelegate {
    var locationManager: CLLocationManager!
    var peripheralManager: CBPeripheralManager!

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let data = [
            "status": String(describing: status)
        ] as [String : Any]

        print("IBeacon.authorizationStatusChanged: \(data)\n")
        notifyListeners("authorizationStatusChanged", data: data, retainUntilConsumed: true)
    }

    public func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        let data = [
            "state": String(describing: state),
            "region": beaconRegionToJson(region as! CLBeaconRegion),
        ] as [String : Any]

        print("IBeacon.determinedStateForRegion: \(data)\n")
        notifyListeners("determinedStateForRegion", data: data, retainUntilConsumed: true)
    }

    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let data = [
            "region": beaconRegionToJson(region as! CLBeaconRegion),
        ] as [String : Any]

        print("IBeacon.enteredRegion: \(data)\n")
        notifyListeners("enteredRegion", data: data, retainUntilConsumed: true)
    }

    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let data = [
            "region": beaconRegionToJson(region as! CLBeaconRegion),
        ] as [String : Any]

        print("IBeacon.leftRegion: \(data)\n")
        notifyListeners("leftRegion", data: data, retainUntilConsumed: true)
    }
    
    @available(iOS 13.0, *)
    public func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying constraint: CLBeaconIdentityConstraint) {
        var regions = JSArray()
        beacons.forEach { beacon in
            regions.append(beaconToJson(beacon))
        }
        var c = JSObject()
        c["uuid"] = constraint.uuid.uuidString
        c["major"] = constraint.major
        c["minor"] = constraint.minor

        let data = [
            "regions": regions,
            "constraint": c,
        ] as [String : Any]

        print("IBeacon.ranged: \(data)\n")
        notifyListeners("ranged", data: data, retainUntilConsumed: true)
    }

    public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        let data = [
            "region": beaconRegionToJson(region as! CLBeaconRegion),
        ] as [String : Any]

        print("IBeacon.startedMonitoring: \(data)\n")
        notifyListeners("startedMonitoring", data: data, retainUntilConsumed: true)
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let data = [
            "message": error.localizedDescription,
            "type": "error",
        ] as [String: Any]

        print("IBeacon.didFailWithError: \(data)\n")
        notifyListeners("error", data: data, retainUntilConsumed: true)
    }

    @available(iOS 13.0, *)
    public func locationManager(_ manager: CLLocationManager, didFailRangingFor constraint: CLBeaconIdentityConstraint, error: Error) {
        var c = JSObject()
        c["uuid"] = constraint.uuid.uuidString
        c["major"] = constraint.major
        c["minor"] = constraint.minor

        let data = [
            "region": c,
            "message": error.localizedDescription,
            "type": "rangingError",
        ] as [String : Any]

        print("IBeacon.didFailRangingFor: \(data)\n")
        notifyListeners("error", data: data, retainUntilConsumed: true)
    }

    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        let data = [
            "region": beaconRegionToJson(region as! CLBeaconRegion),
            "message": error.localizedDescription,
            "type": "monitoringError",
        ] as [String : Any]

        print("IBeacon.monitoringDidFailFor: \(data)\n")
        notifyListeners("error", data: data, retainUntilConsumed: true)
    }

    public func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if (peripheral.state == .poweredOn) {
            print("IBeacon.peripheralManagerDidUpdateState: powered on");
        } else {
            print("IBeacon.peripheralManagerDidUpdateState: no longer powered on");
        }
    }

    public override func load() {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self

        self.peripheralManager = CBPeripheralManager()
        self.peripheralManager.delegate = self
    }

    @objc func isMonitoringAvailable(_ call: CAPPluginCall) {
        call.success([
            "value": CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self),
        ])
    }

    @objc func isRangingAvailable(_ call: CAPPluginCall) {
        call.success([
            "value": CLLocationManager.isRangingAvailable(),
        ])
    }

    @objc func locationServicesEnabled(_ call: CAPPluginCall) {
        call.success([
            "value": CLLocationManager.locationServicesEnabled(),
        ])
    }

    @objc func requestWhenInUseAuthorization(_ call: CAPPluginCall) {
        self.locationManager.requestWhenInUseAuthorization()
        call.success([
            "value": true,
        ])
    }

    @objc func requestAlwaysAuthorization(_ call: CAPPluginCall) {
        self.locationManager.requestAlwaysAuthorization()
        call.success([
            "value": true,
        ])
    }
    
    @objc func startMonitoringForRegion(_ call: CAPPluginCall) {
        guard let beaconRegion = self.getBeacon(call) else {
            // we don't have to call.error because getBeacon() does it
            return
        }

        self.locationManager.startMonitoring(for: beaconRegion)
        call.success([
            "value": true,
        ])
    }
    
    @objc func stopMonitoringForRegion(_ call: CAPPluginCall) {
        guard let beaconRegion = self.getBeacon(call) else {
            // we don't have to call.error because getBeacon() does it
            return
        }

        self.locationManager.stopMonitoring(for: beaconRegion)
        call.success([
            "value": true,
        ])
    }

    @objc func startRangingBeaconsInRegion(_ call: CAPPluginCall) {
        guard let beaconRegion = self.getBeacon(call) else {
            // we don't have to call.error because getBeacon() does it
            return
        }

        self.locationManager.startRangingBeacons(in: beaconRegion)
        call.success([
            "value": true,
        ])
    }
    
    @objc func stopRangingBeaconsInRegion(_ call: CAPPluginCall) {
        guard let beaconRegion = self.getBeacon(call) else {
            // we don't have to call.error because getBeacon() does it
            return
        }

        self.locationManager.stopRangingBeacons(in: beaconRegion)
        call.success([
            "value": true,
        ])
    }

    @objc func getMonitoredRegions(_ call: CAPPluginCall) {
        let regions = self.locationManager.monitoredRegions;
        var ret = JSArray()
        regions.forEach { region in
            ret.append(self.beaconRegionToJson(region as! CLBeaconRegion));
        }
        call.success([
            "regions": ret,
        ])
    }

    @objc func getRangedRegions(_ call: CAPPluginCall) {
        let regions = self.locationManager.rangedRegions;
        var ret = JSArray()
        regions.forEach { region in
            ret.append(self.beaconRegionToJson(region as! CLBeaconRegion));
        }
        call.success([
            "regions": ret,
        ])
    }

    @objc func isAdvertising(_ call: CAPPluginCall) {
        call.success([
            "value": self.peripheralManager.isAdvertising,
        ])
    }

    @objc func startAdvertising(_ call: CAPPluginCall) {
        guard let beaconRegion = self.getBeacon(call) else {
            // we don't have to call.error because getBeacon() does it
            return
        }
        let measuredPower = call.getDouble("measuredPower")
        let advertisedPeripheralData = beaconRegion.peripheralData(withMeasuredPower: measuredPower as NSNumber?)
        print("IBeacon.startAdvertising: \(advertisedPeripheralData)\n")
        self.peripheralManager.startAdvertising(advertisedPeripheralData as? [String : Any])
        call.success([
            "value": true
        ])
    }

    @objc func stopAdvertising(_ call: CAPPluginCall) {
        print("IBeacon.stopAdvertising)\n")
        self.peripheralManager.stopAdvertising()
        call.success([
            "value": true
        ])
    }

    func beaconRegionToJson(_ beacon: CLBeaconRegion) -> JSObject {
        var asJson = JSObject()
        asJson["uuid"] = beacon.proximityUUID.uuidString
        asJson["identifier"] = beacon.identifier
        asJson["major"] = beacon.major
        asJson["minor"] = beacon.minor
        return asJson
    }

    func beaconToJson(_ beacon: CLBeacon) -> JSObject {
        var asJson = JSObject()
        asJson["uuid"] = beacon.proximityUUID.uuidString
        asJson["major"] = beacon.major
        asJson["minor"] = beacon.minor
        return asJson
    }

    func getBeacon(_ call: CAPPluginCall) -> CLBeaconRegion? {
        guard let identifier = call.getString("identifier") else {
            call.error("identifier is a required field")
            return nil
        }
        guard let uuid = call.getString("uuid") else {
            call.error("uuid is a required field")
            return nil
        }
        let major = call.getInt("major")
        let minor = call.getInt("minor")

        let beaconRegion: CLBeaconRegion

        if (minor != nil) {
            beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: uuid)!, major: CLBeaconMajorValue(major!), minor: CLBeaconMinorValue(minor!), identifier: identifier)
        } else if (major != nil) {
            beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: uuid)!, major: CLBeaconMajorValue(major!), identifier: identifier)
        } else {
            beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: uuid)!, identifier: identifier)
        }

        return beaconRegion;
    }
}
