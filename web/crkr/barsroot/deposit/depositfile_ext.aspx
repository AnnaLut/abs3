<%@ Page Language="c#" CodeFile="depositfile_ext.aspx.cs" AutoEventWireup="true" Inherits="DepositFile" 
    meta:resourcekey="PageResource1" EnableSessionState="True" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc2" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Обробка файлів зарахування</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="style/dpt.css" type="text/css" rel="stylesheet" />
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>

    <script type="text/javascript" language="javascript" src="js/js.js"></script>

    <script type="text/javascript" language="javascript" src="js/ck.js"></script>

</head>
<body>
    <form id="dptFileForm" method="post" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager> 
		<table class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" meta:resourcekey="lbTitle9" runat="server" CssClass="InfoHeader"
                        Text="Прием файла обмена" 
                        ></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <input class="FileUpload" id="bankFile" type="file" runat="server" >
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable">
                        <tr>
                            <td style="width:50%">
                                <asp:RadioButton ID="rbDos" runat="server" Checked="True" GroupName="ENCODE" Text="CP866 (DOS)" />
                            </td>
                            <td style="width:50%">
                                <asp:RadioButton ID="rbWin" runat="server" GroupName="ENCODE" Text="windows-1251" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width:50%">
                                &nbsp;</td>
                            <td style="width:50%">
                                &nbsp;</td>
                        </tr>
                    </table>                    
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lbFILE" meta:resourcekey="lbFILE" runat="server" CssClass="InfoLabel"
                        Text="Файл зачислений"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tbNewHeader" runat="server" visible="false" class="InnerTable">
                        <tr>
                            <td style="width: 5%">
                            </td>
                            <td style="width: 20%">
                                <asp:Label ID="labelFileName" runat="server" CssClass="InfoText" Text="Название файла"
                                    meta:resourcekey="lbFileNameResource1"></asp:Label></td>
                            <td style="width: 20%">
                                <asp:TextBox ID="FILENAME" runat="server" CssClass="InfoText" TabIndex="1" MaxLength="16"
                                    ReadOnly="True"></asp:TextBox></td>
                            <td style="width: 10%">
                            </td>
                            <td style="width: 5%">
                            </td>
                            <td style="width: 20%">
                                <asp:Label ID="lbData" runat="server" CssClass="InfoText" Text="Дата" meta:resourcekey="lbDataResource1"></asp:Label></td>
                            <td style="width: 20%">
                                <cc1:DateEdit ID="DAT" runat="server" TabIndex="2" Date="" MaxDate="2099-12-31" meta:resourcekey="DATResource1"
                                    MinDate="" ReadOnly="True">01/01/0001 00:00:00</cc1:DateEdit></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbInfoNum" runat="server" CssClass="InfoText" Text="Количество информационных сторечек"
                                    meta:resourcekey="lbInfoNumResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="INFO_NUM" runat="server" CssClass="InfoText" TabIndex="3" MaxLength="6"
                                    meta:resourcekey="INFO_NUMResource1" ReadOnly="True"></asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbHeaderLength" runat="server" CssClass="InfoText" Text="Длинна заголовка"
                                    meta:resourcekey="lbHeaderLengthResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="HEADER_LENGTH" runat="server" CssClass="InfoText" TabIndex="4" MaxLength="3"
                                    meta:resourcekey="HEADER_LENGTHResource1" ReadOnly="True">000</asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbMFOA" runat="server" CssClass="InfoText" Text="МФО А" meta:resourcekey="lbMFOAResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="MFO_A" runat="server" CssClass="InfoText" TabIndex="5" MaxLength="15"
                                    meta:resourcekey="MFO_AResource1" ReadOnly="True">000000</asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbNLSA" runat="server" CssClass="InfoText" Text="Счет А" meta:resourcekey="lbNLSAResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="NLS_A" runat="server" CssClass="InfoText" TabIndex="6" MaxLength="15"
                                    meta:resourcekey="NLS_AResource1" ReadOnly="True">000000000000000</asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbMFOB" runat="server" CssClass="InfoText" Text="МФО Б" meta:resourcekey="lbMFOBResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="MFO_B" runat="server" CssClass="InfoText" TabIndex="7" MaxLength="15"
                                    meta:resourcekey="MFO_BResource1" ReadOnly="True">000000</asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbNLSB" runat="server" CssClass="InfoText" Text="Счет Б" meta:resourcekey="lbNLSBResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="NLS_B" runat="server" CssClass="InfoText" TabIndex="8" MaxLength="15"
                                    meta:resourcekey="NLS_BResource1" ReadOnly="True">000000000000000</asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbDK" runat="server" CssClass="InfoText" Text="Дебет/Кредит" meta:resourcekey="lbDKResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="DK" runat="server" CssClass="InfoText" TabIndex="9" MaxLength="1"
                                    meta:resourcekey="DKResource2" ReadOnly="True">0</asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbSum" runat="server" CssClass="InfoText" Text="Сумма" meta:resourcekey="lbSumResource1"></asp:Label></td>
                            <td>
                                <cc1:NumericEdit ID="SUM" runat="server" TabIndex="10" MaxLength="19" meta:resourcekey="SUMResource1"
                                    Value="0" ReadOnly="True">0</cc1:NumericEdit></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbType" runat="server" CssClass="InfoText" Text="Вид платежа" meta:resourcekey="lbTypeResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TYPE" runat="server" CssClass="InfoText" TabIndex="11" MaxLength="2"
                                    meta:resourcekey="TYPEResource1" ReadOnly="True">00</asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbNum" runat="server" CssClass="InfoText" Text="Операционный номер платежа"
                                    meta:resourcekey="lbNumResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="NUM" runat="server" CssClass="InfoText" TabIndex="12" MaxLength="12"
                                    meta:resourcekey="NUMResource2"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbHasAdd" runat="server" CssClass="InfoText" Text="Признак наличия дополнения к платежу"
                                    meta:resourcekey="lbHasAddResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="HAS_ADD" runat="server" CssClass="InfoText" TabIndex="13" MaxLength="1"
                                    meta:resourcekey="HAS_ADDResource1"></asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbNAZN" runat="server" CssClass="InfoText" Text="Назначение" meta:resourcekey="lbNAZNResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="NAZN" runat="server" CssClass="InfoText" TabIndex="14" MaxLength="160"
                                    meta:resourcekey="NAZNResource2"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbNAMEA" runat="server" CssClass="InfoText" Text="Наименование отправителя"
                                    meta:resourcekey="lbNAMEAResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="NAME_A" runat="server" CssClass="InfoText" TabIndex="15" MaxLength="27"
                                    meta:resourcekey="NAME_AResource1" ReadOnly="True">000</asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbNameB" runat="server" CssClass="InfoText" Text="Наименование получателя"
                                    meta:resourcekey="lbNameBResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="NAME_B" runat="server" CssClass="InfoText" TabIndex="16" MaxLength="27"
                                    meta:resourcekey="NAME_BResource1" ReadOnly="True">000</asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbBranchCode" runat="server" CssClass="InfoText" Text="Номер филиала"
                                    meta:resourcekey="lbBranchCodeResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="BRANCH_CODE" runat="server" CssClass="InfoText" TabIndex="17" MaxLength="5"
                                    meta:resourcekey="BRANCH_CODEResource1" ReadOnly="True">00000</asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbDPTCODE" runat="server" CssClass="InfoText" Text="Код вклада" meta:resourcekey="lbDPTCODEResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="DPT_CODE" runat="server" CssClass="InfoText" TabIndex="18" MaxLength="3"
                                    meta:resourcekey="DPT_CODEResource1" ReadOnly="True">000</asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbExecORd" runat="server" CssClass="InfoText" Text="Режим обработки"
                                    meta:resourcekey="lbExecORdResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="EXEC_ORD" runat="server" CssClass="InfoText" TabIndex="19" MaxLength="10"
                                    meta:resourcekey="EXEC_ORDResource1"></asp:TextBox></td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="lbKS_EP" runat="server" CssClass="InfoText" Text="КС или ЕП" meta:resourcekey="lbKS_EPResource1"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="KS_EP" runat="server" CssClass="InfoText" TabIndex="20" MaxLength="32"
                                    meta:resourcekey="KS_EPResource2"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="button" id="btCreateHeader" runat="server" class="AcceptButton" meta:resourcekey="btCreateHeader"
                                    onserverclick="btCreateHeader_Click" value="Создать заголовок" tabindex="21"
                                    onclick="if (ckFileHeader()) return;" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <input type="button" id="btFinish" runat="server" class="AcceptButton" meta:resourcekey="btFinish"
                                    value="Завершить ввод" tabindex="22" disabled="disabled" onserverclick="btFinish_ServerClick" /></td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td colspan="5" style="width=100%">
                                <asp:TextBox ID="textStatistics" runat="server" ReadOnly="True" Rows="5" 
                                    TextMode="MultiLine" Width="100%"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="width=20%">
                                <asp:Label ID="Label8" runat="server" Text="Показати записи:"></asp:Label>
                            </td>
                            <td style="width=20%">
                                <asp:CheckBox ID="ckIncorrect" runat="server" Text="Помилкові" 
                                    ValidationGroup="FILTER" AutoPostBack="True" 
                                    oncheckedchanged="ckIncorrect_CheckedChanged" />
                            </td>
                            <td style="width=20%">
                                <asp:CheckBox ID="ckExcluded" runat="server" Text="Виключені" 
                                    ValidationGroup="FILTER" AutoPostBack="True" 
                                    oncheckedchanged="ckExcluded_CheckedChanged" />
                            </td>
                            <td style="width=20%">
                                <asp:CheckBox ID="ckUnknown" runat="server" Text="Не визначені" 
                                    ValidationGroup="FILTER" AutoPostBack="True" 
                                    oncheckedchanged="ckUnknown_CheckedChanged" />
                            </td>
                            <td style="width=20%"></td>
                        </tr>
                    </table>
                </td>
            </tr>            
            <tr>
                <td>
                    <table class="InnerTable">
                        <tr>
                            <td colspan="2">
                                <Bars:BarsGridView ID="gridRecords" runat="server" AllowPaging="True" AllowSorting="True"
                                    DataKeyNames="INFO_ID" AutoGenerateColumns="False" CssClass="BaseGrid" DataSourceID="dsRecords" DateMask="dd/MM/yyyy"
                                    OnRowDataBound="gridRecords_RowDataBound" ShowPageSizeBox="True" meta:resourcekey="gridRecordsResource1" 
                                    OnRowCommand="gridRecords_RowCommand" 
                                    >
                                    <PagerSettings PageButtonCount="5"></PagerSettings>
                                    <Columns>
                                        <asp:ButtonField ButtonType="Button" CommandName="MARK_RECORD" 
                                            Text="Відмітити" 
                                            />
                                        <asp:ButtonField ButtonType="Button" CommandName="UNMARK_RECORD"
                                            Text="Скасувати" 
                                            />
                                        <asp:TemplateField HeaderText="Вибрано до оплати">
                                            <edititemtemplate>
                                            
