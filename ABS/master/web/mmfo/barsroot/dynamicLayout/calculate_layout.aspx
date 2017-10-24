<%@ Page Language="C#" AutoEventWireup="true" CodeFile="calculate_layout.aspx.cs" Inherits="calculate_layout" Title="Функція Сховище. Оприбуткування памятних монет" %>

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
    function OpenDocument() {
        window.open('/barsroot/documentview/default.aspx?ref=' + document.getElementById('<%=tbRef.ClientID%>').value, null, 'dialogWidth:790px;dialogHeight:550px');
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
        <asp:Panel ID="pnButtons" runat="server" GroupingText="Доступні дії:" Style="margin-left: 10px; margin-right: 10px">
            <bars:ImageTextButton ID="btPay" runat="server" ImageUrl="/common/images/default/16/money_calc.png" Enabled="false" Text="Сплатити" ToolTip="Сплатити" OnClick="btPay_Click" Style="margin-left: 10px;" />
            <bars:ImageTextButton ID="btOpenDocument" runat="server" ImageUrl="/common/images/default/16/document_view.png" Enabled="false" Text="Преглянути" ToolTip="Преглянути документ" OnClientClick="OpenDocument()" Style="margin-left: 10px;" />
            <bars:ImageTextButton ID="btNew" runat="server" ImageUrl="/common/images/default/16/new.png" Enabled="true" Text="Створити новий" ToolTip="Створити новий розподіл" OnClick="btNew_Click" Style="margin-left: 10px;" />
        </asp:Panel>
        <asp:Panel ID="pnDynamicLayout" runat="server" GroupingText="Макет:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td>
                        <asp:RadioButtonList ID="rbListDk" runat="server" RepeatDirection="Horizontal" TextAlign="Left" Enabled="false">
                            <asp:ListItem Value="1" Text="Деб" Selected="False"></asp:ListItem>
                            <asp:ListItem Value="0" Text="Кред" Selected="False"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td align="right">
                        <asp:Label ID="lbTotalSum" runat="server" Text="Сума" ToolTip="Загальна сума розподілу"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbTotalSum" runat="server" Value="0.00" MinValue="0" NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" BackColor="LightGreen" />
                    </td>
                    <td align="right">
                        <asp:Label ID="lbRef" runat="server" Text="РЕФ"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbRef" runat="server" Value="0" Width="100" Enabled="false" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator="" EnabledStyle-HorizontalAlign="Right" BackColor="LightGreen" />
                    </td>
                    <td align="right">
                        <asp:Label ID="lbTypedPercents" runat="server" Text="Набрано %"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbTypedPercents" runat="server" Value="0" Width="100" NumberFormat-DecimalDigits="2" Enabled="false" NumberFormat-GroupSeparator="" EnabledStyle-HorizontalAlign="Right" />
                    </td>
                    <td align="right">
                        <asp:Label ID="lbTypedSum" runat="server" Text="Набрано суму"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbTypedSum" runat="server" Value="0.00" NumberFormat-DecimalDigits="2" Enabled="false" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" />
                    </td>
                    <td align="right">
                        <asp:Label ID="lbBranchCount" runat="server" Text="Кількість бранчів"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbBranchCount" runat="server" Value="0" Width="50" NumberFormat-DecimalDigits="0" Enabled="false" NumberFormat-GroupSeparator="" EnabledStyle-HorizontalAlign="Right" />
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td align="right">
                        <asp:Label ID="lbKvA" runat="server" Text="Код вал-А" ToolTip="Код валюти рахунку А"></asp:Label>
                    </td>
                    <td>
                        <BarsRef:TextBoxRefer ID="tbKvA" runat="server" Width="70px" Enabled="false"
                            TAB_NAME="TABVAL" KEY_FIELD="KV" SEMANTIC_FIELD="NAME" ORDERBY_CLAUSE="order by kv desc" WHERE_CLAUSE=" where d_close is null" />
                    </td>
                    <td align="right">
                        <asp:Label ID="lbNlsA" runat="server" Text="Рах-А"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbNlsA" runat="server" Enabled="false" MaxLength="14" BackColor="Yellow" ToolTip="№ рахунку А"></asp:TextBox>
                    </td>
                    <td align="right">
                        <asp:Label ID="lbOstC" runat="server" Text="Факт.Зал.на Рах-А"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbOstC" runat="server" Value="0.00" NumberFormat-DecimalDigits="2" Enabled="false" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" BackColor="Yellow" ToolTip="Фактичний залишок на разунку А" />
                    </td>
                    <td align="right">
                        <asp:Label ID="lnNlsAName" runat="server" Text="Назва Рах-А"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbNlsAName" runat="server" Enabled="false" MaxLength="14" BackColor="Yellow" ToolTip="Назва рахунку А" Width="310"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lbNazn" runat="server" Text="Призначення платежу"></asp:Label>
                    </td>
                    <td colspan="6">
                        <asp:TextBox ID="tbNazn" runat="server" Enabled="true" MaxLength="160" ToolTip="Призначення платежу" Width="843"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td align="right">
                        <asp:Label ID="lbKvB" runat="server" Text="Код вал-Б" ToolTip="Код валюти рахунку Б"></asp:Label>
                    </td>
                    <td>
                        <BarsRef:TextBoxRefer ID="tbKvB" runat="server" Width="70px" Enabled="false"
                            TAB_NAME="TABVAL" KEY_FIELD="KV" SEMANTIC_FIELD="NAME" ORDERBY_CLAUSE="order by kv desc" WHERE_CLAUSE=" where d_close is null" />
                    </td>
                    <td>
                        <asp:Label ID="lbNd" runat="server" Text="№ док" ToolTip="Номер документу(розпорядження)"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbNd" runat="server" Enabled="true" MaxLength="10" ToolTip="Номер документу(розпорядження)" Width="100"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lbDatD" runat="server" Text="Дата док"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsDateInput ID="diDatD" runat="server" EnabledStyle-HorizontalAlign="Center" ToolTip="Дата документу(розпорядження)" MinDate="01/01/2016"></Bars2:BarsDateInput>
                    </td>
                    <td>
                        <asp:Label ID="lbDateFrom" runat="server" Text="З"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsDateInput ID="diDateFrom" runat="server" EnabledStyle-HorizontalAlign="Center" ToolTip="Дата 'З'"></Bars2:BarsDateInput>
                    </td>
                    <td>
                        <asp:Label ID="lbDateTo" runat="server" Text="По"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsDateInput ID="diDateTo" runat="server" EnabledStyle-HorizontalAlign="Center" ToolTip="Дата 'По'"></Bars2:BarsDateInput>
                    </td>
                    <td>
                        <asp:CheckBox ID="cbDatesToNazn" runat="server" Checked="false" Text="+ Дати в призн.пл." />
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table>
                <tr>
                    <td align="right" colspan="2">
                        <asp:Label ID="lbRowPercent" runat="server" Text="Відсоток від розподілу" ToolTip="Відсоток від загальної суми розподілу"></asp:Label>
                    </td>
                    <td colspan="2">
                        <Bars2:BarsNumericTextBox ID="tbRowPercent" runat="server" Value="0" NumberFormat-DecimalDigits="0" MaxLength="3" MaxValue="100" MinValue="0" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" />
                    </td>
                    <td align="right">
                        <asp:Label ID="lbRowSum" runat="server" Text="Сума від розподілу" ToolTip="Cума від загальної суми розподілу"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbRowSum" runat="server" Value="0.00" NumberFormat-DecimalDigits="2" NumberFormat-GroupSeparator=" " MinValue="0" EnabledStyle-HorizontalAlign="Right" />
                    </td>
                    <td colspan="2">
                        <bars:ImageTextButton ID="btSaveDetail" runat="server" ImageUrl="/common/images/default/16/ok.png" Text="Зберегти" ToolTip="Зберегти" OnClick="btSaveDetail_Click" Style="margin-left: 10px;" />
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <BarsEX:BarsObjectDataSource ID="odsDynamicLayoutDetail" runat="server" SelectMethod="Select"
                            TypeName="Bars.DynamicLayout.VTmpDynamicLayoutDetail" DataObjectTypeName="Bars.DynamicLayout.VTmpDynamicLayoutDetailRecord">
                        </BarsEX:BarsObjectDataSource>

                        <BarsEX:BarsGridViewEx ID="gv" runat="server" PagerSettings-PageButtonCount="10"
                            PageSize="100" AllowPaging="True" AllowSorting="True"
                            CssClass="barsGridView" DateMask="dd/MM/yyyy" DataKeyNames="ID"
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
                                <asp:BoundField DataField="KV" HeaderText="Код вал-Б" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="BRANCH" HeaderText="Код Бранчу" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="BRANCH_NAME" HeaderText="Назва Бранчу" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="NLS_B" HeaderText="Рах.Б Бранчу" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="PERCENT" HeaderText="% від заг. суми" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="SUMM_A" HeaderText="Сума проводки в вал-А" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ### ### ### ### ###0.00}" />
                                <asp:BoundField DataField="SUMM_B" HeaderText="Сума проводки в вал-Б" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ### ### ### ### ###0.00}" />
                                <asp:BoundField DataField="NLS_COUNT" HeaderText="Кількість бранчів" ItemStyle-HorizontalAlign="Right" />
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
