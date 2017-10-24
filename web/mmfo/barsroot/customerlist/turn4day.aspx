<%@ Page Language="C#" AutoEventWireup="true" CodeFile="turn4day.aspx.cs" Inherits="customerlist_turn4day" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title title="Обороти по рахунку"></title>
     <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>

    <script type="text/javascript">
        window.document.selected = {gvMainSos: [], gvMain: [] };

        window.document.findRow = function(a, i){
            var dataArr = window.document.selected[a];
            for(var j = 0; j < dataArr.length; j++){
                if(dataArr[j]["index"] == i){ return j; }
            }
            return -1;
        }

        window.document.updateSum = function(a){
            var sumDeb = 0;
            var sumKred = 0;
            var dbtSum = window.document.getElementById("dbtSum_"+a);
            var kdtSum = window.document.getElementById("kdtSum_"+a);
            var dataArr = window.document.selected[a];

            for(var j = 0; j < dataArr.length; j++){
                sumDeb += parseFloat(dataArr[j]["dbt"]);
                sumKred += parseFloat(dataArr[j]["kdt"]);
            }
            sumDeb = sumDeb.toFixed(2);
            sumKred = sumKred.toFixed(2);
            dbtSum.innerText = "Дебет : " + sumDeb;
            kdtSum.innerText = "Кредит: " + sumKred;
        }

        window.document.onSelectRowFunc = function(a, b, event){
            //event.preventDefault();
            
            var dataArr = window.document.selected[a];
            var grid = window.document.getElementById(a);
            for(var i = 0; i < grid.rows.length - 1; i++)
            {
                var rowSelectedIndex = window.document.findRow(a, i);
                if(rowSelectedIndex != -1){dataArr.splice(rowSelectedIndex, 1);}
                    
                var row = grid.rows[i];
                if (row.className == "selectedRow")
                {
                    var sumDeb = row.cells[2].innerText;
                    var sumKred = row.cells[3].innerText;
                    
                    dataArr.push({"index": i, "dbt": sumDeb, "kdt": sumKred});
                }
            }
            window.document.updateSum(a);            
        }
    </script>

</head>
<body>
    <form id="frm_turn4day" runat="server">
        <div>
            <asp:Panel runat="server" ID="pnDate" GroupingText="Період">
                <table>
                    <tr>
                        <td>
                            <bec:TextBoxDate runat="server" ID="tbDat1" />
                        </td>
                        <td>
                            <bec:TextBoxDate runat="server" ID="tbDat2" />
                        </td>
                        <td>
                            <asp:Button runat="server" ID="btSearh" Text="Застосувати" OnClick="btSearh_Click" />
                        </td>
                       <td>
                           <asp:Label runat="server" ID="lbNotPay" Text="Показати не завізовані"></asp:Label>
                       </td>
                        <td>
                            <asp:CheckBox runat="server" ID="cb" AutoPostBack="true" OnCheckedChanged="cb_CheckedChanged"/>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <hr />
            <table>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbInTurnName" Text="Вхідний залишок"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbInTurn"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbDosName" Text="Дебетовий оборот"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbDos"></asp:Label>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label runat="server" ID="lbKosName" Text="Кредитовий оборот"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbKos"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbOutTurnName" Text="Вихідний залишок"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbOutTurn"></asp:Label>
                    </td>
                </tr>
            </table>
            <hr />
            <br>
                Документи по рахунку
                <div>
                    <div id="dbtSum_gvMain" style="color:darkcyan;font-size:medium"></div>
                    <div id="kdtSum_gvMain" style="color:darkcyan;font-size:medium"></div>
                </div>
            <table>
                <tr>
                    <td>
                        <%-- JavascriptSelectionType="MultiSelect" was error with tis grid`s parameter & ref can not be seen on the selected row  --%>
                       <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="REF"
                            DataSourceID="dsMain" CssClass="barsGridView" ShowPageSizeBox="true" ShowFilter="False" ShowMetaFilter="False"
                            AutoGenerateColumns="False" DateMask="dd/MM/yyyy"  JavascriptSelectionType="MultiSelect"
                            pagersettings-pageindex="0"
                            PageSize="10">
                            <SelectedRowStyle CssClass="selectedRow" />
                            <Columns>
                                <asp:BoundField DataField="TT" HeaderText="Код операції" />
                                <asp:TemplateField HeaderText="Референс">
                                    <ItemTemplate>
                                        <a href='<%#String.Format("/barsroot/documentview/default.aspx?ref={0}",Eval("REF")) %>'>
                                            <%#String.Format("{0}",Eval("REF")) %>
                                        </a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DT" HeaderText="Сума Дт" />
                                <asp:BoundField DataField="KT" HeaderText="Сума Кт" />
                                <asp:BoundField DataField="NAZN" HeaderText="Призначення платежу" />
                                <asp:BoundField DataField="FDAT" HeaderText="Дата валютування" />
                            </Columns>
                        </BarsEx:BarsGridViewEx>
                    </td>
                </tr>
                </table>
            <hr />
            <br>
                Не завізовані документи
                <div>
                    <div id="dbtSum_gvMainSos" style="color:darkcyan;font-size:medium"></div>
                    <div id="kdtSum_gvMainSos" style="color:darkcyan;font-size:medium"></div>
                </div>
                <table>
                <tr>
                    <td>
                        <BarsEx:BarsSqlDataSourceEx ID="dsMainSos" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                        <BarsEx:BarsGridViewEx ID="gvMainSos" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="REF"
                            DataSourceID="dsMainSos" CssClass="barsGridView" ShowPageSizeBox="true" ShowFilter="false" ShowMetaFilter="false"
                            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" 
                            pagersettings-pageindex="0" ForeColor="#009933" JavascriptSelectionType="MultiSelect"
                            PageSize="10">
                            <SelectedRowStyle CssClass="selectedRow" />
                            <Columns>
                                <asp:BoundField DataField="TT" HeaderText="Код операції" />
                                <asp:TemplateField HeaderText="Референс">
                                    <ItemTemplate>
                                        <a href='<%#String.Format("/barsroot/documentview/default.aspx?ref={0}",Eval("REF")) %>'>
                                            <%#String.Format("{0}",Eval("REF")) %>
                                        </a>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DT" HeaderText="Сума Дт" />
                                <asp:BoundField DataField="KT" HeaderText="Сума Кт" />
                                <asp:BoundField DataField="NAZN" HeaderText="Призначення платежу" />
                                <asp:BoundField DataField="FDAT" HeaderText="Дата валютування" />
                            </Columns>
                        </BarsEx:BarsGridViewEx>
                    </td>
                </tr>
            </table>
        </div>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
