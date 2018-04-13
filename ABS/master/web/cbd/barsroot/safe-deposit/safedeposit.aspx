<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safedeposit.aspx.cs" Inherits="safe_deposit_safedeposit" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Депозитні сейфи: Картка сейфа</title>
    <script type="text/javascript" src="js/JScript.js"></script>
	<script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>        
    <link type="text/css" rel="stylesheet" href="style/style.css" />    
</head>
<body>
    <form id="safedeposit" runat="server">
    <table class="MainTable">
        <tr>
            <td align="center">
                <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" 
                    meta:resourcekey="lbTitle" Text="Депозитні сейфи: Картка сейфа"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <table id="buttonTable" class="InnerTable">
                    <tr>
                        <td style="width:1%">                            
                            <cc1:ImageTextButton ID="btRefresh" runat="server" ButtonStyle="Image" 
                                ImageUrl="/Common\Images\default\16\refresh.png" ToolTip="Обновить" 
                                meta:resourcekey="btRefresh" OnClick="btRefresh_Click" TabIndex="1" EnabledAfter="0"/>
                            </td>
                        <td style="width:1%">
                            <cc1:Separator ID="Separator2" runat="server" BorderWidth="1px" meta:resourcekey="Separator2Resource1" />
                        </td>                            
                        <td style="width:1%">
                            <cc1:ImageTextButton ID="btSave" runat="server" ButtonStyle="Image" 
                                ImageUrl="/Common\Images\default\16\save.png" ToolTip="Сохранить" 
                                meta:resourcekey="btSave" OnClick="btSave_Click" OnClientClick="if (FormNotFilled()) return;" TabIndex="2" EnabledAfter="0"/>
                        </td>
                        <td style="width:1%">                        
                            <cc1:ImageTextButton ID="btCloseContract" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\cancel.png"
                                OnClick="btCloseContract_Click" ToolTip="Закрыть договор" TabIndex="3" 
                                EnabledAfter="0" meta:resourcekey="btCloseContractResource1" />
                        </td>
                        <td style="width:1%">
                            <cc1:Separator ID="Separator1" runat="server" BorderWidth="1px" meta:resourcekey="Separator1Resource1" />
                        </td>
                        <td style="width:1%">
                            <cc1:ImageTextButton ID="btSelectClient" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\reference.png"
                                OnClientClick="if (GetClientRnk()) return; " ToolTip="Выбрать клиента из перечня контрагентов банка" TabIndex="4" EnabledAfter="0" meta:resourcekey="btSelectClientResource1" />
                        </td>
                        <td style="width:1%">
                            <cc1:Separator ID="Separator3" runat="server" BorderWidth="1px" meta:resourcekey="Separator3Resource1" />
                        </td>                            
                        <td style="width:1%">
                            <cc1:ImageTextButton ID="btDopReqv" runat="server" ButtonStyle="Image" 
                                ImageUrl="/Common\Images\default\16\reference_open.png" ToolTip="Дополнительные реквизиты" 
                                meta:resourcekey="btDopReqv" OnClientClick="if (openDopReqv()) return;" TabIndex="5" EnabledAfter="0"/>                                
                        </td>
                        <td style="width:1%">
                            <cc1:Separator ID="Separator4" runat="server" BorderWidth="1px" meta:resourcekey="Separator3Resource1" />
                        </td>                            
                        <td style="width:1%">
                            <cc1:ImageTextButton ID="btAttorney" runat="server" ButtonStyle="Image" 
                                ImageUrl="/Common\Images\default\16\document_edit.png" ToolTip="Довіреності" 
                                meta:resourcekey="btAttorney" OnClientClick="if (Attorney()) return;" TabIndex="6" EnabledAfter="0"/>                                
                        </td>
                        <td style="width:1%">
                            <cc1:Separator ID="Separator5" runat="server" BorderWidth="1px" meta:resourcekey="Separator3Resource1" />
                        </td>                            
 <td>
                            <cc1:imagetextbutton id="btBack" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\arrow_left.png"
                                onclientclick="location.replace('safeportfolio.aspx'); return;" 
                                        tooltip="До портфеля депозитних сейфів" TabIndex="3" EnabledAfter="0" 
                                        ></cc1:imagetextbutton>
                        </td>
                        <td style="width:100%">
                        </td>


                        
                        <td style="width:100%">&nbsp;</td>
                    </tr>
                </table>            
            </td>
        </tr>
        <tr>
            <td>
                <table id="SafeTable" class="InnerTable">
                    <tr>
                        <td style="width: 20%">
                            <asp:Label ID="lbSafeNum" runat="server" CssClass="InfoText95" meta:resourcekey="lbSafeNum"
                                Style="text-align: center" Text="Сейф № (сист)"></asp:Label></td>
                        <td style="width: 25%">
                            <asp:TextBox ID="SAFE_ID" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="SAFE_IDResource1"></asp:TextBox></td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="lbSNUM" runat="server" CssClass="InfoText95" meta:resourcekey="lbSNUM"
                                Style="text-align: center" Text="Сейф №"></asp:Label></td>
                        <td style="width: 25%">
                            <asp:TextBox ID="SNUM" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="SAFE_IDResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="width:20%;">
                            <asp:Label ID="lbSize" runat="server" CssClass="InfoText95" meta:resourcekey="lbSize"
                                Style="text-align: center" Text="Розмір сейфа"></asp:Label></td>
                        <td style="width:25%;">
                            <asp:DropDownList ID="listSafeSize" runat="server" CssClass="BaseDropDownList" TabIndex="10" AutoPostBack="True" OnSelectedIndexChanged="listSafeSize_SelectedIndexChanged" meta:resourcekey="listSafeSizeResource1">
                            </asp:DropDownList></td>
                        <td style="width:10%;"></td>
                        <td style="width:20%;">
                            <asp:Label ID="lbDatLastPay" runat="server" CssClass="InfoText95" meta:resourcekey="lbDatLastPay"
                                Style="text-align: center" Text="Дата останньої проплати"></asp:Label></td>
                        <td style="width:25%;">
                            <asp:TextBox ID="MDATE" style="text-align:center" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="MDATEResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbTarif" runat="server" CssClass="InfoText95" meta:resourcekey="lbTarif"
                                Style="text-align: center" Text="Тариф"></asp:Label></td>
                        <td><asp:DropDownList ID="listTarif" runat="server" CssClass="BaseDropDownList" TabIndex="11" meta:resourcekey="listTarifResource1">
                        </asp:DropDownList></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbBailSum" runat="server" CssClass="InfoText95" meta:resourcekey="lbBailSum"
                                Style="text-align: center" Text="Сума застави"></asp:Label></td>
                        <td>
                            <cc1:numericedit id="BAIL_SUM" runat="server" cssclass="InfoText95" 
                                TabIndex="12" meta:resourcekey="BAIL_SUMResource1" Value="0" Text="0" 
                                Enabled="False"></cc1:numericedit>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbNLS" runat="server" CssClass="InfoText95" meta:resourcekey="lbNLS"
                                Style="text-align: center" Text="Рахунок застави"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="NLS" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="NLSResource1"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbOstc" runat="server" CssClass="InfoText95" meta:resourcekey="lbOstc"
                                Style="text-align: center" Text="Поточний залишок"></asp:Label></td>
                        <td>
                            <cc1:numericedit id="OSTC" runat="server" cssclass="InfoText95" enabled="False" meta:resourcekey="OSTCResource1" Value="0" Text="0"></cc1:numericedit>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable" id="tbDeal"> 
                    <tr>
                        <td style="width: 20%">
                        </td>
                        <td align="center" colspan = "3">
                            <asp:Label style="text-align: center" CssClass="InfoLabel" ID="lbDealTitle" meta:resourcekey="lbDealTitle" runat="server" Text="Параметри договору"></asp:Label>
                        </td>
                        <td style="width: 25%">
                        </td>
                    </tr>
                    <tr>
                        <td style="width:20%">
                            <asp:Label ID="lbDeal" runat="server" CssClass="InfoText95" meta:resourcekey="lbDeal"
                                Style="text-align: center" Text="Реф. дог."></asp:Label></td>
                        <td style="width:25%">
                            <asp:TextBox ID="DEAL_REF" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="DEAL_REFResource1"></asp:TextBox>
                        </td>
                        <td style="width:10%">
                        </td>
                        <td style="width:20%">
                            <asp:Label ID="Label2" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbDealDate" runat="server" CssClass="InfoText95" meta:resourcekey="lbDealDate"
                                Style="text-align: center" Text="від"></asp:Label></td>
                        <td style="width:25%">
                            <cc1:DateEdit ID="DEAL_DATE" runat="server" Date="" MinDate="" TabIndex="14" MaxDate="2099-12-31" meta:resourcekey="DEAL_DATEResource1" Text="01/01/0001 00:00:00"></cc1:DateEdit></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbDealNum" runat="server" CssClass="InfoText95" meta:resourcekey="lbDealNum"
                                Style="text-align: center" Text="№ договору"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="DEAL_NUM" runat="server" CssClass="InfoText95" TabIndex="13" meta:resourcekey="DEAL_NUMResource1"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="Label3" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbTerm" runat="server" CssClass="InfoText95" meta:resourcekey="lbTerm"
                                Style="text-align: center" Text="на термін (днів)"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="TERM" onblur="CalcDate()" runat="server" CssClass="InfoText95" TabIndex="16" meta:resourcekey="TERMResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label5" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbStartDate" runat="server" CssClass="InfoText95" meta:resourcekey="lbStartDate"
                                Style="text-align: center" Text="Початок договору"></asp:Label></td>
                        <td>
                            <cc1:DateEdit ID="DAT_BEGIN" onblur="CalcDate()" runat="server" Date="" MinDate="" TabIndex="15" MaxDate="2099-12-31" meta:resourcekey="DAT_BEGINResource1" Text="01/01/0001 00:00:00"></cc1:DateEdit></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="Label4" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbEndDate" runat="server" CssClass="InfoText95" meta:resourcekey="lbEndDate"
                                Style="text-align: center" Text="Завершення договору"></asp:Label></td>
                        <td>
                            <cc1:DateEdit ID="DAT_END" runat="server" onblur="CalcDate()" Date="" MinDate="" TabIndex="17" MaxDate="2099-12-31" meta:resourcekey="DAT_ENDResource1" Text="01/01/0001 00:00:00"></cc1:DateEdit></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <table id="tbClient" class="InnerTable">
                    <tr>
                        <td style="width: 20%"><input type="hidden" runat="server" id="RNK" /></td>
                        <td align="center" colspan = "3">
                            <asp:Label style="text-align: center" CssClass="InfoLabel" ID="lbClient" meta:resourcekey="lbClient" runat="server" Text="Параметри клієнта"></asp:Label>
                        </td>
                        <td style="width: 25%"><input type="hidden" runat="server" id="CUSTTYPE" /></td>
                    </tr>
                    <tr runat="server" id="f_1">
                        <td style="width: 20%">
                            <asp:Label ID="Label6" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbFIO" runat="server" CssClass="InfoText95" meta:resourcekey="lbFIO"
                                Style="text-align: center" Text="ПІБ"></asp:Label></td>
                        <td style="width: 25%">
                            <asp:TextBox ID="FIO" runat="server" CssClass="InfoText95" TabIndex="18" 
                                meta:resourcekey="FIOResource1" MaxLength="70"></asp:TextBox></td>
                        <td style="width: 10%">
                            &nbsp;</td>
                        <td style="width: 20%">
                            <asp:Label ID="Label7" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbOKPO" runat="server" CssClass="InfoText95" meta:resourcekey="lbOKPO"
                                Style="text-align: center" Text="Ідентифікаційний код"></asp:Label></td>
                        <td style="width: 25%">
                            <asp:TextBox ID="OKPO" runat="server" CssClass="InfoText95" TabIndex="19" meta:resourcekey="OKPOResource1"></asp:TextBox></td>
                    </tr>
                    <tr runat="server" id="f_2">
                        <td>
                            <asp:Label ID="Label8" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbDoc" runat="server" CssClass="InfoText95" meta:resourcekey="lbDoc"
                                Style="text-align: center" Text="Документ"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="DOC" runat="server" CssClass="InfoText95" TabIndex="20" meta:resourcekey="DOCResource1"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="Label9" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbIssued" runat="server" CssClass="InfoText95" meta:resourcekey="lbIssued"
                                Style="text-align: center" Text="Виданий"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="ISSUED" runat="server" CssClass="InfoText95" TabIndex="21" meta:resourcekey="ISSUEDResource1"></asp:TextBox></td>
                    </tr>
                    <tr runat="server" id="j_1">
                        <td>
                            <asp:Label ID="Label10" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbNMK" runat="server" CssClass="InfoText95" meta:resourcekey="lbNMK"
                                Style="text-align: center" Text="Найменування ЮО"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="NMK" runat="server" CssClass="InfoText95" TabIndex="22" meta:resourcekey="NMKResource1"></asp:TextBox>
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="Label11" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbJOKPO" runat="server" CssClass="InfoText95" meta:resourcekey="lbJOKPO"
                                Style="text-align: center" Text="Ідентифікаційний код"></asp:Label></td>
                        <td style="width: 25%">
                            <asp:TextBox ID="JOKPO" runat="server" CssClass="InfoText95" TabIndex="23" meta:resourcekey="JOKPOResource1"></asp:TextBox></td>
                        
                    </tr>
                    <tr runat="server">
                        <td>
                         <asp:Label ID="Label19" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbNLSK" runat="server" CssClass="InfoText95" meta:resourcekey="lbNLSK"
                                Style="text-align: center" Text="Розрах. рахунок"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="NLSK" runat="server" CssClass="InfoText95" TabIndex="24" meta:resourcekey="NLSKResource1"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                            </td>
                        <td>
                            </td>
                    </tr>
                    <tr runat="server">
                        <td>
                         <asp:Label ID="Label20" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbMFOK" runat="server" CssClass="InfoText95" meta:resourcekey="lbMFOK"
                                Style="text-align: center" Text="МФО"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="MFO" runat="server" CssClass="InfoText95" TabIndex="25" meta:resourcekey="MFOResource1"></asp:TextBox>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="BANK" runat="server" CssClass="InfoText95" Enabled="False" TabIndex="26" meta:resourcekey="BANKResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label12" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbAddress" runat="server" CssClass="InfoText95" meta:resourcekey="lbAddress"
                                Style="text-align: center" Text="Адреса"></asp:Label></td>
                        <td colspan="4">
                            <asp:TextBox ID="ADDRESS" runat="server" CssClass="InfoText95" TabIndex="27" meta:resourcekey="ADDRESSResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbBirthPlace" runat="server" CssClass="InfoText95" meta:resourcekey="lbBirthPlace"
                                Style="text-align: center" Text="Місце народження"></asp:Label></td>
                        <td colspan="4">
                            <asp:TextBox ID="BIRTH_PLACE" runat="server" CssClass="InfoText95" TabIndex="28" meta:resourcekey="BIRTH_PLACEResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbBDATE" runat="server" CssClass="InfoText95" meta:resourcekey="lbBDATE"
                                Style="text-align: center" Text="Дата народження"></asp:Label></td>
                        <td>
                            <cc1:DateEdit ID="BDATE" runat="server" Date="" MinDate="" TabIndex="29" MaxDate="2099-12-31" meta:resourcekey="BDATEResource1" Text="01/01/0001 00:00:00"></cc1:DateEdit></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbTEL" runat="server" CssClass="InfoText95" meta:resourcekey="lbTEL"
                                Style="text-align: center" Text="Телефон"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="TEL" runat="server" CssClass="InfoText95" TabIndex="30" meta:resourcekey="TELResource1"></asp:TextBox></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td style="width: 20%">
							<input id="btShowTrustee" class="ImgButton" type="button" onclick="showTrustee()"
							    value="+" title="Показать">
                        </td>
                        <td align="center" colspan = "3">
                            <asp:Label style="text-align: center" CssClass="InfoLabel" ID="lbShowTrustee" meta:resourcekey="lbShowTrustee" runat="server" Text="Довірена особа"></asp:Label>
                        </td>
                        <td style="width: 25%">
                        </td>
                    </tr>                
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div id="divTrustee" class="mo">                    
                    <table id="tbTrustee" class="InnerTable">
                        <tr>
                            <td style="width: 20%">
                            <asp:Label ID="Label15" runat="server" CssClass="InfoText95" ForeColor="Red" Text="*" Visible = "false"></asp:Label>
                                <asp:Label ID="lbTrusteeFIO" runat="server" CssClass="InfoText95" meta:resourcekey="lbTrusteeFIO"
                                    Style="text-align: center" Text="ПІБ"></asp:Label></td>
                            <td style="width: 25%">
                                <asp:TextBox ID="TRUSTEE_FIO" runat="server" CssClass="InfoText95" TabIndex="31" meta:resourcekey="TRUSTEE_FIOResource1"></asp:TextBox></td>
                            <td style="width: 10%">
                            </td>
                            <td style="width: 20%">
                            <asp:Label ID="Label16" runat="server" CssClass="InfoText95" ForeColor="Red" Text="*" Visible = "false"></asp:Label>
                                <asp:Label ID="lbTrusteeOKPO" runat="server" CssClass="InfoText95" meta:resourcekey="lbTrusteeOKPO"
                                    Style="text-align: center" Text="Ідентифікаційний код"></asp:Label></td>
                            <td style="width: 25%">
                                <asp:TextBox ID="TRUSTEE_OKPO" runat="server" CssClass="InfoText95" TabIndex="32" meta:resourcekey="TRUSTEE_OKPOResource1"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                            <asp:Label ID="Label17" runat="server" CssClass="InfoText95" ForeColor="Red" Text="*" Visible = "false"></asp:Label>
                                <asp:Label ID="lbTrusteeDoc" runat="server" CssClass="InfoText95" meta:resourcekey="lbTrusteeDoc"
                                    Style="text-align: center" Text="Документ"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TRUSTEE_DOC" runat="server" CssClass="InfoText95" TabIndex="33" meta:resourcekey="TRUSTEE_DOCResource1"></asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            <asp:Label ID="Label18" runat="server" CssClass="InfoText95" ForeColor="Red" Text="*" Visible = "false"></asp:Label>
                                <asp:Label ID="lbTrusteeIssued" runat="server" CssClass="InfoText95" meta:resourcekey="lbTrusteeIssued"
                                    Style="text-align: center" Text="Виданий"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TRUSTEE_ISSUED" runat="server" CssClass="InfoText95" TabIndex="34" meta:resourcekey="TRUSTEE_ISSUEDResource1"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <asp:Label ID="lbTrusteeAddress" runat="server" CssClass="InfoText95" meta:resourcekey="lbTrusteeAddress"
                                    Style="text-align: center" Text="Адреса"></asp:Label></td>
                            <td colspan="4">
                                <asp:TextBox ID="TRUSTEE_ADDRESS" runat="server" CssClass="InfoText95" TabIndex="35" meta:resourcekey="TRUSTEE_ADDRESSResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <asp:Label ID="lbTrusteeBPlace" runat="server" CssClass="InfoText95" meta:resourcekey="lbTrusteeBPlace"
                                    Style="text-align: center" Text="Місце народження"></asp:Label></td>
                            <td style="width: 25%">
                                <asp:TextBox ID="TRUSTEE_BPLACE" runat="server" CssClass="InfoText95" TabIndex="36" meta:resourcekey="TRUSTEE_BPLACEResource1"></asp:TextBox>
                            </td>
                            <td style="width: 10%"></td>
                            <td style="width: 20%">
                                <asp:Label ID="lbTrusteeBDay" runat="server" CssClass="InfoText95" meta:resourcekey="lbTrusteeBDay"
                                    Style="text-align: center" Text="Дата народження"></asp:Label></td>
                            <td style="width: 25%">
                                <cc1:DateEdit ID="TRUSTEE_BDAY" runat="server" Date="" MinDate="" TabIndex="37" MaxDate="2099-12-31" meta:resourcekey="TRUSTEE_BDAYResource1" Text="01/01/0001 00:00:00"></cc1:DateEdit></td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <asp:Label ID="lbTrusteeNum" runat="server" CssClass="InfoText95" meta:resourcekey="lbTrusteeNum"
                                    Style="text-align: center" Text="Довіреність (№, з, по)"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TRUSTEE_NUM" runat="server" CssClass="InfoText95" TabIndex="38" meta:resourcekey="TRUSTEE_NUMResource1"></asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                                <cc1:DateEdit ID="TRUSTEE_DAT_BEGIN" runat="server" Date="" MinDate="" TabIndex="39" MaxDate="2099-12-31" meta:resourcekey="TRUSTEE_DAT_BEGINResource1" Text="01/01/0001 00:00:00"></cc1:DateEdit></td>
                            <td>
                                <cc1:DateEdit ID="TRUSTEE_DAT_END" runat="server" Date="" MinDate="" TabIndex="40" MaxDate="2099-12-31" meta:resourcekey="TRUSTEE_DAT_ENDResource1" Text="01/01/0001 00:00:00"></cc1:DateEdit></td>
                        </tr>                        
                    </table>
                </div>            
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable"> 
                    <tr>
                        <td style="width: 20%">
                        </td>
                        <td align="center" colspan = "3">
                            <asp:Label style="text-align: center" CssClass="InfoLabel" ID="lbTechReqv" meta:resourcekey="lbTechReqv" runat="server" Text="Технічні реквізити сейфа"></asp:Label>
                        </td>
                        <td style="width: 25%">
                        </td>
                    </tr>
                    <tr>
                        <td style="width:20%">
                            <asp:Label ID="lbVVS" runat="server" CssClass="InfoText95" meta:resourcekey="lbVVS"
                                Style="text-align: center" Text="Відпов. вик. по рахунку"></asp:Label></td>
                        <td style="width:25%">
                            <asp:TextBox ID="ACCOUNT_MAN" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="ACCOUNT_MANResource1"></asp:TextBox>
                        </td>
                        <td style="width:10%">
                        </td>
                        <td style="width:20%">
                            <asp:Label ID="lbSafeMan" runat="server" CssClass="InfoText95" meta:resourcekey="lbSafeMan"
                                Style="text-align: center" Text="Відпов. вик. по сейфу"></asp:Label></td>
                        <td style="width:25%"><asp:DropDownList ID="SAFE_MAN" runat="server" CssClass="BaseDropDownList" TabIndex="41" meta:resourcekey="SAFE_MANResource1">
                        </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbBankTrustee" runat="server" CssClass="InfoText95" meta:resourcekey="lbBankTrustee"
                                Style="text-align: center" Text="Дов. особа банку"></asp:Label></td>
                        <td><asp:DropDownList ID="BANK_TRUSTEE" runat="server" CssClass="BaseDropDownList" TabIndex="42" meta:resourcekey="BANK_TRUSTEEResource1">
                        </asp:DropDownList></td>
                        <td>
                        </td>
                        <td>
                            </td>
                        <td>
                            </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label13" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbKeyNum" runat="server" CssClass="InfoText95" meta:resourcekey="lbKeyNum"
                                Style="text-align: center" Text="Номер ключа"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="KEY_NUM" runat="server" CssClass="InfoText95" TabIndex="40" 
                                meta:resourcekey="KEY_NUMResource1"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="Label14" runat="server" CssClass="InfoText95" ForeColor="Red" 
                                Text="*"></asp:Label>
                            <asp:Label ID="lbKeysGiven" runat="server" CssClass="InfoText95" meta:resourcekey="lbKeysGiven"
                                Style="text-align: center" Text="Ключів видано"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="KEYS_GIVEN" runat="server" CssClass="InfoText95" TabIndex="40" 
                                meta:resourcekey="KEYS_GIVENResource1"></asp:TextBox></td>
                    </tr>
                </table>              
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable"> 
                    <tr>
                        <td style="width: 20%">
                        </td>
                        <td align="center" colspan = "3">
                            <asp:Label style="text-align: center" CssClass="InfoLabel" ID="lbRent" meta:resourcekey="lbRent" runat="server" Text="Оренда"></asp:Label>
                        </td>
                        <td style="width: 25%">
                        </td>
                    </tr>
                    <tr>
                        <td style="width:20%;">
                            <asp:Label ID="lbRentSum" runat="server" CssClass="InfoText95" meta:resourcekey="lbRentSum"
                                Style="text-align: center" Text="Сума оренди"></asp:Label></td>
                        <td style="width:25%;">
                            <cc1:NumericEdit ID="RENTSUM" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="RENTSUMResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                        <td style="width:10%;">
                        </td>
                        <td style="width:20%;">
                            <asp:Label ID="lbpdv" runat="server" CssClass="InfoText95" meta:resourcekey="lbpdv"
                                Style="text-align: center" Text="ПДВ"></asp:Label></td>
                        <td style="width:25%;">
                            <cc1:NumericEdit ID="PDV" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="PDVResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDayTarif" runat="server" CssClass="InfoText95" meta:resourcekey="lbDayTarif"
                                Style="text-align: center" Text="Денний тариф"></asp:Label></td>
                        <td>
                            <cc1:NumericEdit ID="DAY_TARIF" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="DAY_TARIFResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                        <td>
                        </td>
                        <td>
                            </td>
                        <td>
                            </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDiscount" runat="server" CssClass="InfoText95" meta:resourcekey="lbDiscount"
                                Style="text-align: center" Text="% знижки"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="DISCOUNT" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="DISCOUNTResource1"></asp:TextBox></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbPeny" runat="server" CssClass="InfoText95" meta:resourcekey="lbPeny"
                                Style="text-align: center" Text="% пені"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="PENY" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="PENYResource1"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbPlanPay" runat="server" CssClass="InfoText95" meta:resourcekey="lbPlanPay"
                                Style="text-align: center" Text="Планова оплата"></asp:Label></td>
                        <td>
                            <cc1:NumericEdit ID="PLAN_PAY" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="PLAN_PAYResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbLeft" runat="server" CssClass="InfoText95" meta:resourcekey="lbLeft"
                                Style="text-align: center" Text="залишилось"></asp:Label></td>
                        <td>
                            <cc1:NumericEdit ID="P_LEFT" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="P_LEFTResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbAmortFut" runat="server" CssClass="InfoText95" meta:resourcekey="lbAmortFut"
                                Style="text-align: center" Text="Аморт. приб. майб. пер."></asp:Label></td>
                        <td>
                            <cc1:NumericEdit ID="AMORT" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="AMORTResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbFactPay" runat="server" CssClass="InfoText95" meta:resourcekey="lbFactPay"
                                Style="text-align: center" Text="Фактична оплата"></asp:Label></td>
                        <td>
                            <cc1:NumericEdit ID="FACT_PAY" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="FACT_PAYResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbFLeft" runat="server" CssClass="InfoText95" meta:resourcekey="lbFLeft"
                                Style="text-align: center" Text="залишилось"></asp:Label></td>
                        <td>
                            <cc1:NumericEdit ID="FLEFT" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="FLEFTResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbFPDV" runat="server" CssClass="InfoText95" meta:resourcekey="lbFPDV"
                                Style="text-align: center" Text="ПДВ"></asp:Label></td>
                        <td>
                            <cc1:NumericEdit ID="F_PDV" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="F_PDVResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbCurPeriod" runat="server" CssClass="InfoText95" meta:resourcekey="lbCurPeriod"
                                Style="text-align: center" Text="Прибуток пот. пер."></asp:Label></td>
                        <td>
                            <cc1:NumericEdit ID="CUR_PERIOD" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="CUR_PERIODResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbFutPeriod" runat="server" CssClass="InfoText95" meta:resourcekey="lbFutPeriod"
                                Style="text-align: center" Text="Прибуток майб. пер."></asp:Label></td>
                        <td>
                            <cc1:NumericEdit ID="FUT_PERIOD" runat="server" CssClass="InfoText95" Enabled="False" meta:resourcekey="FUT_PERIODResource1" Value="0" Text="0"></cc1:NumericEdit></td>
                    </tr>
                </table>              
            </td>
        </tr>        
        <tr>
            <td>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
                    <Scripts>
                        <asp:ScriptReference Path="js/JScript.js" />                        
                    </Scripts>                        
                </asp:ScriptManager>
                <input type="hidden" id="isClosing" runat="server" />
                <input type="hidden" id="sos" runat="server" />
                <input type="hidden" runat="server" id="datEndString" value="DAT_END" />
            </td>
        </tr>
    </table>
    </form>
    <script language="javascript" type="text/javascript">
        if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
    </script>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('btRefresh');
       }       
    </script>    
</body>
</html>
