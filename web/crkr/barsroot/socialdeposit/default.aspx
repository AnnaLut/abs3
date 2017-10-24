<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1" %>
<%@ Page language="c#" CodeFile="Default.aspx.cs" AutoEventWireup="true" Inherits="Default" enableViewState="True" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
	    <base target="_self" />
		<title>Депозитний модуль: Картка клієнта</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<script type="text/javascript" language="javascript" src="scripts/Default.js"></script>
        <script type="text/vbscript" language="vbscript" src="/Common/Script/Messages/base.vbs"></script>
        <script type="text/javascript" language="javascript" src="/Common/Script/Messages/base.js"></script>						        
        <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js?v1.2"></script>
        <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js?v1.2"></script>
        <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/AccCk.js?v1.2"></script>	
		<script type="text/javascript" language="javascript">
		function AddListener4Enter(){
			AddListeners("textClientName,textClientFirstName,textClientLastName,textClientPatronymic,textCountry,textClientIndex,listClientCodeType,textClientRegion,textClientDistrict,textClientSettlement,textClientAddress,textClientCode,textDocSerial,textDocNumber,textDocOrg,dtDocDate_t,dtBirthDate_t,textHomePhone,textBirthPlace,textWorkPhone,listDocType,listSex,textFIOGenitive,textFactIndex,textFactRegion,textFactDistrict,textFactSettlement,textFactLocation",
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
		</script>
		<script type="text/javascript">
		    var dtSwitcher = 0;
            function dtDocDate_Blur(oEdit, text, oEvent)
            {
                if (dtSwitcher != 2)
                    ckClRegDate("dtDocDate_t",1);
            }
            function dtBirthDate_Blur(oEdit, text, oEvent)
            {
                if (dtSwitcher != 1)
                    ckClRegDate("dtBirthDate_t",2);
            }
        </script>
		<script type="text/javascript" language="javascript">
		<!--			
			// скажем обычным контролам трактовать Enter как Tab
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
	</head>
	<body onload="focusControl('listSex');">
		<form id="DepositFormMain" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td>
						<asp:label id="lbInfo" runat="server" CssClass="InfoHeader">Клиент</asp:label>
					</td>
				</tr>
				<tr>
					<td>
									<input id="btSearch" meta:resourcekey="btSearch3" onclick="openDialog(this.form)" type="button" value="Поиск" runat="server"
										tabIndex="102" class="DirectionButton"></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
                            <tr>
                                <td width="5%">
                                </td>
                                <td width="30%">
									<asp:label id="lbSex" meta:resourcekey="lbSex" runat="server" CssClass="InfoText">Пол</asp:label></td>
                                <td width="35%">
									<asp:dropdownlist id="listSex" runat="server" CssClass="BaseDropDownList" tabIndex="1">
									</asp:dropdownlist></td>
                                <td width="10%">
                                </td>
                                <td width="20%">
                                </td>
                            </tr>
							<tr>
								<td width="5%">
									<input id="btShowFullName" class="ImgButton" tabIndex="2001" type="button" onclick="changeStyle()"
										value="-" title="Свернуть">
								</td>
								<td width="30%">
									<asp:label id="lbClientName" meta:resourcekey="lbClientName2" runat="server" CssClass="InfoText">ФИО</asp:label>
								</td>
								<td width="35%">
									<input id="textClientName" readOnly type="text" maxLength="70" runat="server" title="ФИО"
										class="InfoText">
								</td>
								<td width="10%"></td>
								<td width="20%">
									<asp:Label id="lbFIO" runat="server" Visible="False" CssClass="Validator">необходимо заполнить</asp:Label>
								</td>
							</tr>
							<tr>
								<td colSpan="5">
									<DIV class="mn" id="full_name">
										<table class="InnerTable">
											<tr>
												<td width="5%">
													<asp:label id="lbLastNameReq" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
												<td width="30%">
													<asp:label id="lbLastName" meta:resourcekey="lbLastName" runat="server" CssClass="InfoText">Фамилия</asp:label>
												</td>
												<td width="35%">
													<input id="textClientLastName" tabIndex="1" type="text" maxLength="70" runat="server" title="Фамилия"
														class="InfoText" onblur="getFullName();">
												</td>
												<td width="10%"></td>
												<td width="20%">
													<asp:requiredfieldvalidator id="validatorClientLastName" meta:resourcekey="NeedToFill" runat="server" ErrorMessage="необходимо заполнить"
														ControlToValidate="textClientLastName" CssClass="Validator"></asp:requiredfieldvalidator>
												</td>
											</tr>
											<tr>
												<td>
													<asp:label id="lbFirstNameReq" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
												<td>
													<asp:label id="lbFirstName" meta:resourcekey="Label3" runat="server" CssClass="InfoText">Имя</asp:label>
												</td>
												<td>
													<input id="textClientFirstName" tabIndex="2" type="text" maxLength="70" runat="server"
														class="InfoText" onblur="getFullName();">
												</td>
												<td></td>
												<td>
													<asp:requiredfieldvalidator id="validatorClientFirstName" meta:resourcekey="NeedToFill" runat="server" ControlToValidate="textClientFirstName"
														ErrorMessage="необходимо заполнить" CssClass="Validator"></asp:requiredfieldvalidator>
												</td>
											</tr>
											<tr>
												<td>
													</td>
												<td>
													<asp:label id="lbPatronymic" meta:resourcekey="lbPatronymic" runat="server" CssClass="InfoText">Отчество</asp:label>
												</td>
												<td>
													<input id="textClientPatronymic" tabIndex="3" type="text" maxLength="70" runat="server"
														class="InfoText" onblur="getFullName();">
												</td>
												<td></td>
												<td>
                                                    &nbsp;</td>
											</tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbFIOGenitiveReq" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:Label></td>
                                                <td>
                                                    <asp:Label ID="lbFIOGenitive" runat="server" CssClass="InfoText" meta:resourcekey="lbFIOGenitive">ФИО (в родительном падеже)</asp:Label></td>
                                                <td>
                                                    <input id="textFIOGenitive" tabIndex="4" type="text" maxLength="70" runat="server"
														class="InfoText"></td>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="validatorTextFioGenitive" runat="server" ControlToValidate="textFIOGenitive"
                                                        CssClass="InfoText" ErrorMessage="необходимо заполнить" meta:resourcekey="NeedToFill"></asp:RequiredFieldValidator></td>
                                            </tr>
										</table>
									</DIV>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbVCountry" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label>
								</td>
								<td>
									<asp:label id="lbClientCountry" meta:resourcekey="lbClientCountry" runat="server" CssClass="InfoText">Страна клиента</asp:label>
								</td>
								<td>
									<input id="textCountry" readOnly type="text" class="InfoText" runat="server" tabIndex="2000">
								</td>
								<td>
									<input id="btCountry" onclick="openCountryDialog()" tabIndex="5" type="button" value="?"
										class="ImgButton" title="Выбрать">
								</td>
								<td>
									<input id="textCountryCode" type="hidden" runat="server">
								</td>
							</tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbResident" runat="server" CssClass="InfoText" meta:resourcekey="lbResident">Резидент</asp:Label></td>
                                <td>
                                    <input id="ckResident" tabIndex="6" type="checkbox" CHECKED
										runat="server" onpropertychange="EnableResident()" enableviewstate="true">
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
                            <td></td>
                            <td>
                                <asp:Label ID="Label1" meta:resourcekey="lbClientIndex" runat="server" CssClass="InfoText">Индекс</asp:Label>
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
                                <td><input id="btShowFactAddress" class="ImgButton" tabIndex="2001" type="button" onclick="changeStyleAddress()"
										value="-" title="Свернуть"></td>
                                <td>
                                    <asp:Label ID="lbFactAddressFull" runat="server" CssClass="InfoText" meta:resourcekey="lbFactAddressFull">Фактический адрес</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="textFactAddressFull" runat="server" CssClass="InfoText" meta:resourcekey="textFactAddressFull" ReadOnly="True"></asp:TextBox></td>
                                <td>
                                </td>
                                <td>
                                    <asp:CustomValidator ID="validatorAddressFull" runat="server" ClientValidationFunction="checkAddress"
                                        ControlToValidate="textClientAddress" CssClass="Validator" ValidateEmptyText="True"></asp:CustomValidator></td>
                            </tr>
                            <tr>
								<td colSpan="5">
									<DIV class="mn" id="fact_address">
										<table class="InnerTable">
											<tr>
												<td width="5%">
													</td>
												<td width="30%">
													<asp:label id="lbFactIndex" meta:resourcekey="lbClientIndex" runat="server" CssClass="InfoText" Text="Индекс"></asp:label>
												</td>
												<td width="35%">
													<asp:textbox id="textFactIndex" onblur="doValueCheck('textFactIndex');CopyAddress();" tabIndex="11" maxLength="5" runat="server"
														class="InfoText" meta:resourcekey="textClientIndex" ></asp:textbox>
												</td>
												<td width="10%"></td>
												<td width="20%"></td>
											</tr>
											<tr>
												<td>
													</td>
												<td>
													<asp:label id="lbFactRegion" meta:resourcekey="lbRegion" runat="server" CssClass="InfoText" Text="Область"></asp:label>
												</td>
												<td>
													<asp:textbox id="textFactRegion" tabIndex="11" maxLength="35" runat="server"
														class="InfoText" meta:resourcekey="textClientRegion" onblur="CopyAddress();" ></asp:textbox>
												</td>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>
													</td>
												<td>
													<asp:label id="lbFactDistrict" meta:resourcekey="lbDistrict" runat="server" CssClass="InfoText" Text="Район"></asp:label>
												</td>
												<td>
													<asp:textbox id="textFactDistrict" tabIndex="11" maxLength="70" runat="server"
														class="InfoText" meta:resourcekey="textClientDistrict" onblur="CopyAddress();" ></asp:textbox>
												</td>
												<td></td>
												<td></td>
											</tr>
                                            <tr>
                                                <td>
                                                    </td>
                                                <td>
                                                    <asp:Label ID="lbFactSettlement" runat="server" CssClass="InfoText" meta:resourcekey="lbSettlement" Text="Населенный пункт"></asp:Label></td>
                                                <td>
                                                    <asp:textbox id="textFactSettlement" tabIndex="11" maxLength="70" runat="server"
														class="InfoText" meta:resourcekey="textClientSettlement" onblur="CopyAddress();"></asp:textbox></td>
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
                                                        Text="Адрес"></asp:Label></td>
                                                <td>
                                                    <asp:textbox id="textFactAddress" tabIndex="11" maxLength="70" runat="server"
														class="InfoText" meta:resourcekey="textClientAddress" onblur="CopyAddress();"></asp:textbox></td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
										</table>
									</DIV>
								</td>
                            </tr>
							<tr>
								<td>
									<asp:label id="lbVCodeType" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:label>
								</td>
								<td>
									<asp:label id="lbClientCodeType" meta:resourcekey="lbClientCodeType" runat="server" CssClass="InfoText">Тип госреестра</asp:label>
								</td>
								<td>
									<asp:dropdownlist id=listClientCodeType runat="server" 
										DataValueField="tgr" DataTextField="name" 
										DataSource="<%# dsClientCodeType %>" tabIndex=12
										CssClass="BaseDropDownList">
									</asp:dropdownlist>
								</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbVClientCode" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:label>
								</td>
								<td>
									<asp:label id="lbClientCode" meta:resourcekey="lbClientCode" runat="server" CssClass="InfoText">Идентификационный код</asp:label>
								</td>
								<td>
									<asp:textbox id="textClientCode" meta:resourcekey="textClientCode" runat="server" MaxLength="10" ToolTip="Идентификационный код"
										tabIndex="13" CssClass="InfoText" onblur="doValueCheck('textClientCode');ckOKPO();"></asp:textbox>
								</td>
								<td></td>
								<td>
									<asp:requiredfieldvalidator id="validatorClientCodeEx" meta:resourcekey="NeedToFill" runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="textClientCode"
										CssClass="Validator"></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbVDocType" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:label>
								</td>
								<td>
									<asp:label id="lbDocType" meta:resourcekey="lbDocType" runat="server" CssClass="InfoText">Вид документа</asp:label>
								</td>
								<td>
									<asp:dropdownlist id=listDocType runat="server" 
										DataValueField="passp" DataTextField="name" 
										DataSource="<%# dsDocType %>" tabIndex=14
										CssClass="BaseDropDownList">
									</asp:dropdownlist>
								</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>
                                    &nbsp;</td>
								<td>
									<asp:label id="lbDocSerial" meta:resourcekey="lbDocSerial3" runat="server" CssClass="InfoText">Серия</asp:label>
								</td>
								<td>
									<asp:textbox id="textDocSerial" meta:resourcekey="textDocSerial" runat="server" MaxLength="10" ToolTip="Серия документа" tabIndex="15"
										CssClass="InfoText" onblur="ckSerial();"></asp:textbox>
								</td>
								<td></td>
								<td>
                                    &nbsp;</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbVDocNumber" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:label>
								</td>
								<td>
									<asp:label id="lbDocNumber" meta:resourcekey="lbDocNumber3" runat="server" CssClass="InfoText">Номер</asp:label>
								</td>
								<td>
									<asp:textbox id="textDocNumber" meta:resourcekey="textDocNumber" runat="server" MaxLength="20" ToolTip="Номер документа" tabIndex="16"
										CssClass="InfoText" onblur="doValueCheck('textDocNumber');ckNumber();"></asp:textbox>
								</td>
								<td></td>
								<td>
									<asp:requiredfieldvalidator id="validatorDocNumber" meta:resourcekey="NeedToFill" runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="textDocNumber"
										CssClass="Validator"></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbVDocOrg" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:label>
								</td>
								<td>
									<asp:label id="lbDocOrg" meta:resourcekey="lbDocOrg" runat="server" CssClass="InfoText">Кем выдан</asp:label>
								</td>
								<td>
									<asp:textbox id="textDocOrg" meta:resourcekey="textDocOrg" runat="server" MaxLength="50" ToolTip="Кем выдан" tabIndex="17"
										CssClass="InfoText"></asp:textbox>
								</td>
								<td></td>
								<td>
									<asp:requiredfieldvalidator id="validatorDocOrg" meta:resourcekey="NeedToFill" runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="textDocOrg"
										CssClass="Validator"></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbVDocDate" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:label>
								</td>
								<td>
									<asp:label id="lbDocDate" meta:resourcekey="lbDocDate" runat="server" CssClass="InfoText">Дата выдачи</asp:label>
								</td>
								<td>
									<igtxt:webdatetimeedit id="dtDocDate" runat="server" ToolTip="Дата выдачи документа" EditModeFormat="dd/MM/yyyy"
										DisplayModeFormat="dd/MM/yyyy" HorizontalAlign="Center" MinValue="1800-01-01" tabIndex="18" CssClass="InfoDateSum"
										onblur="ckClRegDate('dtDocDate')">
										<ClientSideEvents Blur="dtDocDate_Blur"></ClientSideEvents>
									</igtxt:webdatetimeedit>
								</td>
								<td></td>
								<td>
									<asp:requiredfieldvalidator id="validatorDocDate" meta:resourcekey="NeedToFill" runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="dtDocDate"
										CssClass="Validator"></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbVBDate" runat="server" ForeColor="Red" CssClass="InfoText">*</asp:label>
								</td>
								<td>
									<asp:label id="lbBirthDate" meta:resourcekey="lbBirthDate" runat="server" CssClass="InfoText">Дата рождения</asp:label>
								</td>
								<td>
									<igtxt:webdatetimeedit id="dtBirthDate" runat="server" ToolTip="Дата рождения клиента" EditModeFormat="dd/MM/yyyy"
										DisplayModeFormat="dd/MM/yyyy" HorizontalAlign="Center" MinValue="1800-01-01" tabIndex="19" CssClass="InfoDateSum">
										<ClientSideEvents Blur="dtBirthDate_Blur"></ClientSideEvents>
									</igtxt:webdatetimeedit>
								</td>
								<td></td>
								<td>
									<asp:requiredfieldvalidator id="validatorBirthDate" meta:resourcekey="NeedToFill" runat="server" ErrorMessage="необходимо заполнить" ControlToValidate="dtBirthDate"
										CssClass="Validator"></asp:requiredfieldvalidator>
								</td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:label id="lbBirthPlace" meta:resourcekey="lbBirthPlace" runat="server" CssClass="InfoText">Место рождения</asp:label>
								</td>
								<td>
									<asp:textbox id="textBirthPlace" meta:resourcekey="textBirthPlace" runat="server" MaxLength="70" ToolTip="Место рождения" tabIndex="20"
										CssClass="InfoText"></asp:textbox>
								</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:label id="lbHomePhone" meta:resourcekey="lbHomePhone" runat="server" CssClass="InfoText">Домашний телефон</asp:label>
								</td>
								<td>
									<asp:textbox id="textHomePhone" meta:resourcekey="textHomePhone" runat="server" MaxLength="15" ToolTip="Домашний телефон" tabIndex="22"
										CssClass="InfoText"></asp:textbox>
								</td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:label id="lbWorkPhone" meta:resourcekey="lbWorkPhone" runat="server" CssClass="InfoText" Text="Контактный телефон"></asp:label>
								</td>
								<td>
									<asp:textbox id="textWorkPhone" meta:resourcekey="textWorkPhone" runat="server" MaxLength="15" ToolTip="Рабочий телефон" CssClass="InfoText"
										tabIndex="23"></asp:textbox>
								</td>
								<td></td>
								<td></td>
							</tr>
						</table>
						<table class="InnerTable">
							<tr>
								<td width="1%"></td>
								<td width="1%">
									<input id="noCheck" type="hidden">
								</td>
								<td width="1%">
									<input id="fRNK" type="hidden" runat="server">
								</td>
								<td width="100%"></td>
							</tr>
							<tr>
								<td>
									<input id="btSubmit" tabIndex="101" type="submit" value="Далее" 
									    class="DirectionButton" runat="server" >
								</td>
								<td>
									<asp:button id="btUpdate" meta:resourcekey="btUpdate" runat="server" Text="Регистрировать" Visible="False" tabIndex="100"
										CssClass="DirectionButton"></asp:button>
								</td>
								<td>
									&nbsp;</td>
								<td>
									<asp:button id="btnClear" meta:resourcekey="btnClear" runat="server" Text="Очистить" CausesValidation="False" tabIndex="103"
										CssClass="DirectionButton"></asp:button>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
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
			<input runat="server" type="hidden" id="resid_checked" value="1" />
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                <Scripts>
                    <asp:ScriptReference Path="js/js.js" />
                </Scripts>
            </asp:ScriptManager>
            <script language="javascript" type="text/javascript">
                if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
            </script>
			<script type="text/javascript" language="javascript">
				document.getElementById("textDocNumber").attachEvent("onkeydown",doNum);
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
