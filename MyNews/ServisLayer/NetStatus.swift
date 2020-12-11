//
//  NetStatus.swift
//  MyNews
//
//  Created by user on 01.08.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Network
import RxSwift

class NetStatus {
    static let shared = NetStatus()
    
    private var statusPrivate: PublishSubject<Bool>
    var status: Observable<Bool> {
        return statusPrivate.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
    var monitor: NWPathMonitor?
    var isMonitoring = false
    
    var didStartMonitoringHandler: (() -> Void)?
     
    var didStopMonitoringHandler: (() -> Void)?
     
    var netStatusChangeHandler: (() -> Void)?
    
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil }
     
        return monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type) }.first?.type
    }
    
    var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false
    }
 
    private init() {
        self.statusPrivate = PublishSubject<Bool>()
        self.statusPrivate.onNext(false)
    }
    
    func startMonitoring() {
        guard !isMonitoring else { return }
     print("startMonitoring")
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)
     
        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }
        
        isMonitoring = true
        didStartMonitoringHandler?()
        self.statusPrivate.onNext(true)
    }
    
    func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        print("stopMonitoring")
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
        self.statusPrivate.onNext(false)
    }
    
    deinit {
        stopMonitoring()
    }
}
