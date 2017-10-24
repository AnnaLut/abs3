<%@ Page language="c#" Inherits="DocInput.SetRates"  enableViewState="False" CodeFile="setcurrates.aspx.cs" CodeFileBaseClass="Bars.BarsPage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SetRates</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="JavaScript" src="/Common/WebEdit/NumericEdit.js"></script>
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			window.onload = function()
			{
			    webService.useService("DocService.asmx?wsdl","Doc");
				init_sum("Rate1_B");init_sum("Rate2_B");init_sum("Rate3_B");
				init_sum("Rate1_S");init_sum("Rate2_S");init_sum("Rate3_S");
				init_sum("BSum1");init_sum("BSum2");init_sum("BSum3");
				if(location.search.indexOf("readonly=1") > 0 )
				    document.all.btSave.style.visibility = "hidden";
			}
			function SaveData()
			{
			  var data = new Array();
			  data[0] = document.all.Rate1_B.value;
			  data[1] = document.all.Rate1_S.value;
			  data[2] = document.all.BSum1.value;
			  data[3] = "840";
			  data[4] = document.all.Rate2_B.value;
			  data[5] = document.all.Rate2_S.value;
			  data[6] = document.all.BSum2.value;
			  data[7] = "978";
			  data[8] = document.all.Rate3_B.value;
			  data[9] = document.all.Rate3_S.value;
			  data[10] = document.all.BSum3.value;
			  data[11] = "643";
			  
			  webService.Doc.callService(onSaveCurRates,"SaveCurRates",data);
			}
			function onSaveCurRates(result)
			{
			 if(!getError(result)) return;
			 Dialog("Изменения успешно сохранены !","alert");
			}
			//Диалоговое окно
			function Dialog(message,type)
			{
				return window.showModalDialog("dialog.aspx?type="+type+"&message="+escape(message),"","dialogHeight:160px;center:yes;edge:sunken;help:no;status:no;");
			}
			//Обработка ошибок от веб-сервиса
			function getError(result)
			{
				if(result.error) {
				location.replace("dialog.aspx?type=err&page=DocService.asmx");
				return false;
				}
				return true;
			}
		</script>
		<style>.rg { TEXT-ALIGN: right }
		</style>
	</HEAD>
	<body bgColor="#f0f0f0">
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD align="center"><asp:label id="lbTitle" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="12pt">Установка курса валют для безбалансового отделения</asp:label></TD>
				</TR>
				<TR>
					<TD align="center"><asp:label id="lbBaseVal" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="12pt"
							ForeColor="Navy">Базовая валюта - </asp:label></TD>
				</TR>
				<TR>
					<TD align="center">
						<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="300" border="1">
							<TR>
								<TD align="center"><asp:label id="lbNameVals" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
										ForeColor="Green">Валюта</asp:label></TD>
								<TD align="center"><asp:label id="Label2" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
										ForeColor="Navy">Курс покупки</asp:label></TD>
								<TD align="center"><asp:label id="Label3" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
										ForeColor="Maroon">Курс продажи</asp:label></TD>
								<TD align="center"><asp:label id="Label4" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
										ForeColor="Red">Базовая сумма</asp:label></TD>
								<TD align="center"><asp:label id="Label6" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
										ForeColor="Green">Курс официальный(ГБ)</asp:label></TD>
							</TR>
							<TR>
								<TD noWrap align="right"><asp:label id="lbKv1" runat="server" Font-Names="Verdana" Font-Size="10pt" ForeColor="Green"></asp:label></TD>
								<TD><asp:textbox id="Rate1_B" runat="server" ForeColor="Navy" CssClass="rg" Width="120px"></asp:textbox></TD>
								<TD><asp:textbox id="Rate1_S" runat="server" ForeColor="Maroon" CssClass="rg" Width="120px"></asp:textbox></TD>
								<TD align="center"><asp:textbox id="BSum1" runat="server" ForeColor="Red" CssClass="rg" Width="80px" BackColor="#E0E0E0"
										ReadOnly="True"></asp:textbox></TD>
								<TD align="center"><asp:textbox id="Rate1_GO" runat="server" ForeColor="Green" CssClass="rg" Width="120px" BackColor="#E0E0E0"
										ReadOnly="True"></asp:textbox></TD>
							</TR>
							<TR>
								<TD noWrap align="right"><asp:label id="lbKv2" runat="server" Font-Names="Verdana" Font-Size="10pt" ForeColor="Green"></asp:label></TD>
								<TD><asp:textbox id="Rate2_B" runat="server" ForeColor="Navy" CssClass="rg" Width="120px"></asp:textbox></TD>
								<TD><asp:textbox id="Rate2_S" runat="server" ForeColor="Maroon" CssClass="rg" Width="120px"></asp:textbox></TD>
								<TD align="center"><asp:textbox id="BSum2" runat="server" ForeColor="Red" CssClass="rg" Width="80px" BackColor="#E0E0E0"
										ReadOnly="True"></asp:textbox></TD>
								<TD align="center"><asp:textbox id="Rate2_GO" runat="server" ForeColor="Green" CssClass="rg" Width="120px" BackColor="#E0E0E0"
										ReadOnly="True"></asp:textbox></TD>
							</TR>
							<TR>
								<TD noWrap align="right"><asp:label id="lbKv3" runat="server" Font-Names="Verdana" Font-Size="10pt" ForeColor="Green"></asp:label></TD>
								<TD><asp:textbox id="Rate3_B" runat="server" ForeColor="Navy" CssClass="rg" Width="120px"></asp:textbox></TD>
								<TD><asp:textbox id="Rate3_S" runat="server" ForeColor="Maroon" CssClass="rg" Width="120px"></asp:textbox></TD>
								<TD align="center"><asp:textbox id="BSum3" runat="server" ForeColor="Red" CssClass="rg" Width="80px" BackColor="#E0E0E0"
										ReadOnly="True"></asp:textbox></TD>
								<TD align="center"><asp:textbox id="Rate3_GO" runat="server" ForeColor="Green" CssClass="rg" Width="120px" BackColor="#E0E0E0"
										ReadOnly="True"></asp:textbox></TD>
							</TR>
						</TABLE>
						<input class="BarsLabel" id="btSave" onclick="SaveData()" type="button" value="Установить"
							runat="server">
					</TD>
				</TR>
			</TABLE>
			<div class="webservice" id="webService" showProgress="true"></div>
		</form>
	</body>
</HTML>
