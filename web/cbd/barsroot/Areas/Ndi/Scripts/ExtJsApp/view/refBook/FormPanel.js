//вид формы и основные свойства которые используются во всех формах справочников
Ext.define('ExtApp.view.refBook.FormPanel', {
    extend: 'Ext.form.Panel',
    alias: 'widget.refFormPanel',
    overflowY: 'auto',
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

    //в initComponent вынесены свойства которые нужно заполнить с учетом переданных данных при создании комбобокса
    initComponent: function () {
        this.callParent();
    }
});
