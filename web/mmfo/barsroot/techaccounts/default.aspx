<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" EnableViewState="true"  Inherits="_Default" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.DataComponents, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Технічні рахунки: Портфель</title>
    <link href="style/style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="script/JScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="MainTable">
    <tr>
        <td align="center" colspan="6">
            <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" Text="Технічні рахунки: Портфель"></asp:Label>
        </td>
    </tr>
    <tr>
        <td style="width:5%" align="left">
        </td>
        <td style="width:20%">
            <asp:Label ID="lbFio" CssClass="InfoText" runat="server" Text="ПІБ"></asp:Label>
        </td>
        <td style="width:20%">
            <asp:Label ID="lbCode" runat="server" CssClass="InfoText" Text="Ідентифікаційний код"></asp:Label>
        </td>
        <td style="width:15%">
            <asp:Label ID="lbDptNum" runat="server" CssClass="InfoText" Text="Номер вкладу"></asp:Label>
        </td>
        <td style="width:20%">
            <asp:Label ID="lbTechAcc" runat="server" CssClass="InfoText" Text="Номер технічного рахунку"></asp:Label>
        </td>
        <td style="width:20%">
            <asp:Label ID="lbBranch" runat="server" CssClass="InfoText" Text="Відділення"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            <asp:ImageButton ID="btSearch" runat="server" CssClass="ImgButton" ImageUrl="\Common\Images\briefcase_look.gif" OnClick="btSearch_Click" ToolTip="Пошук" TabIndex="6" /></td>
        <td>
            <asp:TextBox ID="textFIO" CssClass="InfoText" runat="server" TabIndex="1"></asp:TextBox>
        </td>
        <td>
            <asp:TextBox ID="textID" runat="server" CssClass="InfoText" TabIndex="2"></asp:TextBox>
        </td>
        <td>
            <asp:TextBox ID="textDptId" runat="server" CssClass="InfoText" TabIndex="3"></asp:TextBox>
        </td>
        <td>
            <asp:TextBox ID="textTechNls" runat="server" CssClass="InfoText" TabIndex="4"></asp:TextBox>
        </td>
        <td style="width:20%">
            <asp:DropDownList ID="ddBranch" runat="server" CssClass="BaseDropDownList" TabIndex="5">
            </asp:DropDownList></td>        
    </tr>
    <tr>
        <td colspan="6">
            <bars:barsgridview id="gvTechAccounts" runat="server" allowpaging="True" allowsorting="True"
                cssclass="BaseGrid" AutoGenerateColumns="False" CellPadding="2" DataSourceID="dsTechAccounts" DateMask="dd/MM/yyyy" MergePagerCells="True">
<PagerSettings PageButtonCount="5"></PagerSettings>
                <Columns>
                    <asp:BoundField DataField="TECH_ACCNUM" HeaderText="№ тех. рах." SortExpression="TECH_ACCNUM" HtmlEncode="False">
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TECH_DAT_OPEN" HeaderText="Дата відкриття" SortExpression="TECH_DAT_OPEN">
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TECH_DAT_END_PLAN" HeaderText="Планове закриття" SortExpression="TECH_DAT_END_PLAN"
                        Visible="False" />
                    <asp:BoundField DataField="TECH_DAT_END_FACT" HeaderText="Фактичне закриття" SortExpression="TECH_DAT_END_FACT"
                        Visible="False" />
                    <asp:BoundField DataField="TECH_SALDO" HeaderText="Залишок" SortExpression="TECH_SALDO">
                        <itemstyle horizontalalign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TECH_CURRENCY" HeaderText="Валюта" SortExpression="TECH_CURRENCY">
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TECH_CUSTNUM" HeaderText="РНК клієнта" SortExpression="TECH_CUSTNUM">
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TECH_CUSTOMER" HeaderText="Клієнт" SortExpression="TECH_CUSTOMER">
                        <itemstyle horizontalalign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TECH_CUSTID" HeaderText="Ід. код" SortExpression="TECH_CUSTID">
                        <itemstyle horizontalalign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DPT_NUM" HeaderText="№ депозиту" SortExpression="DPT_NUM">
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DPT_DAT_BEGIN" HeaderText="Відкр. деп." SortExpression="DPT_DAT_BEGIN">
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DPT_DAT_END" HeaderText="Заверш. деп." SortExpression="DPT_DAT_END">
                        <itemstyle horizontalalign="Center" />
                    </asp:BoundField>
                </Columns>
</bars:barsgridview>
        </td>
    </tr>
    </table>
        <Bars:barssqldatasource ID="dsTechAccounts" ProviderName="barsroot.core" runat="server" OldValuesParameterFormatString="original_{0}">
        </Bars:barssqldatasource>
    </form>
        <script type="text/javascript" language="javascript">
				document.getElementById("textID").attachEvent("onkeydown",doNum);
			    document.getElementById("textDptId").attachEvent("onkeydown",doNum);
                var oldonload = window.onload;
                window.onload = function() 
                {
                   if (oldonload)   oldonload();
                   focusControl('textFIO');
                }       
	    </script>
</body>
</html>
