if (!("bars" in window)) window["bars"] = {};
bars.helper = bars.helper || {
    loadTemplate: function (path) {
        $.get(path).success(function (result) {
            $("body").append(result);
        }).error(function (result) {
            alert("Помилка завантаження шаблону!");
        });
    },
    initAllDictionaries: function (data) {

        // #1 Ціль покупки:
        $("#meta_aim_name").kendoDropDownList({
            dataTextField: "AIM_NAME",
            dataValueField: "AIM_CODE",
            valueTemplate: '<span><b>#: AIM_CODE #</b>  -  #:AIM_NAME#</span>',
            template: '<span class="k-state-default"></span>' +
                                      '<span class="k-state-default" style="font-size: 13px;"><b>#: AIM_CODE #</b> - #:AIM_NAME#</span>',
            dataSource: {
                filter: {
                    field: "AIM_NAME",
                    operator: "neq",
                    value: "null"
                },
                sort: {
                    field: "AIM_CODE",
                    dir: "asc"
                },
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        data: { isBuying : true },
                        url: bars.config.urlContent("/api/zay/aims/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            },
            change: function (e) {
                //var bankName = this.dataItem().BANK_NAME;
                // Use the value of the widget to update BANK_NAME:
                //$("#bank_name").val(bankName);

                // aim code 03 condition:
                if (this.dataItem().AIM_CODE === 3) {
                    var aim = {
                        countryCode: 804,
                        basisText: '3.1.а.1',
                        bankCode: '8040000000'
                    };

                    var dlCountryName = $("#country_name").data("kendoDropDownList"),
                        dlBenefCountry = $("#benef_country").data("kendoDropDownList"),
                        dlBasisText = $("#basis_txt").data("kendoDropDownList"),
                        dlBankCode = $("#bank_code").data("kendoDropDownList");

                    dlCountryName.value(aim.countryCode);
                    dlBenefCountry.value(aim.countryCode);
                    dlBasisText.value(aim.basisText);
                    dlBankCode.text(aim.bankCode);
                    $("#bank_name").val(aim.bankCode);
                }
            },
            height: 400
        });

        var dropdownlist1 = $("#meta_aim_name").data("kendoDropDownList");
        dropdownlist1.list.width(380);

        // #2 Країна перечислення валюти:
        $("#country_name").kendoDropDownList({
            filter: "startswith",
            dataTextField: "COUNTRY_CODE",
            dataValueField: "COUNTRY_CODE",
            optionLabel: "Оберіть країну...",
            valueTemplate: '<span><b>#:COUNTRY_CODE #</b> -  #:COUNTRY_NAME#</span>',
            template: '<span class="k-state-default" style="font-size: 13px;"><b>#: COUNTRY_CODE #</b> - #:COUNTRY_NAME#</span>',
            dataSource: {
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/zay/country/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            },
            select: function (e) {

                var country_name = e.item.text();
                var code = country_name.match(/\d+/);

                if (code != null) {
                    debugger;
                    var dropdownlist5 = $("#bank_code").data("kendoDropDownList");

                    if (code[0].length === 3) {
                        dropdownlist5.dataSource.filter({ field: "BANK_CODE", ignoreCase: true, operator: "startswith", value: code[0] });
                        dropdownlist5.filterInput.val(code);
                    }
                    else if (code[0].length === 2) {
                        dropdownlist5.filterInput.val(code);
                        dropdownlist5.dataSource.filter({ filters: [{ field: "BANK_CODE", ignoreCase: true, operator: "startswith", value: '0' + code[0] }] });
                    }
                    else if (code[0].length === 1) {
                        dropdownlist5.filterInput.val(code);
                        dropdownlist5.dataSource.filter({ filters: [{ field: "BANK_CODE", ignoreCase: true, operator: "startswith", value: '0' + '0' + code[0] }] });
                    }

                }

               

            },
            dataBound: function () {
                var dropdownlist = $("#country_name").data("kendoDropDownList");
                // selects item if its text is equal to "test" using predicate function
                var cName = data.COUNTRY_NAME ? data.COUNTRY_NAME.substr(data.COUNTRY_NAME.indexOf(" ") + 1) : "";
                dropdownlist.select(function (dataItem) {
                    return dataItem.COUNTRY_NAME === cName;
                });
            },
            height: 400
        });

        var dropdownlist2 = $("#country_name").data("kendoDropDownList");
        dropdownlist2.list.width(380);

        // #3 Причина покупки:
        $("#basis_txt").kendoDropDownList({
            dataTextField: "TXT",
            dataValueField: "P63",
            optionLabel: "Оберіть причину...",
            valueTemplate: '<span><b>#: P63 #</b> - #:TXT#</span>',
            template: '<span class="k-state-default"></span>' +
                                      '<span class="k-state-default" style="font-size: 13px;"><b>#: P63 #</b> - #:TXT#</span>',
            dataSource: {
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/zay/kod702/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            },
            dataBound: function () {
                var dropdownlist = $("#basis_txt").data("kendoDropDownList");
                // selects item if its text is equal to "test" using predicate function
                dropdownlist.select(function (dataItem) {
                    return dataItem.TXT === data.TXT;
                });
            },
            height: 400
        });

        var dropdownlist3 = $("#basis_txt").data("kendoDropDownList");
        dropdownlist3.list.width(380);

        // Підстава для купівлі F092 (510):
        $("#f092_text").kendoDropDownList({
            dataTextField: "F902_Name",
            dataValueField: "F092_Code",
            optionLabel: "Оберіть підставу...",
            valueTemplate: '<span><b>#: F092_Code #</b> - #:F092_Name#</span>',
            template: '<span class="k-state-default"></span>' +
            '<span class="k-state-default" style="font-size: 13px;"><b>#: F092_Code #</b> - #:F092_Name#</span>',
            dataSource: {
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/zay/F092/GetBuyingF092")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            }
            /*,
            change: function (e) {
                var grid = $("#grid").data("kendoGrid");
                var row = grid.dataItem(grid.select());
                row.F092_Text = this.text();
                row.F092_Code = this.value();
            }*/
        });

        var f092Dropdownlist = $("#f092_text").data("kendoDropDownList");
        f092Dropdownlist.list.width(380);


        // #4 Країна бенефециара:
        $("#benef_country").kendoDropDownList({
            filter: "startswith",
            dataTextField: "COUNTRY_CODE",
            dataValueField: "COUNTRY_CODE",
            optionLabel: "Оберіть країну...",
            valueTemplate: '<span><b>#: COUNTRY_CODE #</b> - #:COUNTRY_NAME#</span>',
            template: '<span class="k-state-default" style="font-size: 13px;"><b>#: COUNTRY_CODE #</b> - #:COUNTRY_NAME#</span>',
            dataSource: {
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/zay/country/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            },
            dataBound: function () {
                debugger;
                var dropdownlist = $("#benef_country").data("kendoDropDownList");
                // selects item if its text is equal to "test" using predicate function
                dropdownlist.select(function (dataItem) {
                    return dataItem.COUNTRY_NAME === data.NAME;
                });
            },
            height: 400
        });

        // #5 Код іноземного банку:
        var bankCodeDropDown = $("#bank_code").kendoDropDownList({
            dataTextField: "BANK_CODE",
            dataValueField: "BANK_CODE",
            optionLabel: "Оберіть код банку...",
            valueTemplate: '<span>#:BANK_CODE#</span>',
            template: '<span class="k-state-default"></span>' +
                                      '<span class="k-state-default" style="font-size: 12px;"><b>#: BANK_CODE#</b>  #:BANK_NAME==null?" " : "- " + BANK_NAME#</span>',
            dataSource: {
                type: 'aspnetmvc-ajax',
                serverSorting: true,
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/zay/rcbank/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                },
                sort: {
                    field: "BANK_CODE",
                    dir: "asc"
                }
            },
            dataBound: function () {
                debugger;
                var dropdownlist = $("#bank_code").data("kendoDropDownList");
                // selects item if its text is equal to "test" using predicate function
                dropdownlist.select(function (dataItem) {
                    return dataItem.BANK_CODE === data.BANK_CODE;
                });
                var bName = data.BANK_NAME;
                $("#bank_name").val(bName === null ? ' - ' : bName);
            },
            change: function (e) {
                var ev = e;
                debugger;
                var bankName = this.dataItem().BANK_NAME;
                // Use the value of the widget to update BANK_NAME:
                $("#bank_name").val(bankName);
            },
            filter: "startswith",
            filtering: function (e) {
                debugger;
                //get filter descriptor
                var filter = e.filter;

                // handle the event
            }
        });

        var dropdownlist5 = $("#bank_code").data("kendoDropDownList");
        dropdownlist5.filterInput.val($("#bank_code").val() ? $("#bank_code").val() : 1);
        /*dropdownlist5.dataSource.filter({
            filters: [
                {
                    field: "BANK_CODE",
                    ignoreCase: true,
                    operator: "startswith",
                    value: $("#bank_code").val() ? $("#bank_code").val() : 1
                }
            ]
        });*/
        dropdownlist5.list.width(380);

        // #6 Товарна група:
        $("#product_group_name").kendoDropDownList({
            dataTextField: "PRODUCT_GROUP_NAME",
            dataValueField: "PRODUCT_GROUP",
            optionLabel: "Оберіть групу...",
            valueTemplate: '<span><b>#: PRODUCT_GROUP #</b> - #:PRODUCT_GROUP_NAME#</span>',
            template: '<span class="k-state-default"></span>' +
                                      '<span class="k-state-default" style="font-size: 13px;"><b>#: PRODUCT_GROUP #</b> - #:PRODUCT_GROUP_NAME#</span>',
            dataSource: {
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/zay/kod704/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            },
            height: 400
        });

        var dropdownlist6 = $("#product_group_name").data("kendoDropDownList");
        dropdownlist6.list.width(380);

        // #7 Rjl купівлі за імпортом:
        $("#code2c").kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "ID",
            optionLabel: "Оберіть код...",
            valueTemplate: '<span><b>#: ID #</b> - #:NAME#</span>',
            template: '<span class="k-state-default"></span>' +
                                      '<span class="k-state-default" style="font-size: 13px;"><b>#: ID #</b> - #:NAME#</span>',
            dataSource: {
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/zay/codeimport/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            },
            height: 400
        });
        var dropdownlist7 = $("#code2c").data("kendoDropDownList");
        dropdownlist7.list.width(380);

        // #8 Ознака операції:
        $("#p12").kendoDropDownList({
            dataTextField: "TXT",
            dataValueField: "CODE",
            optionLabel: "Оберіть ознаку...",
            valueTemplate: '<span><b>#:CODE #</b> #:TXT#</span>',
            template: '<span class="k-state-default"></span>' +
                                      '<span class="k-state-default" style="font-size: 13px;"><b>#:CODE #</b> #:TXT#</span>',
            dataSource: {
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/zay/opermark/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            },
            height: 400
        });
        var dropdownlist8 = $("#p12").data("kendoDropDownList");
        dropdownlist8.list.width(380);


        // save edited obj:
        function getObjData(data) {
            var id = data.ID,                                                               // Идентификатор заявки
                verifyOpt = $('#checkRequiredField').is(":checked") ? 1 : 0,                // Унікальний номер операції в системі Клієнт-Банк HOKK
                meta = $("#meta_aim_name").data("kendoDropDownList").value(),               // Цель покупки (спр-к zay_aims)
                f092 = $("#f092_text").data("kendoDropDownList").value(),                   // Значение параметра F092
                contract = $("#contract").val(),                                            // № контракта
                dat2Vmd = $("#dat2_vmd").val(),                                             // дата контракта
                datVmd = $("#dat_vmd").val(),                                               // дата последней вмд
                dat5Vmd = $("#dat5_vmd").val(),                                             // дата остальных вмд
                country = $("#country_name").data("kendoDropDownList").value(),             // код страны перечисления заявки
                basis = $("#basis_txt").data("kendoDropDownList").value(),                  // Основание для покупки валюты
                benefcountry = $("#benef_country").data("kendoDropDownList").value(),       // код страны клиента-бенефециара
                bankName = $("#bank_name").val(),                                           // наименование иностранного банка
                bankCode = $("#bank_code").data("kendoDropDownList").text().trim() === 'Оберіть код банку...' ? '' : $("#bank_code").data("kendoDropDownList").text().trim();
            productGroup = $("#product_group_name").data("kendoDropDownList").value(),      // код товарной группы (kod_70_4)
            numVmd = $("#num_vmd").val(),                                                   // № таможенной декларации
            code2C = $("#code2c").data("kendoDropDownList").value(),                        // Код купівлі за імпортом (#2C)
            p122C = $("#p12").data("kendoDropDownList").value();                            // Ознака операції(#2C)

            return {
                Id: id,
                VerifyOpt: verifyOpt,
                Meta: meta,
                F092: f092,
                Contract: contract,
                Dat2Vmd: dat2Vmd,
                DatVmd: datVmd,
                Dat5Vmd: dat5Vmd,
                Country: country,
                Basis: basis,
                BenefCountry: benefcountry,
                BankName: bankName,
                BankCode: bankCode,
                ProductGroup: productGroup,
                NumVmd: numVmd,
                Code2C: code2C,
                P122C: p122C
            }
        }

        // buttons:
        $("#save-btn").kendoButton({
            click: function () {
                
                var detailsModel = getObjData(data);
                
                var codeValid = function (detailsModel) {

                    var cCode = detailsModel.Country;
                    var bCode;
                    if (cCode.length === 3) {
                        bCode = detailsModel.BankCode.substring(0, 3);
                    }
                    else if (cCode.length === 2) {
                        bCode = detailsModel.BankCode.substring(1, 3);
                    }
                    else if (cCode.length === 1) {
                        bCode = detailsModel.BankCode.substring(2, 3);
                    }
                    else {
                        bCode = '';
                    }
                    return cCode === bCode;
                }
                
                if ($('#checkRequiredField').is(":checked") && bars.helper.validateForm()) {
                    var res = codeValid(detailsModel);
                    if (res && detailsModel.Basis) {
                        $.ajax({
                            type: "POST",
                            url: bars.config.urlContent("/api/zay/adddetails/post"),
                            contentType: "application/json",
                            dataType: "json",
                            data: JSON.stringify(detailsModel)
                        }).done(function (result) {
                            if (result.Status === "Ok") {
                                bars.ui.alert({ text: result.Message });
                                var window = $("#window").data("kendoWindow");
                                window.close();
                                $("#grid").data("kendoGrid").dataSource.read();
                            } else {
                                bars.ui.error({ text: result.Message });
                            }
                        });
                    } else {
                        if (!res) {
                            bars.ui.error({ text: 'Код країни перерахування не відповідає коду індекса банка!' });
                        } else if (!detailsModel.Basis) {
                            bars.ui.error({ text: 'Не вказано причину купівлі валюти!' });
                        }
                    }
                }
                else if (!$('#checkRequiredField').is(":checked")) {
                    $.ajax({
                        type: "POST",
                        url: bars.config.urlContent("/api/zay/adddetails/post"),
                        contentType: "application/json",
                        dataType: "json",
                        data: JSON.stringify(detailsModel)
                    }).done(function (result) {
                        if (result.Status === "Ok") {
                            bars.ui.alert({ text: result.Message });
                            var window = $("#window").data("kendoWindow");
                            window.close();
                            $("#grid").data("kendoGrid").dataSource.read();
                        } else {
                            bars.ui.error({ text: result.Message });
                        }
                    });
                }
                
                
            }
        });
        $("#cencel-btn").kendoButton({
            click: function () {
                var window = $("#window").data("kendoWindow");
                window.close();
            }
        });
    },
    initDatepickers: function (data) {
        $("#dat_vmd").kendoDatePicker({
            format: "dd/MM/yyyy"
        });
        $("#dat2_vmd").kendoDatePicker({
            format: "dd/MM/yyyy"
        });
    },
    validateForm: function () {
       
        var contract = $.trim($('#contract').val());
        var dat2_vmd = $.trim($('#dat2_vmd').val());
        var benef_country = $('#benef_country').val();
        var benef_country = $('#benef_country').val();
        var p12 = $('#p12').val();


        var aim = $("#meta_aim_name").data("kendoDropDownList").dataItem().AIM_CODE,
            dlCountryName = $("#country_name").data("kendoDropDownList").value(),
            dlBenefCountry = $("#benef_country").data("kendoDropDownList").value(),
            dlBasisText = $("#basis_txt").data("kendoDropDownList").value(),
            dlBankCode = $("#bank_code").data("kendoDropDownList").value();

        var aimValidCobdition = {
            countryCode: 804,
            basisText: '3.1.а.1',
            bankCode: '8040000000'
        };

        if (aim === 3) {
            if (parseInt(dlCountryName) !== aimValidCobdition.countryCode) {
                bars.ui.error({ text: "Ціль покупки не сумісна із обраним значенням країни перерахування валюти!(п.6)" });
                return false;
            } else if (parseInt(dlBenefCountry) !== aimValidCobdition.countryCode) {
                bars.ui.error({ text: "Ціль покупки не сумісна із обраним значенням країни бенефеціара!(п.8)" });
                return false;
            } else if (dlBasisText !== aimValidCobdition.basisText) {
                bars.ui.error({ text: "Ціль покупки не сумісна із обраним значенням причини покупки!(п.7)" });
                return false;
            } else if (dlBankCode !== aimValidCobdition.bankCode) {
                bars.ui.error({ text: "Ціль покупки не сумісна із обраним значенням коду та назви банку!(п.9/10)" });
                return false;
            }
        }

        if (contract === "" || contract === null) {
            bars.ui.error({ text: "Не вказано № контракту " });
            return false;
        }
        else if (dat2_vmd === "" || dat2_vmd === null) {
            bars.ui.error({ text: "Не вказано дату контракту " });
            return false;
        }
        else if (benef_country === "") {
            bars.ui.error({ text: "Не вказано країну бенефеціара " });
            return false;
        }
        else if (code2c === "") {
            bars.ui.error({ text: "Не вказано код купівлі за імпортом (\#2C)" });
            return false;
        }
        else if (p12 === "") {
            bars.ui.error({ text: "Не вказано ознаку операції (\#2C)" });
            return false;
        }
        else {
            return true;
        }
    }
}