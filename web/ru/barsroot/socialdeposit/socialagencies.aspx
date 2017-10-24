<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SocialAgencies.aspx.cs" Inherits="SocialAgencies" EnableViewState="true" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Соціальні депозити: Довідник органів соціального захисту</title>
	<link href="style.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
	<script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>	
	<style type="text/css">.webservice { BEHAVIOR: url(/Common/WebService/js/WebService.htc) }</style>
	<script type="text/javascript" language="javascript">
	    var l_agg = new Array();
	</script>
	<script type="text/javascript" language="javascript" src="Scripts/Default.js"></script>
</head>
<body onload="GetParams();">
    <form id="form1" runat="server">
        <table id="tbMain" class="MainTable">
            <tr>
                <td align="center" colspan="2">
                    <asp:Label ID="lbTitle" CssClass="InfoHeader" runat="server" Text="Довідник органів соціального захисту"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table class="InnerTable">
                        <tr>
                            <td style="width:50%" valign="top">
                                <asp:GridView ID="gAgencyTypes" CssClass="BaseGrid" runat="server" AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField HeaderText="*">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBoxColumn" runat="server"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="type_id" HeaderText="Тип" />
                                        <asp:BoundField DataField="type_name" HeaderText="Найменування" />
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td style="width:50%" valign="top">
                                &nbsp;<asp:DropDownList ID="listSearchBranch" runat="server" CssClass="BaseDropDownList" DataTextField="name" DataValueField="branch">
                                </asp:DropDownList></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="width:50%">
                    <input id="btSearch" class="AcceptButton" tabindex="1" title="ПОШУК" type="button"
                        value="ПОШУК" onserverclick="btSearch_ServerClick" runat="server" causesvalidation="false" />
                </td>
                <td style="width:50%">
                </td>
          </tr>
            <tr>
                <td style="width: 50%">
                    <input type="hidden" id="hidAGENCY_ID" runat="server" />
                </td>
                <td style="width: 50%">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div>
                        <asp:GridView ID="gSocialAgencies" runat="server" AutoGenerateColumns="False" 
                            CssClass="BaseGrid" OnRowDataBound="gSocialAgencies_RowDataBound" 
                            OnRowCommand="gSocialAgencies_RowCommand" 
                            onrowediting="gSocialAgencies_RowEditing" 
                            onrowdeleting="gSocialAgencies_RowDeleting">
                            <Columns>
                                <asp:ButtonField ButtonType="Button" CommandName="EDIT" HeaderText="*" Text="Редагувати" />
                                <asp:TemplateField HeaderText="*" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button ID="btDelete" runat="server" CausesValidation="false" 
                                            CommandName="DELETE" Text="Видалити" 
                                            Enabled='<%#(Eval("CONTRACT_CLOSED")!="&nbsp;"?true:false)%>'
                                            CommandArgument='<%#Convert.ToString(Eval("agency_id"))%>'/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="agency_id" HeaderText="Код" />
                                <asp:BoundField DataField="agency_name" HeaderText="Назва" />
                                <asp:BoundField DataField="debit_nls" HeaderText="Рах. деб. заборг." />
                                <asp:BoundField DataField="credit_nls" HeaderText="Рах. кр. заборг. (поточн.)" />
                                <asp:BoundField DataField="card_nls" HeaderText="Рах. кр. заборг. (картковий)" />
                                <asp:BoundField DataField="comiss_nls" HeaderText="Рах. коміс. доходів" />
                                <asp:BoundField DataField="contract_number" HeaderText="№ договору" />
                                <asp:BoundField DataField="cdate" HeaderText="Дата договору" />
                                <asp:BoundField DataField="CONTRACT_CLOSED" HeaderText="Дата закриття договору" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="add_agency" class="mn">
                        <table id="tbAdd" class="InnerTable">
                            <tr>
                                <td style="width:5%">
                                    <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="*"></asp:Label></td>
                                <td style="width:25%">
                                    <asp:Label ID="lbName" runat="server" CssClass="InfoText" Text="Назва ОСЗ"></asp:Label></td>
                                <td style="width:35%">
                                    <asp:TextBox ID="textName" runat="server" CssClass="InfoText"></asp:TextBox></td>
                                <td style="width:5%"></td>
                                <td style="width:30%">
                                    </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td style="width: 25%">
                                    <asp:Label ID="lbType" runat="server" CssClass="InfoText" Text="Тип ОСЗ"></asp:Label></td>
                                <td style="width: 40%">
                                    <asp:DropDownList ID="listAgencyType" runat="server" CssClass="BaseDropDownList" DataTextField="type_name" DataValueField="type_id">
                                    </asp:DropDownList></td>
                                <td style="width:5%"></td>
                                <td style="width: 30%">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td style="width: 25%;">
                                    <asp:Label ID="lbBranch" runat="server" CssClass="InfoText" Text="Відділення"></asp:Label></td>
                                <td style="width: 40%;">
                                    <asp:DropDownList ID="listBranch" runat="server" CssClass="BaseDropDownList" DataTextField="name" DataValueField="branch">
                                    </asp:DropDownList></td>
                                <td style="width:5%;"></td>
                                <td style="width: 30%;">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbContractNum" runat="server" CssClass="InfoText" Text="Номер договору"></asp:Label></td>                            
                                <td>
                                    <asp:TextBox ID="textNum" runat="server" CssClass="InfoText"></asp:TextBox>
                                </td>
                                <td></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>                        
                                <td>
                                    <asp:Label ID="lbDate" runat="server" CssClass="InfoText" Text="Дата"></asp:Label></td>
                                <td>
                                    <cc1:dateedit id="textDate" runat="server"></cc1:dateedit>
                                </td>
                                <td></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbBZM1" style="visibility:hidden" runat="server" ForeColor="Red" Text="*"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lbDZ" runat="server" CssClass="InfoText" Text="Рахунок дебеторської  заборгованості"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textDZ" runat="server" CssClass="InfoText" MaxLength="14" onblur="CheckNls('textDZ','D','lbВZM')"></asp:TextBox>
                                </td>
                                <td></td>
                                <td>
                                    <asp:Label ID="lbВZM" runat="server" CssClass="InfoText"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbKZM1" style="visibility:hidden" runat="server" ForeColor="Red" Text="*"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lbKZP" runat="server" CssClass="InfoText" Text="Рахунок кредиторської заборгованості для поточних рахунків"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textKPZ" runat="server" CssClass="InfoText" MaxLength="14" onblur="CheckNls('textKPZ','K','lbKZM')"></asp:TextBox></td>
                                <td></td>
                                <td>
                                    <asp:Label ID="lbKZM" runat="server" CssClass="InfoText"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbCZM1" style="visibility:hidden" runat="server" ForeColor="Red" Text="*"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lbKZC" runat="server" CssClass="InfoText" Text="Рахунок кредиторської заборгованості для карткових рахунків"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textKCZ" runat="server" CssClass="InfoText" MaxLength="14" onblur="CheckNls('textKCZ','C','lbCZM')"></asp:TextBox></td>
                                <td></td>
                                <td>
                                    <asp:Label ID="lbCZM" runat="server" CssClass="InfoText"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbMZM1" style="visibility:hidden" runat="server" ForeColor="Red" Text="*"></asp:Label></td>
                                <td>
                                    <asp:Label ID="lbMZ" runat="server" CssClass="InfoText" Text="Рахунок комісійних доходів"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textMZ" runat="server" CssClass="InfoText" MaxLength="14" onblur="CheckNls('textMZ','M','lbMZM')"></asp:TextBox></td>
                                <td></td>
                                <td>
                                    <asp:Label ID="lbMZM" runat="server" CssClass="InfoText"></asp:Label></td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbadr" runat="server" CssClass="InfoText" Text="Адреса"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textAddres" runat="server" CssClass="InfoText"></asp:TextBox></td>
                                <td></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbPhone" runat="server" CssClass="InfoText" Text="Телефон"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textPhone" runat="server" CssClass="InfoText"></asp:TextBox></td>
                                <td></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbNOTE" runat="server" CssClass="InfoText" Text="Нотатки"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textNote" runat="server" CssClass="InfoText"></asp:TextBox></td>
                                <td></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <input id="btAdd" class="AcceptButton" tabindex="3" type="button"
                                        value="Реєструвати" onclick="if (ckFields())" runat="server" causesvalidation="false" onserverclick="btAdd_ServerClick" />
                                </td>
                                <td><input id="btUpdate" class="AcceptButton" tabindex="3" type="button"
                                        value="Оновити" onclick="if (ckFields())" runat="server" causesvalidation="false" onserverclick="btUpdate_ServerClick"/></td>
                                <td></td>
                                <td>
                                <input id="SELECTED_AGENCY_ID" runat="server" type="hidden" /></td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <input id="clientNames" runat="server" type="hidden" /><input id="ags" runat="server" type="hidden" />
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                <Scripts>
                    <asp:ScriptReference Path="scripts/Default.js" />
                </Scripts>
            </asp:ScriptManager>
                        <script language="javascript" type="text/javascript">
                    if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
            </script>			
                    
                </td>
            </tr>
        </table>
            <script type="text/javascript" language="javascript">
				document.getElementById("textNum").attachEvent("onkeydown",doNumAlpha);
				document.getElementById("textDZ").attachEvent("onkeydown",doNum);
				document.getElementById("textKPZ").attachEvent("onkeydown",doNum);
				document.getElementById("textKCZ").attachEvent("onkeydown",doNumAlpha);
				document.getElementById("textMZ").attachEvent("onkeydown",doNum);								
			</script>
	    <div class="webservice" id="webService" showProgress="true"/>
    </form>
</body>
</html>
