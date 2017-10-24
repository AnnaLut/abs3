<%@ Page Language="C#" AutoEventWireup="true" CodeFile="calculate_static_typeA.aspx.cs" Inherits="calculate_static_typeA" Title="Функція Сховище. Оприбуткування памятних монет" %>

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
    }

    function OpenDocument(ref) {
        // alert(ref.innerText);
        // console.log(ref.innerText);
        // var url = '/barsroot/documents/item/?id=' + ref.innerText; //'/barsroot/documentview/default.aspx?ref=' + ref
        //  window.open(url, null, 'dialogWidth:790px;dialogHeight:550px');

        window.showModalDialog('/barsroot/documents/item/?id=' + ref.innerText, null, 'dialogWidth:720px;dialogHeight:550px');
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
            <bars:ImageTextButton ID="btCalc" runat="server" ImageUrl="/common/images/default/16/gear_ok.png" Enabled="true" Text="Розрахувати" ToolTip="Розрахувати" OnClick="btCalc_Click" Style="margin-left: 10px;" />
            <bars:ImageTextButton ID="btPay" runat="server" ImageUrl="/common/images/default/16/money_calc.png" Enabled="false" Text="Сплатити" ToolTip="Сплатити" OnClick="btPay_Click" Style="margin-left: 10px;" />
            <bars:ImageTextButton ID="btOpenDocument" runat="server" ImageUrl="/common/images/default/16/document_view.png" Enabled="false" Text="Преглянути" ToolTip="Преглянути документ" OnClientClick="OpenDocument()" Style="margin-left: 10px;" />
            <bars:ImageTextButton ID="btNew" runat="server" ImageUrl="/common/images/default/16/new.png" Enabled="true" Text="Створити новий" ToolTip="Створити новий розподіл" OnClick="btNew_Click" Style="margin-left: 10px;" />
        </asp:Panel>
        <asp:Panel ID="pnDynamicLayout" runat="server" GroupingText="" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td>
                        <asp:RadioButtonList ID="rbListDk" runat="server" RepeatDirection="Horizontal" TextAlign="Right" Enabled="true">
                            <asp:ListItem Value="1" Text="ДТ рах/DK=1,3" Selected="False"></asp:ListItem>
                            <asp:ListItem Value="0" Text="КТ рах/DK=0,2" Selected="False"></asp:ListItem>
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
                </tr>
            </table>
            <table>
                <tr>
                    <td>
                        <asp:CheckBox ID="cbInfo" runat="server" Text="Інформаційно" TextAlign="Right"></asp:CheckBox>
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
                        <asp:Label ID="lbKvA" runat="server" Text="Код вал-А" ToolTip="Код валюти рахунку А"></asp:Label>
                    </td>
                    <td>
                        <BarsRef:TextBoxRefer ID="tbKvA" runat="server" Width="70px" Enabled="false"
                            TAB_NAME="TABVAL" KEY_FIELD="KV" SEMANTIC_FIELD="NAME" ORDERBY_CLAUSE="order by kv desc" WHERE_CLAUSE=" where d_close is null" />
                    </td>
                    <td align="right">
                        <asp:Label ID="lnNlsAName" runat="server" Text="Назва Рах-А"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbNlsAName" runat="server" Enabled="false" MaxLength="14" BackColor="Yellow" ToolTip="Назва рахунку А" Width="310"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbNazn" runat="server" Text="Призначення платежу"></asp:Label>
                    </td>
                    <td colspan="7">
                        <asp:TextBox ID="tbNazn" runat="server" Enabled="true" MaxLength="160" ToolTip="Призначення платежу" Width="843"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
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
            <table id="btWorkWithStaticLayout">
                <tr>
                    <td>
                        <bars:ImageTextButton ID="btAddLayout" runat="server" ImageUrl="/common/images/default/16/new.png" Text="Додати" ToolTip="Додати" OnClick="btAddLayout_Click" Style="margin-left: 10px;" />
                    </td>
                    <td>
                        <bars:ImageTextButton ID="btEditLayout" runat="server" ImageUrl="/common/images/default/16/edit.png" Text="Редагувати" ToolTip="Редагувати" OnClick="btEditLayout_Click" Style="margin-left: 10px;" />
                    </td>
                    <td>
                        <bars:ImageTextButton ID="btDeleteLayout" runat="server" ImageUrl="/common/images/default/16/delete.png" Text="Видалити" ToolTip="Видалити" OnClick="btDeleteLayout_Click" Style="margin-left: 10px;" />
                    </td>
                    <td>
                        <bars:ImageTextButton ID="btSaveDetail" runat="server" ImageUrl="/common/images/default/16/ok.png" Text="Зберегти" ToolTip="Зберегти" OnClick="btSaveDetail_Click" Style="margin-left: 10px;" />
                    </td>
                </tr>
            </table>
            <table id="tblDetailTypeA" runat="server" visible="false">
                <tr>
                    <td>
                        <asp:Label ID="lbMfoBTypeA" runat="server" Text="Код МФО-Б" ToolTip="Код МФО-Б"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbNlsBTypeA" runat="server" Text="Рах.Б в МФО-Б" ToolTip="Рах.Б в МФО-Б"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbNameBTypeA" runat="server" Text="Назва отримувача" ToolTip="Назва отримувача"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbOkpobTypeA" runat="server" Text="Ід Код Б" ToolTip="Ід Код Б"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbPersentTypeA" runat="server" Text="% від заг.суми" ToolTip="% від заг.суми"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbConstTypeA" runat="server" Text="+ або - Константа" ToolTip="+ або - Константа"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbSumTypeA" runat="server" Text="Сума проводки" ToolTip="Сума проводки"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbSpecNaznTypeA" runat="server" Text="Особливе признач. платежу" ToolTip="Особливе признач. платежу"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbTTTypeA" runat="server" Text="Код оп" ToolTip="Код операції"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbOrdTypeA" runat="server" Text="№ пп" ToolTip="№ пп"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lbVobTypeA" runat="server" Text="Вид Док" ToolTip="Вид Док"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="tbMfoBTypeA" runat="server" Enabled="true" MaxLength="6" ToolTip="Код МФО-Б" Width="100"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="tbNlsBTypeA" runat="server" Enabled="true" MaxLength="14" ToolTip="Рах.Б в МФО-Б" Width="100"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="tbNameBTypeA" runat="server" Enabled="true" MaxLength="38" ToolTip="Назва отримувача" Width="100"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="tbOkpobTypeA" runat="server" Enabled="true" MaxLength="14" ToolTip="Ід Код Б" Width="100"></asp:TextBox>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbPersentTypeA" runat="server" Value="0.00" NumberFormat-DecimalDigits="2" MaxValue="100" MinValue="0" Enabled="true" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" ToolTip="% від заг.суми" />
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbConstTypeA" runat="server" Value="0.00" NumberFormat-DecimalDigits="2" Enabled="true" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" ToolTip="+ або - Константа" />
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbSumTypeA" runat="server" Value="0.00" NumberFormat-DecimalDigits="2" MinValue="0" Enabled="true" NumberFormat-GroupSeparator=" " EnabledStyle-HorizontalAlign="Right" ToolTip="Сума проводки" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbSpecNaznTypeA" runat="server" Enabled="true" MaxLength="160" ToolTip="Особливе признач. платежу" Width="200px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="tbTTTypeA" runat="server" Enabled="true" MaxLength="3" ToolTip="Код операції" Width="50px"></asp:TextBox>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbOrdTypeA" runat="server" Value="0" NumberFormat-DecimalDigits="0" MinValue="0" Enabled="true" NumberFormat-GroupSeparator="" EnabledStyle-HorizontalAlign="Right" ToolTip="№ пп" Width="50px" />
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbVobTypeA" runat="server" Value="0" NumberFormat-DecimalDigits="0" MinValue="0" Enabled="true" NumberFormat-GroupSeparator="" EnabledStyle-HorizontalAlign="Right" ToolTip="Сума проводки" />
                    </td>
                    <td>
                        <asp:Label ID="lbId" runat="server" Text="0" ToolTip=""></asp:Label>
                    </td>
                </tr>
            </table>

            <table id="tblGvStaticLayout">
                <tr>
                    <td>
                        <BarsEX:BarsObjectDataSource ID="odsStatic" runat="server" SelectMethod="Select"
                            TypeName="Bars.DynamicLayout.VTmpStaticLayoutDetailA" DataObjectTypeName="Bars.DynamicLayout.VTmpStaticLayoutDetailARecord">
                        </BarsEX:BarsObjectDataSource>

                        <BarsEX:BarsGridViewEx ID="gvStatic" runat="server" PagerSettings-PageButtonCount="10" DataSourceID="odsStatic"
                            PageSize="1000" AllowPaging="True" AllowSorting="True"
                            CssClass="barsGridView" DateMask="dd/MM/yyyy" DataKeyNames="ID, MFOB, MFOB_NAME, NLS_B, NAMB, OKPOB, PERCENT, DELTA, SUMM_A, NAZN, TT, NLS_COUNT, ORD, VOB"
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
                                <asp:BoundField DataField="KV" HeaderText="Код вал" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="MFOB" HeaderText="Код МФО8-Б" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="MFOB_NAME" HeaderText="Назава МФО-Б" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="NLS_B" HeaderText="Рах.Б в МФО-Б" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="NAMB" HeaderText="Назва отримувача" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="OKPOB" HeaderText="Ід Код-Б" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="PERCENT" HeaderText="% від заг. суми" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="DELTA" HeaderText="+ або - Крнстанта" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ### ### ### ### ###0.00}" />
                                <asp:BoundField DataField="SUMM_A" HeaderText="Сума проводки" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:### ### ### ### ### ### ### ###0.00}" />
                                <asp:TemplateField HeaderText="РЕФ">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="ftbRef" runat="server">
                                            <asp:Label ID="lbRef" runat="server" Text='<%#String.Format("{0}",Eval("REF")) %>'></asp:Label>
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="NAZN" HeaderText="Призначення" ItemStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="TT" HeaderText="Код оп" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="NLS_COUNT" HeaderText="№ грп" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="ORD" HeaderText="№ ПП" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="VOB" HeaderText="Вид док" ItemStyle-HorizontalAlign="Right" />
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
