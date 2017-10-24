$(document).ready(function () {
    var DptArch_model = kendo.data.Model.define({
        id: DptArch_model,
        fields: {
            deposit_id: { type: "number" },
            nd: { type: "string" },
            kv: { type: "number" },
            branch: { type: "string" },
            acc: { type: "number" },
            nls: { type: "string" },
            rnk: { type: "number" },
            nmk: { type: "string" },
            ostd: { type: "number" },
            ostdq: { type: "number" },
            ostp: { type: "number" },
            ostpq: { type: "number" },
            vidd: { type: "number" },
            vidd_name: { type: "string" },
            ir: { type: "number" },
            dat_begin: { type: "date" },
            dat_end: { type: "date" },
            cnt_dubl: { type: "number" },
            userid: { type: "number" },
            dazs: { type: "date" },
            dos: { type: "number" },
            kos: { type: "number" },
            cdat: { type: "date" },
            idupd: { type: "number" },
            docreq: { type: "string" },
            pdate: { type: "date" },
            porgan: { type: "string" },
            passpname: { type: "string" },
        }
    });
    var prepareDDL = function () {
        var viddarc_list = kendo.data.Model.define({
            id: viddarc_list,
            fields: { TYPE_NAME: { type: "string" } }
        });
        var viddarc_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetVidd') } },
            schema: { data: "data", model: viddarc_list }
        });
        $('#viddlistddl').kendoDropDownList({
            dataTextField: "TYPE_NAME",
            dataValueField: "VIDD",
            dataSource: viddarc_data,
            filter: "contains"
        });
        var branch_list = kendo.data.Model.define({
            id: branch_list,
            fields: { branch_: { type: "string" }, NAME: { type: "string" } }
        });
        var branch_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/DptAdm/DptAdm/GetBranchList') } },
            schema: { data: "data", model: branch_list }
        });
        $('#branchlist').kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "branch_",
            dataSource: branch_data,
            filter: "contains"
        });

    }
    prepareDDL();

    $('#buttonArc').kendoButton({
        enable: true,
        click: function () {
            var cd = $('#cdate').val();
            var vidd = $('#viddlistddl').data("kendoDropDownList").value();
            var branch = $('#branchlist').data("kendoDropDownList").value();
            alert(vidd);
            $.get(bars.config.urlContent('/DptAdm/DptAdm/GetDptArchive'), { cdat: cd, VIDD: vidd, BRANCH: branch }).done(function (result) {
                if (result.status == "ok") {
                    var DPTArch = $('#DPTArch').kendoGrid({
                        autobind: true,
                        selectable: "row",
                        scrolable: true,
                        pagable: true,
                        pagesize: 30,
                        sortable: true,
                        columns: [{field: "deposit_id",title: "Ід",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "nd", title: "Номер", width: "5%", attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" } },
                                {field: "kv",title: "Валюта",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "branch",title: "Відділення",width: "10%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "acc",title: "Ід.рахунку",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "nls",title: "№ рахунку",width: "7%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "rnk",title: "РНК",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "nmk",title: "Найменування клієнта",width: "15%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "ostd",title: "Залишок деп.",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "ostdq",title: "Екв.залишку деп.",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "ostp",title: "Залишок %%",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "ostpq",title: "Екв. залишку %%",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "vidd",title: "Вид",width: "2%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "vidd_name", title: "Назва виду", width: "15%", attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" } },
                                {field: "ir",title: "Ставка",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "dat_begin",title: "Дата початку",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "dat_end",title: "Дата закінчення",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "cnt_dubl",title: "Кількість лонг.",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "userid", title: "Користувач", width: "5%", attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" } },
                                {field: "dazs",title: "Дата закриття",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "dos",title: "Дт.об.",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "kos", title: "Кт.об.", width: "5%", attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" } },
                                {field: "cdat",title: "Звітна дата",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "idupd",title: "Ід.зміни",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "docreq",title: "Документ",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "pdate",title: "Дата видачі",width: "5%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "porgan",title: "Орган",width: "15%",attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }},
                                {field: "passpname", title: "тип документа", width: "15%", attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" } }
                        ],
                        dataSource: result.data
                    });
                }
            });
        }
    });
});
