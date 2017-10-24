<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintButton.aspx.cs" Inherits="PrintButton" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Соціальні депозити: Друк</title>
    <LINK href="style.css" type="text/css" rel="stylesheet">
    <script language="javascript">
        function print(){
	        try {		
		           parent.frames['contents'].focus();
            	   parent.frames['contents'].print();
	        }
	        catch(e){alert('Документ пустий!');}
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div align=center>
        <input type=button id="btPrint" value="Друк" class="AcceptButton" onclick="print()">
    </div>
    </form>
</body>
</html>
