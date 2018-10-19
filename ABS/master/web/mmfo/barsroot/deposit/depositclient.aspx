<%@ Page Language="c#" CodeFile="DepositClient.aspx.cs" AutoEventWireup="true" Inherits="DepositClient"
    EnableViewState="True" %>

<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <base target="_self" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <title>Депозитний модуль: Картка клієнта</title>

    <link href="style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="javascript" src="js/js.js?v1.3"></script>
    <script type="text/javascript" language="javascript" src="js/ck.js?v1.3"></script>
    <script type="text/javascript" language="javascript" src="js/AccCk.js"></script>
    <script type="text/vbscript" language="vbscript" src="/Common/Script/Messages/base.vbs"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/Messages/base.js"></script>
    <script type="text/javascript" language="javascript">
		function AddListener4Enter(){
		    AddListeners("textClientName,textClientFirstName,textClientLastName,textClientPatronymic,textCountry,textClientIndex,listClientCodeType,textClientRegion,textClientDistrict,textClientSettlement,textClientAddress,textClientCode,textDocSerial,textDocNumber,textDocOrg,dtDocDate_t,dtBirthDate_t,textHomePhone,textBirthPlace,textWorkPhone,listDocType,listSex,textFIOGenitive,textFactIndex,textFactRegion,textFactDistrict,textFactAddress,textFactSettlement,textFactLocation,textCellPhone",
		    'onkeydown', TreatEnterAsTab);
		}
    </script>
    <script type="text/javascript" language="javascript">
        function changeStyle() 
        {
			var _div = document.getElementById('full_name');
			if (_div.className == "mo")
			{
				_div.className = "mn";
				document.getElementById('btShowFullName').value = "-";
				document.getElementById('btShowFullName').title = LocalizedString('forbtShowFullName');
			}
			else if (_div.className == "mn")
			{
				_div.className = "mo";
				document.getElementById('btShowFullName').value = "+";
				document.getElementById('btShowFullName').title = LocalizedString('forbtShowFullName2');;
			}
		}
        // Адреса реєстрації
		function changeStyleAddressU()
        {
            var _div = document.getElementById('client_address');

			if (_div.className == "mo")
			{
				_div.className = "mn";
				document.getElementById('btShowClientAddress').value = "-";
				document.getElementById('btShowClientAddress').title = LocalizedString('forbtShowFullName');

				document.getElementById('textClientAddressFull').style.visibility = "hidden";
			}
			else if (_div.className == "mn")
			{
				_div.className = "mo";
				document.getElementById('btShowClientAddress').value = "+";
				document.getElementById('btShowClientAddress').title = LocalizedString('forbtShowFullName2');

                UnionClientAddress();
			}
		}
        // Адреса проживання
		function changeStyleAddressF() {
		    var _div = document.getElementById('fact_address');
		    if (_div.className == "mo") {
		        _div.className = "mn";
		        document.getElementById('btShowFactAddress').value = "-";
		        document.getElementById('btShowFactAddress').title = LocalizedString('forbtShowFullName');
		    }
		    else if (_div.className == "mn") {
		        _div.className = "mo";
		        document.getElementById('btShowFactAddress').value = "+";
		        document.getElementById('btShowFactAddress').title = LocalizedString('forbtShowFullName2'); ;
		    }
		}
		function AfterPageLoad()
        {
		    if (document.getElementById('textClientTerritory'))
		        document.getElementById('textClientTerritory').readOnly = true;

		    UnionClientAddress();

		    ValidateClientCode();

		    focusControl('listSex');
        }
    </script>
    <script type="text/javascript">
		    var dtSwitcher = 0;
            function dtDocDate_Blur(oEdit, text, oEvent)
            {
                if (dtSwitcher != 2)
                    ckClRegDate("dtDocDate_t",1);
                //focusControl('dtDocDate_t');
            }
            function dtBirthDate_Blur(oEdit, text, oEvent)
            {
                if (dtSwitcher != 1)
                    ckClRegDate("dtBirthDate_t",2); 
                dtSwitcher = 1;
                focusControl('dtDocDate_t');
                
            }
    </script>
    <script type="text/javascript" language="javascript">
		<!--			
			// скажем обычным контролам трактовать Enter как Tab
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
    </script>
