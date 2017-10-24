<%@ Page Language="C#" AutoEventWireup="true" CodeFile="coin_invoice.aspx.cs" Inherits="coin_invoice" Title="Функція Сховище. Оприбуткування памятних монет" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="BarsD" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="BarsRef" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Функція Сховище. Оприбуткування памятних монет</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
</head>

<script src="<%=ResolveUrl("~/Scripts/jquery/jquery.min.js")%>" type="text/javascript"></script>
<script src="<%=ResolveUrl("~/Scripts/jquery/jquery-ui.min.js")%>" type="text/javascript"></script>
<script src="<%=ResolveUrl("~/Scripts/jquery/jquery.bars.ui.js")%>" type="text/javascript"></script>
<script src="<%=ResolveUrl("/barsroot/credit/JScript/JScript.js?v1")%>" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    function OpenRefCoin() {

        var dialogReCoinReturn = window.showModalDialog('/barsroot/coin/ref_coin.aspx', window, 'center:{yes};dialogheight:700px;dialogwidth:800px');;

        if (dialogReCoinReturn.code != "-1") {
            document.getElementById('<%=tbCoinCode.ClientID%>').value = dialogReCoinReturn.code;
        }
    }

    function OpenDocument() {
        window.showModalDialog('/barsroot/documents/item/?id=' + document.getElementById('<%=lbRef.ClientID%>').innerText, null, 'dialogWidth:790px;dialogHeight:550px');
    }
