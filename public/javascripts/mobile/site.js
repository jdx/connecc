Ext.setup({
    onReady: function() {
        var card1 = new Ext.Component({
            title: 'Card 1',
            cls: 'card1',
            scroll: 'vertical'
        });
        var card2 = new Ext.Component({
            title: 'Card 2',
            cls: 'card2',
            scroll: 'vertical'
        });
        var panel = new Ext.TabPanel({
            fullscreen: true,
            cardSwitchAnimation: 'slide',
            items: [card1, card2]
        });
        var tabBar = panel.getTabBar();
        tabBar.addDocked({
            xtype: 'button',
            ui: 'mask',
            iconCls: 'refresh',
            dock: 'right',
            stretch: false,
            align: 'center'
        });
    }
});
