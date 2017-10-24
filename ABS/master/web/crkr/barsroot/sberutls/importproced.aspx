<%@ Page Language="C#" AutoEventWireup="true" CodeFile="importproced.aspx.cs" Inherits="sberutls_importproced" Culture="uk-UA" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/common/css/barsgridview.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript" src="js/sberimp.js"></script>
    <style type="text/css">
        .info
        {
            border-collapse: collapse;
            border: solid 1px #E8E8E8;
            background-color: #F8F8F8;
        }
        .info td
        {
            padding: 0px 10px 0px 10px;
            border: 1px solid #E8E8E8;
        }
        .doc
        {
            border-collapse: collapse;
            border: solid 1px #E8E8E8;
            background-color: #F8F8F8;
        }
        .doc tr td
        {
            padding: 0px 10px 0px 10px;
            border: 1px solid #E8E8E8;
            color: #484848;
        }
        .doc tr td textarea
        {
            font-size: 10pt;
        }
        .doc tr td input
        {
            font-size: 10pt;
        }
        .divider
        {
            background-color:#D8D8D8;color:BLACK; font-weight :bold;
        }
    </style>
</head>
<body style="font-size:10pt;">
    <form id="form1" runat="server">
    <div>
        <asp:Button runat="server" ID="btnDoc" Text="Перегляд/редагування" 
            onclick="btnDoc_Click" />
        <asp:Button runat="server" ID="btnW" Text="Додатковi реквiзити" 
            onclick="btnW_Click" />
        <asp:Button runat="server" ID="btnC" Text="БICи" 
            onclick="btnC_Click" />
    </div>    
    <br />
    <div>
        <asp:MultiView ID="mv" runat="server" 
            onactiveviewchanged="mv_ActiveViewChanged">
            <asp:View ID="doc" runat="server">
                <h4>Перегляд/Редагування iмпортованого документу</h4>
                <asp:ObjectDataSource ID="ods" runat="server" DataObjectTypeName="ibank.core.VXmlimpdocsUiRecord"
                    SelectMethod="SelectVXmlimpdocsUi" TypeName="ibank.core.VXmlimpdocsUi" UpdateMethod="Update"
                    ConvertNullToDBNull="false" OnUpdating="ods_Updating">
                    <SelectParameters>
                        <asp:SessionParameter Name="IMPREF" SessionField="impref" Type="Decimal" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="SK" Type="Decimal" ConvertEmptyStringToNull="true" />
                        <asp:Parameter Name="S" Type="Decimal" ConvertEmptyStringToNull="true" />
                        <asp:Parameter Name="KV" Type="Decimal" ConvertEmptyStringToNull="true" />
                        <asp:Parameter Name="VDAT" Type="DateTime" ConvertEmptyStringToNull="true" />
                        <asp:Parameter Name="DATP" Type="DateTime" ConvertEmptyStringToNull="true" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="fv" runat="server" DataKeyNames="IMPREF" DataSourceID="ods" 
                    OnItemUpdating="fv_ItemUpdating" ondatabound="fv_DataBound">
                    <EditItemTemplate>
                        <table class="info">
                            <tr>
                                <td>
                                    Файл: <b>
                                        <asp:TextBox ID="FNTextBox" runat="server" Text='<%# Eval("FN") %>' Enabled="false" /></b>
                                </td>
                                <td>
                                    Дата iмпорту: <b>
                                        <asp:TextBox ID="DATTextBox" runat="server" Style="text-align: center" Text='<%# Eval("DAT") %>'
                                            Enabled="false" /></b>
                                </td>
                                <td>
                                    Референс iмпорту: <b>
                                        <asp:TextBox ID="IMPREFTextBox" Style="text-align: right" runat="server" Width="50px"
                                            Text='<%# Eval("IMPREF") %>' Enabled="false" /></b>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table class="doc">
                            <tr><td colspan="2" align="right" class="info">&nbsp;</td></tr>
                            <tr>
                                <td>
                                    Номер документа:
                                </td>
                                <td>
                                    <asp:TextBox ID="NDTextBox" Enabled="false" Width="50px" Style="text-align: right"
                                        runat="server" Text='<%# Eval("ND") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Дата документа:
                                </td>
                                <td>
                                    <asp:TextBox ID="DATDTextBox" Enabled="false" Style="text-align: center" runat="server"
                                        Text='<%# Eval("DATD") %>' />
                                </td>
                            </tr>
                            <tr><td colspan="2" align="right" class="info">&nbsp</td></tr>
                            <tr><td colspan="2" align="right" class="divider"><asp:Label runat="server" ID="lblTop" Text='<%# Convert.ToString(Eval("DK"))=="0" ? "КРЕДИТ" : "ДЕБЕТ" %>'/></td></tr>
                            <tr>
                                <td>
                                    МФО А:
                                </td>
                                <td>
                                    <asp:TextBox ID="MFOATextBox" Style="text-align: right" runat="server" Text='<%# Bind("MFOA") %>' />
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Рахунок А:
                                </td>
                                <td>
                                    <asp:TextBox ID="NLSATextBox" Style="text-align: right" runat="server" Text='<%# Bind("NLSA") %>' />
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ЗКПО А:
                                </td>
                                <td>
                                    <asp:TextBox ID="ID_ATextBox" Style="text-align: right" runat="server" Text='<%# Bind("ID_A") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Назва платника:
                                </td>
                                <td>
                                    <asp:TextBox ID="NAM_ATextBox" Width="500px" TextMode="MultiLine" onKeyUp="Count(this,38)" onChange="Count(this,38)"
                                        runat="server" Text='<%# Bind("NAM_A") %>' />
                                </td>
                            </tr>
                            <tr><td colspan="2" align="right" class="info">&nbsp</td></tr>
                            <tr><td colspan="2" align="right" class="divider"><asp:Label runat="server" ID="lblBottom" Text='<%# Convert.ToString(Eval("DK"))=="0" ? "ДЕБЕТ" :  "КРЕДИТ" %>'/></td></tr>
                            <tr>
                                <td>
                                    МФО Б:
                                </td>
                                <td>
                                    <asp:TextBox ID="MFOBTextBox" Style="text-align: right" runat="server" Text='<%# Bind("MFOB") %>' />
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Рахунок Б:
                                </td>
                                <td>
                                    <asp:TextBox ID="NLSBTextBox" Style="text-align: right" runat="server" Text='<%# Bind("NLSB") %>' />
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ЗКПО Б:
                                </td>
                                <td>
                                    <asp:TextBox ID="ID_BTextBox" Style="text-align: right" runat="server" Text='<%# Bind("ID_B") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Назва отримувача:
                                </td>
                                <td>
                                    <asp:TextBox ID="NAM_BTextBox" Width="500px" TextMode="MultiLine" onKeyUp="Count(this,38)" onChange="Count(this,38)"
                                        runat="server" Text='<%# Bind("NAM_B") %>' />
                                </td>
                            </tr>
                            <tr><td colspan="2" align="right" class="info">&nbsp</td></tr>
                            <tr><td colspan="2" align="right" class="divider">&nbsp</td></tr>
                            <tr>
                                <td>
                                    Сума:
                                </td>
                                <td>
                                    <Bars:BarsNumericTextBox ID="STextBox" Style="text-align: right" runat="server" DbValue='<%# Bind("S") %>'>
                                        <NumberFormat AllowRounding="false" DecimalDigits="2" GroupSeparator=" " />
                                    </Bars:BarsNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Код валюти:
                                </td>
                                <td>
                                    <asp:TextBox ID="KVTextBox" Enabled="false" Style="text-align: right" runat="server"
                                        Text='<%# Bind("KV") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Ознака дебет/кредит:
                                </td>
                                <td>
                                    <asp:TextBox ID="DKTextBox" Enabled="false" Style="text-align: right" runat="server"
                                        Text='<%# Eval("DK") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Операцiя:
                                </td>
                                <td>
                                    <asp:TextBox ID="TTTextBox" Enabled="false" runat="server" Text='<%# Eval("TT") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Символ каси:
                                </td>
                                <td>
                                    <Bars:BarsNumericTextBox ID="SKTextBox" Style="text-align: right" Type="Number" runat="server"
                                        Text='<%# Bind("SK") %>'>
                                        <NumberFormat AllowRounding="false" DecimalDigits="0" />
                                    </Bars:BarsNumericTextBox>
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Призначення платежа:
                                </td>
                                <td>
                                    <Bars:BarsTextBox ID="NAZNTextBox" Width="500px" TextMode="MultiLine" runat="server" onKeyUp="Count(this,160)" onChange="Count(this,160)"
                                        Text='<%# Bind("NAZN") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Дата вводу:
                                </td>
                                <td>
                                    <asp:TextBox ID="DATPTextBox" Style="text-align: center" Enabled="false" runat="server"
                                        Text='<%# Eval("DATP") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Дата валютування:
                                </td>
                                <td>
                                    <asp:TextBox ID="VDATTextBox" Style="text-align: center" Enabled="false" runat="server"
                                        Text='<%# Eval("VDAT") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Вид обробки:
                                </td>
                                <td>
                                    <asp:TextBox ID="VOBTextBox" Enabled="false" Style="text-align: right" runat="server"
                                        Text='<%# Eval("VOB") %>' />
                                </td>
                            </tr>
                            <tr><td colspan="2" align="right" class="info">&nbsp</td></tr>
                        </table>
                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                            Text="Зберегти" />
                        &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" Visible="false"
                            OnClientClick="location.replace('importproc.aspx?tp=1');return false;" CommandName="Cancel"
                            Text="Назад" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <table class="info">
                            <tr>
                                <td>
                                    Файл: <b>
                                        <asp:TextBox ID="FNTextBox" runat="server" Text='<%# Eval("FN") %>' Enabled="false" /></b>
                                </td>
                                <td>
                                    Дата iмпорту: <b>
                                        <asp:TextBox ID="DATTextBox" runat="server" Style="text-align: center" Text='<%# Eval("DAT") %>'
                                            Enabled="false" /></b>
                                </td>
                                <td>
                                    Референс iмпорту: <b>
                                        <asp:TextBox ID="IMPREFTextBox" Style="text-align: right" runat="server" Width="50px"
                                            Text='<%# Eval("IMPREF") %>' Enabled="false" /></b>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table class="doc">
                            <tr><td colspan="2" align="right" class="info">&nbsp;</td></tr>
                            <tr>
                                <td>
                                    Номер документа:
                                </td>
                                <td>
                                    <asp:TextBox ID="NDTextBox" Enabled="false" Width="50px" Style="text-align: right"
                                        runat="server" Text='<%# Eval("ND") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Дата документа:
                                </td>
                                <td>
                                    <asp:TextBox ID="DATDTextBox" Enabled="false" Style="text-align: center" runat="server"
                                        Text='<%# Eval("DATD") %>' />
                                </td>
                            </tr>
                            <tr><td colspan="2" align="right" class="info">&nbsp</td></tr>
                            <tr><td colspan="2" align="right" class="divider"><asp:Label runat="server" ID="lblTop" Text='<%# Eval("DK")=="0" ? "КРЕДИТ" : "ДЕБЕТ" %>'/></td></tr>
                            <tr>
                                <td>
                                    МФО А:
                                </td>
                                <td>
                                    <asp:TextBox ID="MFOATextBox" Enabled="false"  Style="text-align: right" runat="server" Text='<%# Eval("MFOA") %>' />
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Рахунок А:
                                </td>
                                <td>
                                    <asp:TextBox ID="NLSATextBox" Enabled="false"  Style="text-align: right" runat="server" Text='<%# Eval("NLSA") %>' />
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ЗКПО А:
                                </td>
                                <td>
                                    <asp:TextBox ID="ID_ATextBox" Enabled="false"  Style="text-align: right" runat="server" Text='<%# Eval("ID_A") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Назва платника:
                                </td>
                                <td>
                                    <asp:TextBox ID="NAM_ATextBox" Enabled="false" Width="500px" TextMode="MultiLine" MaxLength="160"
                                        runat="server" Text='<%# Eval("NAM_A") %>' />
                                </td>
                            </tr>
                            <tr><td colspan="2" align="right" class="info">&nbsp</td></tr>
                            <tr><td colspan="2" align="right" class="divider"><asp:Label runat="server" ID="lblBottom" Text='<%# Eval("DK")=="0" ? "ДЕБЕТ" :  "КРЕДИТ" %>'/></td></tr>
                            <tr>
                                <td>
                                    МФО Б:
                                </td>
                                <td>
                                    <asp:TextBox ID="MFOBTextBox" Enabled="false"  Style="text-align: right" runat="server" Text='<%# Eval("MFOB") %>' />
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Рахунок Б:
                                </td>
                                <td>
                                    <asp:TextBox ID="NLSBTextBox" Enabled="false"  Style="text-align: right" runat="server" Text='<%# Eval("NLSB") %>' />
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ЗКПО Б:
                                </td>
                                <td>
                                    <asp:TextBox ID="ID_BTextBox"  Enabled="false" Style="text-align: right" runat="server" Text='<%# Eval("ID_B") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Назва отримувача:
                                </td>
                                <td>
                                    <asp:TextBox ID="NAM_BTextBox" Width="500px" TextMode="MultiLine" Enabled="false"  
                                        runat="server" Text='<%# Eval("NAM_B") %>' />
                                </td>
                            </tr>
                            <tr><td colspan="2" align="right" class="info">&nbsp</td></tr>
                            <tr><td colspan="2" align="right" class="divider">&nbsp</td></tr>
                            <tr>
                                <td>
                                    Сума:
                                </td>
                                <td>
                                    <Bars:BarsNumericTextBox ID="STextBox" Enabled="false"  Style="text-align: right" runat="server" DbValue='<%# Eval("S") %>'>
                                        <NumberFormat AllowRounding="false" DecimalDigits="2" GroupSeparator=" " />
                                    </Bars:BarsNumericTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Код валюти:
                                </td>
                                <td>
                                    <asp:TextBox ID="KVTextBox" Enabled="false" Style="text-align: right" runat="server"
                                        Text='<%# Eval("KV") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Ознака дебет/кредит:
                                </td>
                                <td>
                                    <asp:TextBox ID="DKTextBox" Enabled="false" Style="text-align: right" runat="server"
                                        Text='<%# Eval("DK") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Операцiя:
                                </td>
                                <td>
                                    <asp:TextBox ID="TTTextBox" Enabled="false" runat="server" Text='<%# Eval("TT") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Символ каси:
                                </td>
                                <td>
                                    <Bars:BarsNumericTextBox ID="SKTextBox" Enabled="false"  Style="text-align: right" Type="Number" runat="server"
                                        Text='<%# Eval("SK") %>'>
                                        <NumberFormat AllowRounding="false" DecimalDigits="0" />
                                    </Bars:BarsNumericTextBox>
                                    <span style="color:silver;font-size:7pt">F12 вибiр iз довiдника</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Призначення платежа:
                                </td>
                                <td>
                                    <Bars:BarsTextBox ID="NAZNTextBox" Enabled="false"  Width="500px" TextMode="MultiLine" runat="server" MaxLength="160"
                                        Text='<%# Eval("NAZN") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Дата вводу:
                                </td>
                                <td>
                                    <asp:TextBox ID="DATPTextBox" Enabled="false"  Style="text-align: center" runat="server"
                                        Text='<%# Eval("DATP") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Дата валютування:
                                </td>
                                <td>
                                    <asp:TextBox ID="VDATTextBox" Enabled="false"  Style="text-align: center" runat="server"
                                        Text='<%# Eval("VDAT") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Вид обробки:
                                </td>
                                <td>
                                    <asp:TextBox ID="VOBTextBox" Enabled="false" Style="text-align: right" runat="server"
                                        Text='<%# Eval("VOB") %>' />
                                </td>
                            </tr>
                            <tr><td colspan="2" align="right" class="info">&nbsp</td></tr>
                        </table>
                        <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" Visible="false"
                            OnClientClick="location.replace('importproc.aspx?tp=1');return false;" CommandName="Cancel"
                            Text="Назад" />
                    </ItemTemplate>                    
                </asp:FormView>
            </asp:View>
            <asp:View ID="docW" runat="server">
                <h4>Перегляд додаткових реквiзитiв</h4>
                <Bars:BarsSqlDataSourceEx runat="server" ID="dsW" 
                    SelectCommand="select w.impref, w.tag, w.value, r.name, 1 as action from xml_impdocsw w, op_field r where w.tag=r.tag(+) and w.impref=:impref and substr(w.tag,1,1) <> 'C' order by w.tag"
                    UpdateCommand = "update xml_impdocsw set value=:value where tag=:tag and impref=:impref"
                    DeleteCommand = "delete from xml_impdocsw where tag=:tag and impref=:impref"
                    InsertCommand = "insert into xml_impdocsw (impref, tag, value) values (:impref, :tag, :value)"
                    onselecting="dsW_Selecting" AllowPaging="False" FilterStatement="" 
                    PageButtonCount="10" PagerMode="NextPrevious" PageSize="10" 
                    PreliminaryStatement="" ProviderName="barsroot.core" 
                    SortExpression="" SystemChangeNumber=""
                    TotalsCommand="" WhereStatement="" ondeleting="dsW_Deleting" 
                    oninserting="dsW_Inserting" onupdating="dsW_Updating">
                </Bars:BarsSqlDataSourceEx>
                <Bars:BarsGridViewEx ID="gvW" runat="server" DataSourceID="DsW" 
                    ShowCaption="False" CaptionType="Simple" AutoGenerateColumns="False" 
                    CaptionText="" AutoGenerateNewButton="true" DataKeyNames="impref, tag"
                    ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                    CssClass="barsGridView" DateMask="dd.MM.yyyy"  
                    ExcelImageUrl="/common/images/default/16/export_excel.png" 
                    FilterImageUrl="/common/images/default/16/filter.png" 
                    MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                    RefreshImageUrl="/common/images/default/16/refresh.png" 
                    ShowPageSizeBox="False" onrowdatabound="gvW_RowDataBound" 
                    onrowediting="gvW_RowEditing">
                    <FooterStyle CssClass="footerRow" />
                    <HeaderStyle CssClass="headerRow" />
                    <EditRowStyle CssClass="editRow" />
                    <PagerStyle CssClass="pagerRow" />
                    <NewRowStyle CssClass="" />
                    <SelectedRowStyle CssClass="selectedRow" />
                    <AlternatingRowStyle CssClass="alternateRow" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ButtonType="Image"
                            EditImageUrl="/common/images/default/16/open.png"
                            DeleteImageUrl="/common/images/default/16/cancel.png"
                            CancelImageUrl="/common/images/default/16/cancel.png"
                            UpdateImageUrl="/common/images/default/16/save.png"
                            EditText="Редагувати"
                            CancelText="Вiдмiна"
                            UpdateText="Зберегти"/>
                    </Columns>
                    <RowStyle CssClass="normalRow" />
                </Bars:BarsGridViewEx>
                <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
                             CommandName="Cancel"
                            Text="Назад" onclick="UpdateCancelButton_Click" />
            </asp:View>
            <asp:View ID="docB" runat="server">
                <h4>Перегляд БICiв</h4> 
                <Bars:BarsSqlDataSourceEx runat="server" ID="dsC" ProviderName="barsroot.core" 
                    SelectCommand="select impref, tag, value from xml_impdocsw where impref=:impref and substr(tag,1,1) = 'C' order by tag"
                    UpdateCommand="update xml_impdocsw set value=:value where tag=:tag and impref=:impref"
                    onselecting="dsC_Selecting" >
                </Bars:BarsSqlDataSourceEx>            
                <Bars:BarsGridViewEx ID="gvC" runat="server" DataSourceID="dsC"  DataKeyNames="IMPREF,TAG"
                    ShowCaption="False" CaptionType="Simple" AutoGenerateColumns="False"
                    CaptionText="" 
                    ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                    CssClass="barsGridView" DateMask="dd.MM.yyyy" 
                    ExcelImageUrl="/common/images/default/16/export_excel.png" 
                    FilterImageUrl="/common/images/default/16/filter.png" 
                    MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                    RefreshImageUrl="/common/images/default/16/refresh.png" 
                    ShowPageSizeBox="False">
                    <FooterStyle CssClass="footerRow" />
                    <HeaderStyle CssClass="headerRow" />
                    <EditRowStyle CssClass="editRow" />
                    <PagerStyle CssClass="pagerRow" />
                    <NewRowStyle CssClass="" />
                    <SelectedRowStyle CssClass="selectedRow" />
                    <AlternatingRowStyle CssClass="alternateRow" />
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ButtonType="Image"
                            EditImageUrl="/common/images/default/16/open.png"
                            CancelImageUrl="/common/images/default/16/cancel.png"
                            UpdateImageUrl="/common/images/default/16/save.png"
                            EditText="Редагувати"
                            CancelText="Вiдмiна"
                            UpdateText="Зберегти"/>
                        <asp:BoundField DataField="TAG" HeaderText="Рядок" ReadOnly="true" >
                            <ItemStyle Width="20px" />
                        </asp:BoundField>
                        <asp:TemplateField  HeaderText="Значення" >                        
                            <ItemStyle Width="100%" />
                            <ItemTemplate><asp:Label runat="server" ID="lbl" Text='<%# Eval("VALUE") %>'/></ItemTemplate>
                            <EditItemTemplate>
                            <asp:TextBox runat="server" ID="tb" Width="99%" Text='<%# Bind("VALUE") %>'/>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="normalRow" />
                </Bars:BarsGridViewEx>
                <asp:Button ID="Button1" runat="server" CausesValidation="False"
                             CommandName="Cancel"
                            Text="Назад" onclick="Button1_Click" />
            </asp:View>
        </asp:MultiView>
    </div>
    </form>
</body>
</html>
