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
public class IBeacon: CAPPlugin, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var peripheralManager: CBPeripheralManager!


    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        notifyListeners("didChangeAuthorization", data: [
            "status": status
        ])
    }

    public func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        notifyListeners("didDetermineState", data: [
            "state": state
        ])
    }

    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        notifyListeners("didEnterRegion", data: [
            "region": beaconRegionToJson(region as! CLBeaconRegion),
        ])
    }

    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        notifyListeners("didExitRegion", data: [
            "region": beaconRegionToJson(region as! CLBeaconRegion),
        ])
    }
    
    @available(iOS 13.0, *)
    public func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying constraint: CLBeaconIdentityConstraint) {
        var regions = JSArray()
        beacons.forEach { beacon in
            regions.append(beaconToJson(beacon))
        }
        notifyListeners("didRange", data: [
            "regions": regions,
        ])
    }

    public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        notifyListeners("didStartMonitoringFor", data: [
            "region": beaconRegionToJson(region as! CLBeaconRegion),
        ])
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        notifyListeners("error", data: [
            "error": error.localizedDescription,
            "type": "error",
        ])
    }

    @available(iOS 13.0, *)
    public func locationManager(_ manager: CLLocationManager, didFailRangingFor constraint: CLBeaconIdentityConstraint, error: Error) {
        var c = JSObject()
        c["uuid"] = constraint.uuid
        c["major"] = constraint.major
        c["minor"] = constraint.minor

        notifyListeners("error", data: [
            "region": c,
            "error": error.localizedDescription,
            "type": "rangingError",
        ])
    }

    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        notifyListeners("error", data: [
            "region": beaconRegionToJson(region as! CLBeaconRegion),
            "error": error.localizedDescription,
            "type": "monitoringError",
        ])
    }

    @objc func isMonitoringAvailable(_ call: CAPPluginCall) {
        if (CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)) {
            call.success([
                "value": true
            ])
        } else {
            call.success([
                "value": false
            ])
        }
    }

    @objc func isRangingAvailable(_ call: CAPPluginCall) {
        if (CLLocationManager.isRangingAvailable()) {
            call.success([
                "value": true
            ])
        } else {
            call.success([
                "value": false
            ])
        }
    }

    @objc func locationServicesEnabled(_ call: CAPPluginCall) {
        if (CLLocationManager.locationServicesEnabled()) {
            call.success([
                "value": true
            ])
        } else {
            call.success([
                "value": false
            ])
        }
    }

    @objc func requestWhenInUseAuthorization(_ call: CAPPluginCall) {
        self.locationManager.requestWhenInUseAuthorization()
        call.success([
            "value": true
        ])
    }

    @objc func requestAlwaysAuthorization(_ call: CAPPluginCall) {
        self.locationManager.requestAlwaysAuthorization()
        call.success([
            "value": true
        ])
    }
    
    @objc func startMonitoringForRegion(_ call: CAPPluginCall) {
        guard let beaconRegion = self.getBeacon(call) else {
            // we don't have to call.error because getBeacon() does it
            return
        }

        self.locationManager.startMonitoring(for: beaconRegion)
        call.success([
            "value": true
        ])
    }
    
    @objc func stopMonitoringForRegion(_ call: CAPPluginCall) {
        guard let beaconRegion = self.getBeacon(call) else {
            // we don't have to call.error because getBeacon() does it
            return
        }

        self.locationManager.stopMonitoring(for: beaconRegion)
        call.success([
            "value": true
        ])
    }

    @objc func startRangingBeaconsInRegion(_ call: CAPPluginCall) {
        guard let beaconRegion = self.getBeacon(call) else {
            // we don't have to call.error because getBeacon() does it
            return
        }

        self.locationManager.startRangingBeacons(in: beaconRegion)
        call.success([
            "value": true
        ])
    }
    
    @objc func stopRangingBeaconsInRegion(_ call: CAPPluginCall) {
        guard let beaconRegion = self.getBeacon(call) else {
            // we don't have to call.error because getBeacon() does it
            return
        }

        self.locationManager.stopRangingBeacons(in: beaconRegion)
        call.success([
            "value": true
        ])
    }

    @objc func getMonitoredRegions(_ call: CAPPluginCall) {
        let regions = self.locationManager.monitoredRegions;
        var ret = JSArray()
        regions.forEach { region in
            ret.append(self.beaconRegionToJson(region as! CLBeaconRegion));
        }
        call.success([
            "regions": ret
        ])
    }

    @objc func getRangedRegions(_ call: CAPPluginCall) {
        let regions = self.locationManager.rangedRegions;
        var ret = JSArray()
        regions.forEach { region in
            ret.append(self.beaconRegionToJson(region as! CLBeaconRegion));
        }
        call.success([
            "regions": ret
        ])
    }

    func beaconRegionToJson(_ beacon: CLBeaconRegion) -> JSObject {
        var asJson = JSObject()
        asJson["uuid"] = beacon.proximityUUID
        asJson["identifier"] = beacon.identifier
        asJson["major"] = beacon.major
        asJson["minor"] = beacon.minor
        return asJson
    }

    func beaconToJson(_ beacon: CLBeacon) -> JSObject {
        var asJson = JSObject()
        asJson["uuid"] = beacon.proximityUUID
        asJson["major"] = beacon.major
        asJson["minor"] = beacon.minor
        return asJson
    }

    /*
    func stateToJson(_ state: CLRegionState) -> String {
        switch state {
            case CLRegionState.unknown:
                return "unknown"
            case CLRegionState.inside:
                return "inside"
            case CLRegionState.outside:
                return "outside"
        }
    }
    */

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
