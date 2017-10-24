<%@ Page language="c#" CodeFile="cmd.aspx.cs" AutoEventWireup="true" Inherits="cmd"  enableViewState="False" Buffer="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Друк</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript">
		    function ckEnablePrint()
		    {
		        if (document.getElementById('enable_print').value == '1')
		        {
		            document.getElementById('btPrint').disabled = '';
		        }
		    }

            var _mProg = null;

            function hideProgress()
            {
	            if (_mProg == null || _mProg.parentElement == null)
		            return;
	            document.body.removeChild(_mProg);
            }
            function fnShowProgress()
            {
                if (document.getElementById("DptBlankNumValidator"))
                    if (!Page_IsValid) return;
                
	            if (_mProg == null)
	            {
		            var top = document.body.offsetHeight/2 + 15;
		            var left = document.body.offsetWidth/2 - 50;
		            var s = '<div style="position: absolute; top:'+top+'; background:white; left:'+left+'; width:101; height:33;" >'+
		            '</div>';
		            _mProg = document.createElement(s);
		            _mProg.innerHTML = "<img src='/Common/Images/process.gif'>";
	            }
	            if (document.getElementById("DptBlankNumValidator"))
	                _mProg.style.top = document.body.offsetHeight/2 + 15;
	            else 
	                _mProg.style.top = document.body.offsetHeight/2;
	                
	            _mProg.style.left = document.body.offsetWidth/2 - 50;
	            if (_mProg.parentElement == null)
	            document.body.insertAdjacentElement("beforeEnd",_mProg);
            }
		</script>
	</head>
	<body onload="ckEnablePrint();addControl();resize();EnableBlank();">	
		<form id="Form1" method="post" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
	        <table id="tbMain" style="LEFT: 0px; POSITION: absolute; TOP: 0px" width="100%">
		        <tr>
			        <td align="center" style="height: 23px">
	                    <asp:Button id="btPrint" meta:resourcekey="btPrint2" runat="server" 
	                        Text="Печать" disabled="disabled" CssClass="AcceptButton" OnClick="btPrint_Click" />
                    </td>
                </tr>
		        <tr>
			        <td>
				        <table class="InnerTable" id="tbBlanks" runat="server">
                            <tr>
                                <td style="width: 30%">
                                    <asp:label id="lbUse" meta:resourcekey="lbUse" runat="server" CssClass="InfoText">Використовувати бланк</asp:label>
                                </td>
                                <td align="left" style="width: 20%">
                                    <input id="ckUse" onpropertychange="EnableBlank();"  tabindex="1" type="checkbox" checked="checked"
									    runat="server" enableviewstate="true"/>                                     
                                </td>
                                <td style="width: 10%">
                                </td>
                                <td>
                                </td>
                            </tr>
					        <tr>
						        <td style="width:30%"><asp:label id="lbNumBlank" meta:resourcekey="lbNumBlank" runat="server" CssClass="InfoText">Номер бланка</asp:label></td>
						        <td style="width:20%"><asp:textbox id="dptBlankNum" meta:resourcekey="dptBlankNum" runat="server" CssClass="InfoText" MaxLength="20" ToolTip="Номер бланка договора"></asp:textbox></td>
						        <td style="width:10%"></td>
						        <td><asp:requiredfieldvalidator id="DptBlankNumValidator" meta:resourcekey="NeedToFill" runat="server" CssClass="InfoText" ControlToValidate="dptBlankNum"
								        ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
					        </tr>
					        <tr>
						        <td><asp:label id="lbDeadBlankNum" meta:resourcekey="lbDeadBlankNum" runat="server" CssClass="InfoText">Номер испорченого бланка</asp:label></td>
						        <td><asp:textbox id="deadBlankNum" meta:resourcekey="deadBlankNum" runat="server" CssClass="InfoText" MaxLength="20" ToolTip="Номер испорченного бланка договора"></asp:textbox></td>
						        <td></td>
						        <td><asp:requiredfieldvalidator id="deadBlankNumValidator" meta:resourcekey="NeedToFill" runat="server" CssClass="InfoText" ControlToValidate="deadBlankNum"
								        ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
					        </tr>
					        <tr>
					            <td colspan="4">					                
                                </td>
					        </tr>
				        </table>
			        </td>
		        </tr>
	        </table>			
            <input type="hidden" runat="server" id="enable_print" />
            <input type="hidden" runat="server" id="hidFooter" value="" />
            <input type="hidden" runat="server" id="hidHeader" value="" />
			<input type="hidden" runat="server" id="print_buf" value="" />
			<input type="hidden" runat="server" id="FIRST_PRINT" value="1" />
		    <!-- #include virtual="Inc/DepositCk.inc"-->
		    <!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
