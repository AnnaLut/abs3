<%@ Page Language="C#" MasterPageFile="~/clientregister/clientregister.master" AutoEventWireup="true"
    CodeFile="tab_linked_custs.aspx.cs" Inherits="clientregister_tab_linked_custs"
    Title="Пов`язані з клієнтом особи" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div id="dvCheckLink" style="visibility: hidden; position:absolute">
        <input type="checkbox" id="cbCheckLink" checked="checked" />
        <label class="tableTitle" for="cbCheckLink">Заповнити дані по пов'язаним особам</label>
    </div>
    <table border="0" cellpadding="3" cellspacing="0">
        <tr>
            <td>
                <asp:Panel ID="pnlCusts" runat="server" GroupingText="Пов`язані особи">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td>
                                <bars:BarsObjectDataSource ID="odsCustRelations" runat="server" SelectMethod="SelectCustRelations"
                                    TypeName="clientregister.VCustRelations">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="RNK" QueryStringField="rnk" Type="Decimal" />
                                    </SelectParameters>
                                </bars:BarsObjectDataSource>
                                <bars:BarsGridViewEx ID="gvCustRelations" runat="server" CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                                    CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                                    CssClass="barsGridView" DataSourceID="odsCustRelations" DateMask="dd.MM.yyyy"
                                    EnableModelValidation="True" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                                    FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                                    HoverRowCssClass="hoverRow" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                                    MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                                    AutoGenerateColumns="False" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
                                    ShowExportExcelButton="True" ShowPageSizeBox="False" DataKeyNames="RNK,REL_INTEXT,RELCUST_RNK,RELEXT_ID"
                                    OnSelectedIndexChanged="gvCustRelations_SelectedIndexChanged">
                                    <NewRowStyle CssClass=""></NewRowStyle>
                                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="RELCUST_RNK" HeaderText="РНК (клієнта)" SortExpression="RELCUST_RNK">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="RELEXT_ID" HeaderText="Код особи (НЕ клієнта)" SortExpression="RELEXT_ID">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CUSTTYPE" HeaderText="Ознака (1-ЮО,2-ФО)" SortExpression="CUSTTYPE">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NAME" HeaderText="Найменування" SortExpression="NAME"></asp:BoundField>
                                        <asp:BoundField DataField="DOC_NAME" HeaderText="Документ" SortExpression="DOC_NAME"></asp:BoundField>
                                        <asp:BoundField DataField="DOC_SERIAL" HeaderText="Серія" SortExpression="DOC_SERIAL">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DOC_NUMBER" HeaderText="Номер" SortExpression="DOC_NUMBER">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DOC_DATE" DataFormatString="{0:d}" HeaderText="Коли видано"
                                            SortExpression="DOC_DATE">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DOC_ISSUER" HeaderText="Ким видано" SortExpression="DOC_ISSUER"></asp:BoundField>
                                        <asp:BoundField DataField="BIRTHDAY" DataFormatString="{0:d}" HeaderText="Дата народження"
                                            SortExpression="BIRTHDAY">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BIRTHPLACE" HeaderText="Місце народження" SortExpression="BIRTHPLACE"></asp:BoundField>
                                        <asp:BoundField DataField="SEX_NAME" HeaderText="Стать" SortExpression="SEX_NAME"></asp:BoundField>
                                        <asp:BoundField DataField="ADR" HeaderText="Адреса" SortExpression="ADR"></asp:BoundField>
                                        <asp:BoundField DataField="TEL" HeaderText="Телефон" SortExpression="TEL"></asp:BoundField>
                                        <asp:BoundField DataField="EMAIL" HeaderText="e-mail" SortExpression="EMAIL"></asp:BoundField>
                                        <asp:BoundField DataField="OKPO" HeaderText="Ідент. код / Код за ЕДРПОУ" SortExpression="OKPO"></asp:BoundField>
                                        <asp:BoundField DataField="COUNTRY_NAME" HeaderText="Країна" SortExpression="COUNTRY_NAME"></asp:BoundField>
                                        <asp:BoundField DataField="REGION" HeaderText="Регіон" SortExpression="REGION"></asp:BoundField>
                                        <asp:BoundField DataField="FS" HeaderText="Форма власності (K081)" SortExpression="FS">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="VED" HeaderText="Вид екон. дiяльностi (K110)" SortExpression="VED">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SED" HeaderText="Орг.-правова форма госп. (K051)" SortExpression="SED">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ISE" HeaderText="Інст. сектор екон. (K070)" SortExpression="ISE">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NOTES" HeaderText="Коментар" SortExpression="NOTES"></asp:BoundField>
                                    </Columns>
                                    <EditRowStyle CssClass="editRow"></EditRowStyle>
                                    <FooterStyle CssClass="footerRow"></FooterStyle>
                                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                                    <RowStyle CssClass="normalRow"></RowStyle>
                                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                </bars:BarsGridViewEx>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 10px">
                                <bars:BarsObjectDataSource ID="odsCustRelationsFV" runat="server" SelectMethod="SelectCustRelation"
                                    TypeName="clientregister.VCustRelations" DataObjectTypeName="clientregister.VCustRelationsRecord"
                                    UpdateMethod="Update" InsertMethod="Insert" DeleteMethod="Delete">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="RNK" QueryStringField="rnk" Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelations" Name="REL_INTEXT" PropertyName="SelectedDataKey[&quot;REL_INTEXT&quot;]"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelations" Name="RELCUST_RNK" PropertyName="SelectedDataKey[&quot;RELCUST_RNK&quot;]"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelations" Name="RELEXT_ID" PropertyName="SelectedDataKey[&quot;RELEXT_ID&quot;]"
                                            Type="Decimal" />
                                    </SelectParameters>
                                </bars:BarsObjectDataSource>
                                <bars:BarsSqlDataSourceEx ID="sdsREL_INTEXT" runat="server" SelectCommand="select 0 as ID, '0 - НЕ клієнт банку' as NAME from dual union select 1 as ID, '1 - клієнт банку' as NAME from dual"
                                    ProviderName="barsroot.core">
                                </bars:BarsSqlDataSourceEx>
                                <bars:BarsSqlDataSourceEx ID="sdsCUSTTYPE" runat="server" SelectCommand="select 1 as ID, 'ЮО' as NAME from dual union select 2 as ID, 'ФО' as NAME from dual"
                                    ProviderName="barsroot.core">
                                </bars:BarsSqlDataSourceEx>
                                <bars:BarsSqlDataSourceEx ID="sdsPassp" runat="server" SelectCommand="select * from passp"
                                    ProviderName="barsroot.core">
                                </bars:BarsSqlDataSourceEx>
                                <bars:BarsSqlDataSourceEx ID="sdsSEX" runat="server" SelectCommand="select * from sex"
                                    ProviderName="barsroot.core">
                                </bars:BarsSqlDataSourceEx>
                                <asp:FormView ID="fv" runat="server" DataKeyNames="RNK,REL_INTEXT,RELCUST_RNK,RELEXT_ID"
                                    DataSourceID="odsCustRelationsFV" EnableModelValidation="True" OnDataBound="fv_DataBound"
                                    OnItemUpdated="fv_ItemUpdated" OnItemDeleted="fv_ItemDeleted" OnItemInserted="fv_ItemInserted"
                                    OnItemInserting="fv_ItemInserting">
                                    <EditItemTemplate>
                                        <table border="0" cellpadding="3" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlREL_INTEXT" runat="server" GroupingText="Тип особи">
                                                        <bars:DDLList ID="REL_INTEXT" runat="server" DataSourceID="sdsREL_INTEXT" DataValueField="ID"
                                                            DataTextField="NAME" IsRequired="true" ValidationGroup="Params" Value='<%# Bind("REL_INTEXT") %>'
                                                            Enabled="false">
                                                        </bars:DDLList>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметри особи">
                                                        <asp:MultiView ID="mv" runat="server">
                                                            <asp:View ID="v0" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="RELEXT_IDTitle" runat="server" Text="Код особи: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="RELEXT_ID" runat="server" TAB_ID="1521" KEY_FIELD="ID" SEMANTIC_FIELD="NAME"
                                                                                SHOW_FIELDS="OKPO,CUSTTYPE" IsRequired="true" ValidationGroup="Params" Value='<%# Bind("RELEXT_ID") %>'
                                                                                Enabled="false" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="CUSTTYPETitle" runat="server" Text="Ознака (1-ЮО, 2-ФО): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="CUSTTYPE" runat="server" DataSourceID="sdsCUSTTYPE" DataValueField="ID"
                                                                                DataTextField="NAME" IsRequired="false" ValidationGroup="Params" Value='<%# Bind("CUSTTYPE") %>'>
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NAMETitle" runat="server" Text="Найменування: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NAME" runat="server" Width="300px" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("NAME") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_TYPETitle" runat="server" Text="Документ: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="DOC_TYPE" runat="server" DataSourceID="sdsPassp" DataValueField="PASSP"
                                                                                DataTextField="NAME" IsRequired="false" ValidationGroup="Params" Value='<%# Bind("DOC_TYPE") %>'>
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_SERIALTitle" runat="server" Text="Серія: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="DOC_SERIAL" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("DOC_SERIAL") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_NUMBERTitle" runat="server" Text="Номер: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="DOC_NUMBER" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("DOC_NUMBER") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_DATETitle" runat="server" Text="Коли видано: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="DOC_DATE" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("DOC_DATE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_ISSUERTitle" runat="server" Text="Ким видано: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="DOC_ISSUER" runat="server" Width="300px" IsRequired="false"
                                                                                ValidationGroup="Params" Value='<%# Bind("DOC_ISSUER") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BIRTHDAYTitle" runat="server" Text="Дата народження: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="BIRTHDAY" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("BIRTHDAY") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BIRTHPLACETitle" runat="server" Text="Місце народження: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="BIRTHPLACE" runat="server" Width="300px" IsRequired="false"
                                                                                ValidationGroup="Params" Value='<%# Bind("BIRTHPLACE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="SEXTitle" runat="server" Text="Стать: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="SEX" runat="server" DataSourceID="sdsSEX" DataValueField="ID" DataTextField="NAME"
                                                                                IsRequired="true" ValidationGroup="Params" SelectedValue='<%# Bind("SEX") %>'>
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="ADRTitle" runat="server" Text="Адреса: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="ADR" runat="server" Width="300px" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("ADR") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="TELTitle" runat="server" Text="Телефон: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="TEL" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("TEL") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="EMAILTitle" runat="server" Text="e-mail: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="EMAIL" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("EMAIL") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="OKPOTitle" runat="server" Text="Ідент. код / Код за ЕДРПОУ: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="OKPO" runat="server" MaxLength="10" IsRequired="true" ValidationGroup="Params"
                                                                                Value='<%# Bind("OKPO") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="COUNTRYTitle" runat="server" Text="Країна: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="COUNTRY" runat="server" TAB_ID="128" KEY_FIELD="COUNTRY" SEMANTIC_FIELD="NAME"
                                                                                IsRequired="true" ValidationGroup="Params" Value='<%# Bind("COUNTRY") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="REGIONTitle" runat="server" Text="Регіон: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="REGION" runat="server" TAB_ID="194" KEY_FIELD="C_REG" SEMANTIC_FIELD="NAME_REG"
                                                                                IsRequired="true" ValidationGroup="Params" Value='<%# Bind("REGION") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="FSTitle" runat="server" Text="Форма власності (K081): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="FS" runat="server" TAB_ID="145" KEY_FIELD="FS" SEMANTIC_FIELD="NAME"
                                                                                WHERE_CLAUSE="where D_CLOSE is null" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("FS") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="VEDTitle" runat="server" Text="Вид екон. дiяльностi (K110): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="VED" runat="server" TAB_ID="208" KEY_FIELD="VED" SEMANTIC_FIELD="NAME"
                                                                                WHERE_CLAUSE="where D_CLOSE is null" IsRequired="true" ValidationGroup="Params"
                                                                                Value='<%# Bind("VED") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="SEDTitle" runat="server" Text="Орг.-правова форма госп. (K051): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="SED" runat="server" TAB_ID="191" KEY_FIELD="SED" SEMANTIC_FIELD="NAME"
                                                                                WHERE_CLAUSE="where D_CLOSE is null" IsRequired="true" ValidationGroup="Params"
                                                                                Value='<%# Bind("SED") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="ISETitle" runat="server" Text="Інст. сектор екон. (K070): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="ISE" runat="server" TAB_ID="153" KEY_FIELD="ISE" SEMANTIC_FIELD="NAME"
                                                                                WHERE_CLAUSE="where D_CLOSE is null" IsRequired="true" ValidationGroup="Params"
                                                                                Value='<%# Bind("ISE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NOTESTitle" runat="server" Text="Коментар: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NOTES" runat="server" Width="300px" Rows="3" IsRequired="false"
                                                                                ValidationGroup="Params" Value='<%# Bind("NOTES") %>' />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:View>
                                                        </asp:MultiView>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="3" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Update" CausesValidation="true"
                                                                    ValidationGroup="Params" ImageUrl="/Common/Images/default/16/save.png" ToolTip="Зберегти" />
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                    ImageUrl="/Common/Images/default/16/cancel_1.png" ToolTip="Відміна" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <table border="0" cellpadding="3" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlREL_INTEXT" runat="server" GroupingText="Тип особи">
                                                        <bars:DDLList ID="REL_INTEXT" runat="server" DataSourceID="sdsREL_INTEXT" DataValueField="ID"
                                                            DataTextField="NAME" IsRequired="true" ValidationGroup="Params" Value='<%# Bind("REL_INTEXT") %>'
                                                            OnValueChanged="REL_INTEXT_ValueChanged">
                                                        </bars:DDLList>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметри особи">
                                                        <asp:MultiView ID="mv" runat="server">
                                                            <asp:View ID="v0" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="IS_NEWTitle" runat="server" Text="Нова особа?"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:RBLFlag ID="IS_NEW" IsRequired="true" DefaultValue="true" runat="server" OnValueChanged="IS_NEW_ValueChanged" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="RELEXT_IDTitle" runat="server" Text="Код особи: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="RELEXT_ID" runat="server" TAB_ID="1521" KEY_FIELD="ID" SEMANTIC_FIELD="NAME"
                                                                                SHOW_FIELDS="OKPO,CUSTTYPE" IsRequired="true" ValidationGroup="Params" Value='<%# Bind("RELEXT_ID") %>'
                                                                                OnValueChanged="RELEXT_ID_ValueChanged" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="CUSTTYPETitle" runat="server" Text="Ознака (1-ЮО, 2-ФО): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="CUSTTYPE" runat="server" DataSourceID="sdsCUSTTYPE" DataValueField="ID"
                                                                                DataTextField="NAME" IsRequired="false" ValidationGroup="Params" Value='<%# Bind("CUSTTYPE") %>'>
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NAMETitle" runat="server" Text="Найменування: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NAME" runat="server" Width="300px" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("NAME") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_TYPETitle" runat="server" Text="Документ: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="DOC_TYPE" runat="server" DataSourceID="sdsPassp" DataValueField="PASSP"
                                                                                DataTextField="NAME" IsRequired="false" ValidationGroup="Params" Value='<%# Bind("DOC_TYPE") %>'>
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_SERIALTitle" runat="server" Text="Серія: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="DOC_SERIAL" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("DOC_SERIAL") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_NUMBERTitle" runat="server" Text="Номер: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="DOC_NUMBER" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("DOC_NUMBER") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_DATETitle" runat="server" Text="Коли видано: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="DOC_DATE" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("DOC_DATE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOC_ISSUERTitle" runat="server" Text="Ким видано: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="DOC_ISSUER" runat="server" Width="300px" IsRequired="false"
                                                                                ValidationGroup="Params" Value='<%# Bind("DOC_ISSUER") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BIRTHDAYTitle" runat="server" Text="Дата народження: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="BIRTHDAY" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("BIRTHDAY") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BIRTHPLACETitle" runat="server" Text="Місце народження: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="BIRTHPLACE" runat="server" Width="300px" IsRequired="false"
                                                                                ValidationGroup="Params" Value='<%# Bind("BIRTHPLACE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="SEXTitle" runat="server" Text="Стать: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="SEX" runat="server" DataSourceID="sdsSEX" DataValueField="ID" DataTextField="NAME"
                                                                                IsRequired="true" ValidationGroup="Params" SelectedValue='<%# Bind("SEX") %>'>
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="ADRTitle" runat="server" Text="Адреса: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="ADR" runat="server" Width="300px" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("ADR") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="TELTitle" runat="server" Text="Телефон: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="TEL" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("TEL") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="EMAILTitle" runat="server" Text="e-mail: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="EMAIL" runat="server" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("EMAIL") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="OKPOTitle" runat="server" Text="Ідент. код / Код за ЕДРПОУ: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="OKPO" runat="server" MaxLength="10" IsRequired="true" ValidationGroup="Params"
                                                                                Value='<%# Bind("OKPO") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="COUNTRYTitle" runat="server" Text="Країна: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="COUNTRY" runat="server" TAB_ID="128" KEY_FIELD="COUNTRY" SEMANTIC_FIELD="NAME"
                                                                                IsRequired="true" ValidationGroup="Params" Value='<%# Bind("COUNTRY") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="REGIONTitle" runat="server" Text="Регіон: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="REGION" runat="server" TAB_ID="194" KEY_FIELD="C_REG" SEMANTIC_FIELD="NAME_REG"
                                                                                IsRequired="true" ValidationGroup="Params" Value='<%# Bind("REGION") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="FSTitle" runat="server" Text="Форма власності (K081): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="FS" runat="server" TAB_ID="145" KEY_FIELD="FS" SEMANTIC_FIELD="NAME"
                                                                                WHERE_CLAUSE="where D_CLOSE is null" IsRequired="false" ValidationGroup="Params"
                                                                                Value='<%# Bind("FS") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="VEDTitle" runat="server" Text="Вид екон. дiяльностi (K110): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="VED" runat="server" TAB_ID="208" KEY_FIELD="VED" SEMANTIC_FIELD="NAME"
                                                                                WHERE_CLAUSE="where D_CLOSE is null" IsRequired="true" ValidationGroup="Params"
                                                                                Value='<%# Bind("VED") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="SEDTitle" runat="server" Text="Орг.-правова форма госп. (K051): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="SED" runat="server" TAB_ID="191" KEY_FIELD="SED" SEMANTIC_FIELD="NAME"
                                                                                WHERE_CLAUSE="where D_CLOSE is null" IsRequired="true" ValidationGroup="Params"
                                                                                Value='<%# Bind("SED") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="ISETitle" runat="server" Text="Інст. сектор екон. (K070): "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="ISE" runat="server" TAB_ID="153" KEY_FIELD="ISE" SEMANTIC_FIELD="NAME"
                                                                                WHERE_CLAUSE="where D_CLOSE is null" IsRequired="true" ValidationGroup="Params"
                                                                                Value='<%# Bind("ISE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NOTESTitle" runat="server" Text="Коментар: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NOTES" runat="server" Width="300px" Rows="3" IsRequired="false"
                                                                                ValidationGroup="Params" Value='<%# Bind("NOTES") %>' />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:View>
                                                            <asp:View ID="v1" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="RELCUST_RNKTitle" runat="server" Text="РНК клієнта"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxRefer ID="RELCUST_RNK" runat="server" TAB_ID="282" KEY_FIELD="RNK" SEMANTIC_FIELD="NMK"
                                                                                SHOW_FIELDS="OKPO" WHERE_CLAUSE="where CUSTTYPE in (2,3) and DATE_OFF is null"
                                                                                ValidationGroup="Params" Value='<%# Bind("RELCUST_RNK") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NOTESTitle1" runat="server" Text="Коментар: "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NOTES1" runat="server" Width="300px" Rows="3" IsRequired="false"
                                                                                ValidationGroup="Params" Value='<%# Bind("NOTES") %>' />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:View>
                                                        </asp:MultiView>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="3" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Insert" CausesValidation="true"
                                                                    ValidationGroup="Params" ImageUrl="/Common/Images/default/16/save.png" ToolTip="Додати" />
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                    ImageUrl="/Common/Images/default/16/cancel_1.png" ToolTip="Відміна" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <table border="0" cellpadding="3" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                        ImageUrl="/Common/Images/default/16/open.png" Text="Редагувати" ToolTip="Редагувати пов`язану особу"
                                                        Visible='<%# (Decimal)gvCustRelations.SelectedDataKey["REL_INTEXT"] == 0 %>' />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                                        ImageUrl="/Common/Images/default/16/delete.png" OnClientClick="return confirm('Видалити пов`язану особу?');"
                                                        Text="Видалити" ToolTip="Видалити пов`язану особу" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                                        ImageUrl="/Common/Images/default/16/new.png" Text="Додати" ToolTip="Додати пов`язану особу" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                        <table border="0" cellpadding="3" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                                        ImageUrl="/Common/Images/default/16/new.png" Text="Додати" ToolTip="Додати пов`язану особу" />
                                                </td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                </asp:FormView>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlRelations" runat="server" GroupingText="Зв`язок">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td style="width: 300px; vertical-align: top">
                                <bars:BarsObjectDataSource ID="odsCustRelationTypes" runat="server" SelectMethod="SelectCustRelationTypes"
                                    TypeName="clientregister.VCustRelationTypes">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="RNK" QueryStringField="rnk" Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelations" Name="REL_INTEXT" PropertyName="SelectedDataKey[&quot;REL_INTEXT&quot;]"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelations" Name="RELCUST_RNK" PropertyName="SelectedDataKey[&quot;RELCUST_RNK&quot;]"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelations" Name="RELEXT_ID" PropertyName="SelectedDataKey[&quot;RELEXT_ID&quot;]"
                                            Type="Decimal" />
                                    </SelectParameters>
                                </bars:BarsObjectDataSource>
                                <bars:BarsGridViewEx ID="gvCustRelationTypes" runat="server" AutoGenerateColumns="False"
                                    AutoSelectFirstRow="True" CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                                    CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                                    CssClass="barsGridView" DataSourceID="odsCustRelationTypes" DateMask="dd.MM.yyyy"
                                    EnableModelValidation="True" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                                    FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                                    HoverRowCssClass="hoverRow" JavascriptSelectionType="ServerSelect" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                                    MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                                    ShowExportExcelButton="True" ShowPageSizeBox="False" DataKeyNames="RNK,REL_INTEXT,REL_RNK,REL_ID,RELID_SELECTED">
                                    <NewRowStyle CssClass=""></NewRowStyle>
                                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="REL_NAME" HeaderText="Ознака пов`язаності" SortExpression="REL_NAME"></asp:BoundField>
                                    </Columns>
                                    <EditRowStyle CssClass="editRow"></EditRowStyle>
                                    <FooterStyle CssClass="footerRow"></FooterStyle>
                                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                                    <RowStyle CssClass="normalRow"></RowStyle>
                                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                </bars:BarsGridViewEx>
                            </td>
                            <td style="border: 1px solid black">
                                <bars:BarsObjectDataSource ID="odsCustRelationDataFV" runat="server" SelectMethod="SelectCustRelationData"
                                    TypeName="clientregister.VCustRelationData" DataObjectTypeName="clientregister.VCustRelationDataRecord"
                                    UpdateMethod="Update" InsertMethod="Insert" DeleteMethod="Delete">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="RNK" QueryStringField="rnk" Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelationTypes" Name="REL_INTEXT" PropertyName="SelectedDataKey[&quot;REL_INTEXT&quot;]"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelationTypes" Name="REL_RNK" PropertyName="SelectedDataKey[&quot;REL_RNK&quot;]"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelationTypes" Name="REL_ID" PropertyName="SelectedDataKey[&quot;REL_ID&quot;]"
                                            Type="Decimal" />
                                    </SelectParameters>
                                    <InsertParameters>
                                        <asp:QueryStringParameter Name="RNK" QueryStringField="rnk" Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelationTypes" Name="REL_INTEXT" PropertyName="SelectedDataKey[&quot;REL_INTEXT&quot;]"
                                            Type="Decimal" />
                                        <asp:ControlParameter ControlID="gvCustRelationTypes" Name="REL_RNK" PropertyName="SelectedDataKey[&quot;REL_RNK&quot;]"
                                            Type="Decimal" />
                                    </InsertParameters>
                                </bars:BarsObjectDataSource>
                                <bars:BarsSqlDataSourceEx ID="sdsTYPE" runat="server" SelectCommand="select * from trustee_type"
                                    ProviderName="barsroot.core">
                                </bars:BarsSqlDataSourceEx>
                                <bars:BarsSqlDataSourceEx ID="sdsDOCUMENT_TYPE" runat="server" SelectCommand="select * from trustee_document_type"
                                    ProviderName="barsroot.core">
                                </bars:BarsSqlDataSourceEx>
                                <bars:BarsSqlDataSourceEx ID="sdsCUST_REL" runat="server" SelectCommand="select * from cust_rel where id != -1 order by id"
                                    ProviderName="barsroot.core">
                                </bars:BarsSqlDataSourceEx>
                                <bars:BarsObjectDataSource ID="odsCustRelTypes" runat="server" SelectMethod="Select"
                                    TypeName="clientregister.VCustRelTypes">
                                </bars:BarsObjectDataSource>

                                <bars:BarsSqlDataSourceEx ID="sel_custrel" runat="server" ProviderName="barsroot.core">
                                </bars:BarsSqlDataSourceEx>

                                <asp:FormView ID="fvCustRelationData" runat="server" DataSourceID="odsCustRelationDataFV"
                                    EnableModelValidation="True" OnDataBound="fvCustRelationData_DataBound" DataKeyNames="RNK,REL_INTEXT,REL_RNK,REL_ID,DATASET_ID"
                                    OnItemDeleted="fvCustRelationData_ItemDeleted" OnItemInserted="fvCustRelationData_ItemInserted"
                                    OnItemInserting="fvCustRelationData_ItemInserting" OnItemUpdated="fvCustRelationData_ItemUpdated">
                                    <EditItemTemplate>
                                        <asp:Panel ID="pnlRelData" runat="server" GroupingText="Параметри">
                                            <table border="0" cellpadding="3" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:MultiView ID="mvCustRelationData" runat="server">
                                                            <asp:View ID="vSIMPLE" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BDATE_SIMPLETitle" runat="server" Text="Дата початку дії повноважень"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="BDATE_SIMPLE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("BDATE_SIMPLE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="EDATE_SIMPLETitle" runat="server" Text="Дата кінця дії повноважень"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="EDATE_SIMPLE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("EDATE_SIMPLE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:View>
                                                            <asp:View ID="vVAGA" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="VAGA1Title" runat="server" Text="Питома вага прямої участі у статутному фонді"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDecimal ID="VAGA1" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("VAGA1") %>' MaxValue="100" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="VAGA2Title" runat="server" Text="Питома вага опосередкованої участі в статутному фонді"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDecimal ID="VAGA2" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("VAGA2") %>' MaxValue="100" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BDATE_VAGATitle" runat="server" Text="Дата початку дії повноважень"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="BDATE_VAGA" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("BDATE_VAGA") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="EDATE_VAGATitle" runat="server" Text="Дата кінця дії повноважень"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="EDATE_VAGA" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("EDATE_VAGA") %>' />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:View>
                                                            <asp:View ID="vTRUSTEE" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="TYPE_IDTitle" runat="server" Text="Тип довіреної особи"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="TYPE_ID" runat="server" DataSourceID="sdsTYPE" DataValueField="ID"
                                                                                DataTextField="NAME" IsRequired="true" ValidationGroup="DataParams" Value='<%# Bind("TYPE_ID") %>'>
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="POSITIONTitle" runat="server" Text="Посада"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="POSITION" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("POSITION") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOCUMENT_TYPE_IDTitle" runat="server" Text="Тип документу довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="DOCUMENT_TYPE_ID" runat="server" DataSourceID="sdsDOCUMENT_TYPE"
                                                                                DataValueField="ID" DataTextField="NAME" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("DOCUMENT_TYPE_ID") %>'>
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOCUMENTTitle" runat="server" Text="Документ довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="DOCUMENT" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("DOCUMENT") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="TRUST_REGNUMTitle" runat="server" Text="Номер реєстрації довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="TRUST_REGNUM" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("TRUST_REGNUM") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="TRUST_REGDATTitle" runat="server" Text="Дата реєстрації довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="TRUST_REGDAT" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("TRUST_REGDAT") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BDATE_TRUSTEETitle" runat="server" Text="Дата початку дії довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="BDATE_TRUSTEE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("BDATE_TRUSTEE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="EDATE_TRUSTEETitle" runat="server" Text="Дата кінця дії довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="EDATE_TRUSTEE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("EDATE_TRUSTEE") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NOTARY_NAMETitle" runat="server" Text="ПІБ нотаріуса"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NOTARY_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("NOTARY_NAME") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NOTARY_REGIONTitle" runat="server" Text="Нотаріальний округ"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NOTARY_REGION" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("NOTARY_REGION") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="SIGN_PRIVSTitle" runat="server" Text="Право підпису?"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:RBLFlag ID="SIGN_PRIVS" runat="server" IsRequired="true" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("SIGN_PRIVS") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <!--
                                                    SIGN_ID:
                                                    <asp:Label ID="SIGN_IDLabel" runat="server" Text='Bind("SIGN_ID")' />
                                                    <br />
                                                    SIGN_DATA:
                                                    <asp:Label ID="SIGN_DATALabel" runat="server" Text='Bind("SIGN_DATA")' />
                                                    -->
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="FIRST_NAMETitle" runat="server" Text="Прізвище"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="FIRST_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("FIRST_NAME") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="MIDDLE_NAMETitle" runat="server" Text="Ім`я"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="MIDDLE_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("MIDDLE_NAME") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="LAST_NAMETitle" runat="server" Text="По-батькові"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="LAST_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("LAST_NAME") %>' />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NAME_RTitle" runat="server" Text="ПІБ у родовому відмінку"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NAME_R" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("NAME_R") %>' />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:View>
                                                        </asp:MultiView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table border="0" cellpadding="3" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Update" CausesValidation="true"
                                                                        ValidationGroup="DataParams" ImageUrl="/Common/Images/default/16/save.png" ToolTip="Зберегти" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                        ImageUrl="/Common/Images/default/16/cancel_1.png" ToolTip="Відміна" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <table border="0" cellpadding="3" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlREL_ID" runat="server" GroupingText="Ознака пов`язаності">
                                                        <%-- bars:DDLList bars:DDLList ID="REL_ID" runat="server" DataSourceID="odsCustRelTypes" DataValueField="ID"
                                                            DataTextField="NAME" IsRequired="true" ValidationGroup="DataParams" Value='<%# Bind("REL_ID") %>'
                                                            OnValueChanged="REL_ID_ValueChanged">
                                                        </bars:DDLList --%>

                                                        <bars:DDLList ID="REL_ID" runat="server" DataSourceID="sel_custrel" DataValueField="ID"
                                                            DataTextField="NAME" IsRequired="true" ValidationGroup="DataParams" Value='<%# Bind("REL_ID") %>'
                                                            OnValueChanged="REL_ID_ValueChanged">
                                                        </bars:DDLList>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Panel ID="pnlRelData" runat="server" GroupingText="Параметри">
                                                        <table border="0" cellpadding="3" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:MultiView ID="mvCustRelationData" runat="server">
                                                                        <asp:View ID="vSIMPLE" runat="server">
                                                                            <table border="0" cellpadding="3" cellspacing="0">
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="BDATE_SIMPLETitle" runat="server" Text="Дата початку дії повноважень"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxDate ID="BDATE_SIMPLE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("BDATE_SIMPLE") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="EDATE_SIMPLETitle" runat="server" Text="Дата кінця дії повноважень"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxDate ID="EDATE_SIMPLE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("EDATE_SIMPLE") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:View>
                                                                        <asp:View ID="vVAGA" runat="server">
                                                                            <table border="0" cellpadding="3" cellspacing="0">
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="VAGA1Title" runat="server" Text="Питома вага прямої участі у статутному фонді"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxDecimal ID="VAGA1" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("VAGA1") %>' MaxValue="100" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="VAGA2Title" runat="server" Text="Питома вага опосередкованої участі в статутному фонді"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxDecimal ID="VAGA2" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("VAGA2") %>' MaxValue="100" />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="BDATE_VAGATitle" runat="server" Text="Дата початку дії повноважень"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxDate ID="BDATE_VAGA" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("BDATE_VAGA") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="EDATE_VAGATitle" runat="server" Text="Дата кінця дії повноважень"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxDate ID="EDATE_VAGA" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("EDATE_VAGA") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:View>
                                                                        <asp:View ID="vTRUSTEE" runat="server">
                                                                            <table border="0" cellpadding="3" cellspacing="0">
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="TYPE_IDTitle" runat="server" Text="Тип довіреної особи"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:DDLList ID="TYPE_ID" runat="server" DataSourceID="sdsTYPE" DataValueField="ID"
                                                                                            DataTextField="NAME" IsRequired="true" ValidationGroup="DataParams" Value='<%# Bind("TYPE_ID") %>'>
                                                                                        </bars:DDLList>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="POSITIONTitle" runat="server" Text="Посада"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxString ID="POSITION" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("POSITION") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="DOCUMENT_TYPE_IDTitle" runat="server" Text="Тип документу довіреності"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:DDLList ID="DOCUMENT_TYPE_ID" runat="server" DataSourceID="sdsDOCUMENT_TYPE"
                                                                                            DataValueField="ID" DataTextField="NAME" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("DOCUMENT_TYPE_ID") %>'>
                                                                                        </bars:DDLList>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="DOCUMENTTitle" runat="server" Text="Документ довіреності"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxString ID="DOCUMENT" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("DOCUMENT") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="TRUST_REGNUMTitle" runat="server" Text="Номер реєстрації довіреності"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxString ID="TRUST_REGNUM" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("TRUST_REGNUM") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="TRUST_REGDATTitle" runat="server" Text="Дата реєстрації довіреності"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxDate ID="TRUST_REGDAT" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("TRUST_REGDAT") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="BDATE_TRUSTEETitle" runat="server" Text="Дата початку дії довіреності"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxDate ID="BDATE_TRUSTEE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("BDATE_TRUSTEE") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="EDATE_TRUSTEETitle" runat="server" Text="Дата кінця дії довіреності"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxDate ID="EDATE_TRUSTEE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("EDATE_TRUSTEE") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="NOTARY_NAMETitle" runat="server" Text="ПІБ нотаріуса"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxString ID="NOTARY_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("NOTARY_NAME") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="NOTARY_REGIONTitle" runat="server" Text="Нотаріальний округ"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxString ID="NOTARY_REGION" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("NOTARY_REGION") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="SIGN_PRIVSTitle" runat="server" Text="Право підпису?"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:RBLFlag ID="SIGN_PRIVS" runat="server" IsRequired="true" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("SIGN_PRIVS") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <!--
                                                    SIGN_ID:
                                                    <asp:Label ID="SIGN_IDLabel" runat="server" Text='Bind("SIGN_ID")' />
                                                    <br />
                                                    SIGN_DATA:
                                                    <asp:Label ID="SIGN_DATALabel" runat="server" Text='Bind("SIGN_DATA")' />
                                                    -->
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="FIRST_NAMETitle" runat="server" Text="Прізвище"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxString ID="FIRST_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("FIRST_NAME") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="MIDDLE_NAMETitle" runat="server" Text="Ім`я"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxString ID="MIDDLE_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("MIDDLE_NAME") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="LAST_NAMETitle" runat="server" Text="По-батькові"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxString ID="LAST_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("LAST_NAME") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="NAME_RTitle" runat="server" Text="ПІБ у родовому відмінку"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <bars:TextBoxString ID="NAME_R" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                            Value='<%# Bind("NAME_R") %>' />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:View>
                                                                    </asp:MultiView>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="3" cellspacing="0">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Insert" CausesValidation="true"
                                                                                    ValidationGroup="DataParams" ImageUrl="/Common/Images/default/16/save.png" ToolTip="Додати" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                    ImageUrl="/Common/Images/default/16/cancel_1.png" ToolTip="Відміна" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Panel ID="pnlRelData" runat="server" GroupingText="Параметри">
                                            <table border="0" cellpadding="3" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:MultiView ID="mvCustRelationData" runat="server">
                                                            <asp:View ID="vSIMPLE" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BDATE_SIMPLETitle" runat="server" Text="Дата початку дії повноважень"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="BDATE_SIMPLE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("BDATE_SIMPLE") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="EDATE_SIMPLETitle" runat="server" Text="Дата кінця дії повноважень"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="EDATE_SIMPLE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("EDATE_SIMPLE") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:View>
                                                            <asp:View ID="vVAGA" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="VAGA1Title" runat="server" Text="Питома вага прямої участі у статутному фонді"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDecimal ID="VAGA1" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("VAGA1") %>' ReadOnly="true" MaxValue="100" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="VAGA2Title" runat="server" Text="Питома вага опосередкованої участі в статутному фонді"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDecimal ID="VAGA2" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("VAGA2") %>' ReadOnly="true" MaxValue="100" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BDATE_VAGATitle" runat="server" Text="Дата початку дії повноважень"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="BDATE_VAGA" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("BDATE_VAGA") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="EDATE_VAGATitle" runat="server" Text="Дата кінця дії повноважень"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="EDATE_VAGA" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("EDATE_VAGA") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:View>
                                                            <asp:View ID="vTRUSTEE" runat="server">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="TYPE_IDTitle" runat="server" Text="Тип довіреної особи"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="TYPE_ID" runat="server" DataSourceID="sdsTYPE" DataValueField="ID"
                                                                                DataTextField="NAME" IsRequired="true" ValidationGroup="DataParams" Value='<%# Bind("TYPE_ID") %>'
                                                                                ReadOnly="true">
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="POSITIONTitle" runat="server" Text="Посада"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="POSITION" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("POSITION") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOCUMENT_TYPE_IDTitle" runat="server" Text="Тип документу довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:DDLList ID="DOCUMENT_TYPE_ID" runat="server" DataSourceID="sdsDOCUMENT_TYPE"
                                                                                DataValueField="ID" DataTextField="NAME" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("DOCUMENT_TYPE_ID") %>' ReadOnly="true">
                                                                            </bars:DDLList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="DOCUMENTTitle" runat="server" Text="Документ довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="DOCUMENT" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("DOCUMENT") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="TRUST_REGNUMTitle" runat="server" Text="Номер реєстрації довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="TRUST_REGNUM" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("TRUST_REGNUM") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="TRUST_REGDATTitle" runat="server" Text="Дата реєстрації довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="TRUST_REGDAT" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("TRUST_REGDAT") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="BDATE_TRUSTEETitle" runat="server" Text="Дата початку дії довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="BDATE_TRUSTEE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("BDATE_TRUSTEE") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="EDATE_TRUSTEETitle" runat="server" Text="Дата кінця дії довіреності"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxDate ID="EDATE_TRUSTEE" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("EDATE_TRUSTEE") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NOTARY_NAMETitle" runat="server" Text="ПІБ нотаріуса"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NOTARY_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("NOTARY_NAME") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NOTARY_REGIONTitle" runat="server" Text="Нотаріальний округ"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NOTARY_REGION" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("NOTARY_REGION") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="SIGN_PRIVSTitle" runat="server" Text="Право підпису?"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:RBLFlag ID="SIGN_PRIVS" runat="server" IsRequired="true" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("SIGN_PRIVS") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <!--
                                                    SIGN_ID:
                                                    <asp:Label ID="SIGN_IDLabel" runat="server" Text='Bind("SIGN_ID")' />
                                                    <br />
                                                    SIGN_DATA:
                                                    <asp:Label ID="SIGN_DATALabel" runat="server" Text='Bind("SIGN_DATA")' />
                                                    -->
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="FIRST_NAMETitle" runat="server" Text="Прізвище"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="FIRST_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("FIRST_NAME") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="MIDDLE_NAMETitle" runat="server" Text="Ім`я"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="MIDDLE_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("MIDDLE_NAME") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="LAST_NAMETitle" runat="server" Text="По-батькові"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="LAST_NAME" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("LAST_NAME") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="NAME_RTitle" runat="server" Text="ПІБ у родовому відмінку"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <bars:TextBoxString ID="NAME_R" runat="server" IsRequired="false" ValidationGroup="DataParams"
                                                                                Value='<%# Bind("NAME_R") %>' ReadOnly="true" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:View>
                                                        </asp:MultiView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table border="0" cellpadding="3" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                                        ImageUrl="/Common/Images/default/16/open.png" Text="Редагувати" ToolTip="Редагувати параметри зв`язку" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                                                        ImageUrl="/Common/Images/default/16/delete.png" OnClientClick="return confirm('Видалити зв`язок?');"
                                                                        Text="Видалити" ToolTip="Видалити зв`язок" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                                                        ImageUrl="/Common/Images/default/16/new.png" Text="Додати" ToolTip="Додати зв`язок" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <EmptyDataTemplate>
                                        <table border="0" cellpadding="3" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                                        ImageUrl="/Common/Images/default/16/new.png" Text="Додати" ToolTip="Додати пов`язану особу" />
                                                </td>
                                            </tr>
                                        </table>
                                    </EmptyDataTemplate>
                                </asp:FormView>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
