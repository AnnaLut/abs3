Ext.define('ExtApp.view.refBook.SypleFilterFormPanel', {
    extend: 'Ext.form.Panel',
    alias: 'widget.refFormPanel',
    overflowY: 'auto',
    id: 'SypleFilterFormPanelId',
    labelWidth: 110,
    layout: {
        //размещение элементов вертикально один за одним
        type: 'vbox',
        //дочерние элементы растягиваются на всю ширину
        align: 'stretch'
    },
    bodyPadding: 5,
    //без данного признака значения originalValue полей формы undefined при закачке данных на форму
    trackResetOnLoad: true,
    border: false,
    autoscroll: true,
    //в initComponent вынесены свойства которые нужно заполнить с учетом переданных данных при создании комбобокса
    initComponent: function () {
        this.callParent();
    }
});