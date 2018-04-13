<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fin_form_obu.aspx.cs" Inherits="credit_fin_form_obu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="~/UserControls/LabelTooltip.ascx" TagName="LabelTooltip" TagPrefix="Lab" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Розрахунок коефіцієнта покриття боргу </title>
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <style type="text/css">
        .style1
        {
            width: 420px;
            text-align: right;
        }
        .style2
        {
            width: 523px;
        }
        .style4
        {
            width: 523px;
            text-align: right;
        }
        .style5
        {
            width: 337px;
        }
        .style6
        {
            width: 149px;
        }
        .style7
        {
            font-size: large;
        }
        .style8
        {
            font-family: "Times New Roman" , Times, serif;
        }
    </style>
</head>
<body>
    <form id="formOperationList" runat="server">
    <asp:Panel ID="Pn1" runat="server" Width="910Px">
        <asp:Label runat="server" ID="lab_form" Text="Розрахунок <br /> внутрішнього кредитного рейтингу <br /> контрагента <br /> <br />"
            Style="text-align: center; font-weight: 700; font-size: large; font-family: 'Bookman Old Style';
            font-style: italic; background-color: #CCD7ED" Width="910px"></asp:Label>
        <table width="910Px" bgcolor="#CCD7ED">
            <tr>
                <td class="style1">
                    <asp:Label ID="r0a" runat="server" Text="*** **"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="r0b" runat="server" Text="** ***"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_v" runat="server" Style="text-align: right; text-decoration: underline;"
                        Text="ВИСНОВОК"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:DropDownList ID="bt_v" runat="server" IsRequired="true" Width="150Px">
                        <asp:ListItem Text="Поточний" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Попередній" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="r01" runat="server" Text="*** **"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="r02" runat="server" Text="** ***"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="tl_RNK" runat="server" Style="text-align: right" Text="РНК клієнта"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="tb_RNK" runat="server" Enabled="false" Style="text-align: right"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="tl_NMS" runat="server" Style="text-align: right" Text="Назва клієнта"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="TB_NMS" runat="server" Enabled="false"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="tl_okpo" runat="server" Style="text-align: right" Text="ОКПО клієнта"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="tb_okpo" runat="server" Enabled="false" Style="text-align: right"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_datst" runat="server" Style="text-align: right" Text="Дата створення підприємства"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDate ID="tb_datst" runat="server" IsRequired="true" style="text-align: right">
                    </bec:TextBoxDate>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="tl_datf" runat="server" Style="text-align: right" Text="Баланс підприємства станом на "></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="tb_datf" runat="server" Enabled="false" Style="text-align: right"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="Lb_DP" runat="server" Style="text-align: right" Text="Вид позичальника "></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:DropDownList ID="tb_DP" runat="server" IsRequired="true" Width="250Px">
                        <asp:ListItem Enabled="true" Text="Субєкт господарської діяльності" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Орган державного управління" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_tiprnk" runat="server" Style="text-align: right" Text="Галузь позичальника (для цілей ВКР). "></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:DDLList ID="tb_tiprnk" runat="server" IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="Lb_INV" runat="server" Style="text-align: right" Text="Приналежність до фінансування інвестиційних проектів "></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:DDLList ID="Tb_INV" runat="server" IsRequired="true" OnValueChanged="Changed_Tb_INV">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="Lb_ETAP" runat="server" Style="text-align: right" Text="Етапи інвестиційного проекту "></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:DDLList ID="Tb_ETAP" runat="server" IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_IKY" runat="server" Style="text-align: right" Text="Підняти категорію якості "></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:DDLList ID="tb_IKY" runat="server" IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="r1" runat="server" Text="*** **"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="r12" runat="server" Text="*** **"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="tl_nd" runat="server" Style="text-align: right" Text="Референс угоди "></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="tb_nd" runat="server" Enabled="false" Style="text-align: right"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_cc_id" runat="server" Style="text-align: right" Text="№ угоди "></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="tb_cc_id" runat="server" Style="text-align: right"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_datp" runat="server" Style="text-align: right" Text="Дата укладання кредитної угоди"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDate ID="tb_datp" runat="server" IsRequired="true" style="text-align: right">
                    </bec:TextBoxDate>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_sdate" runat="server" Style="text-align: right" Text="Дата надання (фактично)"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDate ID="tb_sdate" runat="server" IsRequired="true" style="text-align: right">
                    </bec:TextBoxDate>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_wdate" runat="server" Style="text-align: right" Text="Дата погашення  (за угодою)"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDate ID="tb_wdate" runat="server" IsRequired="true" style="text-align: right">
                    </bec:TextBoxDate>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_sumn" runat="server" Style="text-align: right" Text="Сума (за угодою)"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="tb_sumn" runat="server" IsRequired="true" style="text-align: right"
                        MaxValue="9999999999999"></bec:TextBoxDecimal>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_kv" runat="server" Style="text-align: right" Text="Код валюти"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:DDLList ID="tb_kv" runat="server" IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_summ" runat="server" Style="text-align: right" Text="Сума (за угодою)еквівалент"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="tb_summ" runat="server" IsRequired="true" style="text-align: right"
                        MaxValue="99999999999990"></bec:TextBoxDecimal>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_rat" runat="server" Style="text-align: right" Text="Відсоткова ставка (за угодою)%"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="tb_rat" runat="server" IsRequired="true"></bec:TextBoxDecimal>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_graf" runat="server" Style="text-align: right" Text="Графік погашення кредиту "></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:DDLList ID="tb_graf" runat="server" IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="Lb0_obs" runat="server" Style="text-align: right" Text="Стан обслуговування богу "></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:DDLList ID="DDL_obs" runat="server" IsRequired="false" Enabled="false" Width="170">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_nmis" runat="server" Style="text-align: right" Visible="false"
                        Text="Кількість місяців, що залишилася до погашення кредиту з урахуванням строку пролонгації кредиту"
                        Width="300"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxNumb ID="tb_nmis" runat="server" IsRequired="false" Visible="false" Enabled="false">
                    </bec:TextBoxNumb>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_NKO" runat="server" Style="text-align: right" Visible="true" Text="Кількість місяців, що залишилася до погашення кредиту (облігацій), а також до завершення термінів дії договорів, які передбачають надання Банком авалів, гарантії, з урахуванням строків пролонгації договорів(n)"
                        Width="300" ToolTip="У разі якщо Контрагент одночасно має (планує мати) заборгованість або отримати гарантії, авалі за кількома договорами, значення показника n приймається на рівні середньозваженого терміну, що залишився до погашення кредиту (облігацій), а також до завершення термінів дії договорів авалів, гарантії, з урахуванням строків пролонгації договорів(n)"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxNumb ID="tb_NKO" runat="server" IsRequired="true" Visible="true" Enabled="true">
                    </bec:TextBoxNumb>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_sk" runat="server" Style="text-align: right" Visible="false" Text="Cума кредиту (заборгованість за кредитом) та проценти за ним з урахуванням строку, що залишився до погашення кредиту грн."
                        Width="300"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="tb_sk" runat="server" IsRequired="false" Visible="false"
                        Enabled="false"></bec:TextBoxDecimal>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_ZB" runat="server" Style="text-align: right" Visible="true" Text="Заборгованість позичальника перед Банком за всіма кредитними угодами на дату оцінки, а також позабалансові зобов'язання Банку (Зб) грн."
                        Width="300" ToolTip="заборгованість перед Банком за основною сумою боргу (кредит, боргові цінні папери), включаючи зобов’язання, надані Банком за кредитними операціями, гарантіями та авалями"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="tb_ZB" runat="server" IsRequired="true" Visible="true" Enabled="true"
                        MaxValue="999999999999"></bec:TextBoxDecimal>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_BZB" runat="server" Style="text-align: right" Visible="true" Text="Заборгованість перед Банком за основною сумою боргу, яка обліковується на балансі позичальника станом на звітну дату (БЗб) грн."
                        Width="300" ToolTip="заборгованість перед Банком за основною сумою боргу (кредит, боргові цінні папери), яка обліковується на балансі Контрагента станом на звітну дату."></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="tb_BZB" runat="server" IsRequired="true" Visible="true" Enabled="true"
                        MaxValue="999999999999"></bec:TextBoxDecimal>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="r31" runat="server" Text="*** **"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="r32" runat="server" Text="*** **"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_NSM" runat="server" Style="text-align: right" Text="Середньомісячний чистий дохід (виручки) (Вр) тис.грн."></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="tb_NSM" runat="server" Enabled="false" Style="text-align: right"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_ZMO" runat="server" Visible="false" Style="text-align: right" Text="Щомісячні умовно-постійні зобов'язання позичальника (адміністративно-господарські витрати, податкові платежі тощо) (тис.грн.)  (Зм)"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="tb_ZMO" runat="server" Enabled="false" Visible="false" Style="text-align: right"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="lb_ZI0" runat="server" Style="text-align: right" Text="Сума інших зобов'язань перед кредиторами, що мають бути виконані у грошовій формі з рахунку позичальника, крім сум зобов'язань, строк погашення яких перевищує строк дії кредитної угоди (за даними останнього балансу) (тис.грн.)    (Зі)"
                        Width="300"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="tb_ZI0" MaxValue="999999999999" runat="server" IsRequired="true">
                    </bec:TextBoxDecimal>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="L41" runat="server" Text="*** **"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="L42" runat="server" Text="*** **"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnGrid" Style="margin-left: 0px; margin-right: 10px;
        margin-bottom: 0px; margin-top: 0px" Width="1030Px">
        <Bars:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gvMain" runat="server" Width="910Px" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="ND, KOD, IDF,NAME" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="None" ShowPageSizeBox="false" HoverRowCssClass="hoverRow"
            Style="background-color: #CCD7ED" ShowCaption="False">
            <FooterStyle CssClass="footerRow" />
            <HeaderStyle CssClass="headerRow" />
            <EditRowStyle CssClass="editRow" />
            <PagerStyle CssClass="pagerRow" />
            <NewRowStyle CssClass="" />
            <SelectedRowStyle CssClass="selectedRow" />
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="ND" HeaderText="REF KD" Visible="false" />
                <asp:BoundField DataField="FDAT" HeaderText="Дата" Visible="false" />
                <Bars:BarsBoundFieldEx DataField="NAME" HeaderText="Назва" ItemStyle-HorizontalAlign="Right"
                    ItemStyle-Width="420px" />
                <asp:TemplateField HeaderText="Відповідь" FooterStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownList1" AppendDataBoundItems="true" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + Eval("KOD") +((char)39).ToString() + "and idf = " +Eval("IDF") + "union all select -99 as val, null as name from dual")%>'
                            DataTextField="NAME" DataValueField="VAL" Text='<%#Eval("S")%>' Visible="true"
                            Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>' Width="420px"
                            IsRequired="true" runat="server">
                        </asp:DropDownList>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText=" " FooterStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <Lab:LabelTooltip runat="server" Text="Роз`яснення" ToolTip='<%# Eval("DESCRIPT")%>'
                            Visible='<%# (Convert.ToString(Eval("DESCRIPT")).Length == 0)?(false):(true) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Авт." FooterStyle-HorizontalAlign="Left" Visible="false">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Enabled="false" Visible="true" Checked='<%# (Convert.ToString(Eval("POB")) == "0")?(false):(true) %>' /></ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="POB" HeaderText="Вираховується" Visible="false" />
            </Columns>
            <RowStyle CssClass="normalRow" />
        </Bars:BarsGridViewEx>
        <table runat="server" width="910Px" bgcolor="#CCD7ED">
            <tr>
                <td class="style1">
                    <asp:Label ID="Lb_MZ0" runat="server" Style="text-align: right" Text="Місцезнаходження об'єкта застави (Мз) (для нерухомості), Вид майна(ВМ) (для рухомого майна, майнових прав), комбінований вид забезпечення (Кзб)) "></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:DDLList ID="Tb_MZ0" runat="server" IsRequired="true" Width="420" OnValueChanged="ValueChanged_Tb_MZ0">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="Lb_MZ1" runat="server" Style="text-align: right" Text="Комбінований вид забезпечення "
                        Width="300" ToolTip="Pозраховується як середньоарифметичне значення відповідних оцінок показників Мз та Вм"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="Tb_MZ1" runat="server" IsRequired="true" MaxValue="10" MinValue="0">
                    </bec:TextBoxDecimal>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnRez" Visible="false" Style="margin-left: 0px; margin-right: 10px;
        margin-bottom: 0px; margin-top: 0px" Width="1030Px">
        <table width="910Px" bgcolor="#CCD7ED">
            <tr>
                <td class="style2">
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <td class="style4">
                    <asp:Label ID="lb_bal" runat="server" Style="text-align: right; font-style: italic;
                        font-weight: 700; font-family: Arial, Helvetica, sans-serif;" Text="Загальний показник оцінки фінансового стану позичальника "
                        Visible="true" Width="400"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxNumb ID="tb_bal" runat="server" Enabled="false" IsRequired="false" Visible="true" />
                </td>
            </tr>
            <tr>
                <td class="style4">
                    <asp:Label ID="lb_vnkr" runat="server" Style="text-align: right; font-style: italic;
                        font-weight: 700; font-family: Arial, Helvetica, sans-serif;" Text="Внутрішній кредитний рейтинг "
                        Visible="true" Width="400"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxString ID="tb_vnkr" runat="server" Enabled="false" IsRequired="false"
                        Visible="true" CssClass="cssTextBoxNumb" />
                </td>
            </tr>
            <tr>
                <td class="style4">
                    <asp:Label ID="lb_ip" runat="server" Style="text-align: right; font-style: italic;
                        font-weight: 700; font-family: Arial, Helvetica, sans-serif;" Text="Інтегральний показник "
                        Visible="true" Width="400"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="tb_ip" runat="server" Enabled="false" IsRequired="false"
                        Visible="true" />
                </td>
            </tr>
            <tr>
                <td class="style4">
                    <asp:Label ID="lb_klas" runat="server" Style="text-align: right; font-style: italic;
                        font-weight: 700; font-family: Arial, Helvetica, sans-serif;" Text="Клас позичальника "
                        Visible="true" Width="400"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxNumb ID="tb_klas" runat="server" Enabled="false" IsRequired="false" Visible="true" />
                </td>
            </tr>
            <tr>
                <td class="style4">
                    <asp:Label ID="lb_obs" runat="server" Style="text-align: right; font-style: italic;
                        font-weight: 700; font-family: Arial, Helvetica, sans-serif;" Text="Стан обслуговування боргу "
                        Visible="true" Width="400"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxNumb ID="tb_obs" runat="server" Enabled="false" IsRequired="false" Visible="true" />
                </td>
            </tr>
            <tr>
                <td class="style4">
                    <asp:Label ID="Lb_kat" runat="server" Style="text-align: right; font-style: italic;
                        font-weight: 700; font-family: Arial, Helvetica, sans-serif;" Text="Категорія якості за кредитом "
                        Visible="true" Width="400"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxNumb ID="tb_kat" runat="server" Enabled="false" IsRequired="false" Visible="true" />
                </td>
            </tr>
            <tr>
                <td class="style4">
                    <asp:Label ID="lb_k23" runat="server" Style="text-align: right; font-style: italic;
                        font-weight: 700; font-family: Arial, Helvetica, sans-serif;" Text="Значення показника ризику кредиту "
                        Visible="true" Width="400"></asp:Label>
                </td>
                <td style="text-align: left">
                    <bec:TextBoxDecimal ID="tb_kat23" runat="server" Enabled="false" IsRequired="false"
                        Visible="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <br />
                </td>
            </tr>
        </table>
        <table width="910Px" bgcolor="#CCD7ED">
            <tr>
                <td class="style5" style="border: thin ridge #C0C0C0;">
                    <asp:Label runat="server" ID="lb_zbv" Text="Коефіцієнт співвідношення суми заборгованості (наданих зобов'язань) за основною сумою боргу перед Банком та валютою балансу (ЗВб)."
                        BorderColor="Black"></asp:Label>
                </td>
                <td class="style6" style="border: thin ridge #C0C0C0;">
                    <bec:TextBoxDecimal runat="server" ID="lb_zbv_z" Enabled="false"></bec:TextBoxDecimal>
                </td>
                <td style="border: thin ridge #C0C0C0;">
                    <asp:Label runat="server" ID="lb_zbv_k" Style="color: #FF3300"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style5" style="border: thin ridge #C0C0C0;">
                    <asp:Label runat="server" ID="lb_zcd" Text="Коефіцієнт співвідношення суми чистого доходу та суми зобов`язання за основною сумою боргу перед банком (ЗЧд)"></asp:Label>
                </td>
                <td class="style6" style="border: thin ridge #C0C0C0;">
                    <bec:TextBoxDecimal runat="server" ID="lb_zcd_z" Enabled="false"></bec:TextBoxDecimal>
                </td>
                <td style="border: thin ridge #C0C0C0;">
                    <asp:Label runat="server" ID="lb_zcd_k" Style="color: #FF3300"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnGrid2" Style="margin-left: 0px; margin-right: 10px;
        margin-bottom: 10px; margin-top: 0px" Width="1030Px">
        <table width="910Px" bgcolor="#CCD7ED">
            <tr>
                <td style="text-align: center">
                    <asp:DropDownList ID="ddl_print" runat="server" IsRequired="true" Width="55px" Visible="false"
                        ToolTip="Формат друку">
                        <asp:ListItem Text="PDF" Value="PDF"></asp:ListItem>
                        <asp:ListItem Text="RTF" Value="RTF"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:ImageButton ID="Bt_print" runat="server" ImageUrl="/Common/Images/default/24/printer.png"
                        Style="text-align: right" OnClick="Bt_print_Click" Visible="false" ToolTip="Сформувати документ"
                        Height="27px" Width="29px" />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <br />
                    <br />
                    <asp:ImageButton ID="Bt_zast" runat="server" AlternateText="Забезпечення для прийняття в розрахунок"
                        Height="23px" ImageUrl="/Common/Images/briefcase_look.gif" OnClick="Bt_zast_Click"
                        Style="text-align: right" ToolTip="Забезпечення для прийняття в розрахунок" Width="21px" />
                    <asp:ImageButton ID="Bt_get" runat="server" AlternateText="Виконати розрахунок ВНКР"
                        ImageUrl="/Common/Images/default/24/gear_replace.png" OnClick="Bt_get_Click"
                        Style="text-align: right" ToolTip="Виконати розрахунок ВНКР" />
                    <%-- <asp:ImageButton ID="Bt_print" runat="server" ImageUrl="/Common/Images/default/24/printer.png"
                        Visible="false" Style="text-align: right" OnClick="Bt_print_Click" />--%>
                    <asp:ImageButton ID="Bt_Pok" runat="server" ImageUrl="/Common/Images/default/24/documents_view.png"
                        Style="text-align: right" Visible="false" OnClick="Bt_Pok_Click" ToolTip="Переглянути показники оцінки фінстану"
                        Height="21px" Width="20px" />
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <span class="style8">
                        <asp:LinkButton ID="agr_bal" runat="server" BorderColor="#FFFFCC" CssClass="style7"
                            OnClick="agr_bal_Click" Text="Агрегований баланс" ToolTip="Друк Агрегованого балансу в форматі XLS"
                            CausesValidation="false"></asp:LinkButton>
                        <br />
                        <asp:LinkButton ID="Form_s" runat="server" CssClass="style7" OnClick="forms_Click"
                            Text="Форма1, Форма2" ToolTip="Друк форми №1 та форми №2 в форматі XLS" CausesValidation="false"></asp:LinkButton>
                    </span>
                    <br />
                    <br />
                    <br />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:ScriptManager ID="sm1" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    </form>
</body>
</html>