</edititemtemplate>
                                            <itemtemplate>
                                                <asp:CheckBox id="CheckBox1" runat="server" Checked='<%#Convert.ToBoolean(Eval("MARKED4PAYMENT"))%>' Enabled="false"></asp:CheckBox> 
                                            
</itemtemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HtmlEncode="False" DataField="INFO_ID_TEXT">
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>                                    
                                        <asp:BoundField HtmlEncode="False" DataField="INFO_ID" SortExpression="INFO_ID" HeaderText="ID стрічки">
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField HtmlEncode="False" DataField="NLS" SortExpression="NLS" HeaderText="Рахунок"
                                            meta:resourcekey="BoundFieldResource2">
                                            <itemstyle horizontalalign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Рахунок одержувача" SortExpression="REAL_ACC_NUM">
                                            <edititemtemplate></edititemtemplate>
                                            <itemtemplate>
                                                <asp:Label runat="server" Text='<%# Bind("REAL_ACC_NUM") %>' id="lbRealAccNum"></asp:Label>                                                                                      
                                            </itemtemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Ід. код. одержувача" SortExpression="REAL_CUST_CODE">
                                            <edititemtemplate></edititemtemplate>
                                            <itemtemplate>
                                                <asp:Label runat="server" Text='<%# Bind("REAL_CUST_CODE") %>' id="Label4"></asp:Label>                                                                                      
                                            </itemtemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ПІБ одержувача" SortExpression="REAL_CUST_NAME">
                                            <edititemtemplate></edititemtemplate>
                                            <itemtemplate>
                                                <asp:Label runat="server" Text='<%# Bind("REAL_CUST_NAME") %>' id="Label5"></asp:Label>                                                                                      
                                            </itemtemplate>
                                        </asp:TemplateField>                                                                                																				
                                        <asp:BoundField DataField="BRANCH_CODE" SortExpression="BRANCH_CODE" HeaderText="Код відд."
                                            meta:resourcekey="BoundFieldResource3">
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DPT_CODE" SortExpression="DPT_CODE" HeaderText="Код деп."
                                            meta:resourcekey="BoundFieldResource4">
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SUM" SortExpression="SUM" HeaderText="Сума" meta:resourcekey="BoundFieldResource5">
                                            <itemstyle horizontalalign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FIO" SortExpression="FIO" HeaderText="ПІБ" meta:resourcekey="BoundFieldResource6">
                                            <itemstyle horizontalalign="Left"/>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ID_CODE" SortExpression="ID_CODE" HeaderText="Ід. код">
                                            <itemstyle horizontalalign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PAYOFF_DATE" SortExpression="PAYOFF_DATE" HeaderText="День виплати (формат dd/mm/yyyy)">
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>                                        
                                        <asp:TemplateField HeaderText="Відділення" SortExpression="BRANCH">
                                            <edititemtemplate></edititemtemplate>
                                            <itemtemplate>
                                                <asp:Label runat="server" Text='<%# Bind("BRANCH") %>' id="Label2"></asp:Label>                                                                                      
                                            </itemtemplate>
                                            <itemstyle horizontalalign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Орган соц. захисту" SortExpression="AGENCY_NAME">
                                            <edititemtemplate>
                                            
