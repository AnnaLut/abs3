<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentForm.aspx.cs" Inherits="DocumentForm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <base target ="_self" />
    <title>Формування документів</title>
    <link href="style/style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="script/JScript.js"></script>                
	<script type="text/javascript" language="javascript">
	    var arr = new Array();		
	    function Sel(id)
	    { event.srcElement.checked?arr[id]=id:arr[id]=null;	}
	    function returnRes()
	    {
		    window.returnValue = arr;		    
		    window.close();
		}
	</script>    
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
				<td align="center">
					<asp:Label id="lbTitle" CssClass="InfoLabel" runat="server">Виберіть шаблони для формування документів</asp:Label>
				</td>
			</tr>
			<tr>
				<td>
					<asp:DataGrid id="gridTemplates" runat="server" CssClass="BaseGrid" OnItemDataBound="gridTemplates_ItemDataBound"></asp:DataGrid>
				</td>
			</tr>
			<tr>
				<td align="center">
					<input class="AcceptButton" id="btSelect" 
					    type="button" value="Выбрать" onclick="returnRes();"/>
				</td>
			</tr>
		</table>
    </form>
</body>
</html>
