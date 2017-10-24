<%@ Page Language="C#" AutoEventWireup="true" CodeFile="showdoc.aspx.cs" Inherits="ussr_deposit_showdoc" meta:resourcekey="PageResource1"%>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
        <base target="_self" />
		<title>Компенсаційні вклади</title>
		<script type="text/javascript" language="javascript" src="js/func.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/sign.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/Sign.js"></script>
		<link href="css/dpt.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript" language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>
        <table class="MainTable">
            <tr>
                <td>
                    <cc1:imagetextbutton id="btRefresh" runat="server" imageurl="\Common\Images\default\16\refresh.png"
                        onclick="btRefresh_Click" text="Перечитати" EnabledAfter="0" meta:resourcekey="btRefreshResource1" ToolTip="Перечитати"></cc1:imagetextbutton>
                </td>
            </tr>
            <tr>
                <td>
                    <bars:barsgridview id="gridDocs" runat="server" allowpaging="True" allowsorting="True"
                        autogeneratecolumns="False" cssclass="BaseGrid" datasourceid="dsDptDocs" datemask="dd/MM/yyyy"
                        onrowdatabound="gridDocs_RowDataBound" showpagesizebox="True" meta:resourcekey="gridDocsResource1"><Columns>
<asp:BoundField DataField="REF" SortExpression="REF" HeaderText="Референс" meta:resourcekey="BoundFieldResource1" HtmlEncode="False">
    <itemstyle horizontalalign="Center" />
</asp:BoundField>
<asp:BoundField DataField="DATD" SortExpression="to_date(DATD,'dd/MM/yyyy')" HeaderText="Дата документа" meta:resourcekey="BoundFieldResource2">
    <itemstyle horizontalalign="Center" />
</asp:BoundField>
<asp:BoundField DataField="NLS_A" SortExpression="NLS_A" HeaderText="Рахунок А" meta:resourcekey="BoundFieldResource3">
    <itemstyle horizontalalign="Left" />
</asp:BoundField>
<asp:BoundField DataField="KV_A" SortExpression="KV_A" HeaderText="Вал. А" meta:resourcekey="BoundFieldResource4">
    <itemstyle horizontalalign="Center" />
</asp:BoundField>
<asp:BoundField DataField="S_A" SortExpression="to_number(S_A)" HeaderText="Сума А" meta:resourcekey="BoundFieldResource5">
    <itemstyle horizontalalign="Right" />
</asp:BoundField>
<asp:BoundField DataField="NLS_B" SortExpression="NLS_B" HeaderText="Рахунок Б" meta:resourcekey="BoundFieldResource6">
    <itemstyle horizontalalign="Left" />
</asp:BoundField>
<asp:BoundField DataField="KV_B" SortExpression="KV_B" HeaderText="Вал. Б" meta:resourcekey="BoundFieldResource7">
    <itemstyle horizontalalign="Center" />
</asp:BoundField>
<asp:BoundField DataField="S_B" SortExpression="to_number(S_B)" HeaderText="Сума Б" meta:resourcekey="BoundFieldResource8">
    <itemstyle horizontalalign="Right" />
</asp:BoundField>
<asp:BoundField DataField="NAZN" SortExpression="NAZN" HeaderText="Призначення" meta:resourcekey="BoundFieldResource9">
    <itemstyle horizontalalign="Left" />
</asp:BoundField>
<asp:BoundField DataField="SOS" Visible="False" SortExpression="SOS" HeaderText="*" meta:resourcekey="BoundFieldResource10">
</asp:BoundField>
<asp:BoundField DataField="TRANSH_ID" HeaderText="№ док. в межах одного траншу" meta:resourcekey="BoundFieldResource11" SortExpression="TRANSH_ID">
    <itemstyle wrap="False" />
</asp:BoundField>    
<asp:BoundField DataField="TT" SortExpression="TT" HeaderText="Тип" meta:resourcekey="BoundFieldResource12">
    <itemstyle horizontalalign="Center" />
</asp:BoundField>
</Columns>
</bars:barsgridview>
                </td>
            </tr>
            <tr>
                <td>
                    <bars:barssqldatasource ProviderName="barsroot.core" id="dsDptDocs" runat="server"></bars:barssqldatasource>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
