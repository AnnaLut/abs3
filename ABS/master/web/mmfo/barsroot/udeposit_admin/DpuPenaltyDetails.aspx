<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DpuPenaltyDetails.aspx.cs" Inherits="PenaltyDetails"  %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bdc" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="bwc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

<%--    <link href="/barsroot/Content/Themes/Kendo/app.css" rel="stylesheet" />--%>
    <link href="/barsroot/Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
<%--    <link href="/barsroot/Content/Themes/Kendo/Styles.css" rel="stylesheet" />
    --%>

    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/kendo/kendo.all.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.config.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.ui.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.extension.js"></script>

    <style>
        .btn-destroy {
            color: red;
        }
        .btn-edit {
            color: darkblue;
        }
    </style>

    <script type="text/javascript" src="/barsroot/udeposit_admin/dpupenaltydetails.js?v1.1.3"></script>

</head>
<body>
    <form id="frmPenaltyDetails" ClientIDMode="Static" runat="server">
    <div style="width:100%; max-width:1200px; height:100%; max-height:600px">
        <table class="InnerTable" width="100%" cellpadding="3" id="tbl1" >
            <tr>
                <td colspan="4" align="center">
                    <asp:Label ID="lbPenaltyTitle" runat="server" Text="Параметри штрафу" CssClass="InfoLabel" />
                </td>
            </tr>
            <tr>
                <td align="right"  style="width:40%">
                    <asp:Label ID="lbPenaltyName" runat="server" Text="Назва штрафу: " CssClass="InfoLabel" />
                </td>
                <td style="width:5px; color:red;">*</td>
                <td colspan="2">
                    <asp:TextBox ID="tbPenaltyName" TabIndex="0" runat="server" ClientIDMode="Static"
                        style="text-align: left" MaxLength="50" CssClass="InfoText" Width="99%" />
                </td>
            </tr>
            <tr>
                <td align="right"  style="width:40%">
                    <asp:Label ID="lbBalType" runat="server" Text="Тип обчислення залишку: " CssClass="InfoLabel" />
                </td>
                <td style="width:5px; color:red;">*</td>
                <td align="center" style="width:10%">
                    <asp:TextBox ID="tbBalTypeId" TabIndex="1" runat="server" ClientIDMode="Static"
                        style="text-align: center;" CssClass="InfoText" Width="98%" />
                </td>
                <td align="left" style="width:50%" >
                    <asp:DropDownList ID="ddlBalTypes" TabIndex="2" runat="server" CssClass="BaseDropDownList"
                         ClientIDMode="Static"  Width="99%" >
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right"  style="width:40%">
                    <asp:Label ID="lbPeriod" runat="server" Text="Одиниці виміру періоду для штрафу: " CssClass="InfoLabel" />
                </td>
                <td style="width:5px; color:red;">*</td>
                <td align="center" style="width:10%">
                    <asp:TextBox ID="tbPeriodId" TabIndex="3" runat="server" ClientIDMode="Static"
                        style="text-align: center" CssClass="InfoText" Width="98%" />
                </td>
                <td align="left" style="width:50%" >
                    <asp:DropDownList ID="ddlPeriods" TabIndex="4" runat="server"  CssClass="BaseDropDownList"
                        ClientIDMode="Static" Width="99%" >
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <table class="InnerTable" width="100%" cellpadding="3" id="tbl2" runat="server" >
            <tr>
                <td align="right" style="width:40%"></td>
                <td style="width:5px;"></td>
                <td align="left" colspan="2" >
                    <asp:CheckBox ID="cbPenaltyType" TabIndex="5"
                         runat="server" Text="&nbsp; Тип штрафу залежить від терміну депозиту" CssClass="BaseCheckBox">
                    </asp:CheckBox>
                </td>
            </tr>
            <tr>
                <td align="right"  style="width:40%">
                    <asp:Label ID="lbPenaltyType" runat="server" Text="Тип штрафу: " CssClass="InfoLabel" />
                </td>
                <td style="width:5px; color:red;">*</td>
                <td align="center" style="width:10%">
                    <asp:TextBox ID="tbPenaltyTypeId" TabIndex="6" runat="server" ClientIDMode="Static"
                        style="text-align: center" CssClass="InfoText" Width="98%" />
                </td>
                <td align="left" style="width:50%" >
                    <asp:DropDownList ID="ddlPenaltyTypes" TabIndex="7" runat="server" CssClass="BaseDropDownList"
                        ClientIDMode="Static" Width="99%" >
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:40%"></td>
                <td style="width:5px;"></td>
                <td align="left" colspan="2" >
                    <asp:CheckBox ID="cbPenaltyPeriod" TabIndex="8" runat="server" 
                         Text="&nbsp; Штрафний період залежить від терміну депозиту" CssClass="BaseCheckBox">
                    </asp:CheckBox>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:40%">
                    <asp:Label ID="lbPenaltyPeriod" runat="server" Text="Штрафний період: " CssClass="InfoLabel" />
                </td>
                <td style="width:5px; color:red;">*</td>
                <td align="center" style="width:10%">
                    <asp:TextBox ID="tbPenaltyPeriodId" TabIndex="9" runat="server" ClientIDMode="Static"
                        style="text-align: center" CssClass="InfoText" Width="98%" />
                </td>
                <td align="left" style="width:50%" >
                    <asp:DropDownList ID="ddlPenaltyPeriods" TabIndex="10" runat="server" CssClass="BaseDropDownList"
                        ClientIDMode="Static" Width="99%" >
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <table class="InnerTable" width="100%" cellpadding="3" id="tbl3" >
            <tr>
                <td align="right" style="width:40%"></td>
                <td style="width:5px;"></td>
                <td align="left" colspan="2" >
                    <asp:CheckBox ID="cbCruelPenalty" TabIndex="5"
                         runat="server" Text="&nbsp; Якщо депозит не вилежав повний місяць - відсотки не виплачуються" CssClass="BaseCheckBox">
                    </asp:CheckBox>
                </td>
            </tr>
        </table>
        <div>
            <script id="popup-editor" type="text/x-kendo-template">
                <h3>Зміна умов штрафування</h3>
                <p>
                    <label>По:<input data-role="numerictextbox" data-bind="value:UpperLimit" /></label>
                </p>
                <p>
                    <label>Значення штрафу:<input data-role="numerictextbox" data-bind="value:PenaltyValue" /></label>
                </p>
                <p>
                    <label>Тип штрафу: <input required data-role="dropdownlist"
                        data-text-field="PeriodTypeName"
                        data-value-field="PeriodTypeId"
                        data-auto-bind="true"
                        data-bind="value:PenaltyType,
                            dataSource: [
                                { PenaltyTypeName: "Пустий штраф", PenaltyTypeId: 0 },
                                { PenaltyTypeName: "Жорсткий штраф (по історії зміни ставки)", PenaltyTypeId: 1 },
                                { PenaltyTypeName: "М`який штраф (по останній діючій ставці)", PenaltyTypeId: 2 },
                                { PenaltyTypeName: "Фиксований відсоток штрафу", PenaltyTypeId: 3 },
                                { PenaltyTypeName: "Фиксований тип %%-ної ставки", PenaltyTypeId: 5 }
                            ]"  /></label>
                </p>
                <p>
                 <input data-role="dropdownlist"
                    data-text-field="ProductName"
                    data-value-field="ProductID"
                    data-bind="value: selectedProduct,
                              source: products,
                              visible: isVisible,
                              enabled: isEnabled,
                              events: {
                                change: onChange,
                                open: onOpen,
                                close: onClose
                              }"
                    style="width: 100%;"/>
                </p>
                <p>
                    <label>Значення шрафного періоду:<input data-bind="value:PenaltyPeriodValue" /></label>
                </p>
            </script>
            <div id="grid">
            </div>
        </div>
        <table cellpadding="3" style="width:100%; max-width:600px;">
            <tr>
                <td align="center" style="width:50%">
                    <asp:Button ID="btnSave" runat="server" Text="Зберегти" TabIndex="25"  CssClass="AcceptButton"
                        Width="200px" Height="30px" ForeColor="Green" Font-Bold="true" ClientIDMode="Static"
                        CausesValidation="true" OnClientClick="return validateControls();" OnClick="btnSave_Click"  />
                </td>
                <td align="center" style="width:50%">
                    <asp:Button ID="btnExit" runat="server" Text="Вихід" TabIndex="26" CssClass="AcceptButton"
                        Width="200px" Height="30px" ForeColor="Black" Font-Bold="true"
                        CausesValidation="false" OnClientClick="closeWindow(); return false;" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input id="ReadOnlyMode" type="hidden" name="ReadOnlyMode" runat="server"/>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