</edititemtemplate>
                                            <itemtemplate>
                                                <asp:Label runat="server" Text='<%# Bind("AGENCY_NAME") %>' id="Label3"></asp:Label>
                                            
</itemtemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Документ" SortExpression="REF">
                                            <edititemtemplate>
                                            
</edititemtemplate>
                                            <itemtemplate>
                                                <asp:Label runat="server" Text='<%# Bind("REF") %>' id="Label4"></asp:Label>
                                            
</itemtemplate>
                                            <itemstyle horizontalalign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Помилка" SortExpression="INCORRECT">
                                            <edititemtemplate>
                                            
</edititemtemplate>
                                            <itemtemplate>
                                                <asp:Label runat="server" Text='<%# Bind("INCORRECT") %>' id="Label5"></asp:Label>
                                            
</itemtemplate>
                                            <itemstyle horizontalalign="Center"/>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Закритий" SortExpression="CLOSED">
                                            <edititemtemplate>
                                            
</edititemtemplate>
                                            <itemtemplate>
                                                <asp:Label runat="server" Text='<%# Bind("CLOSED") %>' id="Label6"></asp:Label>
                                            
</itemtemplate>
                                            <itemstyle horizontalalign="Center"/>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Виключений" SortExpression="EXCLUDED">
                                            <edititemtemplate>
                                            
