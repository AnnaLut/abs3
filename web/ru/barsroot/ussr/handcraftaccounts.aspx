<%@ Page Language="C#" AutoEventWireup="true" CodeFile="handcraftaccounts.aspx.cs" Inherits="ussr_handcraftaccounts" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Рахунки для ручного розбору</title>
    <link href="/Common/CSS/AppCSS.css" rel="Stylesheet" type="text/css" />
    <link href="/Common/CSS/BarsGridView.css" rel="Stylesheet" type="text/css" />    
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>                            
                        <asp:Panel ID="pnlBranch" runat="server" GroupingText="Пiдроздiл" >
                            <table width="100%">
                                <tr>
                                    <td style="width: 10%">
                                        <asp:Label ID="lbBranch" runat="server" Text="ТВБВ : "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox id="edBranch" style="width: 250px" runat="server"
                                                onclick="var res = window.showModalDialog('dialog.aspx?type=metatab&tabname=BRANCH&tail=\'\'&role=WR_USSR_TECH', 'dialogHeight:600px; dialogWidth:800px'); if (null!=res) document.getElementById('edBranch').value=res[0];"/>
                                    </td>
                                    <td style="width: 90%">
                                        <asp:ImageButton ID="btRefresh" runat="server" AlternateText="Поновити данні" ImageUrl="/common/images/default/16/refresh.png" Height="16px" OnClick="btRefresh_Click" Width="16px" ImageAlign="Middle"/>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="Panel1" runat="server" GroupingText="Рахунки для ручного розбору" >
                            <table width="100%">
                                <tr>
                                    <td style="padding-top: 5px; padding-bottom: 5px">
                                        <Bars:BarsGridView ID="gv" runat="server" DataSourceID="ds" AllowPaging="True" OnRowCommand="gv_RowCommand">
                                            <FooterStyle CssClass="footerRow" />
                                            <HeaderStyle CssClass="headerRow" />
                                            <EditRowStyle CssClass="editRow" />
                                            <PagerStyle CssClass="pagerRow" />
                                            <AlternatingRowStyle CssClass="alternateRow" /> 
                                            <Columns>
                                                <asp:TemplateField>
                                                    <itemtemplate>
                                                        <asp:ImageButton id="btEqual" runat="server" Width="16px" ImageUrl="/common/images/default/16/options.png" AlternateText="Зрівняти" Height="16px" CommandName="EQUAL" CommandArgument='<% Eval("ID") %>'></asp:ImageButton> 
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="NEW_DBCODE" HeaderText="DBCODE" />
                                                <asp:BoundField DataField="PASP_A" HeaderText="Паспорт" />
                                                <asp:BoundField DataField="ICOD_A" HeaderText="Идент. код" />
                                                <asp:BoundField DataField="NMK_A" HeaderText="Наименование" />
                                                <asp:BoundField DataField="NSC" HeaderText="№ счета" />
                                                <asp:BoundField DataField="OST_A" HeaderText="Вход. остаток" />
                                                <asp:BoundField DataField="ROL_A" HeaderText="Обороты" />
                                                <asp:BoundField DataField="FILE_NAME" HeaderText="Имя файла" />
                                                <asp:BoundField HeaderText="|" NullDisplayText="|" />
                                                <asp:BoundField DataField="PASP_B" HeaderText="Паспорт (реестр)" />
                                                <asp:BoundField DataField="ICOD_B" HeaderText="Идент. код (реестр)" />
                                                <asp:BoundField DataField="NMK_B" HeaderText="Наименование (реестр)" />
                                                <asp:BoundField DataField="OST_B" HeaderText="Вход. остаток (реестр)" />
                                                <asp:BoundField DataField="ROL_B" HeaderText="Обороты (реестр)" />
                                            </Columns>
                                            <EmptyDataTemplate>
                                                Нет данных для отображения
                                            </EmptyDataTemplate>
                                        </Bars:BarsGridView>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
            <Bars:BarsSqlDataSource ID="ds" runat="server" ProviderName="barsroot.core"
                SelectCommand="select * from bars.ussr_collation_compared_data where BRANCH = :pbrch">
                <SelectParameters>
                    <asp:controlparameter name="pbrch" controlid="edBranch" propertyname="Text"/>
                </SelectParameters>
            </Bars:BarsSqlDataSource>
        </div>
    </form>
</body>
</html>
