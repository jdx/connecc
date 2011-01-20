Ext.setup({
    onReady: function() {
        var panel = new Ext.form.FormPanel({
            title: "Login",
            fullscreen: true,
            dockedItems: [
                {
                    dock: 'top',
                    xtype: 'toolbar',
                    title: 'conne.cc'
                }
            ],
            items: [
                {
                    xtype:'fieldset',
                    title:'Login',
                    items: [
                        {
                            xtype: 'emailfield',
                            name: 'email',
                            label: 'Email'
                        },
                        {
                            xtype: 'passwordfield',
                            name: 'password',
                            label: 'Password'
                        }
                    ]
                },
                {
                    xtype:'button',
                    text:'Login'
                }
            ]
        });
    }
});
