/*
 * SPDX-FileCopyrightText: 2021 Lucas Wang <lucas.wang@tuta.io>
 *
 * SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 */

// Original header below:
//
//  RunCommandView.swift
//  KDE Connect Test
//
//  Created by Lucas Wang on 2021-09-16.
//

import SwiftUI
// TODO: Commands are not getting parsed properly? Investigate.
struct RunCommandView: View {
    let detailsDeviceId: String
    @State var commandItemsInsideView: [String : CommandEntry] = [:]
    
    var body: some View {
        List {
            ForEach(Array(commandItemsInsideView.keys), id: \.self) { commandkey in
                Button(action: {
                    (backgroundService._devices[detailsDeviceId]!._plugins[PACKAGE_TYPE_RUNCOMMAND] as! RunCommand).runCommand(cmdKey: commandkey)
                    notificationHapticsGenerator.notificationOccurred(.success)
                }, label: {
                    VStack {
                        Text(commandItemsInsideView[commandkey]?.name ?? "ERROR")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(commandItemsInsideView[commandkey]?.command ?? "ERROR")
                            .font(.caption)
                    }
                })
            }
        }
        .navigationBarTitle("Run Command", displayMode: .inline)
        .navigationBarItems(trailing: Button {
            (backgroundService._devices[detailsDeviceId]!._plugins[PACKAGE_TYPE_RUNCOMMAND] as! RunCommand).sendSetupPackage()
        } label: {
            Image(systemName: "command") // is there a better choice for this? This is a nice reference though I think
        })
        .onAppear {
            if ((backgroundService._devices[detailsDeviceId]!._plugins[PACKAGE_TYPE_RUNCOMMAND] as! RunCommand).controlView == nil) {
                (backgroundService._devices[detailsDeviceId]!._plugins[PACKAGE_TYPE_RUNCOMMAND] as! RunCommand).controlView = self
            }
            (backgroundService._devices[detailsDeviceId]!._plugins[PACKAGE_TYPE_RUNCOMMAND] as! RunCommand).processCommandItemsAndGiveToRunCommandView()
        }
    }
}

//struct RunCommandView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunCommandView()
//    }
//}
