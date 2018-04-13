<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page Language="c#" CodeFile="DepositAddRegular.aspx.cs" AutoEventWireup="true" Inherits="DepositAddRegular" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Extenders.Controls" Namespace="Bars.Extenders.Controls" TagPrefix="uc3" %>
<%@ Register Src="~/UserControls/EADoc.ascx" TagName="EADoc" TagPrefix="uc" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagPrefix="uc" TagName="TextBoxDate" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagPrefix="uc" TagName="TextBoxDecimal" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagPrefix="uc" TagName="LabelTooltip" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Депозитний модуль: Додаткова угода Довгострокове доручення вкладника на списання коштів</title>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/AccCk.js"></script>
    <script type="text/javascript" language="javascript">
        function AddListener4Enter() {
            AddListeners("textBankAccount,textBankMFO,textIntRcpName,textIntRcpOKPO,textAccountNumber,textRestRcpMFO,textRestRcpOKPO,textRestRcpName",
		    'onkeydown', TreatEnterAsTab);
        }
        function AfterPageLoad() {
            // document.getElementById('textBankMFO').fireEvent('onblur');
            // document.getElementById('textRestRcpMFO').fireEvent('onblur');

            //document.getElementById('textRestRcpMFO').readOnly = true;
            //document.getElementById('textAccountNumber').readOnly = true;
            //document.getElementById('textRestRcpName').readOnly = true;
            //document.getElementById('textRestRcpOKPO').readOnly = true;

            if (document.getElementById('textBankAccount')) {
                document.getElementById('textBankMFO').readOnly = true;
                document.getElementById('textBankAccount').readOnly = true;
                document.getElementById('textIntRcpName').readOnly = true;
                document.getElementById('textIntRcpOKPO').readOnly = true;
            }

            // focusControl('btnDeposit');
        }

        function validateForm() {
            var result = true;
            var nls = document.getElementById('textBankAccount');

            var startDate = document.getElementById('StartDate_t');
            var endDate = document.getElementById('EndDate_t');

            var startDateArray = document.getElementById('StartDate_t').value.split('/')//date format 'dd/MM/yyyy'
            var startDate1 = new Date(startDateArray[2], parseInt(startDateArray[1], 10) - 1, startDateArray[0])
                        
            var endDateArray = document.getElementById('EndDate_t').value.split('/')//date format 'dd/MM/yyyy'
            var endDate1 = new Date(endDateArray[2], parseInt(endDateArray[1], 10) - 1, endDateArray[0])

            var tmpDate = new Date();
            var systemDate = new Date(tmpDate.getFullYear(), tmpDate.getMonth(), tmpDate.getDay());

            if (nls.value == '') {
                result = false;
                addClass(nls, 'error');
                document.getElementById('NlsValidate').innerHTML = 'Виберіть рахунок';
            }
            else {
                removeClass(nls, 'error');
                document.getElementById('NlsValidate').innerHTML = '';
            }

            if (startDate.value == '') {              
                result = false;
                addClass(startDate, 'error');
                document.getElementById('StartDateValidate').innerHTML = 'Заповніть поле дата початку';
            }
            else {
                if (startDate1 < systemDate) {
                    alert(startDate1 + ' < ' + systemDate);
                    result = false;
                    addClass(startDate, 'error');
                    document.getElementById('StartDateValidate').innerHTML = 'Дата початку має буте більша за поточну або поточна';
                }
                else {
                    removeClass(startDate, 'error');
                    document.getElementById('StartDateValidate').innerHTML = '';
                }
            }
            if (endDate.value == '') {
                result = false;
                addClass(endDate, 'error');
                document.getElementById('EndDateValidate').innerHTML = 'Заповніть поле дата закінчення';
            }
            else {
                if (endDate1 < startDate1) {
                    result = false;
                    addClass(endDate, 'error');
                    document.getElementById('EndDateValidate').innerHTML = 'Дата закінчення має буте більша за дату початку';
                }
                else {
                    removeClass(endDate, 'error');
                    document.getElementById('EndDateValidate').innerHTML = '';
                }
            }
            return result;
        }
        //функція додавання класу до елемента аналог JQuery.addClass()
        function addClass(o, c) {
            var re = new RegExp("(^|\\s)" + c + "(\\s|$)", "g");
            if (re.test(o.className)) return;
            o.className = (o.className + " " + c).replace(/\s+/g, " ").replace(/(^ | $)/g, "");
        }
        //функція віднімання класу від елемента аналог JQuery.removeClass()
        function removeClass(o, c) {
            var re = new RegExp("(^|\\s)" + c + "(\\s|$)", "g");
            o.className = o.className.replace(re, "$1").replace(/\s+/g, " ").replace(/(^ | $)/g, "");
        }
        CrossAddEventListener(window, 'onload', AddListener4Enter);
    </script>
    <style type="text/css">
        .InfoLabel
        {
            text-align: center;
        }
        .style1
        {
            height: 232px;
        }
        .style2
        {
            width: 23%;
        }
        .style3
        {
            width: 758px;
        }
        .style4
        {
            width: 875px;
        }
        .style5
        {
            width: 23%;
            height: 25px;
        }
        .style6
        {
            width: 758px;
            height: 25px;
        }
        .error input[type=text],
        input.error {
            border: 1px solid red !important;
            background-color: #fffacd;
        }
    </style>
    </head>
