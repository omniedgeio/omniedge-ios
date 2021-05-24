//
//  PacketTunnelProvider.swift
//  Tunnel
//
//  Created by samuelsong on 2021/4/27.
//

import NetworkExtension
import os.log

class PacketTunnelProvider: NEPacketTunnelProvider {
    private let log = OSLog(subsystem: "Omniedge", category: "default")
    
    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        os_log(.default, log: log, "Omniedge Starting tunnel, options: %{private}@", "\(String(describing: options))")
        do {
            guard let proto = protocolConfiguration as? NETunnelProviderProtocol else {
                throw NEVPNError(.configurationInvalid)
            }
            os_log(.error, log: log, "Omniedge Failed to read the configuration", "error")
        } catch {
            os_log(.error, log: log, "Omniedge Failed to read the configuration", error.localizedDescription)
            completionHandler(error)
        }

        os_log(.default, log: log, "Omniedge Read configuration %{private}@", "\(String(describing: "hello"))")
        // Add code here to start the process of connecting the tunnel.
    }
    
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        // Add code here to start the process of stopping the tunnel.
        completionHandler()
        os_log(.fault, log: log, "Omniedge stopTunnel tunnel, options: %{private}@");

    }
    
    override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
        // Add code here to handle the message.
        if let handler = completionHandler {
            handler(messageData)
        }
        os_log(.fault, log: log, "Omniedge ****** omniedge now working*********\n");
    }
    
    override func sleep(completionHandler: @escaping () -> Void) {
        // Add code here to get ready to sleep.
        completionHandler()
        os_log(.fault, log: log, "Omniedge ****** omniedge now sleep*********\n");
    }
    
    override func wake() {
        // Add code here to wake up.
        os_log(.fault, log: log, "Omniedge ****** omniedge now wake*********\n");
    }
}