</head>
<body onload="AfterPageLoad();">
    <form id="DepositFormMain" method="post" runat="server">
    <table class="MainTable">
        <tr>
            <td>
                <asp:Label ID="lbInfo" Text="Клієнт" runat="server" CssClass="InfoHeader" />
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td colspan="5">
                            <input id="btSearch" meta:resourcekey="btSearch3" onclick="openDialog(this.form)"
                                type="button" value="Поиск" runat="server" tabindex="102" class="DirectionButton" />
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                        </td>
                        <td width="30%">
                            <asp:Label ID="lbSex" meta:resourcekey="lbSex" runat="server" CssClass="InfoText">Пол</asp:Label>
                        </td>
                        <td width="35%">
                            <asp:DropDownList ID="listSex" runat="server" CssClass="BaseDropDownList" TabIndex="1">
                            </asp:DropDownList>
                        </td>
                        <td width="10%">
                        </td>
                        <td width="20%">
                        </td>
                    </tr>
                    <tr>
                        <td width="5%">
                            <input id="btShowFullName" class="ImgButton" tabindex="2001" type="button" onclick="changeStyle()"
                                value="-" title="Свернуть" />
                        </td>
                        <td width="30%">
                            <asp:Label ID="lbClientName" meta:resourcekey="lbClientName2" runat="server" 
                                Text="П.І.Б." CssClass="InfoText" Font-Bold="true" />
                        </td>
                        <td width="35%">
                            <input id="textClientName" readonly="readonly" type="text" maxlength="70" runat="server"
                                title="ФИО" class="InfoText" style="background-color:LightGray" />
                        </td>
                        <td width="10%">
                        </td>
                        <td width="20%">
                            <asp:Label ID="lbFIO" runat="server" Text="необходимо заполнить" Visible="False" CssClass="Validator" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <div class="mn" id="full_name">
                                <table class="InnerTable">
                                    <tr>
                                        <td width="5%">
                                            <asp:Label ID="lbLastNameReq" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:Label>
                                        </td>
                                        <td width="30%">
                                            <asp:Label ID="lbLastName" meta:resourcekey="lbLastName" runat="server" CssClass="InfoText">Фамилия</asp:Label>
                                        </td>
                                        <td width="35%">
                                            <input id="textClientLastName" tabindex="1" type="text" maxlength="70" runat="server"
                                                title="Фамилия" class="InfoText" onblur="getFullName();" />
                                        </td>
                                        <td style="width: 10%">
                                        </td>
                                        <td width="20%">
                                            <asp:RequiredFieldValidator ID="validatorClientLastName" meta:resourcekey="NeedToFill"
                                                runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="textClientLastName"
                                                CssClass="Validator"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbFirstNameReq" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbFirstName" meta:resourcekey="Label3" runat="server" CssClass="InfoText">Имя</asp:Label>
                                        </td>
                                        <td>
                                            <input id="textClientFirstName" tabindex="2" type="text" maxlength="70" runat="server"
                                                class="InfoText" onblur="getFullName();" />
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="validatorClientFirstName" meta:resourcekey="NeedToFill"
                                                runat="server" ControlToValidate="textClientFirstName" ErrorMessage="необходимо заполнить"
                                                CssClass="Validator"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbPatronymic" meta:resourcekey="lbPatronymic" runat="server" CssClass="InfoText">Отчество</asp:Label>
                                        </td>
                                        <td>
                                            <input id="textClientPatronymic" tabindex="3" type="text" maxlength="70" runat="server"
                                                class="InfoText" onblur="getFullName();" />
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbFIOGenitiveReq" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbFIOGenitive" runat="server" CssClass="InfoText" meta:resourcekey="lbFIOGenitive">ФИО (в родительном падеже)</asp:Label>
                                        </td>
                                        <td>
                                            <input id="textFIOGenitive" tabindex="4" type="text" maxlength="70" runat="server"
                                                class="InfoText" />
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="validatorTextFioGenitive" runat="server" ControlToValidate="textFIOGenitive"
                                                CssClass="InfoText" ErrorMessage="необходимо заполнить" meta:resourcekey="NeedToFill"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVBDate" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbBirthDate" meta:resourcekey="lbBirthDate" runat="server" CssClass="InfoText">Дата рождения</asp:Label>
                        </td>
                        <td>
                            <igtxt:webdatetimeedit id="dtBirthDate" runat="server" ToolTip="Дата рождения клиента"
                                EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy" HorizontalAlign="Center"
                                MinValue="1800-01-01" tabIndex="25" CssClass="InfoDateSum">
                                <clientsideevents blur="dtBirthDate_Blur"></clientsideevents>
                            </igtxt:webdatetimeedit>
                        </td>
                        <td></td>
                        <td>
                            <asp:RequiredFieldValidator ID="validatorBirthDate" meta:resourcekey="NeedToFill"
                                runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="dtBirthDate"
                                CssClass="Validator"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Label ID="lbBirthPlace" meta:resourcekey="lbBirthPlace" runat="server" CssClass="InfoText">Место рождения</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textBirthPlace" meta:resourcekey="textBirthPlace" runat="server"
                                MaxLength="70" TabIndex="26" ToolTip="Место рождения" CssClass="InfoText" />
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVCountry" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbClientCountry" meta:resourcekey="lbClientCountry" runat="server"
                                CssClass="InfoText">Страна клиента</asp:Label>
                        </td>
                        <td>
                            <input id="textCountry" readonly="readonly" type="text" class="InfoText" runat="server"
                                tabindex="2000" />
                        </td>
                        <td>
                            <input id="btCountry" type="button" value="..." runat="server" tabindex="5" title="Выбрать"
                                onclick="openCountryDialog();" />
                        </td>
                        <td>
                            <input id="textCountryCode" type="hidden" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbResident" runat="server" CssClass="InfoText" meta:resourcekey="lbResident">Резидент</asp:Label>
                        </td>
                        <td>
                            <input id="ckResident" tabindex="6" type="checkbox" checked="checked" runat="server"
                                onpropertychange="EnableResident()" enableviewstate="true" />
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVTerritory" runat="server" CssClass="InfoText" ForeColor="Red" Visible="true">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbClientTerritory" Text="Код території" runat="server" meta:resourcekey="lbClientTerritory"
                                CssClass="InfoText" />
                        </td>
                        <td>
                            <asp:TextBox ID="textClientTerritory" meta:resourcekey="textClientTerritory" ToolTip="Код території"
                                runat="server" CssClass="InfoText" BackColor="LightGray" 
                                onblur="doNum('textClientTerritory');" />                           
                        </td>
                        <td>
                         <input id="btTerritory" type="button" runat="server" value="..." title="Вибрати код території"
                                tabindex="7" onclick="showTerritory()" class="ReferenceBookButton" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="validatorTextClientTerritory" ControlToValidate="textClientTerritory"
                                ErrorMessage="необходимо заполнить" CssClass="InfoText" runat="server" meta:resourcekey="NeedToFill"
                                Enabled="true">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btShowClientAddress" class="ImgButton" type="button" onclick="changeStyleAddressU()"
                                value="-" title="Згорнути" />
                        </td>
                        <td>
                            <asp:Label ID="Label1" runat="server" CssClass="InfoText" Text="Юридична адреса" Font-Bold="true" />
                        </td>
                        <td>
                            <asp:TextBox ID="textClientAddressFull" runat="server" CssClass="InfoText" 
                                ReadOnly="True" BackColor="LightGray" />
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <div class="mn" id="client_address">
                                <table class="InnerTable">
                                    <tr>
                                        <td style="width:5%">
                                        </td>
                                        <td style="width:30%">
                                            <asp:Label ID="lbClientIndex" meta:resourcekey="lbClientIndex" runat="server" CssClass="InfoText">Индекс</asp:Label>
                                        </td>
                                        <td style="width:35%">
                                            <asp:TextBox ID="textClientIndex" meta:resourcekey="textClientIndex" runat="server" CssClass="InfoText25"
                                                TabIndex="8" MaxLength="5" onkeydown="doNum();" ToolTip="Індекс"
                                                onblur="doValueCheck('textClientIndex');CopyAddress('textClientIndex','textFactIndex');" />
                                        </td>
                                        <td style="width:10%"></td>
                                        <td style="width:20%"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lbRegion" meta:resourcekey="lbRegion" runat="server" CssClass="InfoText">Область</asp:Label>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <asp:TextBox ID="preClientRegion" runat="server" CssClass="InfoText10" Enabled="False"></asp:TextBox>
                                            <asp:TextBox ID="textClientRegion" meta:resourcekey="textClientRegion" runat="server"
                                                MaxLength="35" ToolTip="Область" TabIndex="9" CssClass="InfoText80" onblur="CopyAddress('textClientRegion','textFactRegion','preClientRegion');">
                                            </asp:TextBox>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lbDistrict" meta:resourcekey="lbDistrict" runat="server" CssClass="InfoText">Район</asp:Label>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <asp:TextBox ID="preClientDistrict" runat="server" CssClass="InfoText10" Enabled="False"></asp:TextBox>
                                            <asp:TextBox ID="textClientDistrict" meta:resourcekey="textClientDistrict" runat="server"
                                                MaxLength="35" ToolTip="Район" TabIndex="10" CssClass="InfoText80" onblur="CopyAddress('textClientDistrict','textFactDistrict','preClientDistrict');"></asp:TextBox>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbVSettlement" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbSettlement" meta:resourcekey="lbSettlement" runat="server" CssClass="InfoText">Населённый пункт</asp:Label>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <asp:TextBox ID="preClientSettlement" runat="server" CssClass="InfoText10" Enabled="False" />
                                            <input id="btSettlementType" type="button" value="..." runat="server" class="ReferenceBookButton"
                                                tabindex="11" onclick="GetLocalityType();" title="Тип населеного пункту" />
                                            <asp:TextBox ID="textClientSettlement" meta:resourcekey="textClientSettlement" runat="server"
                                                TabIndex="12" MaxLength="70" ToolTip="Населённый пункт" CssClass="InfoText80"
                                                onblur="CopyAddress('textClientSettlement','textFactSettlement','preClientSettlement');"></asp:TextBox>
                                        </td>
                                        <td>
                                            <input type="hidden" runat="server" id="hidSettlementType" />
                                        </td>
                                        <td>
                                            <asp:CustomValidator ID="validatorClientSettlement" runat="server" CssClass="Validator"
                                                meta:resourcekey="NeedToFill" ErrorMessage="необходимо заполнить" ClientValidationFunction="validateClientSettlement"
                                                ControlToValidate="textClientSettlement" ValidateEmptyText="True">
                                            </asp:CustomValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbAddress" meta:resourcekey="lbAddress" runat="server" CssClass="InfoText">Адрес</asp:Label>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <asp:TextBox ID="preClientAddress" runat="server" CssClass="InfoText10" Enabled="False" />
                                            <input id="btStreetType" type="button" value="..." runat="server" class="ReferenceBookButton"
                                                tabindex="13" onclick="GetStreetType();" title="Тип вулиці" meta:resourcekey="forbtStreetType" />
                                            <asp:TextBox ID="textClientAddress" runat="server" meta:resourcekey="textClientAddress"
                                                MaxLength="70" ToolTip="Адрес" TabIndex="14" CssClass="InfoText80" onblur="CopyAddress('textClientAddress','textFactAddress','preClientAddress');"></asp:TextBox>
                                        </td>
                                        <td>
                                            <input type="hidden" runat="server" id="hidStreetType" />
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                      <tr>
                        <td>
                            <asp:Label ID="lbVTerritoryReal" runat="server" CssClass="InfoText" ForeColor="Red" Visible="true">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label3" Text="Код території фактичний" runat="server" meta:resourcekey="lbClientTerritory"
                                CssClass="InfoText" />
                        </td>
                        <td>
                            <asp:TextBox ID="textClientTerritoryReal" meta:resourcekey="textClientTerritoryReal" ToolTip="Код території"
                                runat="server" CssClass="InfoText" BackColor="LightGray" 
                                onblur="doNum('textClientTerritoryReal');" />                           
                        </td>
                        <td>
                         <input id="btTerritoryReal" type="button" runat="server" value="..." title="Вибрати код території"
                                tabindex="7" onclick="showTerritoryReal()" class="ReferenceBookButton" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="validatorTextClientTerritoryReal" ControlToValidate="textClientTerritoryReal"
                                ErrorMessage="необходимо заполнить" CssClass="InfoText" runat="server" meta:resourcekey="NeedToFill"
                                Enabled="true">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btShowFactAddress" class="ImgButton" tabindex="2001" type="button" onclick="changeStyleAddressF()"
                                value="-" title="Свернуть" />
                        </td>
                        <td>
                            <asp:Label ID="lbFactAddressFull" runat="server" Text="Фактична адреса" CssClass="InfoText" 
                                meta:resourcekey="lbFactAddressFull" Font-Bold="true" />
                        </td>
                        <td>
                            <asp:TextBox ID="textFactAddressFull" runat="server" CssClass="InfoText" meta:resourcekey="textFactAddressFull"
                                ReadOnly="True" BackColor="LightGray" />
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:CustomValidator ID="validatorAddressFull" runat="server" ClientValidationFunction="checkAddress"
                                ControlToValidate="textClientAddress" CssClass="Validator" ValidateEmptyText="True"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <div class="mn" id="fact_address">
                                <table class="InnerTable">
                                    <tr>
                                        <td width="5%">
                                        </td>
                                        <td width="30%">
                                            <asp:Label ID="lbFactIndex" meta:resourcekey="lbClientIndex" runat="server" 
                                                CssClass="InfoText" Text="Индекс" />
                                        </td>
                                        <td width="35%">
                                            <asp:TextBox ID="textFactIndex" onblur="doValueCheck('textFactIndex');CopyAddress();"
                                                TabIndex="14" MaxLength="5" runat="server" class="InfoText25" meta:resourcekey="textClientIndex"/>
                                        </td>
                                        <td width="10%">
                                        </td>
                                        <td width="20%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lbFactRegion" meta:resourcekey="lbRegion" runat="server" 
                                                CssClass="InfoText" Text="Область" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textFactRegion" TabIndex="15" MaxLength="35" runat="server" class="InfoText"
                                                meta:resourcekey="textClientRegion" onblur="CopyAddress();"></asp:TextBox>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbFactDistrict" meta:resourcekey="lbDistrict" runat="server" CssClass="InfoText"
                                                Text="Район"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textFactDistrict" MaxLength="70" runat="server" class="InfoText"
                                                TabIndex="16" meta:resourcekey="textClientDistrict" onblur="CopyAddress();"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbFactSettlement" runat="server" CssClass="InfoText" meta:resourcekey="lbSettlement"
                                                Text="Населенный пункт"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textFactSettlement" MaxLength="70" runat="server" class="InfoText"
                                                TabIndex="17" meta:resourcekey="textClientSettlement" onblur="CopyAddress();"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbFactAddress" runat="server" CssClass="InfoText" meta:resourcekey="lbAddress"
                                                Text="Адрес"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textFactAddress" MaxLength="70" runat="server" onblur="CopyAddress();"
                                                TabIndex="18" class="InfoText" meta:resourcekey="textClientAddress"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVCodeType" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbClientCodeType" meta:resourcekey="lbClientCodeType" runat="server"
                                CssClass="InfoText">Тип госреестра</asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="listClientCodeType" runat="server" DataValueField="tgr" DataTextField="name"
                                DataSource="<%# dsClientCodeType %>" TabIndex="19" CssClass="BaseDropDownList">
                            </asp:DropDownList>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVClientCode" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbClientCode" meta:resourcekey="lbClientCode" runat="server" CssClass="InfoText">Идентификационный код</asp:Label>
                        </td>
                        <td colspan="2" style="white-space: nowrap" >
                            <asp:TextBox ID="textClientCode" meta:resourcekey="textClientCode" runat="server" CssClass="InfoText25"
                                TabIndex="19" MaxLength="10" ToolTip="Идентификационный код" style="text-align:center"
                                onblur="doValueCheck('textClientCode');ckOKPO();" />
                            <asp:Label ID="lbInvalidClientCode" runat="server" CssClass="Validator" />
                            <input id="hfClientCode" runat="server" type="hidden" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="validatorClientCodeEx" meta:resourcekey="NeedToFill" runat="server"
                                ErrorMessage="необходимо заполнить" ControlToValidate="textClientCode" CssClass="Validator" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVDocType" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbDocType" meta:resourcekey="lbDocType" runat="server" CssClass="InfoText">Вид документа</asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="listDocType" runat="server" DataValueField="passp" DataTextField="name"
                                onchange="ckNumber()"
                                DataSource="<%# dsDocType %>" TabIndex="20" CssClass="BaseDropDownList">
                            </asp:DropDownList>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lbDocSerial" meta:resourcekey="lbDocSerial3" runat="server" CssClass="InfoText">Серия</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textDocSerial" meta:resourcekey="textDocSerial" runat="server" MaxLength="10"
                                ToolTip="Серия документа" TabIndex="21" CssClass="InfoText" onblur="ckSerial();"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVDocNumber" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbDocNumber" meta:resourcekey="lbDocNumber3" runat="server" CssClass="InfoText">Номер</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textDocNumber" meta:resourcekey="textDocNumber" runat="server" MaxLength="20"
                                onkeypress="return CheckDocNumber(this);"
                                ToolTip="Номер документа" TabIndex="22" CssClass="InfoText" onblur="/*doValueCheck('textDocNumber');*/ckNumber();"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="validatorDocNumber" meta:resourcekey="NeedToFill"
                                runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="textDocNumber"
                                CssClass="Validator"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVDocOrg" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbDocOrg" meta:resourcekey="lbDocOrg" runat="server" CssClass="InfoText">Кем выдан</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textDocOrg" meta:resourcekey="textDocOrg" runat="server" MaxLength="70"
                                ToolTip="Кем выдан" TabIndex="23" CssClass="InfoText"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="validatorDocOrg" meta:resourcekey="NeedToFill" runat="server"
                                ErrorMessage="необходимо заполнить" ControlToValidate="textDocOrg" CssClass="Validator"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVDocDate" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbDocDate" meta:resourcekey="lbDocDate" runat="server" CssClass="InfoText">Дата выдачи</asp:Label>
                        </td>
                        <td>
                            <igtxt:webdatetimeedit id="dtDocDate" runat="server" ToolTip="Дата выдачи документа"
                                EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy" HorizontalAlign="Center"
                                MinValue="1800-01-01" tabIndex="24" CssClass="InfoDateSum" onblur="ckClRegDate('dtDocDate')">
                                <clientsideevents blur="dtDocDate_Blur"></clientsideevents>
                            </igtxt:webdatetimeedit>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="validatorDocDate" meta:resourcekey="NeedToFill" runat="server"
                                ErrorMessage="необходимо заполнить" ControlToValidate="dtDocDate" CssClass="Validator"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbVCellPhone" Text="*" runat="server" ForeColor="LightPink" CssClass="InfoText" />
                        </td>
                        <td>
                            <asp:Label ID="lbCellPhone" Text="Мобільний телефон" runat="server" meta:resourcekey="lbCellPhone"
                                CssClass="InfoText" />
                        </td>
                        <td>
                            <asp:TextBox ID="textCellPhone" meta:resourcekey="textCellPhone" runat="server" MaxLength="15"
                                TabIndex="30" ToolTip="Мобільний телефон клієнта" CssClass="InfoText40" onchange="RepeatCellNumbers();"/>
                            <%--<ajax:MaskedEditExtender ID="meeCellPhone" runat="server" TargetControlID="textCellPhone" MaskType="None" Mask="+38(999)9999999" ClearMaskOnLostFocus="true" />--%>
                            <asp:HiddenField ID="textCellPhoneWithoutMask" runat="server" />
                        </td>
                        <td>
                        </td>
                         <td>
                              <asp:Label ID="LCellphone2" Text="невірний мобільний телефон" meta:resourcekey="lbCellPhone" runat="server" CssClass="InfoText" 
                              Visible="false" Textcolor="red" ForeColor="#FF3300" Textalign="Center"/>
                            </td>                          
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbHomePhone" meta:resourcekey="lbHomePhone" runat="server" CssClass="InfoText">Домашний телефон</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textHomePhone" meta:resourcekey="textHomePhone" runat="server" MaxLength="15"
                                TabIndex="27" ToolTip="Домашний телефон" CssClass="InfoText40" />
                            <ajax:MaskedEditExtender ID="meeHomePhone" runat="server" TargetControlID="textHomePhone"
                                Mask="+38(999)9999999" />
                        </td>
                        <td>
                        </td>
                          <td rowspan="2">
                            <asp:CustomValidator ID="validatorPhones" runat="server" CssClass="Validator" ControlToValidate="textCellPhone"
                                ClientValidationFunction="checkPhones" ValidateEmptyText="True" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbWorkPhone" meta:resourcekey="lbWorkPhone" runat="server" CssClass="InfoText">Контактный телефон</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textWorkPhone" meta:resourcekey="textWorkPhone" runat="server" MaxLength="15"
                                TabIndex="28" ToolTip="Рабочий телефон" CssClass="InfoText40" />
                            <ajax:MaskedEditExtender ID="meeWorkPhone" runat="server" TargetControlID="textWorkPhone"
                                Mask="+38(999)9999999" />
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <table class="InnerTable">
                    <tr>
                        <td width="25%">
                        </td>
                        <td width="25%">
                            <input id="noCheck" type="hidden" />
                        </td>
                        <td width="25%">
                            <input id="fRNK" type="hidden" runat="server" />                            
                        </td>
                        <td width="25%">
                           <input id="userFIO" type="hidden" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnClear" meta:resourcekey="btnClear" runat="server" Text="Очистить"
                                CausesValidation="False" TabIndex="103" CssClass="DirectionButton" />
                        </td>
                        <td>
                        </td>
                        <td align="center">
                            <input id="btSubmit" runat="server" type="submit" value="Далее" tabindex="101" class="AcceptButton" />
                        </td>
                        <td align="center">
                            <asp:Button ID="btUpdate" meta:resourcekey="btUpdate" runat="server" Text="Регистрировать"
                                TabIndex="100" CssClass="AcceptButton" Visible="False"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <input runat="server" type="hidden" id="forbtShowFullName" meta:resourcekey="forbtShowFullName"
        value="Свернуть" />
    <input runat="server" type="hidden" id="forbtShowFactAddress" meta:resourcekey="forbtShowFullName"
        value="Свернуть" />
    <input runat="server" type="hidden" id="forbtShowFullName2" meta:resourcekey="forbtShowFullName2"
        value="Развернуть" />
    <input runat="server" type="hidden" id="fortextClientName" meta:resourcekey="fortextClientName"
        value="ФИО" />
    <input runat="server" type="hidden" id="fortextClientLastName" meta:resourcekey="fortextClientLastName"
        value="Фамилия" />
    <input runat="server" type="hidden" id="fortextClientFirstName" meta:resourcekey="fortextClientFirstName"
        value="Имя" />
    <input runat="server" type="hidden" id="fortextClientPatronymic" meta:resourcekey="fortextClientPatronymic"
        value="Отчество" />
    <input runat="server" type="hidden" id="fortextFIOGenitive" meta:resourcekey="fortextFIOGenitive"
        value="ФИО (в родительном падеже)" />
    <input runat="server" type="hidden" id="forbtCountry" meta:resourcekey="forbtCountry"
        value="Выбрать" />
    <input runat="server" type="hidden" id="forbtSubmit" meta:resourcekey="forbtSubmit"
        value="Далее" />
    <input runat="server" type="hidden" id="resid_checked" value="1" />
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        <Scripts>
            <asp:ScriptReference Path="js/js.js" />
        </Scripts>
    </asp:ScriptManager>
    <script language="javascript" type="text/javascript">
                if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
    </script>
    <!-- #include virtual="Inc/DepositAccCk.inc"-->
    <!-- #include virtual="Inc/DepositCk.inc"-->
    <!-- #include virtual="Inc/DepositJs.inc"-->
    <script type="text/javascript" language="javascript">
				//document.getElementById("textDocNumber").attachEvent("onkeydown",doNum);
				document.getElementById("textClientCode").attachEvent("onkeydown",doNum);
				document.getElementById("textClientIndex").attachEvent("onkeydown",doNum);
				document.getElementById("textFactIndex").attachEvent("onkeydown",doNum);
				
				document.getElementById("textClientName").attachEvent("onkeydown",doAlpha);
				document.getElementById("textClientFirstName").attachEvent("onkeydown",doAlpha);
				document.getElementById("textClientLastName").attachEvent("onkeydown",doAlpha);
				document.getElementById("textClientPatronymic").attachEvent("onkeydown",doAlpha);
				
				// Локализация
                LocalizeHtmlTitle("btShowFullName");
                LocalizeHtmlTitle("textClientName");
                LocalizeHtmlTitle("textClientLastName");
                LocalizeHtmlTitle("textClientFirstName");
                LocalizeHtmlTitle("textClientPatronymic");
                LocalizeHtmlTitle("textFIOGenitive");                
                LocalizeHtmlTitle("btCountry");
                LocalizeHtmlValue("btSubmit");
                LocalizeHtmlTitle("btShowFactAddress");
    </script>
    </form>
</body>
</html>
