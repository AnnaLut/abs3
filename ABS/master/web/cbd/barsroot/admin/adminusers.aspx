<%@ Page language="c#" Inherits="BarsWeb.Admin.AdminUsers" CodeFile="adminusers.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Администрирование</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<style>
		    .header { FONT-WEIGHT: bold; FONT-SIZE: 10pt; FONT-FAMILY: Verdana }
		    .rs {font-family:Verdana;font-size:10pt;cursor:Hand;}
		    .cw {width:460px;color:green;}
		    .cwb {width:460px;color:red;}
		    .cd {width:250px;color:navy;}
		</style>
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript">
			var lastSelectRow = null;
			window.attachEvent("onload",CheckNbu);
			
			function CheckNbu()
			{
			  document.getElementById("webuser").readOnly = true;
    		  document.getElementById("dbuser").readOnly = true;
			  
			  if(document.all.hSelectedRow.value)
			    sR(document.getElementById("r_"+document.all.hSelectedRow.value));
			  else 
			    sR(document.getElementById("r_0"))
			}
			function sR(row)
			{
			    if(!row) return;
			    document.getElementById("btCreate").disabled = false;
			    document.getElementById("webuser").readOnly = true;
				if(null != lastSelectRow)
					lastSelectRow.style.background = '';
				row.style.background = '#d3d3d3';
				lastSelectRow = row;
				var index = row.id.substring(2);
				document.all.hSelectedRow.value = index;
				document.getElementById("webuser").value = document.getElementById("c_web_"+index).innerText;
				document.getElementById("dbuser").value = document.getElementById("c_db_"+index).innerText;
				document.getElementById("errormode").value = row.err;
				document.getElementById("adminpass").value = row.pswa;
				document.getElementById("webpass").value = row.pswu;
				if(row.pswa == "")
					document.getElementById("lbSetPsw").innerText = LocalizedString('js1');//"Встановити технічний пароль";
				else 
					document.getElementById("lbSetPsw").innerText = LocalizedString('js2');//"Змінити технічний пароль";	
				document.getElementById("comm").value = row.comm;
				document.getElementById("btBlock").style.visibility = "visible";
				document.getElementById("hStatus").value = row.block;
				if(row.block == "1")
				{
				  document.getElementById("tbStatus").value = LocalizedString('js3');//"Заблокований";
				  document.getElementById("btBlock").value = LocalizedString('js4');//"Розблокувати";
				  document.getElementById("tbStatus").style.color = "red";
				  document.getElementById("btBlock").style.color = "green";
				}
				else
				{
				  document.getElementById("tbStatus").value = LocalizedString('js5');//"Працює";
				  document.getElementById("btBlock").value = LocalizedString('js6');//"Заблокувати";
				  document.getElementById("btBlock").style.color = "red";
				  document.getElementById("tbStatus").style.color = "green";
				}
				ErrInfo();
			}
			function SetPsw(cb)
			{
			  if(cb.checked)
				document.getElementById("adminpassReal").style.visibility = "visible";
			  else 
				document.getElementById("adminpassReal").style.visibility = "hidden";	
			}
			function getUser()
			{
				 var result = window.showModalDialog("dialog.aspx?type=metatab&tail=''&role=wr_metatab&tabname=staff",
													"",
													"dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
				if(result != null){												
					document.getElementById("dbuser").value = result[2];
					document.getElementById("comm").value = result[1] + " (Код=" + result[0]+")";
					if(document.getElementById("NbuAuth").value == "On")
					    document.getElementById("webuser").value = result[3];
				}	
			}
			function genHashCode()
			{
				var hashCode = hex_sha1(document.getElementById("adminpassReal").value.toLowerCase());
				document.getElementById("adminpass").value = hashCode;
			}
			function Validate(form)
			{
			  if(form.cbSetPsw.checked){
				if(form.adminpassReal.value == ""){
					alert(LocalizedString('js7')/*"Введіть пароль !"*/);
					form.adminpassReal.focus();
					return false;
				}	
				genHashCode();
			  }
			  if(form.adminpass.value == "" && form.webpass.value == "")
			  {
			   alert(LocalizedString('js7')/*"Введіть пароль !"*/);
			   if(!form.cbSetPsw.checked)
			   {
			        form.cbSetPsw.checked = true;
			        SetPsw(form.cbSetPsw);
			   }     
			   form.adminpassReal.focus();
			   return false;
			  }
			  if(form.webuser.value == "" || form.dbuser.value == ""){
				alert(LocalizedString('js8')/*"Незаповнені обов'язкові поля !"*/);
				form.webuser.focus();
				return false;
			  }
			  document.getElementById("btCreate").disabled = true;
			  return true;
			}
			function ErrInfo()
			{
			  var err = document.getElementById("errormode").value;
			  switch(err)
			  {
				case "1" : document.getElementById("lbErrInfo").innerText = LocalizedString('js9');/*"[повна інф.]";*/break;
				case "0" : document.getElementById("lbErrInfo").innerText = LocalizedString('js10');/*"[неповна інф.]";*/break;
				default: document.getElementById("lbErrInfo").innerText = "";break;
			  } 
			}
			function checkErr(obj)
			{
			  if(obj.value != "" && obj.value != 0 && obj.value != 1){
				alert(LocalizedString('js1')/*"Недопустиме значення!"*/);
				obj.value = "";
			  }
			  ErrInfo();	
			}
			function CreateUser()
			{
			   document.getElementById("btCreate").disabled = true;
			   document.getElementById("webuser").readOnly = false;
			   document.getElementById("webuser").focus();
			   document.getElementById("webuser").value = "";
			   document.getElementById("dbuser").value = "";
			   document.getElementById("adminpass").value = "";
			   document.getElementById("webpass").value = "";
			   document.getElementById("comm").value = "";
			   document.getElementById("errormode").value = "0";
			   
			   ErrInfo();
			}
		</script>
		<script language="javascript" src="\Common\Script\Encrypt\sha1.js"></script>
	</HEAD>
	<body bgColor="#f0f0f0">
		<form method="post" runat="server">
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD align="center"><asp:label id="Label1" meta:resourcekey="Label1_1" runat="server" Font-Bold="True" Font-Size="12pt" Font-Names="Verdana"
							ForeColor="Navy">Адміністрування користувачів</asp:label></TD>
				</TR>
				<TR>
					<TD align="center" valign="bottom">
						<TABLE id="Table2" cellSpacing="1" cellPadding="1" border="2">
                            <tr>
                                <td align="center" colspan="4" nowrap="nowrap">
                                    <asp:Label ID="lbCurrUserInfo" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
                                        ForeColor="Black" meta:resourcekey="lbCurrUserInfo" Text="Детальна інформація про  користувача"></asp:Label></td>
                            </tr>
							<TR>
								<TD noWrap align="right"><asp:label id="lbWebUser" meta:resourcekey="lbWebUser" runat="server" Font-Size="10pt" Font-Names="Verdana" Text="Користувач Web:"></asp:label></TD>
								<TD><asp:textbox id="webuser" runat="server" Font-Size="10pt" Font-Names="Verdana" ForeColor="Green"
										Width="220px"></asp:textbox></TD>
								<TD noWrap><asp:label id="lbErrMode" meta:resourcekey="lbErrMode" runat="server" Font-Size="10pt" Font-Names="Verdana" Text="Режим відображення  помилок:"></asp:label></TD>
								<TD valign="middle">
									<asp:TextBox id="errormode" onblur="checkErr(this)" runat="server" ForeColor="Red" Width="30px"
										style="TEXT-ALIGN:center"></asp:TextBox><input id="lbErrInfo" type="text" style="FONT-SIZE: 10pt; COLOR: maroon; FONT-FAMILY: Verdana; TEXT-ALIGN: center"
										readOnly></TD>
							</TR>
							<TR>
								<TD noWrap align="right"><asp:label id="lbDbUser" meta:resourcekey="lbDbUser" runat="server" Font-Size="10pt" Font-Names="Verdana" Text="Користувач БД:"></asp:label></TD>
								<TD noWrap><asp:textbox id="dbuser" runat="server" Font-Size="10pt" Font-Names="Verdana" ForeColor="#000040"
										Width="200px"></asp:textbox><IMG runat="server" meta:resourcekey="imgSelect" alt="Выбрать пользователя" onclick="getUser()" src="/Common/Images/cmbDown.gif"
										align="absMiddle">
								</TD>
								<TD noWrap><input id="cbSetPsw" onclick="SetPsw(this)" type="checkbox" name="cbSetPsw"><label id="lbSetPsw" runat="server" meta:resourcekey="lbSetPsw" for="cbSetPsw" style="FONT-SIZE:10pt;FONT-FAMILY:Verdana">Встановити технічний пароль</label></TD>
								<TD noWrap><asp:textbox id="adminpassReal" style="VISIBILITY: hidden" runat="server" Width="100%" TextMode="Password"></asp:textbox><INPUT id="adminpass" type="hidden" runat="server" NAME="adminpass"><INPUT id="webpass" type="hidden" runat="server" NAME="webpass"></TD>
							</TR>
                            <tr>
                                <td align="right" nowrap="nowrap">
                                    <asp:Label ID="lbBlocked" meta:resourcekey="lbBlocked" runat="server" Font-Names="Verdana" Font-Size="10pt" Text="Статус користувача:"></asp:Label></td>
                                <td colspan="3">
                                    <input runat="server" id="tbStatus" meta:resourcekey="tbStatus" type="text" style="FONT-SIZE: 10pt; COLOR: red; FONT-FAMILY: Verdana; TEXT-ALIGN: center; width: 220px;"
										readOnly value="Невизначений">
                                    <asp:Button ID="btBlock" meta:resourcekey="btBlock" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
                                        ForeColor="Red" Text="Заблокувати" Width="140px" style="visibility:hidden" OnClick="btBlock_Click" /></td>
                            </tr>
							<TR>
								<TD noWrap align="right"><asp:label id="lbComm" meta:resourcekey="lbComm" runat="server" Font-Size="10pt" Font-Names="Verdana" Text="Коментар:"></asp:label></TD>
								<TD colSpan="3"><asp:textbox id="comm" runat="server" Font-Size="10pt" Font-Names="Verdana" ForeColor="#400000"
										Width="100%" BackColor="Info"></asp:textbox></TD>
							</TR>
                            <tr>
                                <td align="center" colspan="4" nowrap="nowrap">
                        <input id="btCreate" meta:resourcekey="btCreate" type="button" runat="server" name="btCreate" value="Створити" style="FONT-WEIGHT:bold;FONT-SIZE:10pt;WIDTH:100px;COLOR:green;FONT-FAMILY:Verdana" onclick="CreateUser()">
						<input id="btUpdate" meta:resourcekey="btUpdate" type="button" runat="server" name="btUpdate" value="Зберегти" style="FONT-WEIGHT:bold;FONT-SIZE:10pt;WIDTH:100px;COLOR:green;FONT-FAMILY:Verdana" onserverclick="btUpdate_ServerClick"></td>
                            </tr>
						</TABLE>
                    </TD>
				</TR>
                <tr>
                    <td align="center" valign="bottom">
                        <table id="tAllUsers" border="2">
                            <tr>
                                <td align="center" nowrap="nowrap" valign="middle">
                                    <asp:Label meta:resourcekey="lbFilter" ID="lbFilter" runat="server" Font-Names="Verdana" Font-Size="10pt" Text="Фильтр:"></asp:Label>
                                    <asp:DropDownList ID="ddType" runat="server" Width="152px">
                                        <asp:ListItem Selected="True" Value="0">Користувач БД</asp:ListItem>
                                        <asp:ListItem Value="1">Користувач WEB</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox meta:resourcekey="tbFilter" ID="tbFilter" runat="server"></asp:TextBox>
                                    <asp:Button meta:resourcekey="btFilter" ID="btFilter" runat="server" Font-Bold="True" Text="Применить" OnClick="btFilter_Click" /></td>
                            </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap">
                                        <asp:Label ID="lbAllUserList" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
                                            ForeColor="Black" meta:resourcekey="lbAllUserList" Text="Список всіх користувачів"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap" align="center">
						   <asp:LinkButton meta:resourcekey="spWebUser" Text="Користувач WEB" ID="spWebUser" runat="server" CssClass="header" style="WIDTH:450px; BORDER-TOP-STYLE:groove; BORDER-RIGHT-STYLE:groove; BORDER-LEFT-STYLE:groove; BACKGROUND-COLOR:white; text-align: center;" OnClick="spWebUser_Click" />
						   <asp:Label meta:resourcekey="spDBUser" Text="Користувач БД" ID="spDBUser" runat="server" CssClass="header" style="WIDTH:250px; BORDER-TOP-STYLE:groove; BORDER-RIGHT-STYLE:groove; BORDER-LEFT-STYLE:groove; BACKGROUND-COLOR:white; text-align: center;" />
						   </td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap">
						<DIV STYLE="OVERFLOW: auto; WIDTH: 700px; BORDER-RIGHT-STYLE: groove; BORDER-LEFT-STYLE: groove; HEIGHT: 300px; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: groove">
							<asp:placeholder id="mapUsers" runat="server"></asp:placeholder>
                            &nbsp;</DIV>
                                        <asp:button id="btDelete" meta:resourcekey="btDelete" runat="server" Font-Bold="True" Font-Size="10pt" Font-Names="Verdana"
							Text="Видалити" Width="100px" onclick="btDelete_Click"></asp:button>
                                        <asp:Button ID="btRefresh" meta:resourcekey="btRefresh" runat="server" Font-Bold="True" OnClick="btRefresh_Click"
                                            Text="Обновити" /></td>
                                </tr>
                            </table>
                    </td>
                </tr>
				<TR>
					<TD align="center" style="width: 674px">
					<input id=hStatus type=hidden runat=server></TD>
				</TR>
			</TABLE>
			<input type="hidden" runat="server" id="NbuAuth" />
			<input type="hidden" runat="server" id="hSelectedRow" />
			<input type="hidden" runat="server" id="js1" meta:resourcekey="js1" value=""/>
			<input type="hidden" runat="server" id="js2" meta:resourcekey="js2" value=""/>
			<input type="hidden" runat="server" id="js3" meta:resourcekey="js3" value=""/>
			<input type="hidden" runat="server" id="js4" meta:resourcekey="js4" value=""/>
			<input type="hidden" runat="server" id="js5" meta:resourcekey="js5" value=""/>
			<input type="hidden" runat="server" id="js6" meta:resourcekey="js6" value=""/>
			<input type="hidden" runat="server" id="js7" meta:resourcekey="js7" value=""/>
			<input type="hidden" runat="server" id="js8" meta:resourcekey="js8" value=""/>
			<input type="hidden" runat="server" id="js9" meta:resourcekey="js9" value=""/>
			<input type="hidden" runat="server" id="js10" meta:resourcekey="js10" value=""/>
			<input type="hidden" runat="server" id="js11" meta:resourcekey="js11" value=""/>
		</form>
	</body>
</HTML>
