<%@ Page language="c#" Inherits="DocInput.AskBeforePay"  enableViewState="False" CodeFile="askbeforepay.aspx.cs" CodeFileBaseClass="Bars.BarsPage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Оплата</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script type="text/javascript">
		function PayDoc(){
		  window.returnValue = true;
		  window.close();
		}
		function CancelDoc(){
		  window.returnValue = false;
		  window.close();
		}
		</script>
	</HEAD>
	<body bgColor="#f0f0f0" onload="document.getElementById('btPay').focus();window.returnValue = false;" 
	onkeydown='if(event.keyCode == 27){window.close();window.returnValue = null;} else if(event.keyCode == 37) document.all.btPay.focus(); else if(event.keyCode == 39) document.all.btCancel.focus();'>
		<form id="FormAskBeforePay" method="post" runat="server" onsubmit="return false;">
			<BR>
			<P>&nbsp;&nbsp;<asp:textbox id="textSum" runat="server" TextMode="MultiLine" Rows="3" EnableViewState="False"
					ReadOnly="True" Width="100%" Font-Bold="True"></asp:textbox></P>
			<P>
				<TABLE id="TableButton" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD style="PADDING-RIGHT: 10px" align="right"><INPUT id="btPay" meta:resourcekey="btPay" runat="server" type="button" value="Подтвердить" onclick="PayDoc();" style="WIDTH: 120px"></TD>
						<TD style="PADDING-LEFT: 10px" align="left"><INPUT id="btCancel" meta:resourcekey="btCancel" runat="server" type="button" value="Отменить" onclick="CancelDoc();" style="WIDTH: 120px"></TD>
						</TR>
					</TR>
				</TABLE>
				<BR />
				<asp:Panel Visible=false ID="pnWarning" runat="server" GroupingText="Попередження" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt">
                    &nbsp;&nbsp;<asp:TextBox ID="lbWarning" runat="server" Font-Bold="True" 
                        Font-Names="Verdana" ForeColor="Red" ReadOnly="True" TextMode="MultiLine" EnableViewState="False"
                        Width="100%" BackColor="#F0F0F0" BorderStyle="None" Rows="4"></asp:TextBox>
                            </asp:Panel>
			</P>
		</form>
	</body>
</HTML>
