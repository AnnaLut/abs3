<%@ Page language="c#" Inherits="barsroot.barsweb.LoginPage" CodeFile="loginpage.aspx.cs" Culture="uk-UA" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Вхід в систему</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="javascript" src="\Common\Script\Encrypt\sha1.js"></script>
		<script language="javascript" src="\Common\Script\Encrypt\rc4.js"></script>
	    <script language="javascript" src="\Common\Script\BaseFunc.js"></script>
		<script language="javascript">
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
		
		function DisablePrnScr()
        {
            window.history.forward(-1);
            //Get login from cookies
            var login = getCookie('userLogin');
            if(login && document.all.txtUserName){
                document.all.txtUserName.value = login;
                document.all.txtPassword.focus();
            }
            
            if(document.all.hDisPrnScr && document.all.hDisPrnScr.value == "On")
            {
                try 
                {
                  var ax =  new ActiveXObject("BARSIE.BARSPRINT");
                  ax.DisablePrintScr();
                }
                catch(e)
                {
                  return;
                }
            }     
        }
        function doLogin(userName,password)
		{
			with (document.AuthForm) 
			{
			    challenge.value = "<%=GetChallenge()%>";
				var user_key = "<%=GetUserKey()%>";
				var const_key = "<%=GetConstKey()%>";
				encdata.value = base$encodeBase64(rc4Encrypt(user_key,
				                const_key + "\\" 
				                + challenge.value + "\\" 
				                + user_key+ "\\" 
							    + base$encodeBase64(userName) + "\\" 
							    + base$encodeBase64(hex_sha1(password))));
			}
			return;
		}
        function validateForm()
        {
          if(!validateUserame())
				return false;
		  if(!validatePassword())
				return false;
		  document.forms[0].btLogIn.disabled = true;
		  document.forms[0].txtUserName.disabled = true;
		  document.forms[0].txtPassword.disabled = true;
		  with (document.AuthForm) 
		  {
   		    doLogin(txtUserName.value.toLowerCase(),txtPassword.value.toLowerCase());
   		    var date = new Date((new Date()).getTime() + 24*3600000);
   		    document.cookie = 'userLogin=' + txtUserName.value.toLowerCase()+"; expires=" + date.toGMTString();
   		    txtUserName.value = "";
		    txtPassword.value = "";
		    document.forms[0].submit();
		  }  
    	  return true;			
        }
        
        function validateUserame() 
		{ 
			var tempName=document.forms[0].txtUserName.value;

			if(isEmpty(tempName))
			{
				alert("Задайте ім'я користувача.");
				document.forms[0].txtUserName.focus();
				document.forms[0].txtUserName.select();
				return false;
			}
			else
			{
				return true;
			}
		}
		function validatePassword() 
		{ 
			var tempName=document.forms[0].txtPassword.value;

			if(isEmpty(tempName))
			{
				alert("Задайте пароль користувача.");
				document.forms[0].txtPassword.focus();
				document.forms[0].txtPassword.select();
				return false;
			}
			else
			{
				return true;
			}
		}
		
		function isEmpty(strTextField)
		{
			if (strTextField == "" || strTextField==null)
				return true;
			
			var re = /\s/g; 
			RegExp.multiline = true;
			var str = strTextField.replace(re, "");
			
			if (str.length == 0) 
				return true;
			else
				return false;
		}
        
		</script>
	<base target="_self" />
	</HEAD>
	<body bgColor= "#e1e8f0" topmargin=0 leftmargin=0 rightmargin=0 onload="DisablePrnScr()">
		<form id="AuthForm" 
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
					<TD align="center">
                        <TABLE id="Table" cellSpacing="0" cellPadding="0" width="50%" align="center" border="0">
								<TR>
									<TD align="center" colSpan="2">
                                        &nbsp;<asp:Label ID="lnEnterSystem" runat="server" Font-Bold="True" Font-Names="Verdana"
                                            Font-Size="12pt" Text="Вхід в систему" Visible="False"></asp:Label></TD>
								</TR>
								<TR>
									<TD align="center" colSpan="2" height="5"></TD>
								</TR>
								<TR>
									<TD align="right"><asp:label id="lbUser" runat="server" Font-Names="Verdana" Font-Size="12pt" ForeColor="Black"
											Font-Bold="True" Visible="False">Користувач:</asp:label></TD>
									<TD><asp:textbox id="txtUserName" tabIndex="1" runat="server" BorderStyle="Ridge"
											Width="200px" Visible="False"></asp:textbox></TD>
								</TR>
								<TR>
									<TD align="right"><asp:label id="lbPsw" runat="server" Font-Names="Verdana" Font-Size="12pt" ForeColor="Black"
											Font-Bold="True" Visible="False">Пароль:</asp:label></TD>
									<TD><asp:textbox id="txtPassword" tabIndex="2" runat="server" BorderStyle="Ridge"
											Width="200px" TextMode="Password" Visible="False"></asp:textbox></TD>
								</TR>
								<TR>
									<TD align="right"></TD>
									<TD align="left"><asp:button id="btLogIn" tabIndex="3" runat="server" ForeColor="#004000" Width="100px" Text="Вхід" onclick="btLogIn_Click" Visible="False"></asp:button></TD>
								</TR>
								<TR>
									<TD align="center" colSpan="2" style="margin-top:20px; height: 20px" valign="middle"><A id=linkChangePsw runat=server style="FONT-SIZE: 8pt; FONT-FAMILY: Verdana" onclick="location.replace('changepsw.aspx'+location.search)"
											href="#" visible="false">Змінити пароль користувача</A></TD>
								</TR>
								<TR>
									<TD align="center" colSpan="2"><asp:label id="lbMessage" runat="server" Font-Names="Verdana" Font-Size="8pt" ForeColor="Red"
											Visible="False">Вхід неможливий: невірний користувач\пароль</asp:label></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
                <tr>
                    <td align="center">
                        <asp:Label ID="lbSelectBankDate" runat="server" Font-Bold="True" Font-Names="Verdana"
                            Font-Size="12pt" Text="Виберіть робочу банківську дату" Visible="False"></asp:Label></td>
                </tr>
                <tr>
                    <td align="center" style="height: 10px">
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Calendar ID="Calendar" runat="server" BackColor="White" BorderColor="Black"
                            BorderStyle="Solid" CellSpacing="2" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black"
                            Height="250px" Width="330px" OnDayRender="Calendar_DayRender" Visible="False" OnSelectionChanged="Calendar_SelectionChanged">
                            <SelectedDayStyle BackColor="White" ForeColor="Black" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <DayStyle BackColor="#CCCCCC" ForeColor="Black" BorderColor="Gray" BorderStyle="Solid" BorderWidth="2px" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <NextPrevStyle Font-Bold="True" Font-Size="12pt" ForeColor="Black" />
                            <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                            <TitleStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True"
                                Font-Size="12pt" ForeColor="Black" Height="12pt" Font-Names="Verdana" />
                        </asp:Calendar>
                    </td>
                </tr>
                <tr>
                    <td align="center" style="height: 10px">
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="btNext" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
                            OnClick="btNext_Click" TabIndex="1" Text="Продовжити" Visible="False" /></td>
                </tr>
			</TABLE>
			<div style="position: absolute;top:100%;margin-top: -20px;right:0;">
			    <asp:label id="lbServer" runat="server" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black"></asp:label>
			</div>
			<INPUT type="hidden" id="encdata" name="encdata">
			<INPUT type="hidden" id="challenge" name="challenge">
		</form>
		<script language="jscript">
		    if(document.getElementById('txtUserName')){
		        try{
			        document.getElementById('txtUserName').focus();
			        document.getElementById('txtUserName').select();
			    }
			    catch(e){};
			 }
			 else if(document.getElementById('btNext'))
			    document.getElementById('btNext').focus();
		</script>
	</body>
</HTML>
