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

html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
  margin: 0;
  padding: 0;
  border: 0;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
  display: block;
}
body {
  line-height: 1;
}
ol, ul {
  list-style: none;
}
blockquote, q {
  quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
  content: '';
  content: none;
}
table {
  border-collapse: collapse;
  border-spacing: 0;
}


		    .header { font-family: sans-serif; font-weight: 400; font-size: 16px; padding: 9px; }
		    .rs {font-family:sans-serif;font-size:10pt;cursor:Hand;}
		    .cw {color:green;border-right: solid 1px #8F8F8F;}
		    .cwb {padding: 12px;color:red;border-right: solid 1px #8F8F8F;}
		    .cd {padding: 12px;color:navy;}
		        .cw:hover,
                .cwb:hover,
                .cd:hover {
		        background: #F8F8F8;
                }

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
					<TD align="left" style="text-align:left;"><br/><br/><asp:label id="Label1" meta:resourcekey="Label1_1" runat="server" style="color: #7A9DBE; font-family: sans-serif; font-weight: 100; font-size: 1.8em; padding: 20px 0 20px 20px;">Адміністрування користувачів</asp:label></TD>
				</TR>
				<TR>
					<TD valign="bottom">
						<TABLE id="Table2" cellSpacing="1" cellPadding="1" style="width: 97%; margin: 20px 0 0 20px;">
                            <tr>
                                <td colspan="4" nowrap="nowrap" style="text-align:left;font-family:sans-serif;font-size:18px;font-weight:400;padding-bottom:20px;">
                                    <asp:Label ID="lbCurrUserInfo" runat="server" meta:resourcekey="lbCurrUserInfo" Text="Детальна інформація про користувача"></asp:Label></td>
                            </tr>
							<TR align="left">
								<TD noWrap align="left" ><asp:label id="lbWebUser" Font-Names="sans-serif" Font-Size="14px" meta:resourcekey="lbWebUser" runat="server" Text="Користувач Web:"></asp:label></TD>
								<TD><asp:textbox id="webuser" runat="server" Font-Names="sans-serif" Font-Size="14px" ForeColor="Green"
										Width="220px" style="padding:5px"></asp:textbox></TD>
								<TD noWrap><asp:label id="lbErrMode" meta:resourcekey="lbErrMode" runat="server" Font-Size="14px" style="padding:5px" Font-Names="sans-serif" Text="Режим відображення помилок:"></asp:label></TD>
								<TD valign="middle">
									<asp:TextBox id="errormode" onblur="checkErr(this)" runat="server" ForeColor="Red" Width="30px" 
										style="TEXT-ALIGN:center;padding:5px;"></asp:TextBox><input id="lbErrInfo" type="text" style="padding:5px;FONT-SIZE: 10pt; COLOR: maroon; FONT-FAMILY: sans-serif; TEXT-ALIGN: center"
										readOnly></TD>
							</TR>
                            <br/ ><br/ >
							<TR align="left">
								<TD noWrap align="left"><asp:label id="lbDbUser" meta:resourcekey="lbDbUser" runat="server" Font-Size="14px" Font-Names="sans-serif" Text="Користувач БД:"></asp:label></TD>
								<TD noWrap><asp:textbox id="dbuser" runat="server" Font-Size="14px" Font-Names="sans-serif" ForeColor="#000040"
										Width="200px" style="padding:5px"></asp:textbox><IMG runat="server" meta:resourcekey="imgSelect" alt="Выбрать пользователя" onclick="getUser()" src="/Common/Images/arrow-down.svg"
										align="absMiddle" style="padding: 18px 0 0 3px; width: 13px; margin-bottom: -1px; cursor: pointer;">
								</TD>
								<TD noWrap><input id="cbSetPsw" onclick="SetPsw(this)" type="checkbox" name="cbSetPsw"><label id="lbSetPsw" runat="server" meta:resourcekey="lbSetPsw" for="cbSetPsw" style="FONT-SIZE:14px;FONT-FAMILY:sans-serif">Встановити технічний пароль</label></TD>
								<TD noWrap><asp:textbox id="adminpassReal" style="VISIBILITY: hidden; padding:5px;" runat="server" Width="60%" TextMode="Password"></asp:textbox><INPUT id="adminpass" type="hidden" runat="server" NAME="adminpass"><INPUT id="webpass" type="hidden" runat="server" NAME="webpass"></TD>
							</TR>
                            <tr>
                                <td align="left" nowrap="nowrap">
                                    <asp:Label ID="lbBlocked" meta:resourcekey="lbBlocked" runat="server" Font-Names="sans-serif" Font-Size="14px" Text="Статус користувача:"></asp:Label></td>
                                <td colspan="3">
                                    <input runat="server" id="tbStatus" meta:resourcekey="tbStatus" type="text" style=" font-size: 14px; color: #E05D5D; border: solid 1px; border-radius: 3px; font-family: sans-serif; text-align: center; width: 122px; margin: 10px;"
										readOnly value="Невизначений">
                                    <asp:Button ID="btBlock" meta:resourcekey="btBlock" runat="server" Text="Заблокувати" 
                                        style="visibility:hidden; cursor:pointer; font-size: 14px; padding: 3px 12px;border: none; font-family: sans-serif;" OnClick="btBlock_Click" /></td>
                            </tr>
							<TR>
								<TD noWrap align="left"><asp:label id="lbComm" meta:resourcekey="lbComm" runat="server" Font-Names="sans-serif" Font-Size="14px" Text="Коментар:"></asp:label></TD>
								<TD colSpan="3">
                                    <asp:TextBox ID="comm" TextMode="multiline" Columns="20" Rows="3" runat="server" Font-Size="14px" Font-Names="sans-serif" Width="50%" >
                                    </asp:TextBox></TD>
							</TR>

                            <tr>
                                <td align="left" colspan="4" nowrap="nowrap" style="margin-left:80px"><br/><br/>
                                    <input id="btCreate" meta:resourcekey="btCreate" type="button" runat="server" name="btCreate" value="Створити" style="margin-left:182px;cursor:pointer;font-size: 14px; padding: 8px 22px; color: white; background: #2196F3; border: none; font-family: sans-serif;" onclick="CreateUser()">
						            <input id="btUpdate" meta:resourcekey="btUpdate" type="button" runat="server" name="btUpdate" value="Зберегти" style="cursor:pointer;font-size: 14px; padding: 8px 22px; color: white; background: #2196F3; border: none; font-family: sans-serif" onserverclick="btUpdate_ServerClick">
                                </td>
                            </tr>
						</TABLE>
                    </TD>
				</TR>
                <tr>
                    <td align="center" valign="bottom">
                        <table id="tAllUsers" style=" width: 100%; background-color: #F8F8F8;">
                            <tr>
                                <td align="center" nowrap="nowrap" valign="middle"><br/><br/>
                                    <asp:Label meta:resourcekey="lbFilter" ID="lbFilter" runat="server" Font-Names="sans-serif" Font-Size="14px" Text="Фильтр:"></asp:Label>
                                    <asp:DropDownList ID="ddType" runat="server" style="width: 152px; padding:5px">
                                        <asp:ListItem Selected="True" Value="0">Користувач БД</asp:ListItem>
                                        <asp:ListItem Value="1">Користувач WEB</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox meta:resourcekey="tbFilter" ID="tbFilter" runat="server" style="padding:5px"></asp:TextBox>
                                    <asp:Button meta:resourcekey="btFilter" ID="btFilter" runat="server" Text="Применить" OnClick="btFilter_Click" style="cursor:pointer;font-size: 14px; padding: 6px 22px; color: white; background: #2196F3; border: none; font-family: sans-serif" /></td>
                            </tr>
                                <tr><br/><br/>
                                    <td align="left" nowrap="nowrap"><br/><br/>
                                        <asp:Label ID="lbAllUserList" runat="server" Font-Bold="True" Font-Names="sans-serif" Font-Size="14px" style=" padding: 20px 0 20px 20px;"
                                            ForeColor="Black" meta:resourcekey="lbAllUserList" Text="Список всіх користувачів"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap" align="center"><br/><br/>
						   <asp:LinkButton meta:resourcekey="spWebUser" Text="Користувач WEB" ID="spWebUser" runat="server" CssClass="header" style="margin-left: -117px;" OnClick="spWebUser_Click" />
						   <asp:Label meta:resourcekey="spDBUser" Text="Користувач БД" ID="spDBUser" runat="server" CssClass="header" style="margin-left: 21px;" /><br/><br/>
						   </td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap">
						<DIV STYLE="OVERFLOW: auto; WIDTH: 100%;  HEIGHT: 360px;border-top: solid 1px #8F8F8F; border-bottom: solid 1px #8F8F8F; background-color: #F0F0F0;">
							<asp:placeholder id="mapUsers" runat="server"></asp:placeholder>
                            &nbsp;</DIV>
                                        <asp:button id="btDelete" meta:resourcekey="btDelete" runat="server" 
                                            style="cursor:pointer;margin: 20px 0 20px 0;font-size: 14px; padding: 8px 22px; color: white; background: #E05D5D; border: none; font-family: sans-serif;"
							                Text="Видалити" onclick="btDelete_Click"></asp:button>
                                        <asp:Button ID="btRefresh" meta:resourcekey="btRefresh" runat="server"
                                            style="cursor:pointer;font-size: 14px;margin-top: 20px; padding: 8px 22px; color: white; background: #2196F3; border: none; font-family: sans-serif;" OnClick="btRefresh_Click"
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
