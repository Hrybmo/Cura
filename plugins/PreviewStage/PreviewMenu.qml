// Copyright (c) 2018 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.7
import QtQuick.Controls 2.3

import UM 1.3 as UM
import Cura 1.1 as Cura

Item
{
    id: previewMenu
    // This widget doesn't show tooltips by itself. Instead it emits signals so others can do something with it.
    signal showTooltip(Item item, point location, string text)
    signal hideTooltip()

    property real itemHeight: height - 2 * UM.Theme.getSize("default_lining").width

    UM.I18nCatalog
    {
        id: catalog
        name: "cura"
    }


    Row
    {
        id: stageMenuRow
        anchors.centerIn: parent
        height: parent.height

        Cura.ViewsSelector
        {
            id: viewsSelector
            height: parent.height
            width: UM.Theme.getSize("views_selector").width
            headerCornerSide: Cura.RoundedRectangle.Direction.Left
        }

        // Separator line
        Rectangle
        {
            height: parent.height
            // If there is no viewPanel, we only need a single spacer, so hide this one.
            visible: viewPanel.source != ""
            width: visible ? UM.Theme.getSize("default_lining").width : 0

            color: UM.Theme.getColor("lining")
        }

        Loader
        {
            id: viewPanel
            height: parent.height
            width: childrenRect.width
            source: UM.Controller.activeView != null && UM.Controller.activeView.stageMenuComponent != null ? UM.Controller.activeView.stageMenuComponent : ""
        }

        // Separator line
        Rectangle
        {
            height: parent.height
            width: UM.Theme.getSize("default_lining").width
            color: UM.Theme.getColor("lining")
        }

        Item
        {
            id: printSetupSelectorItem
            // This is a work around to prevent the printSetupSelector from having to be re-loaded every time
            // a stage switch is done.
            children: [printSetupSelector]
            height: childrenRect.height
            width: childrenRect.width
        }
    }
}