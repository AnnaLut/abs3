<%@ Page Language="C#" AutoEventWireup="true" CodeFile="doc.aspx.cs" Inherits="finmon_doc" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Документи для Фінансового Моніторингу</title>
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <link href="../Content/Bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/Styles.css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../Scripts/jquery/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/kendo.all.min.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/kendo.aspnetmvc.min.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/kendo.timezones.min.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/Bars/bars.config.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/cultures/kendo.culture.uk.min.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/cultures/kendo.culture.uk-UA.min.js"></script>
    <script language="javascript" type="text/javascript" src="../Scripts/kendo/messages/kendo.messages.uk-UA.min.js"></script>
    <script language="javascript" type="text/javascript" src="/barsroot/Scripts/Bars/bars.ui.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/Script/BarsIe.js"></script>

    <style type="text/css">
        .modalBackground
        {
            background-color:beige;
            filter: alpha(opacity=90);
            opacity: 0.7;
        }
        .modal
        {
            position: fixed;
            top: 0;
            left: 0;
            background-color: black;
            z-index: 99;
            opacity: 0.8;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            min-height: 100%;
            width: 100%;
        }
        .loading
        {
            display: none;
            position: fixed;
            opacity: 0.8;
            filter: alpha(opacity=80);
            -moz-opacity: 0.8;
            z-index: 999;
        }       

        /*body { margin: 0; }*/

        body { 
          max-height: 100%;
          padding-top: 3px;
        }

        .sticky { background: white; }

        .fixed {
          position: fixed;
          top:0; left:0;
          width: 100%; }

    </style>



