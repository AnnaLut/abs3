if (!('bars' in window)) window['bars'] = {};
bars.sepTechDocs = bars.sepTechDocs || {
    sepTechGrid: null,

    sepObj: {},

    techGrid: function () {
        if (this.sepTechGrid == null) {
            this.sepTechGrid = $('#SepTechAccountsGridV2').data('kendoGrid');
        }
        return this.sepTechGrid;
    },

    getTechGridAccData: function () {
        var self = bars.sepTechDocs;
        var grid = self.techGrid();
        var record = grid.dataItem(grid.select());
        self.openPercentCalc(record);
    },

    openPercentCalc: function (fileRow) {
        var self = bars.sepTechDocs;

        var procParams = {
            acc: fileRow.ACC,
            nls: fileRow.NLS,
            kv: fileRow.KV
        };
        window.location = bars.config.urlContent('/Sep/SepTechAccounts/PercentCalculation?') + jQuery.param(procParams);
    },

    getTechGridProccesingData: function () {
        var self = bars.sepTechDocs;
        var grid = self.techGrid();
        var record = grid.dataItem(grid.select());
        debugger;
        self.openDocsProccessingFile(record);
    },

    openDocsProccessingFile: function (fileRow) {
        var self = bars.sepTechDocs;

        self.sepObj = fileRow;
        debugger;
        var procParams = {
            acc: fileRow.ACC,
            tip: fileRow.TIP,
            kv: fileRow.KV,
            ACCCOUNT: fileRow.ACCCOUNT,
            BLKD : fileRow.BLKD,
            BLKK : fileRow.BLKK,
            DAOS: kendo.toString(fileRow.DAOS, 'dd/MM/yyyy') != null ? kendo.toString(fileRow.DAOS, 'dd/MM/yyyy') : '',
            DAPP: kendo.toString(fileRow.DAPP, 'dd/MM/yyyy') != null ? kendo.toString(fileRow.DAPP, 'dd/MM/yyyy') : '',
            DAZS: kendo.toString(fileRow.DAZS, 'dd/MM/yyyy') != null ? kendo.toString(fileRow.DAZS, 'dd/MM/yyyy') : '',
            DIG : fileRow.DIG,
            DOSF : fileRow.DOSF,
            FIO : fileRow.FIO,
            ISF : fileRow.ISF,
            ISP : fileRow.ISP,
            KOSF : fileRow.KOSF,
            LCV : fileRow.LCV,
            NBS : fileRow.NBS,
            NLS : fileRow.NLS,
            NLSALT : fileRow.NLSALT,
            NMS: fileRow.NMS,
            OB22: fileRow.OB22,
            OSTBF : fileRow.OSTBF,
            OSTCF : fileRow.OSTCF,
            OSTFF: fileRow.OSTFF,
            PAP : fileRow.PAP,
            RNK : fileRow.RNK,
            TOBO : fileRow.TOBO
        };
        
        window.location = bars.config.urlContent('/Sep/SepProccessing/Grid?') + jQuery.param(procParams);
    }

};