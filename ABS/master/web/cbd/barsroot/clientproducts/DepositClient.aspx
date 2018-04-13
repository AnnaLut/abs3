<%@ Page Language="c#" CodeFile="DepositClient.aspx.cs" AutoEventWireup="true" Inherits="DepositClient" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register TagPrefix="Bars" Namespace="Bars.DataComponents" Assembly="Bars.DataComponentsEx" %>
<%@ Register Src="~/credit/usercontrols/ByteImage.ascx" TagName="ByteImage" TagPrefix="bec" %>
<%@ Register Src="../UserControls/ScanIdDocs.ascx" TagName="ScanIdDocs" TagPrefix="bars" %>
<%@ Register Src="~/UserControls/EADocsView.ascx" TagPrefix="bars" TagName="EADocsView" %>
<%@ Register Src="../UserControls/EADoc.ascx" TagName="EADoc" TagPrefix="ead" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <base target="_self" />
    <title>Депозитний модуль: Картка клієнта</title>
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js?v1.3"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js?v1.3"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/AccCk.js?v1.2"></script>
    <script type="text/javascript" language="javascript" src="js/action.js?v1.23"></script>
    <script type="text/javascript" language="javascript" src="js/check.js?v1.16"></script>
    <script type="text/vbscript" language="vbscript" src="/Common/Script/Messages/base.vbs"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/Messages/base.js"></script>
    <script type="text/javascript" language="javascript">
        function AddListener4Enter()
        {
            AddListeners("textClientName,textClientFirstName,textClientLastName,textClientPatronymic,textCountry,textClientIndex,listClientCodeType,textClientRegion,textClientDistrict,textClientSettlement,textClientAddress,textClientCode,textDocSerial,textDocNumber,textDocOrg,textDocDate,textPhotoDate,textBirthDate,textHomePhone,textBirthPlace,textWorkPhone,listDocType,listSex,textFIOGenitive,textFactIndex,textFactRegion,textFactDistrict,textFactSettlement,textFactLocation",
		    'onkeydown', TreatEnterAsTab);
        }
    </script>
    <script type="text/javascript" language="javascript">
        function changeStyle() {
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
        function changeStyleAddress(){
            var _div = document.getElementById('fact_address');
            if (_div.className == "mo")
            {
                _div.className = "mn";
                document.getElementById('btShowFactAddress').value = "-";
                document.getElementById('btShowFactAddress').title = LocalizedString('forbtShowFullName');
            }
            else if (_div.className == "mn")
            {
                _div.className = "mo";
                document.getElementById('btShowFactAddress').value = "+";
                document.getElementById('btShowFactAddress').title = LocalizedString('forbtShowFullName2');;
            }
        }
        function changeStyleTaxDetails()
        {
            var _div = document.getElementById('tax_details');

            if ((document.getElementById('cbSelfEmployer').checked) && (_div.className == "mo"))
            {
                _div.className = "mn";
            }
            else
            {
                _div.className = "mo";
            }
        }

        function AfterPageLoad()
        {
            if (document.getElementById('textClientTerritory'))
                document.getElementById('textClientTerritory').readOnly = true;

            if (document.getElementById('textTaxAgencyCode'))
                document.getElementById('textTaxAgencyCode').readOnly = true;

            if (document.getElementById('textRegAgencyCode'))
                document.getElementById('textRegAgencyCode').readOnly = true;

            focusControl('listSex');
        }
       </script>

 
    <script type="text/javascript" language="javascript">
        // скажем обычным контролам трактовать Enter как Tab
        CrossAddEventListener(window, 'onload', AddListener4Enter);
    </script>
</head>
<body onload="AfterPageLoad();">
    <form id="DepositFormMain" method="post" runat="server">
        <ajax:ToolkitScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true" >
        </ajax:ToolkitScriptManager>
        <table class="MainTable">
            <tr>
                <td>
                    <asp:Label ID="lbInfo" runat="server" CssClass="InfoHeader">Клиент</asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable">
                        <tr>
                            <td colspan="6">
                                <input id="btSearch" meta:resourcekey="btSearch3" onclick="openDialog(this.form)"
                                    type="button" value="Поиск" runat="server" tabindex="102" class="DirectionButton" />
                            </td>
                        </tr>
                        <tr>
                            <td width="3%">
                                <input id="btShowFullName" class="ImgButton" tabindex="2001" type="button" onclick="changeStyle()"
                                    value="-" title="Свернуть" />
                            </td>
                            <td style="width: 20%">
                                <asp:Label ID="lbClientName" Text="ПІБ" meta:resourcekey="lbClientName2" runat="server" 
                                    CssClass="InfoText" Font-Bold="true" />
                            </td>
                            <td width="35%">
                                <input id="textClientName" readonly="readonly" type="text" maxlength="70" runat="server"
                                    title="ФИО" class="InfoText" style="background-color:LightGray" />
                            </td>
                            <td width="3%"></td>
                            <td width="17%">
                                <asp:Label ID="lbFIO" runat="server" Visible="False" CssClass="Validator" Text="необходимо заполнить" />
                            </td>
                            <td align="center" style="width: 22%" rowspan="12" valign="top">
                                <table class="InnerTable">
                                    <tr>
                                        <td align="center" valign="top">
                                            <bec:ByteImage ID="biClietFoto" runat="server" Height="160px" Width="120px" ToolTip="Фотографія клієнта"
                                                Visible="false" ShowLabel="false" ShowView="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td align="center" valign="top">
                                            <bec:ByteImage ID="biClietSign" runat="server" Visible="false" Height="90px" Width="120px"
                                                ToolTip="Підпис клієнта" ShowLabel="false" ShowView="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <div class="mn" id="full_name">
                                    <table class="InnerTable">
                                        <tr>
                                            <td style="width: 3%"></td>
                                            <td style="width: 20%">
                                                <asp:Label ID="lbSex" Text="Стать" meta:resourcekey="lbSex" runat="server" CssClass="InfoText" />
                                            </td>
                                            <td width="35%">
                                                <asp:DropDownList ID="listSex" runat="server" CssClass="BaseDropDownList" TabIndex="1" />
                                            </td>
                                            <td style="width: 3%"></td>
                                            <td style="width: 17%"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbLastNameReq" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbLastName" meta:resourcekey="lbLastName" runat="server" CssClass="InfoText">Фамилия</asp:Label>
                                            </td>
                                            <td>
                                                <input id="textClientLastName" tabindex="2" type="text" maxlength="70" runat="server"
                                                    title="Фамилия" class="InfoText" onblur="getFullName();" />
                                            </td>
                                            <td></td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="validatorClientLastName" meta:resourcekey="NeedToFill" runat="server"
                                                    ErrorMessage="необходимо заполнить" ControlToValidate="textClientLastName" CssClass="Validator" />
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
                                                <input id="textClientFirstName" tabindex="3" type="text" maxlength="70" runat="server"
                                                    class="InfoText" onblur="getFullName();" />
                                            </td>
                                            <td></td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="validatorClientFirstName" meta:resourcekey="NeedToFill"
                                                    runat="server" ControlToValidate="textClientFirstName" ErrorMessage="необходимо заполнить"
                                                    CssClass="Validator"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Label ID="lbPatronymic" meta:resourcekey="lbPatronymic" runat="server" CssClass="InfoText">Отчество</asp:Label>
                                            </td>
                                            <td>
                                                <input id="textClientPatronymic" tabindex="4" type="text" maxlength="70" runat="server"
                                                    class="InfoText" onblur="getFullName();" />
                                            </td>
                                            <td></td>
                                            <td>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbFIOGenitiveReq" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbFIOGenitive" Text="ПІБ (в родовому відмінку)" runat="server" CssClass="InfoText" meta:resourcekey="lbFIOGenitive" />
                                            </td>
                                            <td>
                                                <input id="textFIOGenitive" tabindex="5" type="text" maxlength="70" runat="server"
                                                    class="InfoText" />
                                            </td>
                                            <td></td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="validatorTextFioGenitive" runat="server" ControlToValidate="textFIOGenitive"
                                                    CssClass="Validator" ErrorMessage="необходимо заполнить" meta:resourcekey="NeedToFill"></asp:RequiredFieldValidator>
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
                                <asp:TextBox ID="textBirthDate" runat="server" tabIndex="6" style="width:100px; text-align:center"
                                    ToolTip="Дата народження клієнта" 
                                    onblur="checkDocDate('textBirthDate');" />
                                <ajax:MaskedEditExtender ID="meeBirthDate" TargetControlID="textBirthDate" runat="server"
                                    Mask="99/99/9999" MaskType="Date" Century="2000" CultureName="en-GB"
                                    UserDateFormat="DayMonthYear" InputDirection="LeftToRight" OnFocusCssClass="MaskedEditFocus" />
                            </td>
                            <td></td>
                            <td>
                                <asp:RequiredFieldValidator ID="validatorBirthDate" meta:resourcekey="NeedToFill"
                                    runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="textBirthDate"
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
                                    MaxLength="70" ToolTip="Место рождения" TabIndex="7" CssClass="InfoText"></asp:TextBox>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Label ID="lbSpecialMark" Text="Особливі відмітки" runat="server" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:DropDownList ID="listSpecial" runat="server" CssClass="BaseDropDownList"
                                   DataValueField="MARK_CODE" DataTextField="MARK_NAME" TabIndex="8" />
                            </td>
                            <td></td>
                            <td>
                                <asp:CustomValidator ID="validatorSpecialMark" runat="server" CssClass="Validator"
                                    ControlToValidate="listSpecial" ClientValidationFunction="checkSpecialMark" 
                                    ErrorMessage="не відповідає віку клієнта" />
                            </td>
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
                                <input id="textCountry" readonly="readonly" type="text" class="InfoText" runat="server" tabindex="9" />
                            </td>
                            <td>
                                <input id="btCountry" onclick="openCountryDialog()" runat="server" type="button"
                                    class="ImgButton" value="?" title="Выбрать" tabindex="10" />
                            </td>
                            <td>
                                <input id="textCountryCode" type="hidden" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Label ID="lbResident" runat="server" CssClass="InfoText" meta:resourcekey="lbResident">Резидент</asp:Label>
                            </td>
                            <td>
                                <input id="ckResident" tabindex="11" type="checkbox" checked="CHECKED" runat="server"
                                    onpropertychange="EnableResident()" enableviewstate="true" />
                                <input runat="server" type="hidden" id="resid_checked" value="1" />
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbVTerritory" runat="server" CssClass="InfoText" ForeColor="Red" Visible="true">*</asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lbClientTerritory" Text="Код території" runat="server"
                                    CssClass="InfoText" meta:resourcekey="lbClientTerritory" />
                            </td>
                            <td>
                                <asp:TextBox ID="textClientTerritory" meta:resourcekey="textClientTerritory" runat="server" 
                                    ToolTip="Код території" CssClass="InfoText"  TabIndex="12" BackColor="LightGray"
                                    onblur="doNum('textClientTerritory');"/>
                            </td>
                            <td>
                                <input id="btTerritory" onclick="showTerritory()" tabindex="13" type="button" value="?"
                                    runat="server" class="ImgButton" title="Вибрати код території" visible="TRUE" />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="validatorTextClientTerritory" runat="server" 
                                    ControlToValidate="textClientTerritory" ErrorMessage="необходимо заполнить"
                                    CssClass="Validator" meta:resourcekey="NeedToFill" Enabled="true" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input id="btShowClientAddress" class="ImgButton" type="button" onclick="changeStyleAddressU()"
                                    value="-" title="Згорнути" style="display:none"/>
                            </td>
                            <td>
                                <asp:Label ID="Label1" runat="server" CssClass="InfoText" Text="Юридична адреса" Font-Bold="true" />
                            </td>
                            <td>
                                <asp:TextBox ID="textClientAddressFull" runat="server" CssClass="InfoText" 
                                    TabIndex="14" ReadOnly="True" BackColor="LightGray" Visible="false" />
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Label ID="lbClientIndex" meta:resourcekey="lbClientIndex" runat="server" CssClass="InfoText">Индекс</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="textClientIndex" meta:resourcekey="textClientIndex" onkeydown="doNum();"
                                    TabIndex="15" MaxLength="5" runat="server" ToolTip="Индекс" CssClass="InfoText25"
                                    onblur="doValueCheck('textClientIndex');CopyAddress('textClientIndex','textFactIndex');" />
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Label ID="lbRegion" Text="Область" meta:resourcekey="lbRegion" runat="server" CssClass="InfoText" />
                            </td>
                            <td style="white-space: nowrap">
                                <asp:TextBox ID="preClientRegion" runat="server" CssClass="InfoText10" Enabled="False"></asp:TextBox>
                                <input id="btRegion" type="button" value="..." runat="server" class="ReferenceBookButton"
                                    title="" disabled="disabled" />
                                <asp:TextBox ID="textClientRegion" meta:resourcekey="textClientRegion" runat="server"
                                    MaxLength="35" ToolTip="Область" TabIndex="16" CssClass="InfoText80" 
                                    onblur="CopyAddress('textClientRegion','textFactRegion','preClientRegion');" />
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
                                <asp:TextBox ID="preClientDistrict" runat="server" CssClass="InfoText10" Enabled="False" />
                                <input id="btDistrict" type="button" value="..." runat="server" class="ReferenceBookButton"
                                    title="" disabled="disabled" />
                                <asp:TextBox ID="textClientDistrict" meta:resourcekey="textClientDistrict" runat="server"
                                    MaxLength="35" ToolTip="Район" TabIndex="17" CssClass="InfoText80"
                                    nblur="CopyAddress('textClientDistrict','textFactDistrict','preClientDistrict');" />
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbVSettlement" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lbSettlement" Text="Населений пункт" meta:resourcekey="lbSettlement" runat="server" CssClass="InfoText" />
                            </td>
                            <td style="white-space: nowrap">
                                <asp:TextBox ID="preClientSettlement" runat="server" CssClass="InfoText10" Enabled="False" >
                                </asp:TextBox>
                                <input id="btSettlementType" type="button" value="..." runat="server" class="ReferenceBookButton"
                                    tabindex="19" onclick="GetLocalityType();" title="Тип населеного пункту" />
                                <asp:TextBox ID="textClientSettlement" meta:resourcekey="textClientSettlement" runat="server"
                                    MaxLength="70" ToolTip="Населённый пункт" TabIndex="18" CssClass="InfoText80"
                                    onblur="CopyAddress('textClientSettlement','textFactSettlement','preClientSettlement');"></asp:TextBox>
                            </td>
                            <td>                                
                                <input type="hidden" runat="server" id="hidSettlementType" />
                            </td>
                            <td>
                                <asp:CustomValidator ID="validatorClientSettlement" runat="server" CssClass="Validator"
                                    meta:resourcekey="NeedToFill" ErrorMessage="необходимо заполнить" ClientValidationFunction="validateClientSettlement"
                                    ControlToValidate="textClientSettlement" ValidateEmptyText="True"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Label ID="lbAddress" meta:resourcekey="lbAddress" runat="server" CssClass="InfoText">Адрес</asp:Label>
                            </td>
                            <td style="white-space: nowrap">
                                <asp:TextBox ID="preClientAddress" runat="server" CssClass="InfoText10" Enabled="False">
                                </asp:TextBox>
                                <input id="btStreetType" type="button" value="..." runat="server" class="ReferenceBookButton"
                                    tabindex="21" onclick="GetStreetType()" title="Тип улицы"  meta:resourcekey="forbtStreetType" />
                                <asp:TextBox ID="textClientAddress" runat="server" meta:resourcekey="textClientAddress"
                                    MaxLength="70" ToolTip="Адрес" TabIndex="20" CssClass="InfoText80" 
                                    onblur="CopyAddress('textClientAddress','textFactAddress','preClientAddress');" />
                            </td>
                            <td>
                                <input type="hidden" runat="server" id="hidStreetType" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <input id="btShowFactAddress" class="ImgButton" tabindex="2001" type="button" onclick="changeStyleAddress()"
                                    value="-" title="Свернуть" />
                            </td>
                            <td>
                                <asp:Label ID="lbFactAddressFull" Text="Фактична адреса" runat="server" meta:resourcekey="lbFactAddressFull"
                                     CssClass="InfoText" Font-Bold="true" />
                            </td>
                            <td>
                                <asp:TextBox ID="textFactAddressFull" runat="server" CssClass="InfoText" meta:resourcekey="textFactAddressFull"
                                    TabIndex="22" ReadOnly="True" BackColor="LightGray" />
                            </td>
                            <td></td>
                            <td>
                                <asp:CustomValidator ID="validatorAddressFull" runat="server" ClientValidationFunction="checkAddress"
                                    ControlToValidate="textClientAddress" CssClass="Validator" ValidateEmptyText="True">
                                </asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <div class="mn" id="fact_address">
                                    <table class="InnerTable">
                                        <tr>
                                            <td width="3%"></td>
                                            <td width="20%">
                                                <asp:Label ID="lbFactIndex" meta:resourcekey="lbClientIndex" runat="server" CssClass="InfoText"
                                                    Text="Индекс"></asp:Label>
                                            </td>
                                            <td width="35%">
                                                <asp:TextBox ID="textFactIndex" onblur="doValueCheck('textFactIndex');CopyAddress();"
                                                    TabIndex="23" MaxLength="5" runat="server" class="InfoText40" meta:resourcekey="textClientIndex"/>
                                            </td>
                                            <td width="3%"></td>
                                            <td width="17%"></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Label ID="lbFactRegion" meta:resourcekey="lbRegion" runat="server" CssClass="InfoText"
                                                    Text="Область"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="textFactRegion" MaxLength="35" runat="server" class="InfoText"
                                                    TabIndex="24" meta:resourcekey="textClientRegion" onblur="CopyAddress();"></asp:TextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Label ID="lbFactDistrict" meta:resourcekey="lbDistrict" runat="server" CssClass="InfoText"
                                                    Text="Район"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="textFactDistrict" MaxLength="70" runat="server" class="InfoText"
                                                    TabIndex="25" meta:resourcekey="textClientDistrict" onblur="CopyAddress();"></asp:TextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Label ID="lbFactSettlement" runat="server" CssClass="InfoText" meta:resourcekey="lbSettlement"
                                                    Text="Населенный пункт"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="textFactSettlement" MaxLength="70" runat="server" class="InfoText"
                                                    TabIndex="26" meta:resourcekey="textClientSettlement" onblur="CopyAddress();"></asp:TextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Label ID="lbFactAddress" runat="server" CssClass="InfoText" meta:resourcekey="lbAddress"
                                                    Text="Адрес"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="textFactAddress" MaxLength="70" runat="server" onblur="CopyAddress();"
                                                    TabIndex="27" CssClass="InfoText" meta:resourcekey="textClientAddress"></asp:TextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Label ID="lbSelfEmployer" Text="Самозайнята особа" runat="server" CssClass="InfoText" meta:resourcekey="lbSelfEmployer" />
                            </td>
                            <td>
                                <input id="cbSelfEmployer" type="checkbox" runat="server" enableviewstate="true" 
                                    tabindex="28" onpropertychange="changeStyleTaxDetails()"/>
                                <!-- tabindex="6" checked="CHECKED"   -->
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <div class="mo" id="tax_details">
                                    <table class="InnerTable">
                                        <tr>
                                            <td width="3%">
                                                <asp:Label ID="lbVTaxAgencyCode" runat="server" Text="*" ForeColor="Red" CssClass="InfoText" />
                                            </td>
                                            <td width="20%">
                                                <asp:Label ID="lbTaxAgencyCode" meta:resourcekey="lbTaxCode" runat="server" CssClass="InfoText"
                                                    Text="Код ДПА" />
                                            </td>
                                            <td style="white-space: nowrap; width:35%">
                                                <asp:TextBox ID="textTaxAgencyCode" runat="server" CssClass="InfoText10"
                                                    meta:resourcekey="textTaxAgencyCode" />
                                                <asp:TextBox ID="textTaxAgencyName" runat="server"
                                                    TabIndex="14" CssClass="InfoText80" meta:resourcekey="textTaxAgencyName" />
                                            </td>
                                            <td width="3%">
                                                <input type="button" id="btnTaxAgencyCode" value="?" runat="server" class="ImgButton"
                                                    tabindex="29" onclick="showTaxAgencyCode()" title="Вибрати код ДПА" />
                                            </td>
                                            <td width="17%"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbVRegAgencyCode" runat="server" Text="*" ForeColor="Red" CssClass="InfoText" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lbRegAgencyCode" meta:resourcekey="lbRegAgencyCode" runat="server" CssClass="InfoText"
                                                    Text="Код органу реєстрації" />
                                            </td>
                                            <td style="white-space: nowrap">
                                                <asp:TextBox ID="textRegAgencyCode" runat="server" CssClass="InfoText10"
                                                    meta:resourcekey="textRegAgencyCode" />
                                                <asp:TextBox ID="textRegAgencyName" runat="server" CssClass="InfoText80"
                                                    TabIndex="14" meta:resourcekey="textRegAgencyName" />
                                            </td>
                                            <td>
                                                <input type="button" id="btnRegAgencyCode" value="?" runat="server" class="ImgButton"
                                                    tabindex="30" onclick="showRegAgencyCode()"  title="Вибрати код органу реєстрації" />
                                            </td>
                                            <td></td>
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
                                <asp:Label ID="lbClientCodeType" Text="Тип госреестра" runat="server"
                                    meta:resourcekey="lbClientCodeType" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:DropDownList ID="listClientCodeType" runat="server" CssClass="BaseDropDownList"
                                    TabIndex="31" DataValueField="tgr" DataTextField="name" DataSource="<%# dsClientCodeType %>">
                                </asp:DropDownList>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbVClientCode" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lbClientCode" meta:resourcekey="lbClientCode" runat="server" CssClass="InfoText">Идентификационный код</asp:Label>
                            </td>
                            <td >
                                <asp:TextBox ID="textClientCode" meta:resourcekey="textClientCode" runat="server"
                                    TabIndex="32" MaxLength="10" ToolTip="Идентификационный код" CssClass="InfoText40"
                                    onblur="doValueCheck('textClientCode');ckOKPO();" />                                
                            </td>
                            <td></td>
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
                                <asp:DropDownList ID="listDocType" runat="server" CssClass="BaseDropDownList" 
                                    TabIndex="33" DataSource="<%# dsDocType %>" DataValueField="passp" DataTextField="name" >
                                </asp:DropDownList>
                            </td>
                            <td></td>
                            <td></td>
                            <td>
                                <bars:ScanIdDocs ID="ScanIdentDocs" runat="server" Visible="false"
                                    OnScanIdDocsDone="ScanIdentDocs_ScanIdDocsDone" />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td>
                                <asp:Label ID="lbDocSerial" meta:resourcekey="lbDocSerial3" runat="server" CssClass="InfoText">Серия</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="textDocSerial" meta:resourcekey="textDocSerial" runat="server" MaxLength="10"
                                    TabIndex="34" ToolTip="Серия документа" CssClass="InfoText40" onblur="ckSerial();" />
                            </td>
                            <td></td>
                            <td>&nbsp;
                            </td>
                            <td></td>
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
                                    TabIndex="35" ToolTip="Номер документа" CssClass="InfoText40" 
                                    onblur="doValueCheck('textDocNumber'); ckNumber();" />
                            </td>
                            <td></td>
                            <td>
                                <asp:RequiredFieldValidator ID="validatorDocNumber" meta:resourcekey="NeedToFill"
                                    runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="textDocNumber"
                                    CssClass="Validator"></asp:RequiredFieldValidator>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbVDocOrg" Text="*" runat="server" ForeColor="Red" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:Label ID="lbDocOrg" meta:resourcekey="lbDocOrg" runat="server" CssClass="InfoText">Кем выдан</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="textDocOrg" meta:resourcekey="textDocOrg" runat="server" MaxLength="70"
                                    TabIndex="36" ToolTip="Кем выдан" CssClass="InfoText" />
                            </td>
                            <td>
                                <input id="btnDocOrg" type="button" value="?" runat="server" class="ImgButton"
                                    tabindex="37" onclick="showOrganization()" title="Вибір організації що видала документ" />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="validatorDocOrg" meta:resourcekey="NeedToFill" runat="server"
                                    ErrorMessage="необходимо заполнить" ControlToValidate="textDocOrg" CssClass="Validator" />
                            </td>
                            <td>
                                <bars:EADocsView runat="server" ID="EADocsView" EAStructID="1" Visible="false" OnDocsViewed="EADocsView_DocsViewed" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbVDocDate" Text="*" runat="server" ForeColor="Red" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:Label ID="lbDocDate" meta:resourcekey="lbDocDate" runat="server" CssClass="InfoText">Дата выдачи</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="textDocDate" runat="server" style="width:100px; text-align:center"
                                    tabIndex="38" ToolTip="Дата видачі документу" 
                                    onblur="checkDocDate('textDocDate');" />
                                <ajax:MaskedEditExtender ID="meeDocDate" TargetControlID="textDocDate" runat="server"
                                    Mask="99/99/9999" MaskType="Date" Century="2000" CultureName="en-GB"
                                    UserDateFormat="DayMonthYear" InputDirection="LeftToRight" OnFocusCssClass="MaskedEditFocus" />                                
                            </td>
                            <td></td>
                            <td>
                                <asp:RequiredFieldValidator ID="validatorDocDate" meta:resourcekey="NeedToFill" runat="server"
                                    ErrorMessage="необходимо заполнить" ControlToValidate="textDocDate" CssClass="Validator" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbVPhotoDate" Text="*" runat="server" ForeColor="Red" CssClass="InfoText" Visible="false"/>
                            </td>
                            <td>
                                <asp:Label ID="lbPhotoDate" Text="Дата вклеювання фото" meta:resourcekey="lbPhotoDate" runat="server" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:TextBox ID="textPhotoDate" runat="server" style="width:100px; text-align:center"
                                    tabIndex="39" ToolTip="Дата вклеювання останньої фотографії у паспорт" 
                                    onblur="checkPhotoDate();" />
                                <ajax:MaskedEditExtender ID="meePhotoDate" TargetControlID="textPhotoDate" runat="server"
                                    Mask="99/99/9999" MaskType="Date" Century="2000" CultureName="en-GB"
                                    UserDateFormat="DayMonthYear" InputDirection="LeftToRight" OnFocusCssClass="MaskedEditFocus" />
                            </td>
                            <td></td>
                            <td>
                                <asp:CustomValidator ID="validatorPhotoDate" runat="server" CssClass="Validator"
                                    ControlToValidate="textPhotoDate" ClientValidationFunction="checkPhotoDateRequired" 
                                    meta:resourcekey="NeedToFill" ErrorMessage="необхідно заповнити" ValidateEmptyText="True" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbVCellPhone" Text="*" runat="server" ForeColor="LightPink" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:Label ID="lbCellPhone" Text="Мобільний телефон" runat="server" meta:resourcekey="lbCellPhone" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:TextBox ID="textCellPhone" meta:resourcekey="textCellPhone" runat="server" MaxLength="15"
                                    TabIndex="40" ToolTip="Мобільний телефон клієнта" CssClass="InfoText40" />
                                <ajax:MaskedEditExtender
                                    ID="meeCellPhone" runat="server"
                                    TargetControlID="textCellPhone"
                                    Mask="+38(999)9999999" />
                            </td>
                            <td></td>
                            <td rowspan="3">
                                <asp:CustomValidator ID="validatorPhones" runat="server" CssClass="Validator"
                                    ControlToValidate="textCellPhone" ClientValidationFunction="checkPhones"
                                    ValidateEmptyText="True" />
                            </td>
                            <td>
                                <asp:CheckBox ID="cbDocVerified" runat="server" ForeColor="Red" Font-Bold="true" 
                                    Visible="false" Enabled="false" Text="&nbsp; Документ перевірено" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbVHomePhone" Text="*" runat="server" ForeColor="LightPink" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:Label ID="lbHomePhone" Text="Домашний телефон" meta:resourcekey="lbHomePhone"
                                    runat="server" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:TextBox ID="textHomePhone" meta:resourcekey="textHomePhone" runat="server" MaxLength="15"
                                    TabIndex="41" ToolTip="Домашний телефон" CssClass="InfoText40" />
                                <ajax:MaskedEditExtender
                                    ID="meeHomePhone" runat="server"
                                    TargetControlID="textHomePhone"
                                    Mask="+38(999)9999999" />
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbVWorkPhone" Text="*" runat="server" ForeColor="LightPink" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:Label ID="lbWorkPhone" meta:resourcekey="lbWorkPhone" Text="Контактный телефон"
                                    runat="server" CssClass="InfoText" />
                            </td>
                            <td>
                                <asp:TextBox ID="textWorkPhone" meta:resourcekey="textWorkPhone" runat="server" MaxLength="15"
                                    TabIndex="42" ToolTip="Робочий телефон" CssClass="InfoText40" />
                                <ajax:MaskedEditExtender
                                    ID="meeWorkPhone" runat="server"
                                    TargetControlID="textWorkPhone"
                                    Mask="+38(999)9999999" />
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>
                    <table class="InnerTable">
                        <tr>
                            <td style="width: 20%">
                                <input id="fRNK" type="hidden" runat="server" />
                                <input id="noCheck" type="hidden" />
                            </td>
                            <td style="width: 20%">
                                &nbsp;</td>
                            <td align="center" colspan="2">
                                <ead:EADoc ID="eadPrintChange" TitleText="Друк заяви на зміну реквізитів" runat="server" Visible="false"
                                    TemplateID="DPT_CHANGEATTRS_APPLICATION" EAStructID="141"
                                    OnBeforePrint="eadPrintChange_BeforePrint" OnDocSigned="eadPrintChange_DocSigned" />
                            </td>
                            <td align="center" width="20%">
                                <asp:Button ID="btCreateRequest" meta:resourcekey="btCreateRequest" runat="server" Visible="false"
                                    Text="Запит на БЕК-офіс" CausesValidation="False" CssClass="AcceptButton" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%">
                                <input id="Hidden1" type="hidden" runat="server" />
                                <input id="noCheck" type="hidden" />
                            </td>
                            <td style="width: 20%"></td>
                            <td align="center" colspan="2">
                                <ead:EADoc ID="eadFinmonQuestionnaire_" runat="server" EAStructID="401" Visible="true"
                                            TitleText="Опитувальний лист ФМ" TemplateID="DPT_FINMON_QUESTIONNAIRE"
                                            OnBeforePrint="eadFinmonQuestionnaire_BeforePrint_" OnDocSigned ="eadFinmonQuestionnaire_DocSigned_"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" style="width: 20%">
                                <asp:Button ID="btnClear" meta:resourcekey="btnClear" runat="server" Text="Очистить"
                                    CausesValidation="False" TabIndex="103" CssClass="DirectionButton" />
                            </td>
                            <td align="center" style="width: 20%">
                                <input id="btSubmit" runat="server" type="submit" value="Далее" tabindex="101" class="DirectionButton" />
                            </td>
                            <td align="center" width="20%">
                                <asp:Button ID="btUpdate" meta:resourcekey="btUpdate" runat="server" Text="Регистрировать"
                                    Visible="False" TabIndex="100" CssClass="DirectionButton" />
                            </td>
                            <td align="center" width="20%">
                                <asp:Button ID="btEditClient" meta:resourcekey="btEditClient" runat="server" Visible="false" 
                                    Text="Редагування реквізитів"  CausesValidation="False" CssClass="AcceptButton"
                                    OnClientClick="f_EnableEditCliet(); return false;" />
                            </td>
                            <td align="center" width="20%">
                                <asp:Button ID="btContracts" meta:resourcekey="btContracts" runat="server" Visible="false"
                                    Text="Портфель договорів" CausesValidation="False" CssClass="AcceptButton" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <input runat="server" type="hidden" id="Edited" />
        <input runat="server" type="hidden" id="forbtShowFullName" meta:resourcekey="forbtShowFullName" value="Свернуть" />
        <input runat="server" type="hidden" id="forbtShowFactAddress" meta:resourcekey="forbtShowFullName" value="Свернуть" />
        <input runat="server" type="hidden" id="forbtShowFullName2" meta:resourcekey="forbtShowFullName2" value="Развернуть" />
        <input runat="server" type="hidden" id="fortextClientName" meta:resourcekey="fortextClientName" value="ФИО" />
        <input runat="server" type="hidden" id="fortextClientLastName" meta:resourcekey="fortextClientLastName" value="Фамилия" />
        <input runat="server" type="hidden" id="fortextClientFirstName" meta:resourcekey="fortextClientFirstName" value="Имя" />
        <input runat="server" type="hidden" id="fortextClientPatronymic" meta:resourcekey="fortextClientPatronymic" value="Отчество" />
        <input runat="server" type="hidden" id="fortextFIOGenitive" meta:resourcekey="fortextFIOGenitive" value="ФИО (в родительном падеже)" />
        <input runat="server" type="hidden" id="forbtCountry" meta:resourcekey="forbtCountry" value="Выбрать" />
        <input runat="server" type="hidden" id="forbtSubmit" meta:resourcekey="forbtSubmit" value="Далее" />
        <script language="javascript" type="text/javascript">
            if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
        </script>
		<!-- #include virtual="/barsroot/deposit/Inc/DepositAccCk.inc"-->
		<!-- #include virtual="/barsroot/deposit/Inc/DepositCk.inc"-->
		<!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
        <script type="text/javascript" language="javascript">
            document.getElementById("textDocNumber").onkeydown = function () { doNum(); }   //attachEvent("onkeydown",);
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