</head>
<script language="javascript" type="text/javascript">

    function filterOpen(rnd) {
        var dialogFilterReturn = window.showModalDialog('/barsroot/finmon/docfilter.aspx?rnd=' + rnd, window, 'center:{yes};dialogheight:650px;dialogwidth:500px');;
        if ("ok" == dialogFilterReturn.close) {
            ShowProgress();
            <%= ClientScript.GetPostBackEventReference(this, "PostBack") %>;
        }
        else {
            window.location.reload();
        }
    }

    function statusOpen() {
        var dialogStatusReturn = window.showModalDialog('/barsroot/finmon/docstatus.aspx?', window, 'center:{yes};dialogheight:200px;dialogwidth:600px');;
        if ("ok" == dialogStatusReturn.close) {
            ShowProgress();
            <%= ClientScript.GetPostBackEventReference(this, "PostBack") %>;
        }
        else {
            window.location.reload();
        }
    }

    function paramsOpen(ref, id, rnd) {

        var dialogParamsReturn = window.showModalDialog('/barsroot/finmon/docparams.aspx?ref=' + ref + '&id=' + id + '&rnd=' + rnd, window, 'center:{yes};dialogheight:700px;dialogwidth:650px;status:yes');
        if ("ok" == dialogParamsReturn.close) {
            ShowProgress();
            <%= ClientScript.GetPostBackEventReference(this, "PostBack") %>;
        }
        else {
            window.location.reload();
        }
    };

    function RefreshData() {
        ShowProgress();
        <%= ClientScript.GetPostBackEventReference(this, "PostBack") %>;
    }

    function paramsBulkOpen(rnd) {

        var selectedRows = $(".barsGridView tbody tr").filter(function (index) { if ($(this).find('input').prop('checked') == true) return true; else return false; });
        var refs = [];
        for (var idx = 0; idx < selectedRows.length; idx++) {
            refs[idx] = selectedRows[idx].cells[2].innerText;
        }
                    
        var dialogParamsReturn = window.showModalDialog('/barsroot/finmon/docparams_bulk.aspx?&rnd=' + rnd, refs, 'center:{yes};dialogheight:700px;dialogwidth:650px;status:yes');
        if ("ok" == dialogParamsReturn.close) {
            ShowProgress();
            <%= ClientScript.GetPostBackEventReference(this, "PostBack") %>;
        }
        else {
            window.location.reload();
        }
    };

    function changeHistoryOpen(ref, id) {
        var dialogParamsReturn = window.showModalDialog('/barsroot/finmon/changeHistory.aspx?ref=' + ref + '&id=' + id, window, 'center:{yes};dialogheight:400px;dialogwidth:650px;status:yes');
    };
    function openFilters() {
        bars.ui.getFiltersByMetaTable(function (response, success) {
            if (!success) return;

            if (response.length > 0) {
                ShowProgress();
                var params = response.join(' and ');
                //PageMethods.GetMetaFilterParams(params);
                finmonFilterService.SetMetaFilterParams(params);  
            } else {
                finmonFilterService.SetMetaFilterParams("");
            }

            $.ajax({
                type: "POST",
                url: "/barsroot/finmon/doc.aspx/SetFilterApplyed",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    <%= ClientScript.GetPostBackEventReference(this, "PostBack") %>;
                }
            });
            
        }, { tableName: "V_FINMON_QUE_OPER" });

    };

    function RefTeroristsOpen(otm) {
        window.showModalDialog('/barsroot/finmon/ref_terorist.aspx?otm=' + otm, window, 'center:{yes};dialogheight:650px;dialogwidth:800px');;
    }

    function Confirm() {
        
        var confirm_value = document.createElement("INPUT");
        confirm_value.type = "hidden";
        confirm_value.name = "confirm_value";
        if (confirm("Ви дійсно хочете розблокувати документ?")) {
            confirm_value.value = "Yes";
            ShowProgress();
        } else {
            confirm_value.value = "No";
        }
        document.forms[0].appendChild(confirm_value);
    };

    function filterStatusOpen(rnd) {
        var dialogFilterReturn = window.showModalDialog('/barsroot/finmon/docstatusfilter.aspx?rnd=' + rnd, window, 'center:{yes};dialogheight:650px;dialogwidth:500px');;
        if ("ok" == dialogFilterReturn.close) {
            ShowProgress();
            <%= ClientScript.GetPostBackEventReference(this, "ModalDialogPostBack") %>;
        }
        else {
            window.location.reload();
        }
    };
    function CheckAllEmp(Checkbox) {
        if ($('#gvFmDocs_ctl01_selectAll').is(':checked')) {
            $(".barsGridView tbody tr").each(function (i) {
                $(this).find('input').prop('checked', true);
            });
        }
        else {
            $(".barsGridView tbody tr").each(function (i) {
                $(this).find('input').prop('checked', false);
            });
        }
    };
    function openDoc(Ref) {
        window.showModalDialog('/barsroot/documentview/default.aspx?ref=' + Ref, document, 'dialogwidth:800px;dialogheigh:650px');
    };


    function ruleOpen() {
        var dialogRuleReturn = window.showModalDialog('/barsroot/finmon/rules.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:500px');
        if ("ok" == dialogRuleReturn.close) {
            ShowProgress();
            <%= ClientScript.GetPostBackEventReference(this, "PostBack") %>;
        }
        else {
            window.location.reload();
        }
    }
    function procRules(e) {
        var rules = e.parentElement.outerText;
        if (rules == " " || rules == "") {
            alert("Ідентифікатори правил відсутні для данного запису");
            return false;
        }

        var dialogRuleReturn = window.showModalDialog('/barsroot/finmon/rules.aspx?rule_id=' + rules, window, 'center:{yes};dialogheight:650px;dialogwidth:500px');

    }

    function addСatalogRows() {
        addProcedure($("tr.normalRow"));
        addProcedure($("tr.alternateRow"));
    }
    function addProcedure(data) {
        for (var i = 0; i < data.length;i++) {
            data[i].childNodes[1].innerHTML += '<INPUT type="image" src="/barsroot/Content/images/PureFlat/16/book.png" onclick="procRules(this)" >';
        }
    }

    function delСatalogRows() {
        delProcedure($("tr.normalRow"));
        delProcedure($("tr.alternateRow"));
    }
    function delProcedure(data) {
        for (var i = 0; i < data.length; i++) {
            var line = data[i].childNodes[1].innerHTML;
            line = line.split("<INPUT")[0];
            data[i].childNodes[1].innerHTML = line;
        }
    }

    $(document).ready(function () {
        $("#btnExcelExport")[0].onmouseover = function () { delСatalogRows(); }
        $("#btnExcelExport")[0].onmouseleave = function () { addСatalogRows(); }

        var label = document.getElementById('lblOperCount');
        label.innerText = "Виконується операція відбору";
        label.style.color = 'Black';

        setTimeout(function () { addСatalogRows(); }, 2000);

        setTimeout(function () { 
            $.ajax({
                type: "POST",
                url: "/barsroot/finmon/doc.aspx/OperCount",
                //data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (result) {
                    var count = result["d"];
                    var label = document.getElementById('lblOperCount');
                    if (count === 100000) {
                        label.innerText = "Увага! Стоїть обмеження на відображення даних (до 100 тис. записів). Для пошуку використовуйте додаткові фільтри";
                        label.style.color = 'Red';
                    }
                    else {
                        var FinmonFilterApplyed = "<%= FinmonFilterApplyed %>";
                        label.innerHTML = FinmonFilterApplyed == "1" ? "Всього відібрано документів: <span style=\"color: red;\">" + count + "</span>. Для відображення списку документів натисніть кнопку \"Перечитати дані\"" : "Всього документів: <span style=\"color: red\">" + count + "</span>";
                        <% FinmonFilterApplyed = "";%>
                        label.style.color = 'Black';
                    }
                }
            });
        }, 2500);
    });
   
    ///Після виконання Response.End() для кнопок повертаєм доступність. Кращого швидкого рішення не придумав. 
    function setFormSubmitToFalse() {
        setTimeout(function () { $(':button').prop('disabled', false); }, 3000);
        return true;
    }

    function ShowProgress() {
        var modal = $('<div />');
        modal.addClass("modal");
        $('body').append(modal);
        var loading = $(".loading");
        loading.show();
        var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
        var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
        loading.css({ top: top, left: left });
    }

    function HideProgress() {
        var modal = $('<div />');
        modal.addClass("modal");
        $('body').append(modal);
        var loading = $(".loading");
        loading.hide();
    }

    $(window).scroll(function(){
      var sticky = $('.sticky'),
          scroll = $(window).scrollTop();

      if (scroll >= 3) sticky.addClass('fixed');
      else sticky.removeClass('fixed');
    });


