/* Локализация ресурсов ExtJs */
//RangeMenus.js
Ext.define("Ext.locale.ukr.ux.grid.menu.RangeMenu", {
    override: "Ext.ux.grid.menu.RangeMenu",
    menuItemCfgs: {
        emptyText: 'Введіть число...'
    },
    fieldLabels: {
        gt: 'Більше ніж',
        lt: 'Менже ніж',
        eq: 'Рівно'
    }
});

//ListMenu.js
Ext.define("Ext.locale.ukr.ux.grid.menu.ListMenu", {
    override: "Ext.ux.grid.menu.ListMenu",
    loadingText: 'Завантаження...'
});

//FiltersFeature.js
Ext.define('Ext.locale.ukr.ux.grid.FiltersFeature', {
    override: "Ext.ux.grid.FiltersFeature",
    menuFilterText: 'Фільтр'
});

//DateFilter.js
Ext.define("Ext.locale.ukr.ux.grid.filter.DateFilter", {
    override: "Ext.ux.grid.filter.DateFilter",
    afterText: 'Після',
    beforeText: 'До',
    onText: 'На дату'
});

//BooleanFilter.js
Ext.define("Ext.locale.ukr.ux.grid.filter.BooleanFilter", {
    override: "Ext.ux.grid.filter.BooleanFilter",
    yesText: 'Так',
    noText: 'Ні'
});

//StringFilter.js
Ext.define("Ext.locale.ukr.ux.grid.filter.StringFilter", {
    override: "Ext.ux.grid.filter.StringFilter",
    emptyText: 'Введіть текст...'
});

//Кнопка рефреша
Ext.define("Ext.locale.ukr.toolbar.Paging", {
    override: "Ext.PagingToolbar",
    refreshText: "Оновити"
});
