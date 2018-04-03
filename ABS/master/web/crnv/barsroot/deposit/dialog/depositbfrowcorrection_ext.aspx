<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="depositbfrowcorrection_ext.aspx.cs" AutoEventWireup="true" Inherits="DepositBFRowCorrection"  enableViewState="True"%>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Коректування банківського файлу</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<base target="_self" />
		<meta content="C#" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../style/dpt.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="../js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="../js/js.js"></script>
	</head>
	<body>
		<script type="text/javascript" language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>
		<script type="text/javascript" language="javascript">
			function SetNlsValue()
			{
			    document.getElementById('textNLS').value = event.srcElement.innerText;
			}
		</script>		
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center"><asp:label id="lbTitle" meta:resourcekey="lbTitle17" runat="server" CssClass="InfoHeader">Редактирование записей файла зачислений</asp:label></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td style="width:5%"><asp:label id="lbNLSs" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td style="width:15%"><asp:label id="lbNLS" meta:resourcekey="lbNLS" runat="server" CssClass="InfoText">Счет</asp:label></td>
								<td style="width:40%"><asp:textbox id="textNLS" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td style="width:30%"><asp:requiredfieldvalidator id="vNLS" meta:resourcekey="NeedToFill" runat="server" CssClass="Validator" ControlToValidate="textNLS" ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
							</tr>
							<tr>
								<td><asp:label id="lbBranchCodes" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td><asp:label id="lbBranchCode" meta:resourcekey="lbBranchCode" runat="server" CssClass="InfoText">Код отделения</asp:label></td>
								<td><asp:textbox id="textBranchCode" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td><asp:requiredfieldvalidator id="vBranchCode" meta:resourcekey="NeedToFill" runat="server" CssClass="Validator" ControlToValidate="textBranchCode"
										ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
							</tr>
							<tr>
								<td><asp:label id="lbDptCodes" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td><asp:label id="lbDptCode" meta:resourcekey="lbDptCode" runat="server" CssClass="InfoText">Код вклада</asp:label></td>
								<td><asp:textbox id="textDptCode" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td><asp:requiredfieldvalidator id="vDptCode" meta:resourcekey="NeedToFill" runat="server" CssClass="Validator" ControlToValidate="textDptCode"
										ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
							</tr>
							<tr>
								<td><asp:label id="lbSums" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td><asp:label id="lbSum" meta:resourcekey="lbSum3" runat="server" CssClass="InfoText">Сумма</asp:label></td>
								<td><igtxt:webnumericedit id="Sum" runat="server" CssClass="InfoDateSum" MinDecimalPlaces="SameAsDecimalPlaces"
										DataMode="Decimal" MaxLength="10"></igtxt:webnumericedit></td>
								<td></td>
							</tr>
							<tr>
								<td><asp:label id="lbFios" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td><asp:label id="lbFIO" meta:resourcekey="lbFIO2" runat="server" CssClass="InfoText">ФИО</asp:label></td>
								<td><asp:textbox id="textFIO" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td><asp:requiredfieldvalidator id="vFIO" meta:resourcekey="NeedToFill" runat="server" CssClass="Validator" ControlToValidate="textFIO" ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
							</tr>
							<tr>
								<td>
                                    <asp:Label ID="Label1" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:Label></td>
								<td><asp:label id="lbPasp" runat="server" CssClass="InfoText">Ідент. код</asp:label></td>
								<td><asp:textbox id="textIdCode" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td>
                                    <asp:RequiredFieldValidator ID="Requiredfieldvalidator2" runat="server" ControlToValidate="textIdCode"
                                        CssClass="Validator" ErrorMessage="Необходимо заполнить" meta:resourcekey="NeedToFill"></asp:RequiredFieldValidator></td>
							</tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label2" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:Label></td>
                                <td>
                                    <asp:Label ID="lbDat" runat="server" CssClass="InfoText" Text="Дата зарахування"></asp:Label></td>
                                <td>
                                    <cc1:DateEdit ID="PayoffDate" runat="server"></cc1:DateEdit></td>
                                <td>
                                    <asp:RequiredFieldValidator ID="Requiredfieldvalidator1" runat="server" ControlToValidate="PayoffDate"
                                        CssClass="Validator" ErrorMessage="Необходимо заполнить" meta:resourcekey="NeedToFill"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbBranch" runat="server" CssClass="InfoText" meta:resourcekey="lbBranch">Отделение</asp:Label></td>
                                <td>
                                    <asp:DropDownList ID="ddBranch" runat="server" CssClass="BaseDropDownList">
                                    </asp:DropDownList></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbAgency" runat="server" CssClass="InfoText" meta:resourcekey="lbAgency">Орган соц. обезпечения</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textAgency" runat="server" CssClass="InfoText" Enabled="False"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 21px">
                                </td>
                                <td style="height: 21px">
                                    <asp:Label ID="Label4" runat="server" CssClass="InfoText" Text="Тип рахунку"></asp:Label></td>
                                <td style="height: 21px">
                                    <asp:DropDownList ID="ddAccType" runat="server" CssClass="BaseDropDownList">
                                    </asp:DropDownList></td>
                                <td style="height: 21px">
                                </td>
                            </tr>
							<tr>
								<td></td>
								<td><asp:label id="lbRef" meta:resourcekey="lbRef" runat="server" CssClass="InfoText">Референс</asp:label></td>
								<td><asp:textbox id="textRef" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437" Enabled="False"></asp:textbox></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbIncorrect" meta:resourcekey="lbIncorrect" runat="server" CssClass="InfoText">Некоректный</asp:label></td>
								<td><input id="ckIncorrect" disabled="disabled" type="checkbox" name="Checkbox1" runat="server"/></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbClosed" meta:resourcekey="lbClosed" runat="server" CssClass="InfoText">Счет закрыт</asp:label></td>
								<td><input id="ckClosed" disabled="disabled" type="checkbox" name="Checkbox1" runat="server"/></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbExcluded" meta:resourcekey="lbExcluded" runat="server" CssClass="InfoText">Счет исключен</asp:label></td>
								<td><input id="ckExcluded" type="checkbox" runat="server"/></td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" CssClass="InfoText" Text="Рахунки в системі"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <bars:barsgridviewex id="gvPretenders" runat="server" allowsorting="True" autogeneratecolumns="False"
                            captiontext="" clearfilterimageurl="/common/images/default/16/filter_delete.png"
                            cssclass="barsGridView" datemask="dd.MM.yyyy" excelimageurl="/common/images/default/16/export_excel.png"
                            filterimageurl="/common/images/default/16/filter.png" metafilterimageurl="/common/images/default/16/filter.png"
                            metatablename="" refreshimageurl="/common/images/default/16/refresh.png" showpagesizebox="False" DataSourceID="dsPretenders">