</script>
<body bgcolor="#f0f0f0">
    <form id="formFMdocs" runat="server" style="vertical-align: central">
        <div class="sticky">
            <asp:Panel ID="pnButtons" runat="server" GroupingText="">
                <div>
                    <asp:Label ID="Title" runat="server" Text="" Font-Size="Large" BackColor="White"></asp:Label>
                </div>
                <div>
                    <table>
                        <tr>
                            <td style="width:70%">
                                <cc1:ImageTextButton ID="ibtRefreshData" runat="server" ToolTip="Перечитати дані" Text="" ImageUrl="/common/images/default/16/refresh.png" ButtonStyle="Image" OnClick="ibtRefreshData_Click" Width="50px" />
                                <cc1:ImageTextButton ID="ibtRulesFilter" runat="server" ToolTip="Фільтр по правилам ФМ" Text="" ImageUrl="/common/images/default/16/filter.png" ButtonStyle="Image" Width="50px" OnClick="ibtRulesFilter_Click" />
                                <cc1:ImageTextButton ID="ibStatusFilter" runat="server" ToolTip="Фільтр по статусам" Text="" ImageUrl="/common/images/default/16/find.png" ButtonStyle="Image" Width="50px" OnClick="ibStatusFilter_Click" />
                                <cc1:ImageTextButton ID="ibtOpen" runat="server" ToolTip="Інформація по документу" Text="" ImageUrl="/common/images/default/16/open.png" ButtonStyle="Image" OnClick="btOpen_Click" Width="50px" />
                                <bars:Separator runat="server" />
                                <cc1:ImageTextButton ID="ibtSend" runat="server" ToolTip="Відправити" Text="" ImageUrl="/common/images/default/16/visa_back.png" ButtonStyle="Image" OnClick="btSend_Click" Width="50px" />
                                <cc1:ImageTextButton ID="ibtSetStatus" runat="server" ToolTip="Встановити статус документу ''Повідомлено''" Text="" ImageUrl="/common/images/default/16/options.png" ButtonStyle="Image" OnClick="btSetStatus_Click" Width="50px" />
                                <cc1:ImageTextButton ID="ibtExclude" runat="server" ToolTip="Вилучити" Text="" ImageUrl="/common/images/default/16/delete.png" ButtonStyle="Image" OnClick="btExclude_Click" Width="50px" />
                                <cc1:ImageTextButton ID="ibtSetAside" runat="server" ToolTip="Відкласти" Text="" ImageUrl="/common/images/default/16/arrow_down.png" ButtonStyle="Image" OnClick="btSetAside_Click" Width="50px" />
                                <cc1:Separator runat="server" />
                                <cc1:ImageTextButton ID="ibtUnblock" runat="server" ToolTip="Розблокувати" ImageUrl="/common/images/default/16/lock_delete.png" ButtonStyle="Image" OnClick="btUnblock_Click" Width="50px" />
                                <cc1:ImageTextButton ID="ibtSetParams" runat="server" ToolTip="Параметри фінансового моніторингу" Text="" ImageUrl="/common/images/default/16/folder_gear.png" ButtonStyle="Image" OnClick="btSetParams_Click" Width="50px" />
                                <cc1:ImageTextButton ID="ibtRefTerorists" runat="server" ToolTip="Перегляд даних з переліку осіб, підозрюваних у тероризмі" Text="" ImageUrl="/common/images/default/16/form_green.png" ButtonStyle="Image" OnClick="tbRefTerorists_Click" Width="50px" />
                                <cc1:ImageTextButton ID="ibtGetFilters" runat="server" ToolTip="Фільтр" Text="" ImageUrl="/barsroot/Content/images/PureFlat/16/filter-ok.png" ButtonStyle="Image" OnClick="ibtGetFilters_Click" Width="50px" />
                                <cc1:ImageTextButton ID="ibtExportAllPages" runat="server" ToolTip="Імпортувати всі сторінки" Text="" ImageUrl="/barsroot/Content/images/PureFlat/16/exel.png" ButtonStyle="Image" Width="50px" OnClick="ibtExportAllPages_Click" OnClientClick="javascript: setFormSubmitToFalse()"/>
                                <cc1:ImageTextButton ID="ibtClearFilterParams" runat="server" ToolTip="Скасувати всі фільтри" Text="" ImageUrl="/barsroot/Content/images/PureFlat/16/filter-remove.png" ButtonStyle="Image" Width="50px" OnClick="ibtClearFilterParams_Click" />
                                <cc1:Separator runat="server" />
                                <cc1:ImageTextButton ID="ibChangeHistory" runat="server" ToolTip="Історія змін" Text="" ImageUrl="/barsroot/Content/images/PureFlat/16/book.png" ButtonStyle="Image" OnClick="ibChangeHistory_Click" Width="50px" />
                                <cc1:ImageTextButton ID="ibtBulkSetParams" runat="server" ToolTip="Пакетне встановлення параметрів" Text="" ImageUrl="/common/images/default/16/folder_gear.png" ButtonStyle="Image" OnClick="btBulkSetParams_Click" Width="50px" />
                                <cc1:Separator runat="server" />
                            </td>
                            <td>
                                <table id="tblDat" runat="server" style="margin-left: 10px; margin-right: 10px">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbDat" runat="server" Text=" "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbStatus" runat="server" Text=" "></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br />
                                <asp:Label ID="lblOperCount" 
                                    runat="server"/>
                            </td>
                        </tr>
                    </table>
                    <br />
                </div>       
            </asp:Panel>
        </div>

        <div>
        <BarsEX:BarsSqlDataSourceEx ID="odsFmDocs" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>
        <BarsEX:BarsGridViewEx ID="gvFmDocs" runat="server" PagerSettings-PageButtonCount="10"
            PageSize="20" AllowPaging="True" AllowSorting="True"
            DataSourceID="odsFmDocs" CssClass="barsGridView" DataKeyNames="REF,STATUS,ID,OTM,STATUS_NAME" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow"
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png"
                               OnPreRender="gvFmDocs_OnPreRender"
                               OnPageIndexChanged="gvFmDocs_OnPageIndexChanged">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                    <HeaderTemplate>
                        <asp:CheckBox ID="selectAll" runat="server" onclick="CheckAllEmp(this)" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="cb" ToolTip='<%# Eval("ID") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="RULES" HeaderText="Правила" ItemStyle-HorizontalAlign="Right" SortExpression="RULES"></asp:BoundField>
                <asp:BoundField DataField="REF" HeaderText="Реф." ItemStyle-HorizontalAlign="Right" SortExpression="REF" ></asp:BoundField>
                <asp:BoundField DataField="STATUS" HeaderText="Код статуса" Visible="false" ItemStyle-HorizontalAlign="Right" SortExpression="STATUS"></asp:BoundField>
                <asp:BoundField DataField="STATUS_NAME" HeaderText="Статус" ItemStyle-HorizontalAlign="Right" SortExpression="STATUS_NAME"></asp:BoundField>
                <asp:BoundField DataField="TT" HeaderText="Оп." ItemStyle-HorizontalAlign="Right" SortExpression="TT"></asp:BoundField>
                <asp:BoundField DataField="ND" HeaderText="Номер док." ItemStyle-HorizontalAlign="Left" SortExpression="ND"></asp:BoundField>
                <asp:BoundField DataField="DATD" HeaderText="Дата док." ItemStyle-HorizontalAlign="Center" SortExpression="DATD"></asp:BoundField>
                
                <%--<asp:BoundField DataField="" HeaderText="Дата проведення" ItemStyle-HorizontalAlign="Center" SortExpression=""></asp:BoundField>--%>

                <asp:BoundField DataField="NLSA" HeaderText="Рахунок-А" ItemStyle-HorizontalAlign="Left" SortExpression="NLSA" DataFormatString="{0:0}"></asp:BoundField>
                <asp:BoundField DataField="MFOA" HeaderText="МФО-А" ItemStyle-HorizontalAlign="Right" SortExpression="MFOA"></asp:BoundField>
                <asp:BoundField DataField="NLSB" HeaderText="Рахунок-Б" ItemStyle-HorizontalAlign="Left" SortExpression="NLSB"></asp:BoundField>
                <asp:BoundField DataField="MFOB" HeaderText="МФО-Б" ItemStyle-HorizontalAlign="Right" SortExpression="MFOB"></asp:BoundField>
                <asp:BoundField DataField="S" HeaderText="Сума" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ##0.00}" SortExpression="S"></asp:BoundField>
                <asp:BoundField DataField="SQ" HeaderText="Сума док. (екв)" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ##0.00}" SortExpression="SQ"></asp:BoundField>
                <asp:BoundField DataField="LCV" HeaderText="Вал-А" ItemStyle-HorizontalAlign="Center" SortExpression="LCV"></asp:BoundField>
                <asp:BoundField DataField="OPR_VID2" HeaderText="Ознака ОМ" ItemStyle-HorizontalAlign="Right" SortExpression="OPR_VID2"></asp:BoundField>
                <asp:BoundField DataField="FV2_AGG" HeaderText="Додаткові коди ОМ" ItemStyle-HorizontalAlign="Right" SortExpression="FV2_AGG"></asp:BoundField>
                <asp:BoundField DataField="OPR_VID3" HeaderText="Ознака ВМ" ItemStyle-HorizontalAlign="Right" SortExpression="OPR_VID3"></asp:BoundField>
                <asp:BoundField DataField="SK" HeaderText="СКП" ItemStyle-HorizontalAlign="Right" SortExpression="SK"></asp:BoundField>
                <asp:BoundField DataField="NAZN" HeaderText="Призначення" ItemStyle-HorizontalAlign="Left" SortExpression="NAZN"></asp:BoundField>
                <asp:BoundField DataField="DK" HeaderText="Д/К" ItemStyle-HorizontalAlign="Center" SortExpression="DK"></asp:BoundField>
                <asp:BoundField DataField="S2" HeaderText="Сума-Б" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ##0.00}" SortExpression="S2"></asp:BoundField>
                <asp:BoundField DataField="SQ2" HeaderText="Сума Б (екв)" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ##0.00}" SortExpression="SQ2"></asp:BoundField>
                <asp:BoundField DataField="LCV2" HeaderText="Вал-Б" ItemStyle-HorizontalAlign="Center" SortExpression="LCV2"></asp:BoundField>
                <asp:BoundField DataField="VDAT" HeaderText="Дата валют." ItemStyle-HorizontalAlign="Center" SortExpression="VDAT"></asp:BoundField>
                <asp:BoundField DataField="TOBO" HeaderText="Відділення" ItemStyle-HorizontalAlign="Left" SortExpression="TOBO"></asp:BoundField>
                <asp:BoundField DataField="FIO" HeaderText="Повідомив" ItemStyle-HorizontalAlign="Left" SortExpression="FIO"></asp:BoundField>
                <asp:BoundField DataField="IN_DATE" HeaderText="Дата реєстрації" ItemStyle-HorizontalAlign="Center" SortExpression="IN_DATE"></asp:BoundField>
                <asp:BoundField DataField="COMMENTS" HeaderText="Коментар" ItemStyle-HorizontalAlign="Left" SortExpression="COMMENTS"></asp:BoundField>
                <asp:BoundField DataField="OTM" HeaderText="№ особи в переліку осіб" Visible="true" ItemStyle-HorizontalAlign="Right" SortExpression="OTM"></asp:BoundField>
                <asp:BoundField DataField="NMKA" HeaderText="Клієнт А " Visible="true" ItemStyle-HorizontalAlign="Left" SortExpression="NMKA"></asp:BoundField>
                <asp:BoundField DataField="NMKB" HeaderText="Клієнт Б" Visible="true" ItemStyle-HorizontalAlign="Left" SortExpression="NMKB"></asp:BoundField>
            </Columns>
            <FooterStyle CssClass="footerRow" />
            <HeaderStyle CssClass="headerRow" />
            <EditRowStyle CssClass="editRow" />
            <PagerStyle CssClass="pagerRow" />
            <SelectedRowStyle CssClass="selectedRow" />
            <AlternatingRowStyle CssClass="alternateRow" />
            <PagerSettings Mode="Numeric"></PagerSettings>
            <RowStyle CssClass="normalRow" />
            <NewRowStyle CssClass="newRow" />
        </BarsEX:BarsGridViewEx>

        </div>

        <asp:ScriptManager ID="sm" runat="server" EnablePageMethods="true" EnableScriptGlobalization="false" EnableScriptLocalization="True">
            <Services>
                <asp:ServiceReference Path="~/finmon/finmonFilterService.asmx" />
            </Services>
        </asp:ScriptManager>

        <div class="loading" align="center">
            <img src="/common/Images/loader_blue.gif" alt="Завантаження..." />
        </div>

    </form>
</body>
</html>
