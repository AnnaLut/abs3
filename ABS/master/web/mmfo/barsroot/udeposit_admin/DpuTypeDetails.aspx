<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DpuTypeDetails.aspx.cs" Inherits="DpuTypeDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Параметри типу депозиту</title>

    <link href="/barsroot/Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
    
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/kendo/kendo.all.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.config.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.ui.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.extension.js"></script>

    <script type="text/javascript" src="/barsroot/udeposit_admin/dputypedetails.js"></script>
</head>
<body>
    <form id="frmDpuTypeDeails" runat="server">
    <div>
        <div style="text-align:center" class="row header">
            <asp:Label ID="lbTypeTitle" runat="server" Text="Прараметри типу депозиту" CssClass="InfoHeader" />
        </div>
        <div id="tabstrip">
            <ul>
                <li class="k-state-active">
                    Основні
                </li>
                <li>
                    Параметри ОБ22
                </li>
                <li id="tabRates">
                    Шкала ставок
                </li>
            </ul>
            <div>
                <asp:panel ID="pnlDescr" runat="server" GroupingText="Опис">
                    <table class="InnerTable" width="100%" cellpadding="3">
                        <tr>
                            <td align="right"  style="width:30%">
                                <asp:Label ID="lbTypeId" runat="server" Text="Числовий код типу: " CssClass="InfoLabel" />
                            </td>
                            <td align="left" style="width:10%">
                                <asp:TextBox ID="tbTypeId" TabIndex="1" runat="server" ClientIDMode="Static"
                                    style="text-align: center" CssClass="InfoText" Width="98%" />
                            </td>
                            <td style="width:60%"></td>
                        </tr>
                        <tr>
                            <td align="right"  style="width:30%">
                                <asp:Label ID="lbTypeName" runat="server" Text="Назва типу: " CssClass="InfoLabel" />
                            </td>
                            <td align="left" style="width:70%" colspan="2">
                                <asp:TextBox ID="tbTypeName" TabIndex="2"  MaxLength="100" runat="server" ClientIDMode="Static"
                                    style="text-align: left" CssClass="InfoText" Width="98%" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"  style="width:30%">
                                <asp:Label ID="lbTypeCode" runat="server" Text="Символьний код типу: " CssClass="InfoLabel" />
                            </td>
                            <td align="left" style="width:10%">
                                <asp:TextBox ID="tbTypeCode" TabIndex="3" MaxLength="4" runat="server" ClientIDMode="Static"
                                    style="text-align: left" CssClass="InfoText" Width="98%" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"  style="width:30%">
                                <asp:Label ID="lbTypeOrder" runat="server" Text="Номер для сортування: " CssClass="InfoLabel" />
                            </td>
                            <td align="left" style="width:10%">
                                <asp:TextBox ID="tbTypeOrder" TabIndex="4"  MaxLength="4" runat="server" ClientIDMode="Static"
                                    style="text-align: center" CssClass="InfoText" Width="98%" />
                            </td>
                            <td style="width:60%"></td>
                        </tr>
                        <tr>
                            <td align="right" style="width:30%">
                            </td>
                            <td colspan="2">
                                <asp:CheckBox ID="cbActive" TabIndex="5" ClientIDMode="Static"
                                    runat="server" Text="&nbsp; Ознака активності" CssClass="BaseCheckBox">
                                </asp:CheckBox>
                            </td>
                        </tr>
                    </table>
                </asp:panel>
                <asp:Panel ID="pnlTemplate" runat="server" GroupingText="Шаблон договору">
                    <table class="InnerTable" width="100%" cellpadding="3">
                        <tr>
                            <td align="right" style="width:30%">
                                <asp:TextBox ID="tbTemplateId" TabIndex="6" Width="98%" ClientIDMode="Static" CssClass="InfoText" runat="server"
                                    style="text-align: center" ToolTip="Ідентифікатор шаблону для друку генерального договору деп.лінії" />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTemplates" TabIndex="7" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="TEMPLATE_NAME" DataValueField="TEMPLATE_ID" Width="99%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
            <div>
                <div>
                    <asp:Label ID="lbOB22" runat="server" Text="Параметри ОБ22 дкпозитного продукту" CssClass="InfoLabel" />
                    <div id="gridOB22">
                    </div>
                </div>
            </div>
            <div>
                <div>
                    <asp:Label ID="lbRates" runat="server" Text="Шкала відсоткових ставок депозитного продукту" CssClass="InfoLabel" />
                    <div id="gridRates">
                    </div>
                </div>
            </div>
        </div>
        <table class="InnerTable" cellpadding="0" style="width:100%; bottom: 0px;">
            <tr>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td align="right" style="width:45%">
                    <asp:Button ID="btnSubmit" runat="server" Text="Зберегти"  CssClass="AcceptButton"
                        Width="200px" Height="30px" ForeColor="Brown" Font-Bold="true" ClientIDMode="Static"
                        TabIndex="8" OnClientClick="return validateControls();"
                        OnClick="btnSubmit_Click" />
                </td>
                <td align="center" style="width:10%"></td>
                <td align="left" style="width:45%">
                    <asp:Button ID="btnExit" runat="server" Text="Вийти" CssClass="AcceptButton"
                        Width="200px" Height="30px" ForeColor="Red" Font-Bold="true" ClientIDMode="Static"
                        TabIndex="9" OnClientClick="closeWindow(); return false;" />
                </td>
            </tr>
            <tr>
                <td colspan="3"></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
