<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fin_form_kpb.aspx.cs" Inherits="credit_fin_form_kpb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Розрахунок коефіцієнта покриття боргу </title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <style type="text/css">
        .style4
        {
            width: 131px;
        }
        .style5
        {
            font-size: small;
        }
        .style6
        {
            width: 657px;
            font-size: small;
        }
        p.MsoNormal
        {
            margin-bottom: .0001pt;
            font-size: 12.0pt;
            font-family: "Times New Roman";
            margin-left: 0cm;
            margin-right: 0cm;
            margin-top: 0cm;
        }
        .style8
        {
            font-size: 11pt;
            color: #1C4B75;
            margin-bottom: 15px;
            margin-top: 7px;
            width: 131px;
        }
    </style>
</head>
<body>
    <form id="formOperationList" runat="server">
    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Розрахунок коефіцієнтів" />
    </div>
    <asp:Panel runat="server" ID="pnInfo" GroupingText="Виконання дій" Style="margin-left: 10px;
        margin-right: 10px; margin-bottom: 10px; margin-top: 10px" Width="930px">
        <table class="editRow">
            <tr>
                <td>
                    <asp:Label ID="Lb_RNK" runat="server" Text="РНК:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="tbRNK" runat="server" TabIndex="7" ReadOnly="true" BackColor="Azure"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="tbOKP" runat="server" Text="ОКПО:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="tbOKPO" TabIndex="8" ReadOnly="true" BackColor="Azure" />
                </td>
                <td>
                    <asp:Label ID="tbFr" runat="server" Text="REF: договору"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxNumb runat="server" ID="tbFrm" TabIndex="9" ReadOnly="true" />
                </td>
                <td>
                    <asp:Label ID="tbDAT" runat="server" Text="Дата:"> </asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="tbFDat" runat="server" IsRequired="true" Width="100Px" BackColor="Azure"
                        Enabled="False" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btRefresh" runat="server" ImageUrl="/Common/Images/default/16/find.png"
                        TabIndex="4" ToolTip="Вибрати дані" OnClick="btRefresh_Click" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btOk" runat="server" ImageUrl="/Common/Images/default/16/save.png"
                        TabIndex="7" ToolTip="Виконати" OnClick="btOk_Click" OnClientClick='return confirm("Ви дійсно бажаєте зберегти?")'
                        Width="16px" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="/Common/Images/default/16/arrow_left.png"
                        TabIndex="7" ToolTip="повернутись на попередню сторінку" OnClick="backToFolders"
                        Width="16px" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="ID1" runat="server" Width="930Px" Style="margin-left: 10px; margin-right: 10px;
        margin-bottom: 10px; margin-top: 10px">
        <table width="900px">
            <tr>
                <td>
                    <asp:Label ID="L_p_kl1" runat="server" Text="Письмова згода боржника - на збір, зберігання, використання та поширення через бюро кредитних історій інформації про боржника"
                        Width="700" Style="text-align: right"></asp:Label>
                </td>
                <td>
                    <bec:DDLList ID="D_p_kl1" runat="server" Width="155" Visible="true" OnValueChanged="Changed_D_p_kl1"
                        Enabled="true" IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="L_p_kl2" runat="server" Text="До бюро кредитних історій відомості про боржника – за наявності в договорі відповідної згоди"
                        Width="700" Style="text-align: right"></asp:Label>
                </td>
                <td>
                    <bec:DDLList ID="D_p_kl2" runat="server" Width="155" Visible="true" Enabled="true"
                        IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="L_p_kl3" runat="server" Text="Фінансової звітності боржника – за останній звітний період"
                        Width="700" Style="text-align: right"></asp:Label>
                </td>
                <td>
                    <bec:DDLList ID="D_p_kl3" runat="server" Width="155" Visible="true" Enabled="true"
                        IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="L_p_kl4" runat="server" Text="Проти боржника – юридичної особи порушено справу про банкрутство"
                        Width="700" Style="text-align: right"></asp:Label>
                </td>
                <td>
                    <bec:DDLList ID="D_p_kl4" runat="server" Width="155" Visible="true" Enabled="true"
                        IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="L_p_kl5" runat="server" Text="Боржника визнано банкрутом у встановленому законодавством України порядку"
                        Width="700" Style="text-align: right"></asp:Label>
                </td>
                <td>
                    <bec:DDLList ID="D_p_kl5" runat="server" Width="155" Visible="true" Enabled="true"
                        IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="L_p_klv" runat="server" Text="Боржнику надано кредит в іноземній валюті"
                        Width="700" Style="text-align: center; color: #CC0000; margin-bottom: 0px;"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="L_p_kl6" runat="server" Text="Наявність джерел надходження валютної виручки в обсязі, достатньому для погашення боргу протягом дії договору"
                        Width="700" Style="text-align: right"></asp:Label>
                </td>
                <td>
                    <bec:DDLList ID="D_p_kl6" runat="server" Width="155" Visible="true" Enabled="true"
                        IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <Bars:ImageTextButton ID="Bt_klass" runat="server" Text="Розрахувати Клас" Width="155px"
                        ImageUrl="/Common/Images/default/16/save.png" OnClick="Bt_klass_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="ID2" runat="server" Width="930px" Style="margin-left: 10px; margin-right: 10px;
        margin-bottom: 10px; margin-top: 10px">
        <table width="930" style="border-style: inset; border-width: thin; color: #000080;
            background-color: #F0F0F0;">
            <tr>
                <td>
                    <asp:Label ID="L_FIN23" runat="server" Text="Клас боржника "></asp:Label>
                </td>
                <td>
                    <bec:TextBoxNumb ID="Tb_FIN23" runat="server" Width="115Px" ReadOnly="true" IsRequired="false"
                        OnValueChanged="Tb_fn23_value" />
                </td>
                <td>
                    <asp:Label ID="L_kat23" runat="server" Text="Категорія якості"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxNumb ID="Tb_KAT23" runat="server" ReadOnly="True" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="L_obs" runat="server" Text="Стан обслуговування боргу" />
                </td>
                <td>
                    <bec:DDLList ID="Dl_obs" runat="server" Visible="true" Width="120Px" IsRequired="true">
                    </bec:DDLList>
                </td>
                <td>
                    <asp:Label ID="Lb_K23" runat="server" Text="Значення показника ризику" />
                </td>
                <td>
                    <Bars:NumericEdit ID="N_K23" runat="server" ReadOnly="True" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="L_VNCRR" runat="server" Text="Внутрішній кредитний рейтинг" />
                </td>
                <td>
                    <bec:DDLList ID="DL_VNCRR" runat="server" Visible="true" IsRequired="true" Width="120Px">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel1" runat="server" GroupingText="Розрахунок коефіцієнта покриття боргу"
        Width="930px" Style="margin-left: 10px; margin-right: 10px; margin-bottom: 10px;
        margin-top: 10px">
        <table width="920px">
            <tr>
                <td>
                    <asp:Label runat="server" ID="Lb_N1" Visible="true" Text="Чистий прибуток (збиток), ф. 2 рр. 220–225 гр.3"></asp:Label>
                </td>
                <td class="style4">
                    <Bars:NumericEdit ID="Dn1" runat="server" IsRequired="false" ReadOnly="True" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="Lb_N2" Visible="true" Text="Амортизація необоротних активів, ф. 2 р. 260 (+)"></asp:Label>
                </td>
                <td class="style4">
                    <Bars:NumericEdit ID="Dn2" runat="server" IsRequired="false" ReadOnly="True" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="Lb_N3" Visible="true" Text="Фінансові витрати, ф. 2 р. 140 гр. 3  (+)"></asp:Label>
                </td>
                <td class="style4">
                    <Bars:NumericEdit ID="Dn3" runat="server" MinValue="-999999999" IsRequired="false"
                        ReadOnly="True" />
                </td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label runat="server" ID="Lb_N4" Visible="true" Text="Інші операції, що безпосередньо вплива-ють на чисті грошові потоки від операційної діяльності та не були враховані раніше, за наявності документально підтвердженої інформації (+, –)"></asp:Label>
                </td>
                <td class="style4">
                    <Bars:NumericEdit ID="Dn4" runat="server" IsRequired="false" BackColor="#FFD8CE" />
                </td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label runat="server" ID="Lb_N5" Visible="true" Text="Інші платежі, що впливають на чистий рух коштів від інвестиційної діяльності, за наявності документально підтвердженої інформації  (+,–)"></asp:Label>
                </td>
                <td class="style8">
                    <Bars:NumericEdit ID="Dn5" runat="server" IsRequired="false" BackColor="#FFD8CE" />
                </td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label runat="server" ID="Lb_N6" Visible="true" Text="Чистий грошовий потік за рахунок внутрішніх джерел (сума чистого руху коштів від операційної та інвестиційної діяльності до здійснення фінансових витрат) (=)"></asp:Label>
                </td>
                <td class="style4">
                    <Bars:NumericEdit ID="Dn6" runat="server" IsRequired="false" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label runat="server" ID="Lb_N7" Visible="true" Text="Виплати грошових коштів для погашення отриманих кредитів"></asp:Label>
                </td>
                <td class="style4">
                    <Bars:NumericEdit ID="Dn7" runat="server" IsRequired="false" BackColor="#FFD8CE" />
                </td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label runat="server" ID="Lb_N8" Visible="true" Text="Сплата процентів"></asp:Label>
                </td>
                <td class="style4">
                    <Bars:NumericEdit ID="Dn8" runat="server" IsRequired="false" BackColor="#FFD8CE" />
                </td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label runat="server" ID="Lb_N9" Visible="true" Text="Коефіцієнт покриття боргу: р. 6/(р. 7+ р. 8)"></asp:Label>
                </td>
                <td class="style4">
                    <Bars:NumericEdit ID="DnKPB" runat="server" ReadOnly="true"></Bars:NumericEdit>
                </td>
            </tr>
            <tr>
                <td class="style6">
                    &nbsp;
                </td>
                <td class="style4">
                    <Bars:ImageTextButton ID="Bt11" runat="server" Text="Розрахувати КПБ" Width="155px"
                        OnClick="Bt10_Click" ImageUrl="/Common/Images/default/16/save.png" />
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="Lb1" GroupingText=" " Width="930px" Style="margin-left: 10px;
        margin-right: 10px; margin-bottom: 10px; margin-top: 10px">
        <td class="style6">
            <asp:Label ID="Lb_1" runat="server" Style="margin-left: 10px" Text="Коефіцієнт покриття боргу вважається не достатнім (значення КПБ є меншим за 1). Необхідно заповнити субєктивні показники."
                Width="500px" ForeColor="Red" Height="30px"></asp:Label>
        </td>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnGrid" Style="margin-left: 10px; margin-right: 10px;
        margin-bottom: 10px; margin-top: 10px" Width="1030Px">
        <Bars:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gvMain" runat="server" Width="910Px" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="ND, KOD, IDF, NAME" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="None" ShowPageSizeBox="false" HoverRowCssClass="hoverRow"
            ShowCaption="False">
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
                <Bars:BarsBoundFieldEx DataField="NAME" HeaderText="Назва" />
                <asp:TemplateField HeaderText="Відповідь" FooterStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:DropDownList AppendDataBoundItems="true" DataSource='<%# SQL_SELECT_dataset("select val, name as name from FIN_QUESTION_REPLY where kod=" + ((char)39).ToString() + Eval("KOD") +((char)39).ToString() + "and idf = " +Eval("IDF") + "union all select -99 as val, null as name from dual")%>'
                            DataTextField="NAME" DataValueField="VAL" Text='<%#Eval("S")%>' Visible="true"
                            Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>' Width="480px"
                            IsRequired="false" runat="server">
                        </asp:DropDownList>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Left" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Авт." FooterStyle-HorizontalAlign="Left" Visible="false">
                    <ItemTemplate>
                        <asp:CheckBox runat="server" Enabled="false" Visible="true" Checked='<%# (Convert.ToString(Eval("POB")) == "0")?(false):(true) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="POB" HeaderText="Вираховується" Visible="false" />
            </Columns>
            <RowStyle CssClass="normalRow" />
        </Bars:BarsGridViewEx>
        <table width="910Px">
            <tr>
                <td>
                </td>
                <td class="style4">
                    &nbsp;
                    <Bars:ImageTextButton ID="test" runat="server" Text="Розрахувати ЗПР" Width="155px"
                        OnClick="BtZPR_Click" ImageUrl="/Common/Images/default/16/save.png" Enabled="true" />
                    &nbsp;
                </td>

            </tr>
            <tr>
                <td>
                </td>
                <td class="style4">
                    &nbsp;
                    <Bars:ImageTextButton ID="Bt_Print" runat="server" Text="Друк" Width="155px"
                        OnClick="Bt_Print_Click" ImageUrl="/Common/Images/default/16/print.png" Enabled="true" Visible="false" />
                    &nbsp;
                </td>

            </tr>
            <tr>
                <td class="style6">
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    </form>
</body>
</html>