</script>
<body bgcolor="#f0f0f0">
    <form id="frmCoinInvoice" runat="server" style="vertical-align: central">
        <div>
            <ajx:ToolkitScriptManager ID="sm" runat="server">
                <Scripts>
                    <asp:ScriptReference Path="/barsroot/credit/JScript/JScript.js?v1" />
                </Scripts>
            </ajx:ToolkitScriptManager>

        </div>
        <asp:Panel ID="pnInvoiceHead" runat="server" GroupingText="Накладна:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td colspan="6">
                        <asp:RadioButton ID="rbTypeOuter" runat="server" Text="Зовнішня (НБУ)" GroupName="invoiceType" ForeColor="#990033"></asp:RadioButton>
                        <asp:RadioButton ID="rbTypeInner" runat="server" Text="Внутрішня (ГОУ)" GroupName="invoiceType" ForeColor="#0033cc"></asp:RadioButton>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbInvoiceNumber" runat="server" Text="Накладна"></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsTextBox ID="tbInvoiceNumber" runat="server" MaxLength="30"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <asp:Label ID="lbReason" runat="server" Text="Підстава"></asp:Label>
                    </td>
                    <td style="text-align: right" colspan="3">
                        <Bars2:BarsTextBox ID="tbReason" runat="server" MaxLength="256" Width="485px"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbInvoiceDate" runat="server" Text="Від"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsDateInput ID="diInvoiceDate" runat="server" EnabledStyle-HorizontalAlign="Center"></Bars2:BarsDateInput>
                    </td>
                    <td>
                        <asp:Label ID="lbBailee" runat="server" Text="Через"></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsTextBox ID="tbBailee" runat="server" MaxLength="128" Width="200px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <asp:Label ID="lbProxy" runat="server" Text="Довіреність"></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsTextBox ID="tbProxy" runat="server" MaxLength="128" Width="200px"></Bars2:BarsTextBox>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbTotalCount" runat="server" Text="Усього: "></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsTextBox ID="tbTotalCount" runat="server" Width="50px" Enabled="false" Text="0" EnabledStyle-HorizontalAlign="Right" ToolTip="Кількість"></Bars2:BarsTextBox>
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsNumericTextBox NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" ID="tbTotalNomonal" runat="server" Width="100px" Enabled="false" Text="0.00" ToolTip="Сума за номіналом" />
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsNumericTextBox NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" Value="0.00" ID="tbTotalSum" runat="server" Width="100px" Enabled="false" Text="0.00" ToolTip="Сума без ПДВ та НОМ" />
                    </td>
                    <td style="text-align: right" rowspan="5">
                        <textarea id="ta" rows="7" cols="55" disabled="disabled" readonly="readonly" runat="server" style="resize: none"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy" runat="server" Text=" "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbIn" runat="server" Text="у т.ч: "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbTotalWithoutVat" runat="server" Text="Разом без ПДВ"></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsNumericTextBox NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator=" " ID="tbTotalWithoutVat" EnabledStyle-HorizontalAlign="Right" runat="server" Width="100px" Enabled="false" Text="0.00" ToolTip="Разом без ПДВ" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lbDummy2" runat="server" Text=" "></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbVatPercent" runat="server" Text="%ПДВ"></asp:Label>
                        <Bars2:BarsTextBox ID="tbVatPercent" runat="server" Width="60px" Enabled="false" Text="0" EnabledStyle-HorizontalAlign="Right" ToolTip="ПДВ"></Bars2:BarsTextBox>
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsNumericTextBox NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator=" " ID="tbVatSum" runat="server" Width="100px" Enabled="false" Text="0.00" EnabledStyle-HorizontalAlign="Right" ToolTip="у тч ПДВ" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: right">
                        <asp:Label ID="lbTotalNominalPrice" runat="server" Text="Номінальна вартість "></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsNumericTextBox NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator=" " ID="tbTotalNominalPrice" runat="server" Width="100px" Enabled="false" Text="0.00" EnabledStyle-HorizontalAlign="Right" ToolTip="Номінальна вартість" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: right">
                        <asp:Label ID="lbTotalWithVat" runat="server" Text="Усього з ПДВ до сплати"></asp:Label>
                    </td>
                    <td style="text-align: right">
                        <Bars2:BarsNumericTextBox NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator=" " ID="tbTotalWithVat" runat="server" Width="100px" Enabled="false" Text="0.00" EnabledStyle-HorizontalAlign="Right" ToolTip="Усього з ПДВ до сплати" />
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbCoin" runat="server" Text="Монета"></asp:Label>
                    </td>
                    <td>
                        <BarsRef:TextBoxRefer ID="tbCoinCode" runat="server" TAB_NAME="SPR_MON" KEY_FIELD="KOD_MONEY"
                            SEMANTIC_FIELD="NAMEMONEY" Width="200px" />
                    </td>
                    <%--<td>
                        <Bars2:BarsTextBox ID="tbCoinCode" runat="server" MaxLength="11" Width="40px" EnabledStyle-HorizontalAlign="Center" Enabled="false" AutoPostBack="false"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbCoinName" runat="server" Text="не вказано" Width="320px" Enabled="false"></Bars2:BarsTextBox>
                    </td>
                    --%>
                    <%-- <td>
                        <bars:ImageTextButton ID="ibRefCoin" runat="server" ImageUrl="/common/images/default/16/find.png" Enabled="true" OnClientClick="OpenRefCoin()" />
                    </td>--%>
                    <%--  <td>
                        <asp:Label ID="lbDllCoinCode" runat="server" Text="Код"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCoinCode" runat="server" Width="150px"></asp:DropDownList>
                    </td>--%>
                    <td>
                        <asp:Label ID="lbCoinCount" runat="server" Text="Кількість"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbCoinCount" runat="server" Value="0" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" />
                    </td>
                    <td>
                        <asp:Label ID="lbCoinPrice" runat="server" Text="Ціна за 1 шт."></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" ID="tbCoinPrice" runat="server" Value="0.00" />
                    </td>
                    <td>
                        <input id="inNom" runat="server" type="hidden" />
                    </td>
                    <td>
                        <bars:ImageTextButton ID="btAddDetail" runat="server" ImageUrl="/common/images/default/16/ok.png" Text="Додати" ToolTip="Додати рядок" OnClick="btAddDetail_Click" Style="margin-left: 5px;" />
                    </td>
                    <td>
                        <bars:ImageTextButton ID="btRemoveDet" runat="server" ImageUrl="/common/images/default/16/delete.png" Enabled="false" Text="Видалити" ToolTip="Видалити рядок" OnClick="btRemoveDet_Click" Style="margin-left: 5px;" />
                    </td>
                    <td>
                        <bars:ImageTextButton ID="btPayInvoice" runat="server" ImageUrl="/common/images/default/16/money_calc.png" Enabled="false" Text="Сплатити" ToolTip="Сплатити накладну" OnClick="btPayInvoice_Click" Style="margin-left: 5px;" />
                    </td>
                    <td>
                        <bars:ImageTextButton ID="btOpenDocument" runat="server" ImageUrl="/common/images/default/16/document_view.png" Enabled="false" Text="Переглянути" ToolTip="Преглянути документ" OnClientClick="OpenDocument()" Style="margin-left: 5px;" />
                        <asp:Label ID="lbRef" runat="server" Text=" " ForeColor="White"></asp:Label>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <BarsEX:BarsObjectDataSource ID="odsInvoiceDetail" runat="server" SelectMethod="Select"
                            TypeName="Bars.CoinInvoice.VCoinInvoiceDetail" DataObjectTypeName="Bars.CoinInvoice.VCoinInvoiceDetailRecord">
                        </BarsEX:BarsObjectDataSource>

                        <BarsEX:BarsGridViewEx ID="gv" runat="server" PagerSettings-PageButtonCount="10"
                            PageSize="50" AllowPaging="True" AllowSorting="True"
                            CssClass="barsGridView" DateMask="dd/MM/yyyy" DataKeyNames="RN, CODE, CNT, UNIT_PRICE, UNIT_PRICE_VAT"
                            JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
                            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
                            AutoSelectFirstRow="false"
                            HoverRowCssClass="headerRow"
                            RefreshImageUrl="/common/images/default/16/refresh.png"
                            ExcelImageUrl="/common/images/default/16/export_excel.png"
                            FilterImageUrl="/common/images/default/16/filter.png">
                            <EditRowStyle CssClass="editRow"></EditRowStyle>
                            <FooterStyle CssClass="footerRow"></FooterStyle>
                            <HeaderStyle CssClass="headerRow"></HeaderStyle>
                            <PagerStyle CssClass="pagerRow"></PagerStyle>
                            <RowStyle CssClass="normalRow"></RowStyle>
                            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                            <NewRowStyle CssClass=""></NewRowStyle>
                            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                            <Columns>
                                <asp:BoundField DataField="RN" HeaderText="№ пп" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="CODE" HeaderText="Код" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="NAME" HeaderText="Назва" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="METAL" HeaderText="Метал" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="NOMINAL" HeaderText="Платіжний номінал 1 шт." ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ### ### ### ### ###0.00}" />
                                <asp:BoundField DataField="CNT" HeaderText="Кількість шт" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="NOMINAL_PRICE" HeaderText="Сума за номіналом " ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ### ### ### ### ###0.00}" />
                                <asp:BoundField DataField="UNIT_PRICE" HeaderText="Ціна 1 шт. без ПДВ та НОМ" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ### ### ### ### ###0.00}" />
                                <asp:BoundField DataField="NOMINAL_SUM" HeaderText="Сума без ПДВ та НОМ" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ### ### ### ### ###0.00}" />
                                <asp:BoundField DataField="UNIT_PRICE_VAT" HeaderText="Ціна з ПДВ та НОМ" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ### ### ### ### ###0.00}" />
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
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </form>
</body>
</html>
