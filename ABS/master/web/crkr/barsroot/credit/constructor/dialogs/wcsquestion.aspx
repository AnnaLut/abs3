<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsquestion.aspx.cs" Inherits="credit_constructor_dialogs_wcsquestion"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Вопрос"
    Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxSQLBlock.ascx" TagName="TextBoxSQLBlock"
    TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/TextBoxQuestion_ID.ascx" TagName="TextBoxQuestion_ID"
    TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <base target="_self" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsQuestionParamsRecord"
            SelectMethod="SelectQuestion" TypeName="credit.VWcsQuestionParams" InsertMethod="Insert"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:QueryStringParameter Name="ID" Direction="Input" QueryStringField="question_id"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsWcsQuestionTypes" runat="server" SelectMethod="SelectTypes"
            TypeName="credit.WcsQuestionTypes" OnSelecting="odsWcsQuestionTypes_Selecting">
            <SelectParameters>
                <asp:Parameter DefaultValue="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL,XML" Name="TYPES"
                    Size="255" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="ID" DataSourceID="odsFV" CssClass="formView"
            EnableModelValidation="True" OnItemCommand="fv_ItemCommand" OnItemInserted="fv_ItemInserted"
            OnDataBound="fv_DataBound" OnItemUpdating="fv_ItemUpdating">
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnlBase" runat="server" GroupingText="Базовые параметры">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' />
                                        </td>
                                        <td>
                                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("ID") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="NAME" runat="server" Text='<%# Bind("NAME") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" />
                                        </td>
                                        <td>
                                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsQuestionTypes"
                                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("TYPE_ID") %>'
                                                Enabled="false">
                                            </bec:DDLList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="IS_CALCABLERBLFlagTitle" runat="server" Text='Вычисляется :' />
                                        </td>
                                        <td>
                                            <bec:RBLFlag ID="IS_CALCABLE" ReadOnly="true" DefaultValue="false" runat="server"
                                                Value='<%# Bind("IS_CALCABLE") %>' OnPreRender="IS_CALCABLE_PreRender" Enabled="false" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <bec:TextBoxSQLBlock ID="CALC_PROCTextBox" Value='<%# Bind("CALC_PROC") %>' Enabled="false"
                                                Rows="3" TextMode="MultiLine" Width="300px" runat="server" ToolTip="Текст вычисления" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer">
                            <asp:ImageButton ID="ibAdd" runat="server" ImageUrl="/Common/Images/default/16/ok.png"
                                ToolTip="Добавить" CausesValidation="False" OnClientClick=<%# "CloseDialog('" + Eval("ID") + "');" %> />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" SkinID="ibCancel"
                                OnClientClick="CloseDialog(null);" ToolTip="Отмена" />
                            <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="/Common/Images/default/16/open.png" ToolTip="Редактировать" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnlBase" runat="server" GroupingText="Базовые параметры">
                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' />
                                        </td>
                                        <td>
                                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("ID") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("NAME") %>'
                                                MaxLength="255" Width="300px"></bec:TextBoxString>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" />
                                        </td>
                                        <td>
                                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsQuestionTypes"
                                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("TYPE_ID") %>'
                                                IsRequired="true">
                                            </bec:DDLList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="IS_CALCABLERBLFlagTitle" runat="server" Text='Вычисляется :' />
                                        </td>
                                        <td>
                                            <bec:RBLFlag ID="IS_CALCABLE" IsRequired="true" DefaultValue="false" runat="server"
                                                Value='<%# Bind("IS_CALCABLE") %>' OnValueChanged="ValueChanged" OnPreRender="IS_CALCABLE_PreRender" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <bec:TextBoxSQLBlock ID="CALC_PROCTextBox" Value='<%# Bind("CALC_PROC") %>' IsRequired="true"
                                                Rows="3" TextMode="MultiLine" Width="300px" runat="server" ToolTip="Текст вычисления" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell" style="text-align: left">
                            <asp:Panel ID="pnl" runat="server" GroupingText="Дополнительные параметры">
                                <asp:MultiView ID="mvTypes" runat="server">
                                    <asp:View ID="TEXT" runat="server">
                                        <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="TEXT_LENG_MINTitle" runat="server" Text='Минимальная длина :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="tbTEXT_LENG_MIN" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("TEXT_LENG_MIN") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="TEXT_LENG_MAXTitle" runat="server" Text='Максимальная длина :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="tbTEXT_LENG_MAX" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("TEXT_LENG_MAX") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="TEXT_VAL_DEFAULTTitle" runat="server" Text='Дефолтное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="tbTEXT_VAL_DEFAULT" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("TEXT_VAL_DEFAULT") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="TEXT_WIDTHTitle" runat="server" Text='Визуальная ширина :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxNumb ID="TEXT_WIDTH" runat="server" Value='<%# Bind("TEXT_WIDTH") %>'>
                                                    </bec:TextBoxNumb>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="TEXT_ROWSTitle" runat="server" Text='Кол-во рядков :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxNumb ID="TEXT_ROWS" runat="server" Value='<%# Bind("TEXT_ROWS") %>'>
                                                    </bec:TextBoxNumb>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="NUMBDEC" runat="server">
                                        <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="NMBDEC_VAL_MINTitle" runat="server" Text='Минимальное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="tbNMBDEC_VAL_MIN" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("NMBDEC_VAL_MIN") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="NMBDEC_VAL_MAXTitle" runat="server" Text='Максимальное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="tbNMBDEC_VAL_MAX" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("NMBDEC_VAL_MAX") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="NMBDEC_VAL_DEFAULTTitle" runat="server" Text='Дефолтное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="tbNMBDEC_VAL_DEFAULT" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("NMBDEC_VAL_DEFAULT") %>'>
                                                    </bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="DATE" runat="server">
                                        <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="DAT_VAL_MINTitle" runat="server" Text='Минимальное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="tbDAT_VAL_MIN" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("DAT_VAL_MIN") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="DAT_VAL_MAXTitle" runat="server" Text='Максимальное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="tbDAT_VAL_MAX" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("DAT_VAL_MAX") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="DAT_VAL_DEFAULTTitle" runat="server" Text='Дефолтное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="tbDAT_VAL_DEFAULT" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("DAT_VAL_DEFAULT") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="LIST" runat="server">
                                        <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                            <tr>
                                                <td class="titleCell" colspan="2">
                                                    <table border="0" cellpadding="3" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <Bars:BarsObjectDataSource ID="odsVWcsQuestionListItems" runat="server" DataObjectTypeName="credit.VWcsQuestionListItemsRecord"
                                                                    SelectMethod="SelectQuestionListItemsAll" TypeName="credit.VWcsQuestionListItems">
                                                                    <SelectParameters>
                                                                        <asp:QueryStringParameter Name="QUESTION_ID" Direction="Input" QueryStringField="question_id"
                                                                            Type="String" />
                                                                    </SelectParameters>
                                                                </Bars:BarsObjectDataSource>
                                                                <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsQuestionListItems" DataTextField="DESCR"
                                                                    DataValueField="ORD" Height="150px" Width="200px" AutoPostBack="True" OnDataBound="lb_DataBound"
                                                                    OnSelectedIndexChanged="lb_SelectedIndexChanged"></asp:ListBox>
                                                            </td>
                                                            <td valign="middle" align="center" style="width: 50px">
                                                                <table border="0" cellpadding="3" cellspacing="0">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:ImageButton ID="ibUp" runat="server" ImageUrl="/Common/Images/default/16/arrow_up.png"
                                                                                ToolTip="Переместить вверх" CausesValidation="False" OnClick="ibUp_Click" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:ImageButton ID="ibDown" runat="server" ImageUrl="/Common/Images/default/16/arrow_down.png"
                                                                                ToolTip="Переместить вниз" CausesValidation="False" OnClick="ibDown_Click" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:ImageButton ID="idDelete" runat="server" ImageUrl="/Common/Images/default/16/cancel.png"
                                                                                ToolTip="Удалить" CausesValidation="False" OnClick="idDelete_Click" Width="16px"
                                                                                Height="16px" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:ImageButton ID="ibNew" runat="server" ImageUrl="/Common/Images/default/16/new.png"
                                                                                ToolTip="Добавить новый" OnClick="ibNew_Click" CausesValidation="False" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td valign="top">
                                                                <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" Height="150px"
                                                                    Width="300px" HorizontalAlign="Left">
                                                                    <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 100%">
                                                                        <tr>
                                                                            <td class="titleCell" style="width: 20%">
                                                                                <asp:Label ID="ORDTitle" runat="server" Text='Порядок :' />
                                                                            </td>
                                                                            <td>
                                                                                <bec:TextBoxNumb ID="ORD" runat="server" MaxLength="38" ReadOnly="true" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="titleCell">
                                                                                <asp:Label ID="TEXTTitle" runat="server" Text='Текст :' />
                                                                            </td>
                                                                            <td>
                                                                                <bec:TextBoxString ID="TEXTTextBox" runat="server" IsRequired="True" MaxLength="255" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="titleCell">
                                                                                <asp:Label ID="VISIBLETitle" runat="server" Text='Отображать :' />
                                                                            </td>
                                                                            <td>
                                                                                <bec:RBLFlag ID="VISIBLE" IsRequired="true" DefaultValue="true" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="actionButtonsContainer" colspan="2" style="text-align: right">
                                                                                <asp:Button ID="btSave" runat="server" Text="Сохранить" OnClick="btSave_Click" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="LIST_SID_DEFAULTTitle" runat="server" Text='Дефолтное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="LIST_SID_DEFAULT" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("LIST_SID_DEFAULT") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="REFER" runat="server">
                                        <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="TAB_IDTitle" runat="server" Text='Идентификатор таблицы справочника :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxNumb ID="TAB_ID" runat="server" IsRequired="True" Value='<%# Bind("TAB_ID") %>'>
                                                    </bec:TextBoxNumb>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="KEY_FIELDTitle" runat="server" Text='Ключевое поле :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxString ID="KEY_FIELD" runat="server" IsRequired="True" Value='<%# Bind("KEY_FIELD") %>'>
                                                    </bec:TextBoxString>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="SEMANTIC_FIELDTitle" runat="server" Text='Поле семантики :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxString ID="SEMANTIC_FIELD" runat="server" Value='<%# Bind("SEMANTIC_FIELD") %>'>
                                                    </bec:TextBoxString>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="SHOW_FIELDSTitle" runat="server" Text='Поля для отображения (перечисление через запятую) :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxString ID="SHOW_FIELDS" runat="server" Value='<%# Bind("SHOW_FIELDS") %>'>
                                                    </bec:TextBoxString>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell" colspan="2">
                                                    <asp:Label ID="WHERE_CLAUSETitle" runat="server" Text='Условие отбора (включая слово where)' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <bec:TextBoxSQLBlock ID="WHERE_CLAUSE" runat="server" MaxLength="4000" Rows="3" TextMode="MultiLine"
                                                        Width="300px" Value='<%# Bind("WHERE_CLAUSE") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="REFER_SID_DEFAULTTitle" runat="server" Text='Дефолтное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="REFER_SID_DEFAULT" runat="server" MaxLength="4000" Rows="1"
                                                        TextMode="MultiLine" Width="300px" Value='<%# Bind("REFER_SID_DEFAULT") %>'>
                                                    </bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="BOOL" runat="server">
                                        <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                            <tr>
                                                <td class="titleCell">
                                                    <asp:Label ID="BOOL_VAL_DEFAULTTitle" runat="server" Text='Дефолтное значение :' />
                                                </td>
                                                <td>
                                                    <bec:TextBoxSQLBlock ID="BOOL_VAL_DEFAULT" runat="server" MaxLength="4000" Rows="1"
                                                         Width="300px" Value='<%# Bind("BOOL_VAL_DEFAULT") %>'></bec:TextBoxSQLBlock>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:View>
                                    <asp:View ID="XML" runat="server">
                                    </asp:View>
                                </asp:MultiView>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Update" ImageUrl="/Common/Images/default/16/save.png"
                                Text="Сохранить" ToolTip="Сохранить" meta:resourcekey="ibUpdateResource1" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" meta:resourcekey="ibCancelResource1" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
            <InsertItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="ID" runat="server" IsRequired="True" Value='<%# Bind("ID") %>'
                                MaxLength="100"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("NAME") %>'
                                MaxLength="255" Width="300px"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" />
                        </td>
                        <td>
                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsQuestionTypes"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("TYPE_ID") %>'
                                IsRequired="true">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IS_CALCABLERBLFlagTitle" runat="server" Text='Вычисляется :' />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_CALCABLE" IsRequired="true" DefaultValue="false" runat="server"
                                Value='<%# Bind("IS_CALCABLE") %>' OnValueChanged="ValueChanged" OnPreRender="IS_CALCABLE_PreRender" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <bec:TextBoxSQLBlock ID="CALC_PROCTextBox" Value='<%# Bind("CALC_PROC") %>' IsRequired="true"
                                Rows="3" TextMode="MultiLine" Width="300px" runat="server" ToolTip="Текст вычисления" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Insert" ImageUrl="/Common/Images/default/16/save.png"
                                ToolTip="Добавить" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" SkinID="ibCancel"
                                OnClientClick="CloseDialog(null);" ToolTip="Отмена" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>