</edititemtemplate>
                                            <itemtemplate>
                                                <asp:Label runat="server" Text='<%# Bind("EXCLUDED") %>' id="Label7"></asp:Label>
                                            
</itemtemplate>
                                            <itemstyle horizontalalign="Center"/>
                                        </asp:TemplateField>
                                    </Columns>
                                </Bars:BarsGridView>
                    <Bars:barssqldatasource ProviderName="barsroot.core" ID="dsRecords" runat="server" OldValuesParameterFormatString="old_{0}">
                    </Bars:barssqldatasource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table style="width:100%">
                                    <tr>
                                        <td style="width:20%">
                                            <asp:Label ID="lbRed" runat="server" ForeColor="Red" Text="Помилка"></asp:Label>
                                        </td>
                                        <td style="width:20%">
                                            <asp:Label ID="lbGray" runat="server" ForeColor="Gray" Text="Не вибрані до оплати"></asp:Label>
                                        </td>
                                        <td style="width:20%">
                                            <asp:Label ID="lbBlue" runat="server" ForeColor="Blue" Text="Нові"></asp:Label>
                                        </td>
                                        <td style="width:20%">
                                            <asp:Label ID="lbGreen" runat="server" ForeColor="Green" Text="Виключені"></asp:Label>
                                        </td>
                                        <td style="width:20%">
                                            <asp:Label ID="lbOrange" runat="server" ForeColor="Orange" Text="Закриті"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>						
                        <tr>
                            <td width="50%">
                                <asp:Label ID="lbChoose" meta:resourcekey="lbChoose" runat="server" CssClass="InfoText"
                                    Text="Виберіть район та тип зарахування"></asp:Label></td>
                            <td width="50%">
                            </td>
                        </tr>
                        <tr>
                            <td width="50%">
                                <asp:DropDownList ID="listTypes" runat="server" CssClass="InfoText" DataSource="<%# dsTypes %>"
                                    DataTextField="type_name" DataValueField="type_id" TabIndex="22" meta:resourcekey="listTypesResource1">
                                </asp:DropDownList></td>
                            <td width="50%">
                            </td>
                        </tr>
                        <tr>
                            <td width="50%">
                                <asp:DropDownList ID="listAgencyType" runat="server" CssClass="InfoText" DataSource="<%# dsAgencyTypes %>"
                                    DataTextField="type_name" DataValueField="type_id" TabIndex="22" meta:resourcekey="listTypesResource1" AutoPostBack="True" OnSelectedIndexChanged="listAgencyType_SelectedIndexChanged">
                                </asp:DropDownList></td>
                            <td width="50%">
                            </td>
                        </tr>
                        <tr>
                            <td width="50%">
                                <asp:DropDownList ID="ddAgencyInGb" runat="server" CssClass="BaseDropDownList" Visible="False">
                                </asp:DropDownList></td>
                            <td width="50%">
                            </td>
                        </tr>
                        <tr>
                            <td width="50%">
                                <asp:DropDownList ID="ddAccType" runat="server" CssClass="BaseDropDownList">
                                </asp:DropDownList></td>
                            <td width="50%">
                            </td>
                        </tr>
                        <tr>
                            <td width="50%">
                                <table class="InnerTable">
                                    <tr>
                                        <td style="width:50%">
                                <asp:Label ID="lbMonthYear" runat="server" CssClass="InfoText" Text="Місяць зарахування"></asp:Label></td>
                                        <td style="width:50%">
                                        <asp:DropDownList ID="ddMonth" runat="server" CssClass="BaseDropDownList">
                                            <asp:ListItem Value="1">січень</asp:ListItem>
                                            <asp:ListItem Value="2">лютий</asp:ListItem>
                                            <asp:ListItem Value="3">березень</asp:ListItem>
                                            <asp:ListItem Value="4">квітень</asp:ListItem>
                                            <asp:ListItem Value="5">травень</asp:ListItem>
                                            <asp:ListItem Value="6">червень</asp:ListItem>
                                            <asp:ListItem Value="7">липень</asp:ListItem>
                                            <asp:ListItem Value="8">серпень</asp:ListItem>
                                            <asp:ListItem Value="9">вересень</asp:ListItem>
                                            <asp:ListItem Value="10">жовтень</asp:ListItem>
                                            <asp:ListItem Value="11">листопад</asp:ListItem>
                                            <asp:ListItem Value="12">грудень</asp:ListItem>
                                        </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>                            
                             </td>
                            <td width="50%">
                            </td>
                        </tr>
                        <tr>
                            <td width="50%">
                                <table class="InnerTable">
                                    <tr>
                                        <td style="width:50%">
                                <asp:Label ID="lbYear" runat="server" CssClass="InfoText" Text="Рік зарахування"></asp:Label></td>
                                        <td style="width:50%"><asp:TextBox ID="textYear" runat="server" CssClass="InfoDateSum" MaxLength="4"></asp:TextBox></td>
                                    </tr>
                                </table>
                                </td>
                            <td width="50%">
                            </td>
                        </tr>
                        <tr>
                            <td width="1%">                                
                                <input class="AcceptButton" id="btUpload" type="button" value="Прием" runat="server"
                                    tabindex="23"></td>
                            <td>
                                </td>
                        </tr>
                        <tr>
                            <td width="1%">
                                <input class="AcceptButton" id="btPay" disabled="disabled" type="button" value="Зачисление"
                                    runat="server" tabindex="24"/></td>
                            <td>
                                </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <Bars:BarsGridViewEx ID="gvBranch" runat="server" CaptionText="" CssClass="BaseGrid"
                                    DataSourceID="dsBranch" DateMask="dd.MM.yyyy" ExcelImageUrl="/common/images/default/16/export_excel.png"
                                    FilterImageUrl="/common/images/default/16/find.png" MetaFilterImageUrl="/common/images/default/16/filter.png"
                                    MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png" ShowPageSizeBox="False" AutoGenerateColumns="False" 
                                    DataKeyNames="BRANCH">
                                    <FooterStyle CssClass="footerRow" />
                                    <HeaderStyle CssClass="headerRow" />
                                    <EditRowStyle CssClass="editRow" />
                                    <PagerStyle CssClass="pagerRow" />
                                    <NewRowStyle CssClass="" />
                                    <SelectedRowStyle CssClass="selectedRow" />
                                    <AlternatingRowStyle CssClass="alternateRow" />
                                    <RowStyle CssClass="normalRow" />
                                    
                                    <Columns>
                                        <asp:CommandField ShowEditButton="True" InsertVisible="False" />                                        
                                        <asp:BoundField DataField="BRANCH" HeaderText="Відділення" SortExpression="BRANCH" ReadOnly="True" />                                        
                                        <asp:TemplateField HeaderText="Орган соц. захисту">
                                            <edititemtemplate>
                                                <asp:DropDownList id="listSocAgency" runat="server" DataValueField="value" DataTextField="text" DataSource='<%# GetSocAgency(Eval("BRANCH")) %>' cssclass="BaseDropDownList" SelectedValue='<%# Bind("AGENCY_ID") %>' __designer:wfdid="w2"></asp:DropDownList> 
                                            </edititemtemplate>
                                            <itemtemplate>
                                                <asp:TextBox id="AGENCY_NAME" runat="server" Text='<%# Eval("AGENCY_NAME") %>' ReadOnly="true" cssclass="InfoText" __designer:wfdid="w1"></asp:TextBox> 
                                            </itemtemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </Bars:BarsGridViewEx>
                                <Bars:BarsSqlDataSourceEx ProviderName="barsroot.core" ID="dsBranch" runat="server"
                                    SelectCommand="SELECT A.BRANCH, A.AGENCY_ID, S.AGENCY_NAME FROM DPT_FILE_AGENCY A, V_SOCIALAGENCIES_EXT S WHERE A.HEADER_ID = :HEADER_ID AND A.AGENCY_ID = S.AGENCY_ID" 
                                    UpdateCommand="UPDATE DPT_FILE_AGENCY SET AGENCY_ID = :AGENCY_ID WHERE BRANCH = :BRANCH AND HEADER_ID = :HEADER_ID"
                                    AllowPaging="False" PageButtonCount="10" PagerMode="NextPrevious" 
                                    PageSize="10" PreliminaryStatement="" 
                                    SortExpression="" SystemChangeNumber="" WhereStatement="">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="bf_header_id" DefaultValue="" Name="HEADER_ID" PropertyName="Value"
                                            Size="38" Type="String" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="bf_header_id" DefaultValue="" Name="HEADER_ID" PropertyName="Value"
                                            Size="38" Type="String" />
                                    </UpdateParameters>
                                </Bars:BarsSqlDataSourceEx>
                            </td>
                        </tr>
                        <tr>
                            <td width="1%">
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                    <input id="bf_filename" type="hidden" runat="server" />
                    <input id="bf_dat" type="hidden" runat="server" />
                    <asp:HiddenField ID="bf_header_id" runat="server" />
                    <input id="ins_header_id"
                        type="hidden" runat="server" />
                    <input id="bf_reload" type="hidden" value="0" runat="server" />
                    <input id="forbtUpload" meta:resourcekey="forbtUpload" type="hidden" value="Прием"
                        runat="server" />
                    <input id="forbtPay" meta:resourcekey="forbtPay" type="hidden" value="Зачисление"
                        runat="server" />&nbsp;
                </td>
            </tr>
        </table>
        <!-- #include virtual="Inc/DepositJs.inc"-->

        <script type="text/javascript" language="javascript">
				if (document.getElementById("tbNewHeader") != null)
				{
				    document.getElementById("INFO_NUM").attachEvent("onkeydown",doNum);
				    document.getElementById("HEADER_LENGTH").attachEvent("onkeydown",doNum);
				    document.getElementById("MFO_A").attachEvent("onkeydown",doNum);
				    document.getElementById("NLS_A").attachEvent("onkeydown",doNum);
				    document.getElementById("MFO_B").attachEvent("onkeydown",doNum);
				    document.getElementById("NLS_B").attachEvent("onkeydown",doNum);
				    document.getElementById("DK").attachEvent("onkeydown",doNum);
				    document.getElementById("TYPE").attachEvent("onkeydown",doNum);
				    document.getElementById("BRANCH_CODE").attachEvent("onkeydown",doNum);
				    document.getElementById("DPT_CODE").attachEvent("onkeydown",doNum);
    				
				    document.getElementById("FILENAME").attachEvent("onkeydown",doNumAlpha);
				    document.getElementById("NUM").attachEvent("onkeydown",doNumAlpha);
				    document.getElementById("HAS_ADD").attachEvent("onkeydown",doNumAlpha);
				    document.getElementById("NAZN").attachEvent("onkeydown",doNumAlpha);
				    document.getElementById("EXEC_ORD").attachEvent("onkeydown",doNumAlpha);
				    document.getElementById("KS_EP").attachEvent("onkeydown",doNumAlpha);
    				
				    document.getElementById("NAME_A").attachEvent("onkeydown",doAlpha);
				    document.getElementById("NAME_B").attachEvent("onkeydown",doAlpha);
				    
				    document.getElementById("textYear").attachEvent("onkeydown",doNum);
				}
				// Локализация
                LocalizeHtmlValue("btUpload");
                LocalizeHtmlValue("btPay");
        </script>

    </form>
</body>
</html>
