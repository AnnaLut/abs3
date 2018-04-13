<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="Query" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Виплата відсотків та вкладів в іншому відділені</title>
    <link href="Style/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="Script/script.js"></script>	
    <script type="text/vbscript"   language="vbscript" src="Script/base.vbs"></script>	    
    <script type="text/javascript" language="javascript" src="Script/base.js"></script>	    
	<script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>
	<script language="JavaScript" type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>	
	<style type="text/css">.webservice { BEHAVIOR: url(/Common/WebService/js/WebService.htc) }</style>	
	<script type="text/javascript" language="javascript">var noCheck = 0;</script>
</head> 
<body onload="LoadQuery()">
    <form id="form1" runat="server">
    <div>
        <table id="tbMain" class="MainTable">
            <tr>
                <td colspan="3" align="center">
                    <asp:Label ID="lbTitle" runat="server" Text="Виплата відсотків і вкладу в іншому відділені" CssClass="HeaderText"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="3">
                </td>
            </tr>
            <tr>
                <td style="width:35%">
                    <asp:Label ID="lbDepartmet" runat="server" CssClass="InfoText" Text="Відділення, де відкритий депозитний договір"></asp:Label></td>
                <td style="width:50%">
                    <asp:DropDownList ID="listBranch" runat="server" CssClass="InfoText" TabIndex="1" onclick="ShowMetaTable();">
                        <asp:ListItem Selected="True" Value="/">Банк</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="width:15%">
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbDptNumber" runat="server" CssClass="InfoText" Text="Номер депозитного договору"></asp:Label></td>
                <td>
                    <asp:TextBox ID="DptNum" runat="server" CssClass="InfoText" TabIndex="2" MaxLength="20"></asp:TextBox></td>
                <td>
                    </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbLastName" runat="server" CssClass="InfoText" Text="Прізвище"></asp:Label></td>
                <td>
                    <asp:TextBox ID="LastName" runat="server" CssClass="InfoText" TabIndex="3" MaxLength="70"></asp:TextBox></td>
                <td>
                    </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbFirstName" runat="server" CssClass="InfoText" Text="Ім'я"></asp:Label></td>
                <td>
                    <asp:TextBox ID="FirstName" runat="server" CssClass="InfoText" TabIndex="4" MaxLength="70"></asp:TextBox></td>
                <td>
                    </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbPatronimic" runat="server" CssClass="InfoText" Text="По-батькові"></asp:Label></td>
                <td>
                    <asp:TextBox ID="Patronimic" runat="server" CssClass="InfoText" TabIndex="5" MaxLength="70"></asp:TextBox></td>
                <td>
                    </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbOKPO" runat="server" CssClass="InfoText" Text="Ідентифікаційний код"></asp:Label></td>
                <td>
                    <asp:TextBox ID="OKPO" runat="server" CssClass="InfoText" TabIndex="6" MaxLength="12"></asp:TextBox></td>
                <td>
                    </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbDocSerial" runat="server" CssClass="InfoText" Text="Серія паспорта"></asp:Label></td>
                <td>
                    <asp:TextBox ID="DocSerial" runat="server" onblur="ckSerial()" CssClass="InfoText" TabIndex="7" MaxLength="2"></asp:TextBox></td>
                <td>
                    </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbDocNumber" runat="server" CssClass="InfoText" Text="Номер паспорта"></asp:Label></td>
                <td>
                    <asp:TextBox ID="DocNumber" runat="server" onblur="ckNumber()" CssClass="InfoText" TabIndex="8" MaxLength="6"></asp:TextBox></td>
                <td>
                    </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbDocDate" runat="server" CssClass="InfoText" Text="Дата видачі паспорта"></asp:Label></td>
                <td>
                    <input id='DocDate' type='hidden'/><input id='DocDate_Value' type='hidden' name="DocDate"/><input id='DocDate_TextBox' TabIndex="9" style="TEXT-ALIGN:center" name="DocDate"/>
                    <script language="javascript" type="text/javascript">
                          window['DocDate'] = new RadDateInput('DocDate', 'Windows');
                          window['DocDate'].PromptChar='_'; 
                          window['DocDate'].DisplayPromptChar='_';
                          window['DocDate'].SetMask(rdmskr(1, 31, false, true),rdmskl('/'),rdmskr(1,12, false, true),rdmskl('/'),rdmskr(1, 2099, false, true));	
                          window['DocDate'].RangeValidation=true; 
                          window['DocDate'].SetMinDate('01/01/1900 00:00:00'); 
                          window['DocDate'].SetMaxDate('31/12/2099 00:00:00'); 
                          window['DocDate'].SetValue('01/01/2000');                     
                          window['DocDate'].Initialize();
                    </script>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbQueryType" runat="server" CssClass="InfoText" Text="Тип запиту"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="listType" runat="server" CssClass="InfoText" TabIndex="10">
                        <asp:ListItem Selected="True" Value="0">Інформаційний</asp:ListItem>
                        <asp:ListItem Value="1">Виплата відсотків</asp:ListItem>
                    </asp:DropDownList>
               </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbSum" runat="server" CssClass="InfoText" Text="Сума до видачі"></asp:Label></td>
                <td>
                    <asp:TextBox ID="Sum" runat="server" TabIndex="11" style="text-align: center" MaxLength="12"></asp:TextBox>
                    <script type="text/javascript" language="javascript">
                        init_numedit("Sum",(""==document.getElementById("Sum").value)?(0):(document.getElementById("Sum").value),2);
                    </script>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="btSubmit" class="NextButton" tabindex="20" type="button" onclick="if (CheckControls()) SubmitQuery()" value="Сформувати запит" />
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
        <div class="webservice" id="webService" showProgress="true"/>
    </div>
    </form>
</body>
</html>
