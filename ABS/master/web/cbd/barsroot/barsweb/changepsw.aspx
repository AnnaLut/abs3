<%@ Page language="c#" Inherits="barsweb.ChangePsw" CodeFile="changepsw.aspx.cs"  UICulture="uk"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Изменение пароля</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="javascript" src="\Common\Script\Encrypt\sha1.js"></script>
		<script language="javascript" src="\Common\Script\StrongPsw.js"></script>
		
		<script language="javascript">
		<!--
			window.attachEvent("onload",OnLoad);
			function getCookie(par)
		    {
		        var pageCookie = document.cookie;
		        var pos = pageCookie.indexOf(par + '=');
                if(pos != -1 )
		        { 	
	    	        var start = pos + par.length + 1;
	    	        var end = pageCookie.indexOf(';',start);
	    	        if(end == -1) end = pageCookie.length;
	                var value = pageCookie.substring(start, end);
	                value = unescape(value);
	                return value;
	            }
		    }
			function OnLoad()
			{
			   var login = getCookie('userLogin');
               if(login)
                    document.all.txtUserName.value = login;
			   InitPasswordPolicyParams(document.all.__pswMinLength.value,document.all.__pswMaxSeq.value,2,document.all.__sysUser.value,'txtPasswordNew',"btChangePsw");
			   if(document.all.txtUserName.disabled || document.all.txtUserName.value != "")
			       document.all.txtPasswordOld.focus();
			   else 
			       document.all.txtUserName.focus();    
			   if(location.search.indexOf('techPsw') > 0)
					alert("Вы використовуєте технічний пароль! Необхідно задати новий пароль!");
			}
			function pressEnter()
			{
			    if(event.keyCode == 13){
			        if(!document.all.btChangePsw.disabled)    
			            document.all.btChangePsw.focus();
			    }    
			}
			function Validate()
			{
			  if(!ConfirmPsw()) return false;
			  if(document.all.__InitPassword.value == hex_sha1(document.all.txtPasswordNew.value.toLowerCase()))
			  {
			   alert("Ви знову використовуете технічний пароль! Необхідно задати новий пароль!");
			   document.getElementById('txtPasswordNew').focus();
			   document.getElementById('txtPasswordNew').select();
			   return false;
			  }
			  return true;
			}
			function ConfirmPsw()
			{
			  if(document.getElementById('txtPasswordNew').value != ""){
			    window.event.cancelBubble = true;
			    var psw = window.showModalDialog("dialog.aspx?type=promptpsw&message="+escape("Підтвердіть пароль:"),"","dialogHeight:160px;center:yes;edge:sunken;help:no;status:no;");
			    window.event.cancelBubble = true;
			    if(null == psw) return false;
			    if(document.getElementById('txtPasswordNew').value.toLowerCase() != psw.toLowerCase()){
			        alert("Невірне підтвердження пароля");
			        document.getElementById('txtPasswordNew').focus();
			        document.getElementById('txtPasswordNew').select();
			        return false;
			    }    
			 }
			 return true;
			}
		-->	
		</script>
		<base target="_self" />
	</HEAD>
	<body  bgColor= "#e1e8f0" topmargin=0 leftmargin=0 rightmargin=0>
		<form id="AuthForm" onsubmit="txtPasswordOld_encrypt.value = hex_sha1(txtPasswordOld.value.toLowerCase());txtPasswordNew_encrypt.value = hex_sha1(txtPasswordNew.value.toLowerCase())"
			method="post" runat="server">
			<TABLE width="100%" cellSpacing=0 cellPadding=0 border=0>
			    <tr>
			    <td style="height: 286px">
			    <TABLE cellSpacing=0 cellPadding=0 border=0  width=100%>
			        <tr>
                    <td background="images/WEB.jpg" width="700px" height="267px">
                    </td>
                    <td background="images/logo_r.JPG">&nbsp;</td>                    
                    </tr>
                    </TABLE>
                   </td>
                </tr>
                <TR>
					<TD align="center" valign="top" style="height: 300px">
													<TABLE id="Table" cellSpacing="0" cellPadding="0" width="50%" align="center" border="0">
								<TR>
									<TD align="center" colSpan="2"><asp:label id="lbTitle" meta:resourcekey="lbTitle" runat="server" ForeColor="Black" Font-Size="12pt" Font-Names="Verdana" Font-Bold="True" Text="Зміна пароля користувача"></asp:label></TD>
								</TR>
								<TR>
									<TD align="center" colSpan="2" height="20"></TD>
								</TR>
								<TR>
									<TD align="right"><asp:label id="lbUser" meta:resourcekey="lbUser2" runat="server" ForeColor="Black" Font-Size="12pt" Font-Names="Verdana"
											Font-Bold="True">Користувач:</asp:label></TD>
									<TD><asp:textbox id="txtUserName" tabIndex="1" runat="server" Width="200px" BorderStyle="Ridge"></asp:textbox></TD>
								</TR>
								<TR>
									<TD noWrap align="right"><asp:label id="lbPswOld" meta:resourcekey="lbPswOld" runat="server" ForeColor="Black" Font-Size="12pt" Font-Names="Verdana"
											Font-Bold="True" Height="20px" Width="142px">Старий пароль:</asp:label></TD>
									<TD><asp:textbox id="txtPasswordOld" tabIndex="2" runat="server" Width="200px" BorderStyle="Ridge" TextMode="Password"></asp:textbox></TD>
								</TR>
								<TR>
									<TD align="right" style="height: 23px"><asp:label id="lbPswNew" meta:resourcekey="lbPswNew" runat="server" ForeColor="Black" Font-Size="12pt" Font-Names="Verdana"
											Font-Bold="True" Height="19px" Width="145px">Новий пароль:</asp:label></TD>
									<TD valign="top"><asp:textbox style="POSITION:absolute" id="txtPasswordNew" tabIndex="2" runat="server" Width="200px"
											BorderStyle="Ridge" TextMode="Password"></asp:textbox></TD>
								</TR>
								<TR>
									<TD align="right">&nbsp;</TD>
									<TD align="left"><asp:button id="btChangePsw" meta:resourcekey="btChangePsw" tabIndex="3" runat="server" ForeColor="#004000" Width="100px" Text="Змінити"
											Enabled="False" OnClick="btChangePsw_Click"></asp:button></TD>
								</TR>
								<TR>
									<TD align="center" colSpan="2" valign="bottom"><asp:label id="lbMessage" meta:resourcekey="lbMessage" runat="server" ForeColor="Red" Font-Size="8pt" Font-Names="Verdana"
											Visible="False">Невірний старий пароль</asp:label></TD>
								</TR>
								<TR>
									<TD colSpan="2" style="height: 48px"><input type=hidden id="__pswMinLength" runat="server" ><input type=hidden id="__sysUser" runat="server" >
									<input type=hidden id="__pswMaxSeq" runat="server" ><input type=hidden id="__InitPassword" runat="server" >
                                        <INPUT id="txtPasswordOld_encrypt" type="hidden" name="txtPasswordOld_encrypt" runat="server">
                                        <INPUT id="txtPasswordNew_encrypt" type="hidden" name="txtPasswordNew_encrypt" runat="server"></TD>
								</TR>
							</TABLE>
					</TD>
					</TR>
			</TABLE>
		</form>
		<script language="jscript">
			if(document.getElementById('txtUserName').value == "")
			{
				document.getElementById('txtUserName').focus();
			}
			else
			{
				document.getElementById('txtPasswordOld').focus();
				document.getElementById('txtPasswordOld').select();
			}	
		</script>
	</body>
</HTML>
