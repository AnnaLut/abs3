<%@ Page Language="C#" AutoEventWireup="true" CodeFile="doc.aspx.cs" Inherits="finmon_doc" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Документи для Фінансового Моніторингу</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
</head>
<script language="javascript" type="text/javascript">


    function filterOpen(rnd) {
        var dialogFilterReturn = window.showModalDialog('/barsroot/finmon/docfilter.aspx?rnd=' + rnd, window, 'center:{yes};dialogheight:650px;dialogwidth:500px');;
        if ("ok" == dialogFilterReturn.close) {
            <%= GetPostBackEventReference(this, "PostBack") %>;
        }
        else {
            window.location.reload();
        }
    }

    function statusOpen(ref) {
        var dialogStatusReturn = window.showModalDialog('/barsroot/finmon/docstatus.aspx?ref=' + ref, window, 'center:{yes};dialogheight:200px;dialogwidth:600px');;
        if ("ok" == dialogStatusReturn.close) {
            <%= GetPostBackEventReference(this, "PostBack") %>;
        }
        else {
            window.location.reload();
        }
    }



    function paramsOpen(ref, id, rnd) {

        var dialogParamsReturn = window.showModalDialog('/barsroot/finmon/docparams.aspx?ref=' + ref + '&id=' + id + '&rnd=' + rnd, window, 'center:{yes};dialogheight:600px;dialogwidth:650px;status:yes');;
        if ("ok" == dialogParamsReturn.close) {
            <%= GetPostBackEventReference(this, "PostBack") %>;
        }
        else {
            window.location.reload();
        }
    }

    function RefTeroristsOpen(otm) {
        window.showModalDialog('/barsroot/finmon/ref_terorist.aspx?otm=' + otm, window, 'center:{yes};dialogheight:650px;dialogwidth:800px');;
    }

    function Confirm() {
        var confirm_value = document.createElement("INPUT");
        confirm_value.type = "hidden";
        confirm_value.name = "confirm_value";
        if (confirm("Ви дійсно хочете розблокувати документ?")) {
            confirm_value.value = "Yes";
        } else {
            confirm_value.value = "No";
        }
        document.forms[0].appendChild(confirm_value);
    }

    function filterStatusOpen(rnd) {
        var dialogFilterReturn = window.showModalDialog('/barsroot/finmon/docstatusfilter.aspx?rnd=' + rnd, window, 'center:{yes};dialogheight:650px;dialogwidth:500px');;
        if ("ok" == dialogFilterReturn.close) {
            <%= GetPostBackEventReference(this, "ModalDialogPostBack") %>;
        }
        else {
            window.location.reload();
        }
    }

</script>
<body bgcolor="#f0f0f0">
    <form id="formFMdocs" runat="server" style="vertical-align: central">
        <asp:Panel ID="pnButtons" runat="server" GroupingText="Доступні дії:" Style="margin-left: 10px; margin-right: 10px">
            <cc1:ImageTextButton ID="ibtRulesFilter" runat="server" ToolTip="Фільтр по правилам ФМ" Text="" ImageUrl="/common/images/default/16/filter.png" ButtonStyle="Image" Width="50px" OnClick="ibtRulesFilter_Click" />
            <cc1:ImageTextButton ID="ibStatusFilter" runat="server" ToolTip="Фільтр по статусам" Text="" ImageUrl="/common/images/default/16/find.png" ButtonStyle="Image" Width="50px" OnClick="ibStatusFilter_Click" />
            <cc1:ImageTextButton ID="ibtOpen" runat="server" ToolTip="Інформація по документу" Text="" ImageUrl="/common/images/default/16/open.png" ButtonStyle="Image" OnClick="btOpen_Click" Width="50px" />
            <cc1:ImageTextButton ID="ibtSetStatus" runat="server" ToolTip="Встановити статус документу ''Повідомлено''" Text="" ImageUrl="/common/images/default/16/options.png" ButtonStyle="Image" OnClick="btSetStatus_Click" Width="50px" />
            <cc1:ImageTextButton ID="ibtSetParams" runat="server" ToolTip="Параметри фінансового моніторингу" Text="" ImageUrl="/common/images/default/16/row_preferences.png" ButtonStyle="Image" OnClick="btSetParams_Click" Width="50px" />
            <cc1:ImageTextButton ID="ibtRefTerorists" runat="server" ToolTip="Перегляд даних з переліку осіб, підозрюваних у тероризмі" Text="" ImageUrl="/common/images/default/16/businessman_preferences.png" ButtonStyle="Image" OnClick="tbRefTerorists_Click" Width="50px" />
        </asp:Panel>
        <br />
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

        <BarsEX:BarsSqlDataSourceEx ID="odsFmDocs" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>

        <BarsEX:BarsGridViewEx ID="gvFmDocs" runat="server" PagerSettings-PageButtonCount="10"
            PageSize="20" AllowPaging="True" AllowSorting="True"
            DataSourceID="odsFmDocs" CssClass="barsGridView" DataKeyNames="REF,STATUS,ID,OTM" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound" AutoGenerateCheckBoxColumn="true"
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow"
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="RULES" HeaderText="Правила" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="REF" HeaderText="Реф." ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="STATUS" HeaderText="Код статуса" Visible="false" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="STATUS_NAME" HeaderText="Статус" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="TT" HeaderText="Оп." ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="ND" HeaderText="Номер док." ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="DATD" HeaderText="Дата док." ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="NLSA" HeaderText="Рахунок-А" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="S" HeaderText="Сума" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="LCV" HeaderText="Вал-А" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="MFOA" HeaderText="МФО-А" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="DK" HeaderText="Д/К" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="NLSB" HeaderText="Рахунок-Б" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="S2" HeaderText="Сума-Б" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="LCV2" HeaderText="Вал-Б" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="MFOB" HeaderText="МФО-Б" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="VDAT" HeaderText="Дата валют." ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="NAZN" HeaderText="Призначення" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="TOBO" HeaderText="Відділення" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="OPR_VID2" HeaderText="Ознака обов`язк. моніторінгу" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="OPR_VID3" HeaderText="Ознака внутр. моніторінгу" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="FIO" HeaderText="Повідомив" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="IN_DATE" HeaderText="Дата реєстрації" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="COMMENTS" HeaderText="Коментар" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="OTM" HeaderText="№ особи в переліку осіб" Visible="true" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="NMKA" HeaderText="Клієнт А " Visible="true" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="NMKB" HeaderText="Клієнт Б" Visible="true" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
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
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="false" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
