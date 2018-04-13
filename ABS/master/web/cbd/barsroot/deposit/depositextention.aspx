<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositextention.aspx.cs" Inherits="deposit_depositextention" EnableSessionState="True" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="style/dpt.css" type="text/css" rel="stylesheet"/>    
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader">Відмова від переоформлення вкладу №%s</asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable">
				        <tr>
					        <td>
					        </td>
				        </tr>
				        <tr>
					        <td>
					        <table class="InnerTable">
						        <tr>
							        <td>
								        <asp:label id="lbClientInfo" runat="server" CssClass="InfoLabel">Вкладник</asp:label>
							        </td>
						        </tr>
						        <tr>
							        <td>
								        <asp:textbox id="textClientName" runat="server" CssClass="InfoText" ReadOnly="True"></asp:textbox>
							        </td>
						        </tr>
						        <tr>
							        <td>
								        <table class="InnerTable">
									        <tr>
										        <td width="30%">
										            <asp:textbox id="textDocNumber" runat="server" CssClass="InfoText" ReadOnly="True"></asp:textbox>
										        </td>
										        <td width="70%">
											        <asp:textbox id="textDocOrg" runat="server" CssClass="InfoText" ReadOnly="True"></asp:textbox>
										        </td>
									        </tr>
								        </table>
							        </td>
						        </tr>
						        <tr>
							        <td>
								        <asp:label id="lbContractInfo" runat="server" CssClass="InfoLabel">Договір</asp:label>
							        </td>
						        </tr>
						        <tr>
							        <td>
								        <table class="InnerTable">
									        <tr>
										        <td width="25%">
											        <asp:label id="lbContractNumber" runat="server" CssClass="InfoText">Номер</asp:label>
										        </td>
										        <td width="15%">
											        <asp:textbox id="textContractNumber" runat="server" CssClass="InfoText" ReadOnly="True"></asp:textbox>
										        </td>
										        <td width="20%"></td>
										        <td width="25%">
											        <asp:label id="lbContractDate" runat="server" CssClass="InfoText">від</asp:label>
										        </td>
										        <td width="15%">
                                                    <asp:TextBox ID="textDateFrom" runat="server" CssClass="InfoText"
                                                        ReadOnly="True"></asp:TextBox></td>
									        </tr>
									        <tr>
										        <td>
											        <asp:label id="lbContractBegin" runat="server" CssClass="InfoText">Дата початку</asp:label>
										        </td>
										        <td>
                                                    <asp:TextBox ID="textDatBegin" runat="server" CssClass="InfoText"
                                                        ReadOnly="True"></asp:TextBox></td>
										        <td></td>
										        <td>
											        <asp:label id="lbContractEnd" runat="server" CssClass="InfoText">Дата завершення</asp:label>
										        </td>
										        <td>
                                                    <asp:TextBox ID="textDatEnd" runat="server" CssClass="InfoText" 
                                                        ReadOnly="True"></asp:TextBox></td>
									        </tr>
								        </table>
							        </td>
						        </tr>
						        <tr>
							        <td>
								        <table class="InnerTable">
									        <tr>
										        <td width="25%">
											        <asp:label id="lbDepositType" runat="server" CssClass="InfoText">Вид вкладу</asp:label>
										        </td>
										        <td>
											        <asp:textbox id="textDepositType" runat="server" ReadOnly="True" CssClass="InfoText"></asp:textbox>
										        </td>
									        </tr>
								        </table>
							        </td>
						        </tr>
						        <tr>
							        <td>
								        <table class="InnerTable">
									        <tr>
										        <td width="25%">
											        <asp:label id="lbInterestRate" runat="server" CssClass="InfoText">Відсоткова ставка</asp:label>
										        </td>
										        <td>
                                                    <asp:TextBox ID="textRate" runat="server" CssClass="InfoDateSum"
                                                        ReadOnly="True"></asp:TextBox>
                                                </td>                                                
									        </tr>
								        </table>
							        </td>
						        </tr>
						        <tr>
							        <td>
								        <asp:label id="lbAccountInfo" runat="server" CssClass="InfoLabel">Рахунки</asp:label>
							        </td>
						        </tr>
						        <tr>
							        <td>
								        <table class="InnerTable">
									        <tr>
										        <td width="25%">
											        <asp:label id="lbDepositAccount" runat="server" CssClass="InfoText">Основний рахунок</asp:label>
										        </td>
										        <td width="20%">
											        <asp:textbox id="textDepositAccountCurrency" runat="server" CssClass="InfoText" ReadOnly="True"></asp:textbox>
										        </td>
										        <td width="35%">
											        <asp:textbox id="textDepositAccount" runat="server" CssClass="InfoText" ReadOnly="True"></asp:textbox>
										        </td>
										        <td style="width:20%">
											        <asp:textbox id="textDepositAccountRest" runat="server" CssClass="InfoText" ReadOnly="True" ></asp:textbox>
										        </td>
									        </tr>
									        <tr>
										        <td>
											        <asp:label id="lbInterestAccount" runat="server" CssClass="InfoText">Рахунок відсотків</asp:label>
										        </td>
										        <td>
											        <asp:textbox id="textIntAccountCurrency" runat="server" CssClass="InfoText" ReadOnly="True"></asp:textbox>
										        </td>
										        <td>
											        <asp:textbox id="textInterestAccount" runat="server" CssClass="InfoText" ReadOnly="True"></asp:textbox>
										        </td>
										        <td>
											        <asp:textbox id="textInterestAccountRest" runat="server" CssClass="InfoText" ReadOnly="True"></asp:textbox>
										        </td>
									        </tr>
									        <tr>
										        <td></td>
										        <td></td>
										        <td></td>
										        <td></td>
									        </tr>
									        <tr id="rStorno" runat="server">
										        <td>
											        <asp:label id="lbInterestAccount0" runat="server" CssClass="InfoText">Причина сторнування</asp:label>
										        </td>
										        <td colspan="2">
											        <asp:textbox id="textStornoReason" runat="server" CssClass="InfoText" 
                                                        TextMode="MultiLine"></asp:textbox>
										        </td>
										        <td>
											        <asp:RequiredFieldValidator ID="vReason" runat="server" 
                                                        ControlToValidate="textStornoReason" Display="Dynamic"
                                                        ErrorMessage="Необхідно заповнити"></asp:RequiredFieldValidator>
										        </td>
									        </tr>
									        <tr>
									            <td>
									                <asp:Button ID="btRefuse" runat="server" CssClass="AcceptButton" OnClick="btRefuse_Click"
                                                        Text="Відмовитися" CausesValidation="False" /></td>
									            </td>
									            <td>
									                <asp:Button ID="btStorno" runat="server" CssClass="AcceptButton" OnClick="btStorno_Click"
                                                        Text="Сторнувати" /></td>
									            <td></td>
									            <td></td>
									        </tr>
								        </table>
							        </td>
						        </tr>
                    </table>                                
            </tr>
        </table>
    </form>
</body>
</html>
