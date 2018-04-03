<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Transfer.aspx.cs" Inherits="Transfer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Перерахування коштів з технічного рахунку</title>
    <link href="style/style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="script/JScript.js"></script>    
    <script language="JavaScript" type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>	    
</head>
<body>
    <form id="form1" runat="server">
    <table class="MainTable">
        <tr>
            <td align="center" colspan="3">
                <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" 
                    Text="Перерахування коштів з технічного рахунку"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table class="InnerTable">
                    <tr>
                        <td style="width: 30%">
                            <asp:Label ID="lbClient" runat="server" CssClass="InfoText" Text="Клієнт"></asp:Label></td>
                        <td style="width: 40%">
                            <asp:TextBox ID="textNMK" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="ПІБ клієнта" TabIndex="11"></asp:TextBox></td>
                        <td style="width: 10%">
                            <asp:TextBox ID="textRNK" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Реєстраційний номер клієнта" TabIndex="12"></asp:TextBox></td>
                        <td style="width: 20%">
                            <asp:TextBox ID="textOKPO" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Ідентифікаційний код клієнта" TabIndex="13"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDptId" runat="server" CssClass="InfoText" Text="Депозит"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="textDPT_NUM" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="№ депозитного договору" TabIndex="14"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbNLS" runat="server" Text="Технічний рахунок" CssClass="InfoText"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textNLS" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Рахунок" TabIndex="15"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textKV" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Валюта" TabIndex="16"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textSUM" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Залишок" TabIndex="17"></asp:TextBox>
                        </td>                                                                        
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDat" runat="server" CssClass="InfoText" Text="Дата відкриття рахунку"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="textDAT" runat="server" ReadOnly="true" CssClass="InfoText" TabIndex="18"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table class="InnerTable">
                    <tr>
                        <td style="width:30%">
                            <asp:Label ID="lbTransfer" runat="server" CssClass="InfoText" Text="Сума виплати"></asp:Label>
                        </td>
                        <td style="width:20%">
                            <asp:TextBox ID="Sum" runat="server" TabIndex="1" style="text-align: right" MaxLength="12" CssClass="DateSum"></asp:TextBox>
                            <script type="text/javascript" language="javascript">
                                init_numedit("Sum",(""==document.getElementById("Sum").value)?(0):(document.getElementById("Sum").value),2);                                
                            </script>
                        </td>
                        <td style="width:40%">
                            <input id="btPay" class="AcceptButton" type="button" onclick="if (CheckSum())Transfer()"
                                value="Перерахувати кошти" runat="server" tabindex="7" />
                        </td>
                        <td style="width:10%">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbCommission" runat="server" CssClass="InfoText" Text="Сума комісії"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="Commission" runat="server" TabIndex="1" style="text-align: right" MaxLength="12" ReadOnly="True" CssClass="DateSum"></asp:TextBox>
                            <script type="text/javascript" language="javascript">
                                init_numedit("Commission",(""==document.getElementById("Commission").value)?(0):(document.getElementById("Commission").value),2);
                            </script>                        
                        </td>
                        <td>
                            <input id="btPayCommission" class="AcceptButton" type="button" value="Оплатити комісію" runat="server" onclick="TakeTransferComission()" tabindex="8" disabled="disabled" />
                        </td>
                        <td>
                        </td>
                    </tr>                    
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table class = "InnerTable" id="tbDocs"  runat="server" visible="false">
                    <tr>
                        <td style="width:30%">
                            <input id="btFormDocuments" class="AcceptButton" runat="server" 
                                onclick="if (GetTemplates())" type="button" value="Формувати документи" 
                                onserverclick="btFormDocuments_ServerClick" tabindex="9" />
                        </td>
                        <td style="width:40%">
                            <input id="btPrintDocuments" class="AcceptButton" type="button" 
                                value="Друкувати документи" onclick="if (ckFill('Templates','Документи не сформовані!'))ShowPrintDialog()" runat="server" tabindex="10" />
                        </td>
                        <td style="width:30%">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table class = "InnerTable" id="tbTransferInfo"  runat="server" visible="false">
                    <tr>
                        <td colspan="3" align="center">
                            <asp:Label ID="lbInfo" runat="server" CssClass="InfoText" Text="Параметри перехування суми"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:30%">                            
                            <asp:Label ID="lbReciever" runat="server" CssClass="InfoText" Text="Отримувач"></asp:Label></td>
                        <td style="width:40%">
                            <asp:TextBox ID="textNMS_B" runat="server" CssClass="InfoText" ToolTip="ПІБ одержувача" MaxLength="256" TabIndex="2"></asp:TextBox>
                        </td>
                        <td style="width:30%">
                            <asp:TextBox ID="textOKPO_B" runat="server" CssClass="InfoText" ToolTip="Ідентифікаційний код отримувача" MaxLength="10" TabIndex="3"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>                            
                            <asp:Label ID="lbRecieverNLS" runat="server" CssClass="InfoText" Text="Рахунок для перерахування"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="textNLS_B" runat="server" CssClass="InfoText" ToolTip="Номер рахунку отримувача" MaxLength="14" TabIndex="4"></asp:TextBox>                            
                        </td>
                        <td>
                            <asp:TextBox ID="textMFO_B" runat="server" CssClass="InfoText" ToolTip="МФО отримувача" MaxLength="6" TabIndex="5"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbNazn" runat="server" CssClass="InfoText" Text="Призначення платежу"></asp:Label></td>                    
                        <td colspan="2">
                            <asp:TextBox ID="textNAZN" runat="server" CssClass="InfoText" ToolTip="Призначення платежу" TextMode="MultiLine" MaxLength="1024" TabIndex="6"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
            <tr>
                <td>
                    <input id="PASP" runat="server" type="hidden" /><input id="NMK" runat="server" type="hidden" />
                    <input id="PASPN" runat="server" type="hidden" /><input id="ATRT" runat="server" type="hidden" />                    
                    <input id="ADRES" runat="server" type="hidden" /><input id="DT_R" runat="server" type="hidden" />
                    
                </td>
                <td>
                    <input id="DPT_ID" runat="server" type="hidden" /><input id="NLS" runat="server" type="hidden" />
                    <input id="LCV" runat="server" type="hidden" /><input id="cash" runat="server" type="hidden" />                
                    <input id="KV" runat="server" type="hidden" /><input id="SMAIN" runat="server" type="hidden" />
                </td>
                <td>
                    <input id="tt" runat="server" type="hidden" />
                    <input id="tt_IN" runat="server" type="hidden" /><input id="tt_IN_K" runat="server" type="hidden" />
                    <input id="tt_OUT" runat="server" type="hidden" /><input id="tt_OUT_K" runat="server" type="hidden" />                    
                </td>
            </tr>     
        <tr>
            <td>
                <asp:ScriptManager id="ScriptManager1" runat="server" EnablePageMethods="True">
                    <Scripts>
                        <asp:ScriptReference Path="JScript.js" />
                    </Scripts>
                </asp:ScriptManager>
            </td>
            <td>
                <input id="Templates" runat="server" type="hidden" />
                <input id="maxSUM" runat="server" type="hidden" />
                <input id="ourMFO" runat="server" type="hidden" />
            </td>
            <td>
            </td>
        </tr>
    </table>
    </form>
    <script language="javascript" type="text/javascript">
        if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
    </script>
    <script type="text/javascript" language="javascript">
		if (document.getElementById("textNMS_B"))
		    document.getElementById("textNMS_B").attachEvent("onkeydown",doAlpha);
		if (document.getElementById("textOKPO_B"))
		    document.getElementById("textOKPO_B").attachEvent("onkeydown",doNum);
		if (document.getElementById("textNLS_B"))
		    document.getElementById("textNLS_B").attachEvent("onkeydown",doNumAlpha);
		if (document.getElementById("textMFO_B"))
		    document.getElementById("textMFO_B").attachEvent("onkeydown",doNum);
		if (document.getElementById("textNAZN"))
		    document.getElementById("textNAZN").attachEvent("onkeydown",doNumAlpha);
	</script>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('Sum');
       }       
    </script>	    	
</body>
</html>
