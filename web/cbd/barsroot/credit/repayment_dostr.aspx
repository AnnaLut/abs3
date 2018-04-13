<%@ Page Language="C#" AutoEventWireup="true" CodeFile="repayment_dostr.aspx.cs"
    Inherits="credit_repayment_dostr" meta:resourcekey="PageResource1" Theme="default" %>

<%@ Register Src="usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="usercontrols/loading.ascx" TagName="loading" TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Дострокове погашення кредиту</title>
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript">
        function ShowPayDialog(url) {
            ProgressMode(true);
            var rnd = Math.random();
            var result = window.showModalDialog(url + '&rnd=' + rnd, window, 'dialogHeight:600px; dialogWidth:600px');
            ProgressMode(false);

            window.location.replace('/barsroot/credit/repayment_dostr.aspx');
        }
        function ProgressMode(flag) {
            var val = (flag ? 'block' : 'none');
            document.getElementById('Progress').style.display = val;
        }
    </script>
    <script language="javascript" type="text/javascript" src="jscript/JScript.js"></script>
    <style type="text/css">
        #Div2
        {
            height: 134px;
            width: 940px;
        }
        .style1
        {
            width: 104px;
            text-align: right;
        }
        .style3
        {
            width: 377px;
        }
        .style4
        {
            width: 109px;
            text-align: right;
        }
        #dvEdits2
        {
            height: 113px;
        }
        .style5
        {
            width: 351px;
        }
        .style6
        {
            width: 368px;
        }
        .style7
        {
            width: 113px;
        }
        .style8
        {
            width: 134px;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Дострокове погашення кредиту"></asp:Label>
    </div>
    <div style="padding: 10px 0px 10px 10px">
        <table border="0" cellpadding="5" cellspacing="0">
            <tr>
                <td class="style8">
                    <asp:Label ID="lbND" runat="server" Text="Референс угоди  : " Font-Size="Medium"
                        Font-Underline="true"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxString ID="tbsCC_ID" runat="server" IsRequired="True" MaxLength="20"
                        meta:resourcekey="tbsCC_IDResource1" ValidationGroup="Search"></bec:TextBoxString>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    <asp:ImageButton ID="ibSearch" runat="server" AlternateText="Искать" ImageUrl="/Common/Images/default/16/find.png"
                        ToolTip="Искать" OnClick="ibSearch_Click" meta:resourcekey="ibSearchResource1"
                        CausesValidation="true" ValidationGroup="Search" Height="16" Width="16" />
                </td>
                <td>
                </td>
                <td>
                    <asp:ImageButton ID="PB_NLSKD" runat="server" ToolTip="Перегляд рахунків угоди" ImageUrl="/Common/Images/details.gif"
                        BorderStyle="Outset" BorderWidth="2Px" Height="16" Width="16" OnClick="PB_NLSKD_CLICK" />
                </td>
                <td>
                    <asp:ImageButton ID="pb_GPK_NEW" runat="server" ToolTip="Діюча версія ГПК" ImageUrl="/Common/Images/CHEKIN.gif"
                        BorderStyle="Outset" BorderWidth="2px" Height="16" Width="16" OnClick="pb_GPK_NEW_Click" />
                </td>
                <td>
                    <asp:ImageButton ID="pb_GPK_OLD" runat="server" ToolTip="Попередня версія ГПК" ImageUrl="/Common/Images/browse.gif"
                        BorderStyle="Outset" BorderWidth="2px" Height="16" Width="16" OnClick="pb_GPK_OLD_Click" />
                </td>
                <td>
                    <asp:ImageButton ID="pb_del" runat="server" ToolTip="Повернути з архіву попередню версію ГПК та сторнувати документ"
                        ImageUrl="/Common/Images/grid_delete.gif" BorderStyle="Outset" BorderWidth="2px"
                        Height="16" Width="16" OnClientClick="if (!confirm('Повернути з архіву попередню версію ГПК та сторнувати документ?')) return false;"
                        OnClick="pb_del_Click" />
                </td>
                <td class="style7">
                    <%--    <asp:Label ID="lbFIO" runat="server"    Visible="true" Font-Size=Medium></asp:Label>--%>
                </td>
            </tr>
        </table>
        &nbsp;
        <asp:Label ID="lbFIO" runat="server" Visible="true" Font-Size="Medium" Font-Underline="true"></asp:Label>
    </div>
    <div id="dvEdits" runat="server" visible='<%# rp_dosr.HasData_dosr %>' style="padding: 10px 0px 10px 10px;
        border-top: solid 1px #94ABD9; border-top-width: medium; border-top-style: double;
        width: 517px;">
        <table width="950Px">
            <tr>
                <td style="width: 56%">
                    <table border="2" cellpadding="5" cellspacing="0" style="width: 516px" dir="ltr"
                        frame="border" title="Інфо-блок «Заборгованість»">
                        <tr>
                            <td class="style3">
                                <asp:Label ID="Label2" runat="server" Text="Прострочки "></asp:Label>
                                &nbsp;
                            </td>
                            <td class="style4">
                                <%-- <bec:TextBoxDecimal ID="Label5" runat="server" Value='<%# rp.Z1 %>'/>--%>
                                <asp:Label ID="Label5" runat="server" Text='<%# rp_dosr.Z1 %>'></asp:Label>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style3">
                                <asp:Label ID="Label6" runat="server" Text="Поточні %% "></asp:Label>
                            </td>
                            <td class="style4">
                                <asp:Label ID="Label7" runat="server" Text='<%# rp_dosr.Z2 %>'></asp:Label>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style3">
                                <asp:Label ID="Label8" runat="server" Text="Черговий платіж <<тіло кредиту>> "></asp:Label>
                                &nbsp;
                            </td>
                            <td class="style4">
                                <asp:Label ID="Label9" runat="server" Text='<%# rp_dosr.Z3 %>'></asp:Label>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style3">
                            </td>
                            <td class="style4">
                            </td>
                        </tr>
                        <tr>
                            <td class="style3">
                                <asp:Label ID="Label10" runat="server" Text="Разом обов`язкового платежу"></asp:Label>
                                &nbsp;
                            </td>
                            <td class="style4">
                                <asp:Label ID="Label11" runat="server" Text='<%# rp_dosr.Z4 %>'></asp:Label>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style3">
                                <asp:Label ID="Label12" runat="server" Text="Плановий залишок по тілу"></asp:Label>
                                &nbsp;
                            </td>
                            <td class="style4" rowspan="1">
                                <asp:Label ID="Label13" runat="server" Text='<%# rp_dosr.Z5 %>'></asp:Label>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="border-style: outset; border-width: medium">
                    <asp:TextBox ID="tb_branch" runat="server" Text='<%# rp_dosr.branch_ %>' Enabled="false"></asp:TextBox>
                    <asp:Label ID="lb_branch" runat="server" Text="Бранч" Enabled="False"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_sdat" runat="server" Text='<%# rp_dosr.sdat_ %>' Enabled="false"></asp:TextBox>
                    <asp:Label ID="lb_sdat" runat="server" Text="Поч. дата" Enabled="false"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_wdat" runat="server" Text='<%# rp_dosr.wdat_ %>' Enabled="false"></asp:TextBox>
                    <asp:Label ID="lb_wdat" runat="server" Text="Кін. дата" Enabled="false"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_dat_prev" runat="server" Text='<%# rp_dosr.dat_prev_ %>' Enabled="false"></asp:TextBox>
                    <asp:Label ID="Lb_dat_prev" runat="server" Text="Попередня платіжна дата" Enabled="false"></asp:Label>
                    <br />
                    <asp:TextBox ID="tb_dat_next" runat="server" Text='<%# rp_dosr.dat_next_ %>' Enabled="false"></asp:TextBox>
                    <asp:Label ID="lb_dat_next" runat="server" Text="Наступна платіжна дата" Enabled="false"></asp:Label>
                    <br />
                    <asp:TextBox ID="Tb_glbd" runat="server" Text='<%# rp_dosr.glbd_ %>' Enabled="false"></asp:TextBox>
                    <asp:Label ID="Lb_glbd" runat="server" Text="Банківська дата" Enabled="false"></asp:Label>
                    <br />
                    <asp:TextBox ID="Tb_dat_mod" runat="server" Text='<%# rp_dosr.dat_mod_ %>' Enabled="false"></asp:TextBox>
                    <asp:Label ID="lb_dat_mod" runat="server" Text="Попередня дата модифікації" Enabled="false"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvEdits1" runat="server" visible='<%# rp_dosr.HasData_dosr %>' style="border-bottom: thick outset #94ABD9;
        padding: 10px 0px 10px 10px; border-top: thick outset #94ABD9; width: 517px;
        border-color: #94ABD9; border-width: medium; border-bottom-style: double; border-top-style: double;"
        title="Інфо-Блок «Ресурс»">
        <table border="2" cellpadding="5" cellspacing="2" style="width: 515px">
            <tr>
                <td style="font-weight: 700; font-style: italic" class="style6">
                    <asp:Label ID="Label1" runat="server" Text="Загальний ресурс <<2620>>"></asp:Label>
                    &nbsp;
                </td>
                <td class="style1">
                    <asp:Label ID="Label3" runat="server" Text='<%# rp_dosr.R1 %>' Style="font-weight: 700"
                        Width="93px"></asp:Label>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label ID="Label4" runat="server" Text="Вільний ресурс <<2620>>" Style="font-weight: 700;
                        font-style: italic"></asp:Label>
                    &nbsp;
                </td>
                <td class="style1">
                    <asp:Label ID="Label14" runat="server" Text='<%# rp_dosr.R2 %>' Style="font-weight: 700"
                        Width="93px"></asp:Label>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style6">
                    <asp:Label ID="Label18" runat="server" Text="Графік погашення КД" Style="font-weight: 700;
                        font-style: italic"></asp:Label>
                    &nbsp;
                </td>
                <td class="style1">
                    <%--                        <asp:Label ID="LbGPK" runat="server"  
                        style="font-weight: 700"  Width="93px" Visible="false" ></asp:Label>
                    &nbsp;--%>
                    <asp:DropDownList ID="drl_gpl" runat="server" Enabled="false" Visible="true" Width="100Px">
                        <asp:ListItem Value="0" Text="Класичний"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Антуїтет"></asp:ListItem>
                        <asp:ListItem Value="" Text="" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvEdits2" runat="server">
        <table border="0" cellpadding="5" cellspacing="0" style="width: 527px">
            <tr>
                <td class="style5">
                    <asp:Label ID="Label15" runat="server" Text="«Сума для дострокового погашення»" Style="font-weight: 700;
                        font-style: italic; color: #000066;"></asp:Label>
                </td>
                <td class="style1">
                    <bec:TextBoxDecimal ID="K1" runat="server" IsRequired="True" Enabled='<%# rp_dosr.R2 > 0 %>'
                        Value='<%# (rp_dosr.K1>0)?(rp_dosr.K1):(0) %>' MaxValue='<%# (rp_dosr.K1>0)?(rp_dosr.K1):(0) %>'>
                    </bec:TextBoxDecimal>
                </td>
            </tr>
            <tr>
                <td class="style5">
                    <asp:Label ID="Label16" runat="server" Text="«Платіжний день»" Style="font-weight: 700;
                        font-style: italic; color: #000066;"></asp:Label>
                </td>
                <td class="style1">
                    <bec:TextBoxNumb ID="K2" runat="server" IsRequired="True" Value='<%# rp_dosr.DD %>'
                        MaxValue="31"></bec:TextBoxNumb>
                </td>
            </tr>
            <tr>
                <td class="style5">
                    <asp:Label ID="Label17" runat="server" Text="«Зі збереженням ?» " Style="font-weight: 700;
                        font-style: italic; color: #000066;"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="K3" runat="server" Width="150px">
                        <asp:ListItem Value="0" meta:resourcekey="ListItem1">Терміну</asp:ListItem>
                        <asp:ListItem Selected="True" Value="1" meta:resourcekey="ListItem2">Суми платежу</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbRef" runat="server" Font-Size="Medium"></asp:Label>
                    <asp:HyperLink ID="LinREF" runat="server" Target="_blank" Font-Size="Medium">[LinREF]</asp:HyperLink>
                </td>
                <td>
                    <asp:Button ID="btPay" meta:resourcekey="btPayResource1" Text="Сплатити" runat="server"
                        OnClick="btPay_Click" OnClientClick="if (!confirm('Проивести оплату?')) return false;"
                        ToolTip="Виконати дострокове погашення + Побудова ГПК" Width="100Px" Visible='<%# rp_dosr.R2 >0 %>' />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="btPgpk" meta:resourcekey="btPayResource1" Text="Зміна ГПК" runat="server"
                        OnClick="btPgpk_Click" OnClientClick="if (!confirm('Побудувати новий ГПК?')) return false;"
                        ToolTip=" Побудова нового ГПК " Width="100Px" />
                </td>
            </tr>
        </table>
    </div>
    <div id="Progress" style="display: none">
        <bec:loading ID="lProgress" runat="server" />
    </div>
    </form>
</body>
</html>
