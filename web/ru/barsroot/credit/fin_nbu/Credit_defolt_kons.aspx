<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Credit_defolt_kons.aspx.cs"
    Inherits="credit_fin_nbu_Credit_drfolt_kons" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<%@ Register Src="~/UserControls/LabelTooltip.ascx" TagName="LabelTooltip" TagPrefix="Lab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .navigationButton
        {
            padding: 3px;
            border: 1px solid #29acf7;
            background: white;
        }
        .navigationButton:hover
        {
            background: #29acf7;
            color: white;
            cursor: pointer;
        }
        .sideBar
        {
            margin-top: 20px;
        }
        .navigation
        {
            padding-top: 10px;
            text-align: center;
            font-style: italic;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Panel ID="Pn_Wizar0" runat="server">
            <asp:HiddenField ID="RNK_" runat="server" />
            <asp:HiddenField ID="OKPO_" runat="server" />
            <asp:HiddenField ID="ND_" runat="server" />
            <table>
                <tr>
                    <td style="width: 155Px">
                        <asp:Label ID="lb_nmk" runat="server" Text="Назва клієнта" Width="155px"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="Tb_nmk" runat="server" ReadOnly="True" Enabled="False" Width="420px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Lb_okpo" runat="server" Text="Код ОКПО"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="Tb_okpo" runat="server" Enabled="False" 
                            style="text-align: center"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="Lb_date_open" runat="server" Text="Дата реєстрації Контрагента" Width="120px" Visible="false"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TB_Date_open" runat="server" Enabled="False" Visible="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Lb_dat" runat="server" Text="Звітний період Ф1(Ф2)"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TB_Dat" runat="server" Enabled="False" 
                            style="text-align: center"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Pn2" runat="server" Visible="false">
                <table>
                    <tr>
                        <td style="width: 380Px">
                            <asp:Label ID="Lb_clas" runat="server" Text="Клас визначений з інтегрального показника "></asp:Label>
                        </td>
                        <td style="width: 100Px">
                            <asp:TextBox ID="Tb_clas" runat="server" Enabled="true" ReadOnly="true" Width="100px"
                                CssClass="navigation" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 380Px">
                            <asp:Label ID="Lb_cls" runat="server" Text="Зкорегований клас"></asp:Label>
                        </td>
                        <td style="width: 100Px">
                            <asp:TextBox ID="Tb_cls" runat="server" Enabled="true" ReadOnly="true" Width="100px"
                                CssClass="navigation"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <h3 style="color: #000080; font-family: 'Times New Roman', Times, serif; font-style: italic;">
                Показники високого кредитного ризику</h3>
            <table>
                <tr>
                    <td style="width: 580Px">
                        <asp:Label ID="Lb_Kzdv" runat="server" Text="Чиста кредитна заборгованість до чистої виручки від реалізації"></asp:Label>
                    </td>
                    <td style="width: 100Px">
                        <asp:TextBox ID="Tb_Kzdv" runat="server" Width="100px" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 580Px">
                        <asp:Label ID="Lb_Kzde" runat="server" Text="Чиста кредитна заборгованість до значення EBITDA"></asp:Label>
                    </td>
                    <td style="width: 100Px">
                        <asp:TextBox ID="Tb_Kzde" runat="server" Width="100px" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <asp:GridView ID="GrWiz2_kl" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
                DataKeyNames="KOD,IDF,NAME,POB" BorderColor="#EFF3FB" ShowHeader="False" Width="730Px">
                <Columns>
                    <asp:BoundField DataField="NAME" HtmlEncode="False" ItemStyle-Width="600Px">
                        <ItemStyle Wrap="True" HorizontalAlign="Left" Width="600px" Font-Italic="True" />
                    </asp:BoundField>
                    <asp:TemplateField ItemStyle-Width="110Px">
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList1" AppendDataBoundItems="true" DataSource='<%# SQL_SELECT_dataset(""+Eval("L_SQL")+"")%>'
                                DataTextField="NAME" DataValueField="VAL" Text='<%#Eval("S")%>' Enabled='<%# (Convert.ToString(Eval("POB")) == "1")?(false):(true) %>'
                                Width="100px" runat="server" ToolTip='<%# Eval("DESCRIPT")%>' Visible="true">
                            </asp:DropDownList>
                        </ItemTemplate>
                        <FooterStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="20Px">
                        <ItemTemplate>
                            <asp:Image ID="Im4" runat="server" Visible='<%# (Convert.ToString(Eval("DESCRIPT")).Length == 0)?(false):(true) %>'
                                ToolTip='<%# Eval("DESCRIPT")%>' ImageUrl="/Common/Images/default/16/help2.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <table>
                <tr>
                    <td style="width: 480Px">
                    </td>
                    <td style="width: 100Px">
                        <asp:Button ID="Bt_run" runat="server" CssClass="navigationButton" Text="Зберегти"
                            Height="40px" Width="100Px" OnClick="Bt_run_Click" ToolTip="Здійснити коригування класу групи під спільним контролем" />
                    </td>
                    <td style="width: 100Px">
                        <asp:Button ID="But_red_Kl" runat="server" CssClass="navigationButton" Text="Картка
позичальника"
                            Height="40px" Width="100Px" OnClick="BtI_Cardkl_Click" ToolTip="Перейти до картки фінстану позичальника" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </div>
    </form>
</body>
</html>