<body onload="AfterPageLoad();">
    <form id="Form1" method="post" runat="server">
    <table class="MainTable" id="InnerTable">
        <tr align="center"  dir="ltl">
            <td>
                <table id="ContractTable" class="InnerTable">
                    <tr>
                        <td class="style4">
                            <asp:Label ID="lbDUInfo" meta:resourcekey="lbDUInfo" CssClass="InfoLabel"
                                runat="server" Height="20px">Додаткова угода "Довгострокове доручення вкладника на списання коштів з карткового рахунку"</asp:Label>
                        </td>
                    </tr>
            </td>
            <tr>
         
                <td colspan="1" class="style4">
                <table id="tbTerm" runat="server" class="InnerTable">
                  <tr>
                       <td class="style2"> 
                         <asp:Label ID="lbClientInfo" meta:resourcekey="lbClientInfo2" CssClass="InfoText" runat="server">Вкладник</asp:Label>
                       </td>
                       <td class="style3">
                         <asp:TextBox ID="textClientName" runat="server" CssClasts="InfoText" 
                               ReadOnly="True" BackColor="WhiteSmoke" Width="600px"></asp:TextBox>
                       </td>
                  </tr>                  
                  <tr>
                       <td class="style2"> 
                         <asp:Label ID="lbContractType" meta:resourcekey="lbContractType" runat="server" CssClass="InfoText">Вид договора</asp:Label>
                       </td>
                       <td class="style3">
                         <asp:TextBox ID="textContractType" meta:resourcekey="textContractTypeName" 
                               runat="server" CssClass="InfoText" ToolTip="Вид депозитного договору" 
                               ReadOnly="true" BackColor="WhiteSmoke" Width="600px"/>
                       </td>
                  </tr>
                  <tr>
                       <td class="style2"> 
                         <asp:Label ID="lbContractID" meta:resourcekey="lbContractID" runat="server" CssClass="InfoText">Идентификатор договора</asp:Label>
                       </td>
                       <td class="style3">
                         <asp:TextBox ID="textContractID" meta:resourcekey="textContractIDName" 
                               runat="server" CssClass="InfoText" 
                               ToolTip="Идентификатор депозитного договору"  ReadOnly="true" 
                               BackColor="WhiteSmoke" Width="600px"/>
                       </td>
                  </tr>
                   <tr>
                       <td class="style2"> 
                         <asp:Label ID="lbCur" meta:resourcekey="lbCur" runat="server" CssClass="InfoText">Валюта договора</asp:Label>
                       </td>
                       <td class="style3">
                         <asp:TextBox ID="textCur" runat="server" CssClass="InfoText" 
                               ToolTip="Валюта договору" BackColor="WhiteSmoke" ReadOnly="true" Width="600px"></asp:TextBox>
                       </td>
                  </tr>
                  
                  <tr> <td class="style2"></td>
                       <td class="style3" > 
                         <asp:Label ID="lbClientInfo3" meta:resourcekey="lbClientInfo3" CssClass="InfoLabel" runat="server">Перелік існуючих ДУ про регулярні платежі клієнта</asp:Label>
                       </td>                    
                  </tr>
                 	<tr>
					<td colSpan="2" class="style1">
                        <asp:datagrid id="gridRegular" runat="server" 
                            CssClass="BaseGrid" EnableViewState="False" HorizontalAlign="Left"
							AutoGenerateColumns="False" style="margin-right: 0px">
							<Columns>
								<asp:BoundColumn DataField="ord" HeaderText="№">
									<HeaderStyle Width="2%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="freq" HeaderText="Періодичність">
									<HeaderStyle Width="2%"></HeaderStyle>
								</asp:BoundColumn>
                                <asp:BoundColumn DataField="DAT1" HeaderText="З">
									<HeaderStyle Width="2%"></HeaderStyle>
								</asp:BoundColumn>
                                <asp:BoundColumn DataField="DAT2" HeaderText="По">
									<HeaderStyle Width="3%"></HeaderStyle>
								</asp:BoundColumn>
                                <asp:BoundColumn DataField="nlsa" HeaderText="Рахунок А">
									<HeaderStyle Width="3%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="nlsb" HeaderText="Рахунок B">
									<HeaderStyle Width="15%"></HeaderStyle>
								</asp:BoundColumn>								
                                <asp:BoundColumn DataField="FSUM" HeaderText="Сума">
									<HeaderStyle Width="15%"></HeaderStyle>
								</asp:BoundColumn>						    
                                <asp:BoundColumn DataField="NAZN" HeaderText="Призначення">
									<HeaderStyle Width="45%"></HeaderStyle>
								</asp:BoundColumn>						    
								
							</Columns>
						</asp:datagrid></td>
				</tr>

                    <tr> <td class="style2"></td>
                        <td class="style3">
                        <asp:Label ID="lbDUInfo2" meta:resourcekey="lbDUInfo2" CssClass="InfoLabel"
                             runat="server" >Додати новий регулярний платіж</asp:Label>
                        </td>
                    </tr>

                   <tr>
                       <td class="style2"> 
                         <asp:Label ID="lbAccountNLS" meta:resourcekey="lbAccountNLS" runat="server" CssClass="InfoText">Картковий рахунок в валюті договора (Рахунок відправника)</asp:Label>
                       &nbsp;</td>
                       <td class="style3">
                        <asp:TextBox ID="textBankAccount" meta:resourcekey="textNLS" runat="server" CssClass="InfoText"
                                            BorderStyle="Outset" MaxLength="14" ToolTip="Номер счета" 
                               TabIndex="2" Font-Bold="True"></asp:TextBox>   
                           <span runat="server" id="NlsValidate" style="color: red"></span>                        
                       </td>
                       <td>
                            <input type="button" id="btnPercent" value="?" runat="server" class="HelpButton" BackColor = "whitesmoke"
                            onclick="SearchAccounts('BPK190', 'textBankAccount', 'textBankMFO', 'textIntRcpOKPO', 'textIntRcpName');" />
                       </td>
                  </tr>
                  <tr>
                   <td class="style2" dir="rtl">
                     <asp:Label ID="lbBankMFO" Text="МФО банку" meta:resourcekey="lbMFO" 
                           runat="server" CssClass="InfoText" ForeColor="#999999" 
                           Font-Size="X-Small" />
                   </td>
                   <td class="style3">
                     <asp:TextBox ID="textBankMFO" meta:resourcekey="textMFO" runat="server" 
                           CssClass="InfoText" readonly="true"
                                            BorderStyle="Inset" MaxLength="12" 
                           ToolTip="МФО банка" TabIndex="1" BackColor="WhiteSmoke"></asp:TextBox>
                   </td>
                  </tr>
                  <tr>
                   <td class="style2" dir="rtl">
                     <asp:Label ID="lbIntRcpName" meta:resourcekey="lbNMK2" runat="server" 
                           CssClass="InfoText" ForeColor="#999999" Font-Size="X-Small">Назва клієнта-платника</asp:Label>
                   </td>
                   <td class="style3">
                      <asp:TextBox ID="textIntRcpName" meta:resourcekey="textNMK" runat="server" CssClass="InfoText"  readonly="true" BackColor="WhiteSmoke"
                                        BorderStyle="Inset" MaxLength="35" ToolTip="     Назва клієнта-платника" TabIndex="4"></asp:TextBox>
                   </td>
                  </tr>
                  <tr>
                   <td class="style2" dir="rtl">
                    <asp:Label ID="lbIntRcpOKPO" meta:resourcekey="lbIntRcpOKPO" runat="server" 
                           CssClass="InfoText" ForeColor="#999999" Font-Size="X-Small">Код ЄДРПОУ платника</asp:Label>
                   </td>
                   <td class="style3">
                   <asp:TextBox ID="textIntRcpOKPO" meta:resourcekey="textIntRcpOKPO" runat="server" readonly="true" enable="false" BackColor="WhiteSmoke"
                                            CssClass="InfoText" BorderStyle="Inset" MaxLength="10" ToolTip="     Код ОКПО" TabIndex="3"></asp:TextBox>
                   </td>
                  </tr>
                    <tr>
                       <td class="style2" dir="rtl"> 
                         <asp:Label ID="lbAccountDPTNLS" meta:resourcekey="lbAccountDPTNLS" runat="server" 
                               CssClass="InfoText" ForeColor="#999999" Font-Size="X-Small">Рахунок договора (Рахунок отримувача)</asp:Label>
                       </td>
                       <td class="style3">
                         <asp:TextBox ID="textDPTAccount" runat="server" BorderStyle="Inset" readonly = "true" CssClass="InfoText" MaxLength="14" meta:resourcekey="textNLS" BackColor="WhiteSmoke" ToolTip="Номер счета"></asp:TextBox>
                       </td>
                     </tr>  
                   </tr>
                   <tr>
                       <td class="style2"> 
                         <asp:Label ID="lbSumRegular" meta:resourcekey="lbSumRegular" runat="server" CssClass="InfoText">Сума регулярного платежу</asp:Label>
                       </td>
                       <td class="style3">
                        <Bars:BarsNumericTextBox ID="textSumRegular" Style="text-align: right" runat="server" DbValue='<%# Bind("S") %>'>
                                        <NumberFormat AllowRounding="false" DecimalDigits="2" GroupSeparator="" />
                        </Bars:BarsNumericTextBox>                        
                       </td>
                  </tr>
                    <tr>
                       <td class="style2" dir="rtl"> 
                         <asp:Label ID="lbNazn" meta:resourcekey="lbNazn" runat="server" 
                               CssClass="InfoText" ForeColor="#999999" Font-Size="X-Small">Призначення платежу</asp:Label>
                       </td>
                       <td class="style3">
                         <asp:TextBox ID="textNazn" runat="server" BorderStyle="Inset" readonly = "true" 
                               CssClass="InfoText" MaxLength="14" meta:resourcekey="textNAZN" 
                               ToolTip="Призначення платежу" Width="610px" BackColor="WhiteSmoke"></asp:TextBox>
                       </td>
                     </tr>  
                   </tr>
            <tr>
                <td class="style2">
                    <input id="NMK" type="hidden" runat="server" />
                    <input id="IDD" type="hidden" runat="server" />
                    <input id="OKPO" type="hidden" runat="server" /><input id="rnk" type="hidden" runat="server" />
                    <input id="cur_id" type="hidden" runat="server" />
                    <input id="MFO" type="hidden" runat="server" /><input id="err_n" type="hidden" runat="server"
                        value="0" />
                </td>
                       
            </tr>
                    <tr>
                        <td class="style5">
                            <asp:Label ID="lbStartDate" meta:resourcekey="lbStartDate" runat="server" CssClass="InfoText" >Дата початку дії договору</asp:Label>
                        </td>
                        <td class="style6">
                            <igtxt:webdatetimeedit id="StartDate" runat="server" ToolTip="Дата початку"
                                EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy" HorizontalAlign="Center"
                                MinValue="2000-01-01" tabIndex="25" CssClass="InfoDateSum"  BorderWidth="1">
                                <clientsideevents blur="dtBirthDate_Blur"></clientsideevents>
                            </igtxt:webdatetimeedit>
                            <span runat="server" id="StartDateValidate" style="color: red"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="style5">
                            <asp:Label ID="lbEndDate" meta:resourcekey="lbEndDate" runat="server" CssClass="InfoText">Дата завершення договора</asp:Label>
                        </td>
                        <td class="style6">
                            <igtxt:webdatetimeedit id="EndDate" runat="server" ToolTip="Дата закінчення"
                                EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy" HorizontalAlign="Center"
                                MinValue="2000-01-01" tabIndex="25" CssClass="InfoDateSum" BorderWidth="1">
                                <clientsideevents blur="dtBirthDate_Blur"></clientsideevents>
                            </igtxt:webdatetimeedit>      
                            <span runat="server" id="EndDateValidate" style="color: red"></span>                        
                        </td>
                    </tr>
                      <tr>
                        <td class="style2">
                            <asp:Label ID="lbFreq" meta:resourcekey="lbFreq" runat="server" CssClass="InfoText">Періодичність</asp:Label>
                        </td>                        
                        <td class="style3">
                            <asp:dropdownlist ID="Freq" runat="server" CssClass="InfoText" ReadOnly="False">                                                                           
                            </asp:dropdownlist>
                        </td>
                    </tr>                      
                      <tr>
                        <td class="style2">
                            <asp:Label ID="lbWeek" meta:resourcekey="lbWeek" runat="server" CssClass="InfoText">Врахування вихідних днів</asp:Label>
                        </td>                        
                        <td class="style3">
                            <asp:RadioButton ID="Weekends" Text="-1" runat="server" GroupName="RequestType" PostBack="true" />
                            <asp:RadioButton ID="Weekends_1" Text="+1" runat="server" GroupName="RequestType" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">
                        <asp:Label ID="lbPrior" meta:resourcekey="lbPrior" runat="server" CssClass="InfoText">Прiоритет виконання</asp:Label>
                        </td>
                        <td class="style3">
                            <asp:dropdownlist ID="Proir" runat="server" CssClass="InfoText" ReadOnly="False">                                                                       
                            </asp:dropdownlist>
                        </td>
                        </tr>
                    </table>
                </td>
               </tr>
   </tr>
                    <tr>
                        <td class="style4">
                            <table class="InnerTable">
                                <tr>
                                    <td align="left" style="width:5%">
                                        <asp:Button ID="btnBack" Text="Назад" runat="server" CausesValidation="false" 
                                            tabindex="2" CssClass="AcceptButton" onclick="btnBack_Click" />
                                    </td>
                                    <td align="left" style="width:15%" height="13">
                                        <asp:Button id="btReg" meta:resourcekey="btReg" type="button" 
                                            Text="Створити регулярне поповнення депозитного договору" runat="server" 
                                            tabindex="0" class="AcceptButton" onclick = "btnReg_ServerClick" OnClientClick="return validateForm();" 
                                            Width="559px"/>
                                        <asp:Button ID="btPrint" runat="server" Text="Друк" onclick="btPrint_Click" />
                                    </td>                                    
                                </tr>
                            </table>
                        </td>                        
                    </tr>               
                </table>
            </td>
        </tr>
    </table>
    <!-- #include virtual="/barsroot/deposit/Inc/DepositAccCk.inc"-->
    <!-- #include virtual="/barsroot/deposit/Inc/DepositCk.inc"-->
    <!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
    </form>
</body>
</html>
