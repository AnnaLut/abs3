<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepositTechAcc.aspx.cs" Inherits="DepositTechAcc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Картка технічного рахунку</title>
    <link href="style/style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="script/JScript.js"></script>            
</head>
<body>
    <form id="form1" runat="server">
    <table class="MainTable">
        <tr>
            <td align="center">
                <asp:Label ID="lbSearchInfo" runat="server" CssClass="InfoHeader">Картка технічного рахунку</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td style="width: 30%">
                            <asp:Label ID="lbClient" runat="server" CssClass="InfoText" Text="Клієнт"></asp:Label></td>
                        <td style="width: 40%">
                            <asp:TextBox ID="textNMK" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="ПІБ клієнта" TabIndex="7"></asp:TextBox></td>
                        <td style="width: 10%">
                            <asp:TextBox ID="textRNK" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Реєстраційний номер клієнта" TabIndex="8"></asp:TextBox></td>
                        <td style="width: 20%">
                            <asp:TextBox ID="textOKPO" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Ідентифікаційний код клієнта" TabIndex="9"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDptId" runat="server" CssClass="InfoText" Text="Депозит"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="textDPT_NUM" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="№ депозитного договору" TabIndex="10"></asp:TextBox></td>
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
                            <asp:TextBox ID="textNLS" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Рахунок" TabIndex="11"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textKV" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Валюта" TabIndex="12"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textSUM" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Залишок" TabIndex="13"></asp:TextBox>
                        </td>                                                                        
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDat" runat="server" CssClass="InfoText" Text="Дата відкриття рахунку"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="textDAT" runat="server" CssClass="InfoText" ReadOnly="True" TabIndex="14"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDateClose" runat="server" CssClass="InfoText" Text="Планова дата закриття рахунку"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textDateClose" runat="server" CssClass="InfoText" ReadOnly="True" TabIndex="15"></asp:TextBox>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td style="width:30%;">
                            <input id="btFormDocuments" class="AcceptButton" runat="server" 
                                onclick="if (GetTemplates())" type="button" value="Формувати документи" 
                                onserverclick="btFormDocuments_ServerClick" tabindex="1" />
                        </td>
                        <td style="width:40%;">
                            <input id="btPrintDocuments" class="AcceptButton" type="button" 
                                value="Друкувати документи" onclick="ShowPrintDialog()" runat="server" tabindex="2" />
                        </td>
                        <td style="width:30%;">
                            </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btHistory" class="AcceptButton" type="button" onclick="ShowDoc(document.getElementById('acc').value)" value="Історія рахунку" runat="server" tabindex="3" /></td>
                        <td>
                            <input id="btPay" class="AcceptButton" onclick="ShowDocInput()"
                                type="button" value="Оплатити комісію" runat="server" tabindex="4" />                        
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btSurvey" class="AcceptButton" onclick="ShowSurvey()"
                                type="button" value="Заповнити анкету" runat="server" tabindex="5" /></td>
                        <td><input id="btClose" class="AcceptButton" type="button" value="Закрити рахунок" runat="server" onserverclick="btClose_ServerClick" visible="false" tabindex="6" disabled="disabled" /></td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <input id="acc" runat="server" type="hidden" />
                <input id="Templates" runat="server" type="hidden" />
                <input id="tt" runat="server" type="hidden" />
                <input id="dpt_id" runat="server" type="hidden" />
                
                <input id="PASP" runat="server" type="hidden" />
                <input id="PASPN" runat="server" type="hidden" />
                <input id="ATRT" runat="server" type="hidden" />
                <input id="ADRES" runat="server" type="hidden" />
                <input id="DT_R" runat="server" type="hidden" />
                <input id="NMK" runat="server" type="hidden" />
                
                <input id="KV" runat="server" type="hidden" />                
                <input id="dpf_oper" runat="server" type="hidden" />    
                <input id="AfterPay" runat="server" type="hidden" />    
                <asp:ScriptManager id="ScriptManager1" runat="server" EnablePageMethods="True">
                    <Scripts>
                        <asp:ScriptReference Path="JScript.js" />
                    </Scripts>
                </asp:ScriptManager>            
            </td>            
        </tr>
    </table>
    </form>
    <script type="text/javascript">
       if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('btFormDocuments');
       }       
    </script>	    
</body>
</html>
