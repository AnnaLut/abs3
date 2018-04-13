<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepositSearch.aspx.cs" Inherits="DepositSearch" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.DataComponents, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Пошук депозитного договору</title>
    <link href="style/style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="script/JScript.js"></script>    
	<script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>    
</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table id="mainTable" class="MainTable">
				<tr>
					<td align="center">
						<asp:label id="lbSearchInfo" runat="server" CssClass="InfoHeader">Пошук депозитного договору</asp:label>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="tbParams">
							<tr>
								<td style="width:15%">
                                    <asp:label id="lbDepositNumber" runat="server" CssClass="InfoText">Номер вкладу</asp:label></td>
								<td style="width:30%">
                                    <asp:TextBox id="textDepositNum" tabIndex="1" onblur="doValueCheck('textDepositNum')" runat="server" CssClass="InfoText" MaxLength="12"
										ToolTip="Номер вкладу"></asp:TextBox></td>
								<td style="width:10%"></td>
								<td style="width:15%">
									<asp:label id="lbClientName" runat="server" CssClass="InfoText">Вкладник</asp:label>
								</td>
								<td style="width:30%">
									<asp:TextBox id="textClientName" runat="server" ToolTip="ПІБ вкладника" MaxLength="35" tabIndex="5"
										CssClass="InfoText"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td>
                                    <asp:label id="lbDepositId" CssClass="InfoText" runat="server">Ідентифікатор вкладу</asp:label></td>
								<td>
                                    <asp:TextBox id="textDepositId" onblur="doValueCheck('textDepositId')" runat="server" ToolTip="Ідентифікатор вкладу" MaxLength="12"
										tabIndex="2" CssClass="InfoText"></asp:TextBox></td>
								<td></td>
								<td>
									<asp:label id="lbClientOKPO" runat="server" CssClass="InfoText">Ідентифікаційний код</asp:label>
								</td>
								<td>
									<asp:TextBox id="textClientCode" onblur="doValueCheck('textClientCode')" runat="server" ToolTip="Ідентифікаційний код" MaxLength="10"
										tabIndex="6" CssClass="InfoText"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbClientId" runat="server" onblur="doValueCheck('textClientId')" CssClass="InfoText">Номер контрагента</asp:label>
								</td>
								<td>
									<asp:TextBox id="textClientId" runat="server" ToolTip="Номер контрагента" MaxLength="12" tabIndex="3"
										CssClass="InfoText"></asp:TextBox>
								</td>
								<td></td>
								<td>
									<asp:label id="lbBirthDate" runat="server" CssClass="InfoText">Дата народження</asp:label>
								</td>
								<td>
								    <input runat="server" id='DocDate' type='hidden'/><input runat="server" id='DocDate_Value' type='hidden' name="DocDate"/><input id='DocDate_TextBox' runat="server" TabIndex="7" style="TEXT-ALIGN:center" name="DocDate"/>
                                    <script language="javascript" type="text/javascript">
                                          window['DocDate'] = new RadDateInput('DocDate', 'Windows');
                                          window['DocDate'].PromptChar='_'; 
                                          window['DocDate'].DisplayPromptChar='_';
                                          window['DocDate'].SetMask(rdmskr(1, 31, false, true),rdmskl('/'),rdmskr(1,12, false, true),rdmskl('/'),rdmskr(1, 2099, false, true));	
                                          window['DocDate'].RangeValidation=true; 
                                          window['DocDate'].SetMinDate('01/01/0001 00:00:00'); 
                                          window['DocDate'].SetMaxDate('31/12/2099 00:00:00'); 
                                          window['DocDate'].SetValue('01/01/0001');                     
                                          window['DocDate'].Initialize();
                                    </script>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbDepositAccount" runat="server" CssClass="InfoText">Номер рахунку</asp:label>
								</td>
								<td>
									<asp:TextBox id="textAccount" runat="server" onblur="doValueCheck('textAccount')" ToolTip="Номер рахунку" MaxLength="14" tabIndex="4"
										CssClass="InfoText"></asp:TextBox>
								</td>
								<td></td>
								<td>
									<asp:label id="lbDocSerial" runat="server" CssClass="InfoText">Серія документу</asp:label>
								</td>
								<td>
									<asp:TextBox id="DocSerial" runat="server" ToolTip="Серія документу" MaxLength="10" tabIndex="8"
										CssClass="InfoText"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td></td>
								<td></td>
								<td>
									<asp:label id="lbDocNumber" runat="server" CssClass="InfoText">Номер документу</asp:label>
								</td>
								<td>
									<asp:TextBox id="DocNumber" onblur="doValueCheck('DocNumber')" runat="server" ToolTip="Номер документу" MaxLength="10" tabIndex="9"
										CssClass="InfoText"></asp:TextBox>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table id="tbl_Hint" class="InnerTable">
							<tr>
								<td style="width:45%">
									<input id="btSearch" class="AcceptButton" type="button" value="Пошук" 
									    runat="server" tabindex="10" onserverclick="btSearch_ServerClick"/>
								</td>
								<td style="width:10%"></td>
								<td style="width:25%">
									<input id="btSelect" onclick="if (ckFill('dptid')) Move('DepositCoowner.aspx?dpt_id='+document.getElementById('dptid').value);"
									 class="AcceptButton" type="button" value="Вибрати" runat="server"
										tabindex="11"/>
								</td>
								<td style="width:20%">
									<input id="dptid" type="hidden" runat="server" value="null"/>
								</td>
							</tr>
						</table>
                        <bars:barsgridview id="gridDeposit" runat="server" allowpaging="True" allowsorting="True"
                            autogeneratecolumns="False" cssclass="BaseGrid" datasourceid="dsContract" datemask="dd/MM/yyyy" OnRowDataBound="gridDeposit_RowDataBound" TabIndex="12">
                                <PagerSettings PageButtonCount="5"></PagerSettings>
                                <Columns>