<FooterStyle CssClass="footerRow"></FooterStyle>

<HeaderStyle CssClass="headerRow"></HeaderStyle>

<EditRowStyle CssClass="editRow"></EditRowStyle>

<PagerStyle CssClass="pagerRow"></PagerStyle>

<NewRowStyle CssClass=""></NewRowStyle>

<SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>

<AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
<Columns>
<asp:TemplateField HeaderText="*">
    <itemtemplate>
        <asp:LinkButton id="imgOpen" runat="server" __designer:wfdid="w4" onclientclick="<%# &quot;Edit_client('&quot; + Eval(&quot;CUST_ID&quot;) + &quot;');&quot;%>">
                Редагувати клієнта</asp:LinkButton>
</itemtemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="*">
    <itemtemplate>
        <asp:LinkButton id="imgOpen1" runat="server" onclientclick="<%# &quot;Edit_account('&quot; + Eval(&quot;ACC_ID&quot;) + &quot;','&quot; + Eval(&quot;CUST_ID&quot;) + &quot;');&quot;%>">
                Редагувати рахунок</asp:LinkButton>
</itemtemplate>
</asp:TemplateField>
<asp:BoundField DataField="ASVO_ACCOUNT" HeaderText="Рахунок АСВО" SortExpression="ASVO_ACCOUNT"></asp:BoundField>
<asp:TemplateField HeaderText="Рахунок">
    <itemtemplate>
        <asp:LinkButton id="imgOpen2" runat="server" OnClientClick='SetNlsValue(); return false;'>
        <%# Eval("ACC_NUM") %></asp:LinkButton>
