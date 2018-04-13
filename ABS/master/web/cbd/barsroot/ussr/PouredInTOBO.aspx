<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PouredInTOBO.aspx.cs" Inherits="ussr_PouredInTOBO" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Влиті філії</title>
    <link href="/Common/CSS/AppCSS.css" rel="Stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="JScript/PouredInTOBO.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="title">Філії</td>
                </tr>
                <tr>
                    <td style="padding-bottom: 10px">
                        <Bars:BarsSqlDataSource ID="sdsMain" runat="server" ProviderName="barsroot.core"
                            PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;"
                            SelectCommand="select a.num, a.branch, b.name from alegrob a, branch b where a.BRANCH = b.BRANCH order by num" />
                        <Bars:BarsGridView ID="gvMain" runat="server" 
                        DataKeyNames="BRANCH" 
                        DataSourceID="sdsMain" 
                        AutoGenerateColumns="False" 
                        AllowPaging="True" 
                        MergePagerCells="True" 
                        ShowFilter="True" 
                        OnSelectedIndexChanged="gvMain_SelectedIndexChanged" 
                        AllowSorting="True">
                            <Columns>
                                <asp:CommandField HeaderText="Показати влиті філії" InsertVisible="False" SelectText="Вибрати"
                                    ShowCancelButton="False" ShowSelectButton="True">
                                    <headerstyle width="100px" />
                                    <itemstyle horizontalalign="Center" />
                                </asp:CommandField>
                                <asp:BoundField DataField="NUM" HeaderText="Ідентифікатор" SortExpression="NUM" />
                                <asp:BoundField DataField="BRANCH" HeaderText="Підрозділ" SortExpression="BRANCH" />
                                <asp:BoundField DataField="NAME" HeaderText="Найменування" SortExpression="NAME" />
                            </Columns>
                            <SelectedRowStyle BackColor="#E0E0E0" />
                        </Bars:BarsGridView>
                    </td>
                </tr>
                <tr>
                    <td class="title">Влиті філії</td>
                </tr>
                <tr>
                    <td style="padding-bottom: 10px">
                        <Bars:BarsSqlDataSource ID="sdsChilds" ProviderName="barsroot.core" runat="server" PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;" />
                        <Bars:BarsGridView ID="gvChilds" runat="server" DataSourceID="sdsChilds" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="NUM" HeaderText="Ідентифікатор" />
                                <asp:BoundField DataField="NAME" HeaderText="Найменування" />
                            </Columns>
                        </Bars:BarsGridView>
                    </td>
                </tr>
                <tr id="trAddTitle" runat="server">
                    <td class="title">Додати нову філію</td>
                </tr>
                <tr id="trAdd" runat="server">
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width: 50%; text-align: right; padding-right: 5px; padding-top: 10px">Ідентифікатор</td>
                                <td style="padding-top: 10px"><asp:TextBox ID="edNum" runat="server" MaxLength="11" onkeypress="return VerifyNum(this.value, event.keyCode)"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="text-align: right; padding-right: 5px">Найменування</td>
                                <td><asp:TextBox ID="edName" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center; padding-top: 10px"><asp:Button ID="btAdd" runat="server" Text="Додати" OnClick="btAdd_Click" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>        
        </div>
    </form>
</body>
</html>
