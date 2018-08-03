if (!("bars" in window)) window["bars"] = {};
bars.visaCtrl = bars.visaCtrl || {
    runCheckData: function (row) {

        // F_CHECK_DATA > F_RESERVE > SET_PRIORITY

        var self = bars.visaCtrl;

        // F_CHECK_DATA: 
        bars.ui.loader("body", true);

        var model = { dk: row.DK, id: row.ID, kv: row.KV2, s: row.S2, kursZ: row.KURS_Z, fDat: row.FDAT };
       
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/api/zay/currencystatus/post"),
            data: JSON.stringify(model)
        }).done(function (result) {

            if (result) {
                // if F_CHECK_DATA false:
                bars.ui.loader("body", false);

                var arrayOfLines = [];
                arrayOfLines = result.split(/\r?\n/);

                if (arrayOfLines[0].indexOf('УВАГА! До клієнта застосовано санкції!') !== -1) {
                    bars.ui.confirm({ text: 'УВАГА! До клієнта застосовано санкції! Продовжити?' }, function () {
                        self.runReserve(glReserve, row, model);
                    });
                } else {
                    bars.ui.error({ text: arrayOfLines[0] });
                }

            } else {
                // if F_CHECK_DATA true:
                self.runReserve(glReserve, row, model);
            }
        });
    },
    runReserve: function (glRes, row, model) {

        var self = bars.visaCtrl;

        // F_RESERVE:
        if (parseInt(glRes) === 1) {

            //get DK result - operation type:

            $.ajax({
                type: "GET",
                contentType: "application/json",
                url: bars.config.urlContent("/api/zay/actiontype/get"),
                data: { id: row.ID }
            }).done(function (dkResult) {

                // F_RESERVE result "Do" / "Do not"

                if (dkResult.Data !== 3) {

                    // Do NOT reserve:
                    bars.ui.loader("body", false);

                    if (model.dk === 2 || model.dk === 4) {
                        self.setPriority(row, dkResult.Data);
                    } else {
                        bars.ui.confirm({ text: 'Вы действительно хотите отказаться от блокировки гривны?' }, function () {

                            // bars.ui.alert({ text: 'ZAY. Пользователь отказался от блокировки гривны, ' +
                            // 'необходимой на покупку валюты по заявке' });

                            // run PRIORITY(row + start > bars.ui.loader("body", false);) func
                            self.setPriority(row, dkResult.Data);
                        });
                    }
                } else {
                    // Do reserve:
                    $.ajax({
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/api/zay/reserve/get"),
                        data: { id: row.ID, type: 1 }
                    }).done(function (reserveResult) {

                        if (reserveResult.Data.Msg && reserveResult.Data.SumB === 0) {


                            bars.ui.loader("body", false);
                            bars.ui.alert({ text: reserveResult.Data.Msg });
                        } else {


                            // go forward, run PRIORITY(row + start > bars.ui.loader("body", false);) func
                            bars.ui.loader("body", false);
                            bars.ui.alert({ text: reserveResult.Data.Msg });



                            bars.ui.loader("body", true);

                            self.setPriority(row, dkResult.Data);
                        }
                    });
                }
            });
        } else {
            bars.ui.loader("body", false);
            self.setPriority(row, row.DK);
        }
    },
    setPriority: function (row, dk) {
        // done > done > SET_PRIORITY
        var self = bars.visaCtrl;

         
        bars.ui.loader("body", false);

        if (dk !== 3) {
            if (row.PRIORITY !== parseInt(glCovered) && parseInt(glCovered) > 0) {
                if (row.COVER_ID === 0) {
                    bars.ui.confirm({
                        text: 'Заявка № ' + row.ID + ' не обеспечена средствами.' +
                            'Вы действительно хотите завизировать заявку с приоритетом № ' + row.PRIORITY + ' ?'
                    }, function() {
                        //If pBuySell = 1
                        //Set ZAYV_BUY.PRIORITY = nCovered
                        bars.ui.loader("body", true);
                        self.setVisa(row, dk);
                    });
                } else {
                    // COVER_ID > 0
                    bars.ui.loader("body", true);
                    self.setVisa(row, dk);
                }              
            } else {
                bars.ui.error({ text: 'Заявка не пройшла перевірку. Операція скасована!' });
            }
        } else {
             
            bars.ui.loader("body", true);
            self.setVisa(row, dk);
        }
    },
    setVisa: function (row, dk) {

         

        // Viza type: 1 
        // try to use dk?
        var visaType = 1;

       
        var supDoc = row.SUP_DOC ? 1 : null;
        
        var visaArr = [],
            model = { Id: row.ID, Viza: visaType, Priority: row.PRIORITY, AimsCode: row.AIMS_CODE ? row.AIMS_CODE : null, SupDoc: supDoc, F092Code: row.F092_Code };
        visaArr.push(model);

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/api/zay/setvisa/post"),
            data: JSON.stringify(visaArr)
        }).done(function (result) {             
            bars.ui.loader("body", false);
            var grid = $("#grid").data("kendoGrid");
            var iDsuccess = '';
            var idErrors = '';
            for(var i = 0; i < result.length; i++) {
                if (result[i].Status === 1) {
                                        
                    iDsuccess = iDsuccess ? iDsuccess + ', ' + result[i].Id : result[i].Id;
                    bars.ui.alert({ text: 'Завізовано: ' + iDsuccess + ' .' });
                    
                    grid.dataSource.read();
                } else {
                    idErrors = idErrors ? idErrors + ', ' + result[i].Id : result[i].Id;
                    bars.ui.error({ text: 'Не завізовано: ' + idErrors + ' .<br/>' + result[i].Msg });
                    
                    grid.dataSource.read();
                }
            }

            
        });
    }
}