</itemtemplate>
</asp:TemplateField><asp:BoundField DataField="ACC_TYPE" HeaderText="Тип" SortExpression="ACC_TYPE" />
<asp:BoundField DataField="BRANCH_NAME" HeaderText="Відділення" SortExpression="BRANCH_NAME" />
<asp:BoundField DataField="CUST_NAME" HeaderText="ПІБ" SortExpression="CUST_NAME"></asp:BoundField>
<asp:BoundField DataField="CUST_CODE" HeaderText="Ід. код" SortExpression="CUST_CODE"></asp:BoundField>
<asp:BoundField DataField="DOC_SERIAL" HeaderText="Серія" SortExpression="DOC_SERIAL"></asp:BoundField>
<asp:BoundField DataField="DOC_NUMBER" HeaderText="Номер" SortExpression="DOC_NUMBER"></asp:BoundField>
<asp:BoundField DataField="DOC_ISSUED" HeaderText="Виданий" SortExpression="DOC_ISSUED"></asp:BoundField>
<asp:BoundField DataField="DOC_DATE" HeaderText="Дата документу" SortExpression="DOC_DATE"></asp:BoundField>
<asp:BoundField DataField="CUST_BDAY" HeaderText="Дата народження" SortExpression="CUST_BDAY"></asp:BoundField>
</Columns>

<RowStyle CssClass="normalRow"></RowStyle>
</bars:barsgridviewex>
                        <bars:barssqldatasourceex ProviderName="barsroot.core" id="dsPretenders" runat="server" allowpaging="False" filterstatement=""
                            pagebuttoncount="10" pagermode="NextPrevious" pagesize="10" preliminarystatement=""
                            selectcommand="select cust_id, acc_id, acc_num, acc_type, asvo_account, cust_name, cust_code, doc_serial, doc_number, doc_issued, cust_bday, doc_date, branch_name from v_file_pretenders where info_id = :info_id"
                            sortexpression="" systemchangenumber="" totalscommand=""
                            wherestatement="" ><SelectParameters>
                                <asp:QueryStringParameter Name="info_id" QueryStringField="info_id" Type="Decimal" />
</SelectParameters>
</bars:barssqldatasourceex>
                    </td>
                </tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" style="width:50%"><asp:button id="btAccept" meta:resourcekey="btAccept" runat="server" CssClass="AcceptButton" Text="Обновить"></asp:button></td>
								<td align="left" style="width:50%"><input meta:resourcekey="btClose" runat="server" class="AcceptButton" onclick="window.close();" type="button" value="Закрыть"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- #include virtual="../Inc/DepositCk.inc"-->
			<!-- #include virtual="../Inc/DepositJs.inc"-->
			<script type="text/javascript" language="javascript">
				document.getElementById("textBranchCode").attachEvent("onkeydown",doNum);
				document.getElementById("textDptCode").attachEvent("onkeydown",doNum);				
			    document.getElementById("textFIO").attachEvent("onkeydown",doAlpha);				
				document.getElementById("textIdCode").attachEvent("onkeydown",doNum);								
				document.getElementById("textNLS").attachEvent("onkeydown",doNumAlpha);
			</script>
    </form>
    </body>
</html>
