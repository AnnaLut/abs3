<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssurveygroupquestions.aspx.cs"
    Inherits="credit_constructor_wcssurveygroupquestions" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title='Вопросы анкеты "{0}" групы "{1}"' Trace="false" MaintainScrollPositionOnPostback="true" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxSQLBlock.ascx" TagName="TextBoxSQLBlock" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxQuestion_ID.ascx" TagName="TextBoxQuestion_ID"
    TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <Bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectSurveyGroupQuestions"
            TypeName="credit.VWcsSurveyGroupQuestions" SortParameterName="SortExpression">
            <SelectParameters>
                <asp:QueryStringParameter Name="SURVEY_ID" QueryStringField="survey_id" Type="String" />
                <asp:QueryStringParameter Name="GROUP_ID" QueryStringField="group_id" Type="String" />
            </SelectParameters>
        </Bars:BarsObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="QUESTION_ID" AutoSelectFirstRow="True"
            JavascriptSelectionType="ServerSelect" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" AllowSorting="true"
            OnRowDataBound="gv_RowDataBound">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="QUESTION_ID" HeaderText="Идентификатор" SortExpression="QUESTION_ID" />
                <asp:BoundField DataField="QUESTION_NAME" HeaderText="Наименование" SortExpression="QUESTION_NAME" />
                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsSurveyGroupQuestionsRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectSurveyGroupQuestion"
            TypeName="credit.VWcsSurveyGroupQuestions" UpdateMethod="Update">
            <SelectParameters>
                <asp:QueryStringParameter Name="SURVEY_ID" QueryStringField="survey_id" Type="String" />
                <asp:QueryStringParameter Name="GROUP_ID" QueryStringField="group_id" Type="String" />
                <asp:ControlParameter ControlID="gv" Name="QUESTION_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsWcsSurveyGroupRectypes" runat="server" SelectMethod="Select"
            TypeName="credit.WcsSurveyGroupRectypes"></asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="SURVEY_ID,GROUP_ID,QUESTION_ID"
            DataSourceID="odsFV" OnItemDeleted="fv_ItemDeleted" OnItemInserted="fv_ItemInserted"
            OnItemUpdated="fv_ItemUpdated" CssClass="formView" EnableModelValidation="True"
            OnItemInserting="fv_ItemInserting" OnItemCommand="fv_ItemCommand">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="RECTYPE_IDTitle" runat="server" Text='Тип записи :' />
                        </td>
                        <td>
                            <asp:DropDownList ID="RECTYPE_ID" runat="server" DataSourceID="odsWcsSurveyGroupRectypes"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("RECTYPE_ID") %>'
                                Enabled="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="QUESTION_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <bec:TextBoxQuestion_ID ID="QUESTION_ID" IsRequired="true" runat="server" QUESTION_ID='<%# Bind("QUESTION_ID") %>'
                                TYPES='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  "TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL" : "SECTION" %>'
                                SECTIONS='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  "inc:AUTHS,SURVEYS" : "inc:SURVEYS" %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="QUESTION_NAMETitle" runat="server" Text='Наименование :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="QUESTION_NAME" runat="server" Enabled="false" Value='<%# Bind("QUESTION_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TYPE_NAMETitle" runat="server" Text='Тип :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="TYPE_NAME" runat="server" Enabled="false" Value='<%# Bind("TYPE_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="DNSHOW_IFTitle" runat="server" Text='Не показывать если :' />
                        </td>
                        <td>
                            <bec:TextBoxSQLBlock ID="DNSHOW_IF" IsRequired="false" Rows="2" TextMode="MultiLine"
                                Width="300px" runat="server" Value='<%# Bind("DNSHOW_IF") %>' TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL"
                                SECTIONS="inc:AUTHS,SURVEYS" Enabled='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  true : false %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IS_REQUIREDTitle" runat="server" Text='Обязательный :' />
                        </td>
                        <td>
                            <bec:TextBoxSQLBlock ID="IS_REQUIRED" runat="server" Value='<%# Bind("IS_REQUIRED") %>'
                                SECTIONS="inc:AUTHS,SURVEYS" Enabled='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  true : false %>'
                                Width="200"></bec:TextBoxSQLBlock>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IS_READONLYTitle" runat="server" Text='Только чтение:' />
                        </td>
                        <td>
                            <bec:TextBoxSQLBlock ID="IS_READONLY" runat="server" Value='<%# Bind("IS_READONLY") %>'
                                SECTIONS="inc:AUTHS,SURVEYS" Enabled='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  true : false %>'
                                Width="200"></bec:TextBoxSQLBlock>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IS_REWRITABLETitle" runat="server" Text='Возможность перезаписи :' />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_REWRITABLE" IsRequired="true" DefaultValue="true" runat="server"
                                Value='<%# Bind("IS_REWRITABLE") %>' Enabled='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  true : false %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IS_CHECKABLETitle" runat="server" Text='Проверяется :' />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_CHECKABLE" IsRequired="true" DefaultValue="false" runat="server"
                                Value='<%# Bind("IS_CHECKABLE") %>' OnValueChanged="ValueChanged" OnPreRender="IS_CALCABLE_PreRender"
                                Enabled='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  true : false %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="CHECK_PROCTitle" runat="server" Text='Текст проверки :' />
                        </td>
                        <td>
                            <bec:TextBoxSQLBlock ID="CHECK_PROC" runat="server" Rows="5" TextMode="MultiLine"
                                Width="350px" Value='<%# Bind("CHECK_PROC") %>' TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL"
                                SECTIONS="inc:AUTHS,SURVEYS" Enabled='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  true : false %>'>
                            </bec:TextBoxSQLBlock>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Update" ImageUrl="/Common/Images/default/16/save.png"
                                Text="Сохранить" ToolTip="Сохранить" meta:resourcekey="ibUpdateResource1" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" meta:resourcekey="ibCancelResource1" />
                            <asp:ImageButton ID="ibUp" runat="server" ImageUrl="/Common/Images/default/16/arrow_up.png"
                                ToolTip="Переместить вверх" CausesValidation="False" CommandName="MoveUp" />
                            <asp:ImageButton ID="ibDown" runat="server" ImageUrl="/Common/Images/default/16/arrow_down.png"
                                ToolTip="Переместить вниз" CausesValidation="False" CommandName="MoveDown" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
            <InsertItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <colgroup>
                        <col class="titleCell" />
                        <tr>
                            <td>
                                <asp:Label ID="RECTYPE_IDTitle" runat="server" Text="Тип записи :" />
                            </td>
                            <td>
                                <asp:DropDownList ID="RECTYPE_ID" runat="server" AutoPostBack="True" DataSourceID="odsWcsSurveyGroupRectypes"
                                    DataTextField="NAME" DataValueField="ID" OnDataBound="RECTYPE_ID_DataBound" OnSelectedIndexChanged="RECTYPE_ID_SelectedIndexChanged"
                                    SelectedValue='<%# Bind("RECTYPE_ID") %>'>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="QUESTION_IDTitle" runat="server" Text="Идентификатор :" />
                            </td>
                            <td>
                                <bec:TextBoxQuestion_ID ID="QUESTION_ID" runat="server" IsRequired="true" QUESTION_ID='<%# Bind("QUESTION_ID") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="DNSHOW_IFTitle" runat="server" Text="Не показывать если :" />
                            </td>
                            <td>
                                <bec:TextBoxSQLBlock ID="DNSHOW_IF" runat="server" IsRequired="false" Rows="2" SECTIONS="inc:AUTHS,SURVEYS"
                                    TextMode="MultiLine" TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL" Value='<%# Bind("DNSHOW_IF") %>'
                                    Width="300px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="IS_REQUIREDTitle" runat="server" Text="Обязательный :" />
                            </td>
                            <td>
                                <bec:TextBoxSQLBlock ID="IS_REQUIRED" runat="server" Value='<%# Bind("IS_REQUIRED") %>'
                                    SECTIONS="inc:AUTHS,SURVEYS" Enabled='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  true : false %>'
                                    Width="200"></bec:TextBoxSQLBlock>
                            </td>
                        </tr>
                        <tr>
                            <td class="titleCell">
                                <asp:Label ID="IS_READONLYTitle" runat="server" Text='Только чтение:' />
                            </td>
                            <td>
                                <bec:TextBoxSQLBlock ID="IS_READONLY" runat="server" Value='<%# Bind("IS_READONLY") %>'
                                    SECTIONS="inc:AUTHS,SURVEYS" Enabled='<%# (String)Eval("RECTYPE_ID") == "QUESTION" ?  true : false %>'
                                    Width="200"></bec:TextBoxSQLBlock>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="IS_REWRITABLETitle" runat="server" Text="Возможность перезаписи :" />
                            </td>
                            <td>
                                <bec:RBLFlag ID="IS_REWRITABLE" runat="server" DefaultValue="true" IsRequired="true"
                                    Value='<%# Bind("IS_REWRITABLE") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="IS_CHECKABLETitle" runat="server" Text="Проверяется :" />
                            </td>
                            <td>
                                <bec:RBLFlag ID="IS_CHECKABLE" runat="server" DefaultValue="false" IsRequired="true"
                                    OnPreRender="IS_CALCABLE_PreRender" OnValueChanged="ValueChanged" Value='<%# Bind("IS_CHECKABLE") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="CHECK_PROCTitle" runat="server" Text="Текст проверки :" />
                            </td>
                            <td>
                                <bec:TextBoxSQLBlock ID="CHECK_PROC" runat="server" Rows="5" SECTIONS="inc:AUTHS,SURVEYS"
                                    TextMode="MultiLine" TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL" Value='<%# Bind("CHECK_PROC") %>'
                                    Width="350px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="actionButtonsContainer" colspan="2">
                                <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Insert" ImageUrl="/Common/Images/default/16/save.png"
                                    meta:resourcekey="ibUpdateResource2" Text="Добавить" ToolTip="Добавить" />
                                <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                    meta:resourcekey="ibCancelResource2" SkinID="ibCancel" />
                            </td>
                        </tr>
                    </colgroup>
                </table>
            </InsertItemTemplate>
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <colgroup>
                        <col class="titleCell">
                            <tr>
                                <td>
                                    <asp:Label ID="RECTYPE_IDTitle" runat="server" Text="Тип записи :" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="RECTYPE_ID" runat="server" DataSourceID="odsWcsSurveyGroupRectypes"
                                        DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("RECTYPE_ID") %>'
                                        Enabled="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="QUESTION_IDTitle" runat="server" Text="Идентификатор :" />
                                </td>
                                <td>
                                    <bec:TextBoxQuestion_ID ID="QUESTION_ID" runat="server" IsRequired="true" QUESTION_ID='<%# Bind("QUESTION_ID") %>'
                                        ReadOnly="true" SECTIONS="inc:AUTHS,SURVEYS" TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="QUESTION_NAMETitle" runat="server" Text="Наименование :" />
                                </td>
                                <td>
                                    <bec:TextBoxString ID="QUESTION_NAME" runat="server" Enabled="false" Value='<%# Bind("QUESTION_NAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="TYPE_NAMETitle" runat="server" Text="Тип :" />
                                </td>
                                <td>
                                    <bec:TextBoxString ID="TYPE_NAME" runat="server" Enabled="false" Value='<%# Bind("TYPE_NAME") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="DNSHOW_IFTitle" runat="server" Text="Не показывать если :" />
                                </td>
                                <td>
                                    <bec:TextBoxSQLBlock ID="DNSHOW_IF" runat="server" Enabled="false" IsRequired="false"
                                        Rows="2" SECTIONS="inc:AUTHS,SURVEYS" TextMode="MultiLine" TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL"
                                        Value='<%# Bind("DNSHOW_IF") %>' Width="300px" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="IS_REQUIREDTitle" runat="server" Text="Обязательный :" />
                                </td>
                                <td>
                                    <bec:TextBoxSQLBlock ID="IS_REQUIRED" runat="server" Value='<%# Bind("IS_REQUIRED") %>'
                                        SECTIONS="inc:AUTHS,SURVEYS" Enabled="false" Width="200"></bec:TextBoxSQLBlock>
                                </td>
                            </tr>
                            <tr>
                                <td class="titleCell">
                                    <asp:Label ID="IS_READONLYTitle" runat="server" Text='Только чтение:' />
                                </td>
                                <td>
                                    <bec:TextBoxSQLBlock ID="IS_READONLY" runat="server" Value='<%# Bind("IS_READONLY") %>'
                                        SECTIONS="inc:AUTHS,SURVEYS" Enabled="false" Width="200"></bec:TextBoxSQLBlock>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="IS_REWRITABLETitle" runat="server" Text="Возможность перезаписи :" />
                                </td>
                                <td>
                                    <bec:RBLFlag ID="IS_REWRITABLE" runat="server" DefaultValue="false" Enabled="false"
                                        IsRequired="true" Value='<%# Bind("IS_REWRITABLE") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="IS_CHECKABLETitle" runat="server" Text="Проверяется :" />
                                </td>
                                <td>
                                    <bec:RBLFlag ID="IS_CHECKABLE" runat="server" DefaultValue="false" Enabled="false"
                                        IsRequired="true" Value='<%# Bind("IS_CHECKABLE") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="CHECK_PROCTitle" runat="server" Text="Текст проверки :" />
                                </td>
                                <td>
                                    <bec:TextBoxSQLBlock ID="CHECK_PROC" runat="server" Enabled="false" Rows="5" SECTIONS="inc:AUTHS,SURVEYS"
                                        TextMode="MultiLine" TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL" Value='<%# Bind("CHECK_PROC") %>'
                                        Width="350px" />
                                </td>
                            </tr>
                            <tr>
                                <td class="actionButtonsContainer" colspan="2">
                                    <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                        ImageUrl="/Common/Images/default/16/open.png" meta:resourcekey="ibEditResource1"
                                        Text="Редактировать" ToolTip="Редактировать" />
                                    <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                        OnClientClick="return confirm('Удалить строку?');" SkinID="ibDelete" />
                                    <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                        ImageUrl="/Common/Images/default/16/new.png" meta:resourcekey="ibNewResource2"
                                        Text="Добавить строку" ToolTip="Добавить строку" />
                                </td>
                            </tr>
                        </col>
                    </colgroup>
                </table>
            </ItemTemplate>
            <EmptyDataTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                ImageUrl="/Common/Images/default/16/new.png" Text="Добавить строку" ToolTip="Добавить строку"
                                meta:resourcekey="ibNewResource1" />
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
        </asp:FormView>
    </div>
</asp:Content>
