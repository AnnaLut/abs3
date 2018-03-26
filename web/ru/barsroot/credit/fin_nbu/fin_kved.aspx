<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fin_kved.aspx.cs" Inherits="credit_fin_nbu_fin_kved" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link type="text/css" rel="stylesheet" href="style/style.css" />--%>
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Panel ID="PnZag" runat="server">
            <table>
                <tr>
                    <td style="width: 25Px">
                    </td>
                    <td>
                        <asp:Label ID="lbOKPO" runat="server" Text="ОКПО:" meta:resourcekey="lbCC_IDResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbOKPO" TabIndex="8" ReadOnly="true" BackColor="Azure"
                            Width="100Px" />
                    </td>
                    <td>
                        <asp:Label ID="LbNMK" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 25Px">
                    </td>
                    <td>
                        <asp:Label ID="lb_kved" runat="server" Text="КВЕД"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:DropDownList ID="DD_ved" runat="server" Width="550Px" TabIndex="1" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:ImageButton ID="BtSave" runat="server" ImageUrl="/common/Images/default/16/save.png"
                            Visible="false" ToolTip="Видалити макет документу" OnClick="Clik_bt_save" OnClientClick="if (!confirm('Зберегти вибраний КВЕД?')) return false;"
                            CausesValidation="false" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="3">
                        <asp:CheckBox ID="CC_CK" runat="server" Text="Позичальник належить до СК" ToolTip="Позичальник належить до страхових компаній"
                            Font-Size="X-Small" Font-Italic="True" AutoPostBack="true" OnCheckedChanged="CC_CK_CheckedChanged"
                            Visible="False" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <asp:Panel ID="Pn1" runat="server" Width="900">
            <table>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td style="width: 25Px" align="center">
                        <asp:Label ID="LbOrp" runat="server" Width="750px" Font-Size="X-Large"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 25Px">
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="/Common/Images/default/16/arrow_left.png"
                            CausesValidation="false" TabIndex="7" ToolTip="повернутись на попередню сторінку"
                            OnClick="backToFolders" Width="16px" />
                    </td>
                    <td>
                        <Bars:Separator ID="Separator2" runat="server" BorderWidth="1px" />
                    </td>
                    <td>
                        <asp:ImageButton ID="bt_insert" runat="server" ImageUrl="/common/Images/default/16/new.png"
                            CausesValidation="false" ToolTip="Додати" OnClick="Clik_bt_insert" />
                    </td>
                    <td>
                        <Bars:Separator ID="Separator1" runat="server" BorderWidth="1px" />
                    </td>
                    <td>
                        <asp:ImageButton ID="bt_edit" runat="server" ImageUrl="/common/Images/default/16/edit.png"
                            CausesValidation="false" ToolTip="Редагувати" OnClick="Clik_bt_edit" />
                    </td>
                    <td>
                        <Bars:Separator ID="Separator3" runat="server" BorderWidth="1px" />
                    </td>
                    <td>
                        <asp:ImageButton ID="bt_del" runat="server" ImageUrl="/common/Images/default/16/delete.png"
                            ToolTip="Видалити" OnClick="Clik_bt_del" OnClientClick="if (!confirm('Видалити КВЕД?')) return false;"
                            CausesValidation="false" />
                    </td>
                    <td>
                        <Bars:Separator ID="Separator4" runat="server" BorderWidth="1px" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="PnKVED" runat="server" Width="900">
            <Bars:BarsGridViewEx AllowPaging="false" ID="DataKved" runat="server"  CssClass="barsGridView"
                Visible="true" AutoGenerateColumns="False" OnRowDataBound="DataDepository_RowDataBound"
                ShowPageSizeBox="false" EnableViewState="true" DataKeyNames="FLAG,ORD" AllowSorting="true"
                Width="880" ShowCaption="false" ShowExportExcelButton="True" ShowFilter="false"
                ShowFooter="true">
                <Columns>
                    <asp:BoundField DataField="KOD" HeaderText="Рядок" HtmlEncode="False">
                        <ItemStyle Wrap="False" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="KVED" HeaderText="Код &lt;BR&gt;за КВЕД-2010" HtmlEncode="False">
                        <ItemStyle Wrap="False" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NAME" HeaderText="Найменування виду &lt;BR&gt;економічної діяльності"
                        HtmlEncode="False">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="VOLME_SALES" HeaderText="Обсяг реалізованої продукції &lt;BR&gt;(товарів, послуг) без ПДВ"
                        HtmlEncode="False" DataFormatString="{0:F}">
                        <ItemStyle Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="WEIGHT" HeaderText="Питома вага &lt;BR&gt;%" HtmlEncode="False">
                        <ItemStyle Wrap="False" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="Im4" runat="server" Visible='<%# (Convert.ToString(Eval("ERR")).Length == 0)?(false):(true) %>'
                                            ToolTip='<%# Eval("ERR")%>' ImageUrl="/Common/Images/default/16/warning.png"  Height="15Px" Width="15Px"  />
                                    </ItemTemplate>
                                </asp:TemplateField>
                </Columns>
                <FooterStyle CssClass="footerRow" />
                <HeaderStyle CssClass="headerRow" />
                <EditRowStyle CssClass="editRow" />
                <PagerStyle CssClass="pagerRow" />
                <SelectedRowStyle CssClass="selectedRow" />
                <AlternatingRowStyle CssClass="alternateRow" />
                <RowStyle CssClass="normalRow" />
            </Bars:BarsGridViewEx>
        </asp:Panel>
        <br />
        <br />
        <asp:Panel ID="pnrekv" runat="server" Width="750Px" BackColor="#ECF0F9" Visible="false"
            BorderStyle="Outset" Style="margin-left: 50px;">
            <br />
            <table width="700Px">
                <tr>
                    <td style="width: 10%">
                    </td>
                    <td style="width: 40%">
                        <asp:Label ID="Lb_kod" runat="server" Text="Рядок"></asp:Label>
                        &nbsp;<span class="style1">*</span>
                    </td>
                    <td style="width: 50%">
                        <asp:DropDownList ID="dl_kod" runat="server" Width="350Px" TabIndex="1" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%">
                    </td>
                    <td style="width: 40%">
                        <asp:Label ID="Lb_TT" runat="server" Text="Код за КВЕД-2010"></asp:Label>
                        &nbsp;<span class="style1">*</span>
                    </td>
                    <td style="width: 50%">
                        <asp:DropDownList ID="dl_kved" runat="server" Width="350Px" TabIndex="1" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 10%">
                    </td>
                    <td style="width: 40%">
                        <asp:Label ID="Lb_sump" runat="server" Text="Обсяг реалізованої продукції &lt;BR&gt;(товарів, послуг) без ПДВ"></asp:Label>&nbsp;<span
                            class="style1"></span>
                    </td>
                    <td style="width: 50%">
                        <asp:TextBox ID="tb_sump" runat="server" Width="170Px" MaxLength="10" TabIndex="7"
                            Style="text-align: right">
                        </asp:TextBox>
                    </td>
                    <td>
                        <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" Display="Dynamic"
                            ControlToValidate="tb_sump" ValidationExpression=">(^(\ |\-)(0|([1-9][0-9]*))([\.\,][0-9]{0,2})?$)|(^(0{0,1}|([1-9][0-9]*))([\.\,][0-9]{0,2})?$)"
                            SetFocusOnError="true" BackColor="Yellow" ToolTip="Не вірний формат суми">Помилка</asp:RegularExpressionValidator>
                    </td>
                </tr>
            </table>
            <br />
            <table width="600Px">
                <tr>
                    <td style="text-align: center">
                        <asp:Button ID="bt_Ok" runat="server" Text="Зберегти" OnClick="bt_Ok_Click" TabIndex="9" />
                    </td>
                    <td style="text-align: center">
                        <asp:Button ID="bt_Cancel" runat="server" Text="Відмінити" OnClick="bt_Cancel_Click"
                            CausesValidation="false" />
                    </td>
                </tr>
            </table>
            <br />
        </asp:Panel>
    </div>
    <asp:HiddenField ID="KOD_" runat="server" />
    <asp:HiddenField ID="KVED_" runat="server" />
    <asp:HiddenField ID="SS_" runat="server" />
    <asp:HiddenField ID="FLAG_" runat="server" />
    <asp:HiddenField ID="ORD_" runat="server" />
    <asp:HiddenField ID="OKPO_" runat="server" />
    <asp:HiddenField ID="DAT_" runat="server" />
    <asp:HiddenField ID="DATP_" runat="server" />
    <asp:HiddenField ID="RNK_" runat="server" />
    <asp:HiddenField ID="hRefList" runat="server" />
    </form>
</body>
</html>