<asp:BoundField HtmlEncode="False" DataField="ND" SortExpression="to_number(ND)" HeaderText="№">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="D_ID" SortExpression="D_ID" HeaderText="Сист. №"></asp:BoundField>
<asp:BoundField DataField="TYPE_NAME" ConvertEmptyStringToNull="False" SortExpression="TYPE_NAME" HeaderText="Тип вкладу">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="DATZ" ConvertEmptyStringToNull="False" SortExpression="DATZ" HeaderText="Укладено">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="DAT_END" ConvertEmptyStringToNull="False" SortExpression="DAT_END" HeaderText="Завершення">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="RNK" ConvertEmptyStringToNull="False" SortExpression="RNK" HeaderText="РНК">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="OKPO" ConvertEmptyStringToNull="False" SortExpression="OKPO" HeaderText="Ід.код">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="NMK" ConvertEmptyStringToNull="False" SortExpression="NMK" HeaderText="ПІБ">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="NLS" ConvertEmptyStringToNull="False" SortExpression="NLS" HeaderText="Рахунок">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="LCV" ConvertEmptyStringToNull="False" SortExpression="LCV" HeaderText="Валюта">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="OSTC" ConvertEmptyStringToNull="False" SortExpression="OSTC" HeaderText="Залишок">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="P_OSTC" ConvertEmptyStringToNull="False" SortExpression="P_OSTC" HeaderText="%%">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
</Columns>
                        </bars:barsgridview>
					</td>
				</tr>
				<tr>
					<td>
                        <bars:barssqldatasource ProviderName="barsroot.core" id="dsContract" runat="server"></bars:barssqldatasource>
                    </td>
				</tr>
			</table>
		</form>
		<script type="text/javascript" language="javascript">
				document.getElementById("textDepositId").attachEvent("onkeydown",doNum);
				document.getElementById("textDepositNum").attachEvent("onkeydown",doNum);
				document.getElementById("textClientId").attachEvent("onkeydown",doNum);
				document.getElementById("textAccount").attachEvent("onkeydown",doNumAlpha);
				document.getElementById("textClientCode").attachEvent("onkeydown",doNum);
				document.getElementById("DocNumber").attachEvent("onkeydown",doNum);				
				document.getElementById("textClientName").attachEvent("onkeydown",doAlpha);
		</script>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('btSearch');
       }       
    </script>			
	</body>
</html>
