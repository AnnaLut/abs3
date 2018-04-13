<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QueryResult.aspx.cs" Inherits="QueryResult" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Результати запиту</title>
    <link href="Style/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="Script/script.js"></script>	
    <script type="text/vbscript"   language="vbscript" src="Script/base.vbs"></script>	    
    <script type="text/javascript" language="javascript" src="Script/base.js"></script>	    
	<script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>
	<script language="JavaScript" type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>	
	<style type="text/css">.webservice { BEHAVIOR: url(/Common/WebService/js/WebService.htc) }</style>	
	<script type="text/javascript" language="javascript">var noCheck = 0;</script>
</head>
<body onload="LoadResponse()" onunload="ClearQuest()">
    <form id="form1" runat="server">
    <div>
        <table id="tbMain" class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" runat="server" Text="Результати запиту" CssClass="HeaderText"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tbError" class="InnerTable">
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbErrM" runat="server" CssClass="InfoText" Text="Помилка"></asp:Label>
                            </td>
                            <td style="width: 50%">
                                <asp:TextBox ID="ErrorMessage" runat="server" CssClass="InfoText" MaxLength="10000" TabIndex="100" TextMode="MultiLine" ReadOnly="True"></asp:TextBox>
                             </td>
                            <td style="width: 20%">
                            </td>                                                        
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <table id="tbInfo" class="InnerTable">
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbId" runat="server" CssClass="InfoText" Text="Ідентифікатор запиту"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="ID" runat="server" CssClass="InfoText" MaxLength="20" TabIndex="2" ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbDepartmet" runat="server" CssClass="InfoText" Text="Відділення, де відкритий депозитний договір"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="Branch" runat="server" CssClass="InfoText" MaxLength="20" TabIndex="2" ReadOnly="True"></asp:TextBox></td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbDptNumber" runat="server" CssClass="InfoText" Text="Номер депозитного договору"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="DptNum" runat="server" CssClass="InfoText" TabIndex="2" MaxLength="20" ReadOnly="True"></asp:TextBox></td>
                            <td>
                                </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbLastName" runat="server" CssClass="InfoText" Text="Прізвище"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="LastName" runat="server" CssClass="InfoText" TabIndex="3" MaxLength="70" ReadOnly="True"></asp:TextBox></td>
                            <td>
                                </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbFirstName" runat="server" CssClass="InfoText" Text="Ім'я"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="FirstName" runat="server" CssClass="InfoText" TabIndex="4" MaxLength="70" ReadOnly="True"></asp:TextBox></td>
                            <td>
                                </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbPatronimic" runat="server" CssClass="InfoText" Text="По-батькові"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="Patronimic" runat="server" CssClass="InfoText" TabIndex="5" MaxLength="70" ReadOnly="True"></asp:TextBox></td>
                            <td>
                                </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbOKPO" runat="server" CssClass="InfoText" Text="Ідентифікаційний код"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="OKPO" runat="server" CssClass="InfoText" TabIndex="6" MaxLength="12" ReadOnly="True"></asp:TextBox></td>
                            <td>
                                </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbDocSerial" runat="server" CssClass="InfoText" Text="Серія паспорта"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="DocSerial" runat="server" onblur="ckSerial()" CssClass="InfoText" TabIndex="7" MaxLength="2" ReadOnly="True"></asp:TextBox></td>
                            <td>
                                </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbDocNumber" runat="server" CssClass="InfoText" Text="Номер паспорта"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="DocNumber" runat="server" onblur="ckNumber()" CssClass="InfoText" TabIndex="8" MaxLength="6" ReadOnly="True"></asp:TextBox></td>
                            <td>
                                </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbDocDate" runat="server" CssClass="InfoText" Text="Дата видачі паспорта"></asp:Label></td>
                            <td>
                                <input id='DocDate' type='hidden'/><input id='DocDate_Value' type='hidden' name="DocDate"/><input id='DocDate_TextBox' TabIndex="9" style="TEXT-ALIGN:center" name="DocDate" readonly="readOnly"/>
                                <script language="javascript" type="text/javascript">
                                      window['DocDate'] = new RadDateInput('DocDate', 'Windows');
                                      window['DocDate'].PromptChar='_'; 
                                      window['DocDate'].DisplayPromptChar='_';
                                      window['DocDate'].SetMask(rdmskr(1, 31, false, true),rdmskl('/'),rdmskr(1,12, false, true),rdmskl('/'),rdmskr(1, 2099, false, true));	
                                      window['DocDate'].RangeValidation=true; 
                                      window['DocDate'].SetMinDate('01/01/1900 00:00:00'); 
                                      window['DocDate'].SetMaxDate('31/12/2099 00:00:00'); 
                                      window['DocDate'].Initialize();
                                </script>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbSum" runat="server" CssClass="InfoText" Text="Сума до видачі"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="Sum" runat="server" TabIndex="11" style="text-align: center" MaxLength="12" ReadOnly="True"></asp:TextBox>
                                <script type="text/javascript" language="javascript">
                                    init_numedit("Sum",(""==document.getElementById("Sum").value)?(0):(document.getElementById("Sum").value),2);
                                </script>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <table id="tbResponse" class="InnerTable">
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbDptNls" runat="server" CssClass="InfoText" Text="Депозитний рахунок"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="DPT_NLS" runat="server" CssClass="InfoText" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox></td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%; height: 30px">
                                <asp:Label ID="lbDptKv" runat="server" CssClass="InfoText" Text="Валюта депозитного договору"></asp:Label></td>
                            <td style="width: 50%; height: 30px">
                                <asp:TextBox ID="DPT_KV" runat="server" CssClass="InfoText" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox></td>
                            <td style="width: 20%; height: 30px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbDptRest" runat="server" CssClass="InfoText" Text="Залишок на депозиті"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="DPT_OST" runat="server" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox>
                                <script type="text/javascript" language="javascript">
                                    init_numedit("DPT_OST",(""==document.getElementById("DPT_OST").value)?(0):(document.getElementById("DPT_OST").value),2);
                                </script>
                            </td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbDptRestAv" runat="server" CssClass="InfoText" Text="Доступний залишок на депозиті"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="DPT_OST_A" runat="server" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox>
                                <script type="text/javascript" language="javascript">
                                    init_numedit("DPT_OST_A",(""==document.getElementById("DPT_OST_A").value)?(0):(document.getElementById("DPT_OST_A").value),2);
                                </script>
                            </td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbIntNLS" runat="server" CssClass="InfoText" Text="Рахунок відсотків"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="INT_NLS" runat="server" CssClass="InfoText" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox></td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbIntCur" runat="server" CssClass="InfoText" Text="Валюта відсотків"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="INT_KV" runat="server" CssClass="InfoText" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox></td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbIntOst" runat="server" CssClass="InfoText" Text="Залишок відсотків"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="INT_OST" runat="server" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox>
                                <script type="text/javascript" language="javascript">
                                    init_numedit("INT_OST",(""==document.getElementById("INT_OST").value)?(0):(document.getElementById("INT_OST").value),2);
                                </script>
                            </td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbIntOstAv" runat="server" CssClass="InfoText" Text="Доступний залишок відсотків"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="INT_OST_A" runat="server" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox>
                                <script type="text/javascript" language="javascript">
                                    init_numedit("INT_OST_A",(""==document.getElementById("INT_OST_A").value)?(0):(document.getElementById("INT_OST_A").value),2);
                                </script>
                             </td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbTransAm" runat="server" Text="Перерахована сума"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="TransfAm" runat="server" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox>
                                <script type="text/javascript" language="javascript">
                                    init_numedit("TransfAm",(""==document.getElementById("TransfAm").value)?(0):(document.getElementById("TransfAm").value),2);
                                </script>                                    
                            </td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%">
                                <asp:Label ID="lbDocRef" runat="server" CssClass="InfoText" Text="Сформований документ"></asp:Label></td>
                            <td style="width: 50%">
                                <asp:TextBox ID="DocRef" runat="server" CssClass="InfoText" MaxLength="20" ReadOnly="True"
                                    TabIndex="2"></asp:TextBox></td>
                            <td style="width: 20%">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>               
            </tr>
            <tr>
                <td align="center" >
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tbControl" class="InnerTable">
                        <tr>
                            <td style="width: 50%">                                                                
                                <input id="btPay" type="button" class="NextButton" value="Оплата в касу" 
                                    onclick="PayDoc()"/>
                            </td>
                            <td style="width: 50%">                                
                                <input id="btClose" type="button" class="NextButton" 
                                    value="Закриття запиту" onclick="ClearQuest()" />
                            </td>                            
                        </tr>
                    </table>
                    <input id="TNLS" type="hidden" />
                    <input id="BDAY" type="hidden" />
                    <input id="ADR" type="hidden" />
                    <input id="ORGAN" type="hidden" /></td>                
            </tr>
            </table>
        <div class="webservice" id="webService" showProgress="true"/></div>
    </form>
</body>
</html>
