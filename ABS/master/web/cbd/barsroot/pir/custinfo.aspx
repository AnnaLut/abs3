<%@ Page Language="C#" AutoEventWireup="true" CodeFile="custinfo.aspx.cs" Inherits="pir_custinfo" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript">
        function alertSearchTypes() {
            alert("Не заповнені обовязкові поля.\r\nВаріанти пошуку:\r\n1. По РНК \r\n2. По ІНН\r\n3. По виду документу, його серії та номеру\r\n4. По ПІБ та даті народження");
            return false;
        }
    </script>
</head>
<body bgcolor="#f0f0f0">
    <form id="formfindCust" runat="server" style="vertical-align: central">

        <asp:Panel ID="pnFilter" runat="server" GroupingText="" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <%--   <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
                <telerik:RadInputManager ID="RadInputManager1" runat="server">
                    <telerik:NumericTextBoxSetting BehaviorID="NumericBehavior2" Type="Number">
                        <TargetControls>
                            <telerik:TargetInput ControlID="TextBox5"></telerik:TargetInput>
                        </TargetControls>
                    </telerik:NumericTextBoxSetting>
                </telerik:RadInputManager>
                <tr>
                    <td style="width: 100px;">
                        <label for="TextBox5">Number:</label>
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                    </td>
                </tr>--%>
                <tr>
                    <td>
                        <asp:Label ID="lbCustRnk" runat="server" Text="РНК"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbCustRnk" runat="server" MaxLength="38" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator="" MinValue="0"></Bars2:BarsNumericTextBox>
                    </td>
                    <td>
                        <asp:Label ID="lbCustDocType" runat="server" Text="Вид документу"></asp:Label>
                    </td>
                    <td>
                        <BarsEX:BarsSqlDataSourceEx ID="odsPassp" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>
                        <asp:DropDownList ID="ddlCustDocType" runat="server" Width="250px" DataTextField="NAME" DataValueField="PASSP"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbCustCode" runat="server" Text="ІНН"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbCustCode" runat="server" MaxLength="14"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <asp:Label ID="lbCustDocSerial" runat="server" Text="Серія документу"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbCustDocSerial" runat="server" MaxLength="2" Width="250px"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbCustBirthday" runat="server" Text="Дата народження"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsDateInput ID="diCustBirthday" runat="server" EnabledStyle-HorizontalAlign="Center"></Bars2:BarsDateInput>
                    </td>
                    <td>
                        <asp:Label ID="lbCustDocNumber" runat="server" Text="№ документу"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbCustDocNumber" runat="server" MaxLength="8" Width="250px"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbCustFio" runat="server" Text="ПІБ"></asp:Label>
                    </td>
                    <td colspan="2">
                        <Bars2:BarsTextBox ID="tbCustFio" runat="server" Width="97%"></Bars2:BarsTextBox>
                    </td>

                    <td align="right">
                        <bars:ImageTextButton ID="btFindLocalRNK" runat="server" ImageUrl="/common/images/default/16/find.png" Text="Пошук" OnClick="btFindLocalRNK_Click" Width="100%" Visible="true" ToolTip="Варіанти пошуку:                                                               1. По РНК;                                                                             2. По ІНН;                                                                             3. По виду документу, його серії та номеру;                4. По ПІБ та даті народження" />
                        <bars:ImageTextButton ID="btFind" runat="server" ImageUrl="/common/images/default/16/find.png" Text="Пошук" OnClick="btFind_Click" Width="100%" Visible="false" ToolTip="Варіанти пошуку:                                                               1. По РНК;                                                                             2. По ІНН;                                                                             3. По виду документу, його серії та номеру;                4. По ПІБ та даті народження" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <input id="inLocalRnk" runat="server" type="hidden" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnButtons" runat="server" GroupingText="Доступні дії:" Style="margin-left: 10px; margin-right: 10px">
            <bars:ImageTextButton ID="btGoToSearchInCrimea" runat="server" ImageUrl="/common/images/default/16/gear_preferences.png" Text="Далі" ToolTip="Перейти до пошуку клієнта в Кримському РУ" OnClick="btGoToSearchInCrimea_Click" />
            <bars:ImageTextButton ID="btNext" runat="server" ImageUrl="/common/images/default/16/gear_preferences.png" Text="Далі" ToolTip="Виконати пошук продуктів по вибраному клієнту" OnClick="btNext_Click" />
        </asp:Panel>
        <br />
        <BarsEX:BarsSqlDataSourceEx ID="odsFmDocs" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>
        <div id="dvGridTitle" runat="server">
            <asp:Label ID="lbGvTitle" runat="server" Text="Клієнти" Font-Size="Medium" Style="margin-left: 10px; margin-right: 10px"></asp:Label>
        </div>
        <BarsEX:BarsGridViewEx ID="gv" runat="server" PagerSettings-PageButtonCount="10"
            PageSize="20" AllowPaging="True" AllowSorting="True"
            CssClass="barsGridView" DateMask="dd/MM/yyyy" DataKeyNames="RNK,OKPO,NMK,PASSP,BDAY"
            JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow"
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="RNK" HeaderText="РНК" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="NMK" HeaderText="ПІБ" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="OKPO" HeaderText="ІНН" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="PASSP" HeaderText="Документ" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="BDAY" HeaderText="Дата народження" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="ADR" HeaderText="Адреса" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
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
    </form>
</body>
</html>
