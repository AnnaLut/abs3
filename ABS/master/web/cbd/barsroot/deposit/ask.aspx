<%@ Page language="c#" CodeFile="Ask.aspx.cs" AutoEventWireup="true" Inherits="Ask" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозитний модуль: Вибір типу операції</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript">
		    function on_prop_change()
		    {
		        var e = window.event;
		        if ( e.propertyName =="checked" ) 
			    {
			        var rad = e.srcElement;
			        if ( rad.checked )
				        document.getElementById("op_id").value = rad.value;
			    } 
		    }
		</script>
	</head>
	<body>
		<script type="text/javascript" language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>
		<form id="Form1" method="post" runat="server">
			<table id="Table1" class="MainTable">
				<tr>
					<td align="center">
						<asp:Label id="lbTitle" meta:resourcekey="lbTitle10" runat="server" CssClass="InfoLabel">Выберите тип доп. соглашения</asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						<input type="radio" name="radio" checked value="1" onpropertychange="on_prop_change()"
							id="rb_add"/> <label id="Label1" meta:resourcekey="rb_add" runat="server" for="rb_add" class="RadioText">Пополнение</label>
					</td>
				</tr>
				<tr>
					<td>
						<input type="radio" name="radio" value="2" onpropertychange="on_prop_change()" id="rb_take"/>
						<label id="Label2" for="rb_take" meta:resourcekey="rb_take" runat="server" class="RadioText">Частичное снятие</label>
					</td>
				</tr>
				<tr>
					<td align="center">                        
						<input id="btConfirm" runat="server" meta:resourcekey="btConfirm" class="AcceptButton" onclick="getOP()" type="button" value="Выбрать"/>
					</td>
				</tr>
				<tr>
					<td><input id="op_id" type="hidden" value="1"/></td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
