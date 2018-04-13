<%@ Page MaintainScrollPositionOnPostback="true" Language="C#" AutoEventWireup="true"
    CodeFile="wcsscoringballs.aspx.cs" Inherits="credit_constructor_wcsscoringballs"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Скоринговые баллы"
    Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <Bars:BarsObjectDataSource ID="odsWcsSignTypesMin" runat="server" SelectMethod="SelectWcsSignTypesMin"
            TypeName="credit.WcsSignTypes">
        </Bars:BarsObjectDataSource>
        <asp:MultiView ID="mvTypes" runat="server">
            <asp:View ID="NUMB" runat="server">
                <div class="dataContainer">
                    <asp:ObjectDataSource ID="odsVWcsScoringQsNumb" runat="server" SelectMethod="SelectScoringQsNumb"
                        TypeName="credit.VWcsScoringQsNumb" SortParameterName="SortExpression">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx ID="gvVWcsScoringQsNumb" runat="server" AutoGenerateColumns="False"
                        CaptionText="" ClearFilterImageUrl="/common/images/default/16/filter_delete.png"
                        CssClass="barsGridView" DataSourceID="odsVWcsScoringQsNumb" DateMask="dd.MM.yyyy"
                        ExcelImageUrl="/common/images/default/16/export_excel.png" FilterImageUrl="/common/images/default/16/filter.png"
                        MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png"
                        ShowFooter="True" ShowPageSizeBox="False" DataKeyNames="ORD" AutoSelectFirstRow="true"
                        JavascriptSelectionType="ServerSelect" AllowSorting="true">
                        <FooterStyle CssClass="footerRow" />
                        <HeaderStyle CssClass="headerRow" />
                        <EditRowStyle CssClass="editRow" />
                        <PagerStyle CssClass="pagerRow" />
                        <NewRowStyle CssClass="" />
                        <SelectedRowStyle CssClass="selectedRow" />
                        <AlternatingRowStyle CssClass="alternateRow" />
                        <Columns>
                            <asp:BoundField DataField="MIN_VAL" HeaderText="Мин." SortExpression="MIN_VAL" />
                            <asp:BoundField DataField="MIN_SIGN_SIGN" HeaderText="Знак мин." SortExpression="MIN_SIGN" />
                            <asp:BoundField DataField="MAX_SIGN_SIGN" HeaderText="Знак макс." SortExpression="MAX_SIGN" />
                            <asp:BoundField DataField="MAX_VAL" HeaderText="Макс." SortExpression="MAX_VAL" />
                            <asp:BoundField DataField="SCORE" HeaderText="Баллы" SortExpression="SCORE" />
                        </Columns>
                        <RowStyle CssClass="normalRow" />
                    </Bars:BarsGridViewEx>
                </div>
                <div class="formViewContainer">
                    <asp:ObjectDataSource ID="odsVWcsScoringQsNumbFV" runat="server" SelectMethod="SelectScoringQNumb"
                        TypeName="credit.VWcsScoringQsNumb" DataObjectTypeName="credit.VWcsScoringQsNumbRecord"
                        DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                            <asp:ControlParameter ControlID="gvVWcsScoringQsNumb" Name="ORD" PropertyName="SelectedValue"
                                Size="100" Type="Decimal" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                            <asp:ControlParameter ControlID="gvVWcsScoringQsNumb" Name="ORD" PropertyName="SelectedValue"
                                Size="100" Type="Decimal" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                    <asp:FormView ID="fvWcsScoringQsNumb" runat="server" DataSourceID="odsVWcsScoringQsNumbFV"
                        DataKeyNames="SCORING_ID,QUESTION_ID,ORD" OnItemDeleted="fvWcsScoringQsNumb_ItemDeleted"
                        OnItemInserted="fvWcsScoringQsNumb_ItemInserted" OnItemUpdated="fvWcsScoringQsNumb_ItemUpdated"
                        OnItemInserting="fvWcsScoringQsNumb_ItemInserting">
                        <EditItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="MIN_VALTitle" runat="server" Text='Минимум :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxNumb ID="MIN_VAL" runat="server" IsRequired="true" Value='<%# Bind("MIN_VAL") %>'>
                                        </bec:TextBoxNumb>
                                        <bec:DDLList ID="MIN_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MIN_SIGN") %>'>
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MAX_VALTitle" runat="server" Text='Максимум :' />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="MAX_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MAX_SIGN") %>'>
                                        </bec:DDLList>
                                        <bec:TextBoxNumb ID="MAX_VAL" runat="server" IsRequired="true" Value='<%# Bind("MAX_VAL") %>'>
                                        </bec:TextBoxNumb>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SCORETitle" runat="server" Text='Баллы :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                            MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="/Common/Images/default/16/save.png" Text="Сохранить" ToolTip="Сохранить" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            SkinID="ibCancel" />
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="MIN_VALTitle" runat="server" Text='Минимум :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxNumb ID="MIN_VAL" runat="server" IsRequired="true" Value='<%# Bind("MIN_VAL") %>'>
                                        </bec:TextBoxNumb>
                                        <bec:DDLList ID="MIN_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MIN_SIGN") %>'>
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MAX_VALTitle" runat="server" Text='Максимум :' />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="MAX_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MAX_SIGN") %>'>
                                        </bec:DDLList>
                                        <bec:TextBoxNumb ID="MAX_VAL" runat="server" IsRequired="true" Value='<%# Bind("MAX_VAL") %>'>
                                        </bec:TextBoxNumb>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SCORETitle" runat="server" Text='Баллы :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                            MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" CommandName="Insert"
                                            ImageUrl="/Common/Images/default/16/save.png" Text="Добавить" ToolTip="Добавить" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            SkinID="ibCancel" />
                                    </td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="MIN_VALTitle" runat="server" Text='Минимум :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxNumb ID="MIN_VAL" runat="server" IsRequired="true" Value='<%# Bind("MIN_VAL") %>'
                                            Enabled="false"></bec:TextBoxNumb>
                                        <bec:DDLList ID="MIN_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MIN_SIGN") %>'
                                            Enabled="false">
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MAX_VALTitle" runat="server" Text='Максимум :' />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="MAX_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MAX_SIGN") %>'
                                            Enabled="false">
                                        </bec:DDLList>
                                        <bec:TextBoxNumb ID="MAX_VAL" runat="server" IsRequired="true" Value='<%# Bind("MAX_VAL") %>'
                                            Enabled="false"></bec:TextBoxNumb>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SCORETitle" runat="server" Text='Баллы :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                            Enabled="false" MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать" />
                                        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                            SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" />
                                        <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                            ImageUrl="/Common/Images/default/16/new.png" Text="Создать новый отрезок" ToolTip="Создать новый отрезок" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                            ImageUrl="/Common/Images/default/16/new.png" Text="Создать новый отрезок" ToolTip="Создать новый отрезок" />
                                    </td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                    </asp:FormView>
                </div>
            </asp:View>
            <asp:View ID="DECIMAL" runat="server">
                <div class="dataContainer">
                    <asp:ObjectDataSource ID="odsVWcsScoringQsDecimal" runat="server" SelectMethod="SelectScoringQsDecimal"
                        TypeName="credit.VWcsScoringQsDecimal" SortParameterName="SortExpression">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx ID="gvVWcsScoringQsDecimal" runat="server" AutoGenerateColumns="False"
                        CaptionText="" ClearFilterImageUrl="/common/images/default/16/filter_delete.png"
                        CssClass="barsGridView" DataSourceID="odsVWcsScoringQsDecimal" DateMask="dd.MM.yyyy"
                        ExcelImageUrl="/common/images/default/16/export_excel.png" FilterImageUrl="/common/images/default/16/filter.png"
                        MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png"
                        ShowFooter="True" ShowPageSizeBox="False" DataKeyNames="ORD" AutoSelectFirstRow="true"
                        JavascriptSelectionType="ServerSelect" AllowSorting="true">
                        <FooterStyle CssClass="footerRow" />
                        <HeaderStyle CssClass="headerRow" />
                        <EditRowStyle CssClass="editRow" />
                        <PagerStyle CssClass="pagerRow" />
                        <NewRowStyle CssClass="" />
                        <SelectedRowStyle CssClass="selectedRow" />
                        <AlternatingRowStyle CssClass="alternateRow" />
                        <Columns>
                            <asp:BoundField DataField="MIN_VAL" HeaderText="Мин." SortExpression="MIN_VAL" />
                            <asp:BoundField DataField="MIN_SIGN_SIGN" HeaderText="Знак мин." SortExpression="MIN_SIGN" />
                            <asp:BoundField DataField="MAX_SIGN_SIGN" HeaderText="Знак макс." SortExpression="MAX_SIGN" />
                            <asp:BoundField DataField="MAX_VAL" HeaderText="Макс." SortExpression="MAX_VAL" />
                            <asp:BoundField DataField="SCORE" HeaderText="Баллы" SortExpression="SCORE" />
                        </Columns>
                        <RowStyle CssClass="normalRow" />
                    </Bars:BarsGridViewEx>
                </div>
                <div class="formViewContainer">
                    <asp:ObjectDataSource ID="odsVWcsScoringQsDecimalFV" runat="server" SelectMethod="SelectScoringQDecimal"
                        TypeName="credit.VWcsScoringQsDecimal" DataObjectTypeName="credit.VWcsScoringQsDecimalRecord"
                        DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                            <asp:ControlParameter ControlID="gvVWcsScoringQsDecimal" Name="ORD" PropertyName="SelectedValue"
                                Size="100" Type="Decimal" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                            <asp:ControlParameter ControlID="gvVWcsScoringQsDecimal" Name="ORD" PropertyName="SelectedValue"
                                Size="100" Type="Decimal" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                    <asp:FormView ID="fvWcsScoringQsDecimal" runat="server" DataSourceID="odsVWcsScoringQsDecimalFV"
                        DataKeyNames="SCORING_ID,QUESTION_ID,ORD" OnItemDeleted="fvWcsScoringQsDecimal_ItemDeleted"
                        OnItemInserted="fvWcsScoringQsDecimal_ItemInserted" OnItemUpdated="fvWcsScoringQsDecimal_ItemUpdated"
                        OnItemInserting="fvWcsScoringQsDecimal_ItemInserting">
                        <EditItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="MIN_VALTitle" runat="server" Text='Минимум :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="MIN_VAL" runat="server" IsRequired="true" Value='<%# Bind("MIN_VAL") %>'>
                                        </bec:TextBoxDecimal>
                                        <bec:DDLList ID="MIN_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MIN_SIGN") %>'>
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MAX_VALTitle" runat="server" Text='Максимум :' />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="MAX_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MAX_SIGN") %>'>
                                        </bec:DDLList>
                                        <bec:TextBoxDecimal ID="MAX_VAL" runat="server" IsRequired="true" Value='<%# Bind("MAX_VAL") %>'>
                                        </bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SCORETitle" runat="server" Text='Баллы :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                            MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="/Common/Images/default/16/save.png" Text="Сохранить" ToolTip="Сохранить" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            SkinID="ibCancel" />
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="MIN_VALTitle" runat="server" Text='Минимум :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="MIN_VAL" runat="server" IsRequired="true" Value='<%# Bind("MIN_VAL") %>'>
                                        </bec:TextBoxDecimal>
                                        <bec:DDLList ID="MIN_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MIN_SIGN") %>'>
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MAX_VALTitle" runat="server" Text='Максимум :' />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="MAX_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MAX_SIGN") %>'>
                                        </bec:DDLList>
                                        <bec:TextBoxDecimal ID="MAX_VAL" runat="server" IsRequired="true" Value='<%# Bind("MAX_VAL") %>'>
                                        </bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SCORETitle" runat="server" Text='Баллы :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                            MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" CommandName="Insert"
                                            ImageUrl="/Common/Images/default/16/save.png" Text="Добавить" ToolTip="Добавить" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            SkinID="ibCancel" />
                                    </td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="MIN_VALTitle" runat="server" Text='Минимум :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="MIN_VAL" runat="server" IsRequired="true" Value='<%# Bind("MIN_VAL") %>'
                                            Enabled="false"></bec:TextBoxDecimal>
                                        <bec:DDLList ID="MIN_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MIN_SIGN") %>'
                                            Enabled="false">
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MAX_VALTitle" runat="server" Text='Максимум :' />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="MAX_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MAX_SIGN") %>'
                                            Enabled="false">
                                        </bec:DDLList>
                                        <bec:TextBoxDecimal ID="MAX_VAL" runat="server" IsRequired="true" Value='<%# Bind("MAX_VAL") %>'
                                            Enabled="false"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SCORETitle" runat="server" Text='Баллы :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                            Enabled="false" MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать" />
                                        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                            SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" />
                                        <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                            ImageUrl="/Common/Images/default/16/new.png" Text="Создать новый отрезок" ToolTip="Создать новый отрезок" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                            ImageUrl="/Common/Images/default/16/new.png" Text="Создать новый отрезок" ToolTip="Создать новый отрезок" />
                                    </td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                    </asp:FormView>
                </div>
            </asp:View>
            <asp:View ID="DATE" runat="server">
                <div class="dataContainer">
                    <asp:ObjectDataSource ID="odsVWcsScoringQsDate" runat="server" SelectMethod="SelectScoringQsDate"
                        TypeName="credit.VWcsScoringQsDate" SortParameterName="SortExpression">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx ID="gvVWcsScoringQsDate" runat="server" AutoGenerateColumns="False"
                        CaptionText="" ClearFilterImageUrl="/common/images/default/16/filter_delete.png"
                        CssClass="barsGridView" DataSourceID="odsVWcsScoringQsDate" DateMask="dd.MM.yyyy"
                        ExcelImageUrl="/common/images/default/16/export_excel.png" FilterImageUrl="/common/images/default/16/filter.png"
                        MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png"
                        ShowFooter="True" ShowPageSizeBox="False" DataKeyNames="ORD" AutoSelectFirstRow="true"
                        JavascriptSelectionType="ServerSelect" AllowSorting="true">
                        <FooterStyle CssClass="footerRow" />
                        <HeaderStyle CssClass="headerRow" />
                        <EditRowStyle CssClass="editRow" />
                        <PagerStyle CssClass="pagerRow" />
                        <NewRowStyle CssClass="" />
                        <SelectedRowStyle CssClass="selectedRow" />
                        <AlternatingRowStyle CssClass="alternateRow" />
                        <Columns>
                            <asp:BoundField DataField="MIN_VAL" HeaderText="Мин." SortExpression="MIN_VAL" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="MIN_SIGN_SIGN" HeaderText="Знак мин." SortExpression="MIN_SIGN" />
                            <asp:BoundField DataField="MAX_SIGN_SIGN" HeaderText="Знак макс." SortExpression="MAX_SIGN" />
                            <asp:BoundField DataField="MAX_VAL" HeaderText="Макс." SortExpression="MAX_VAL" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="SCORE" HeaderText="Баллы" SortExpression="SCORE" />
                        </Columns>
                        <RowStyle CssClass="normalRow" />
                    </Bars:BarsGridViewEx>
                </div>
                <div class="formViewContainer">
                    <asp:ObjectDataSource ID="odsVWcsScoringQsDateFV" runat="server" SelectMethod="SelectScoringQDate"
                        TypeName="credit.VWcsScoringQsDate" DataObjectTypeName="credit.VWcsScoringQsDateRecord"
                        DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                            <asp:ControlParameter ControlID="gvVWcsScoringQsDate" Name="ORD" PropertyName="SelectedValue"
                                Size="100" Type="Decimal" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                            <asp:ControlParameter ControlID="gvVWcsScoringQsDate" Name="ORD" PropertyName="SelectedValue"
                                Size="100" Type="Decimal" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                    <asp:FormView ID="fvWcsScoringQsDate" runat="server" DataSourceID="odsVWcsScoringQsDateFV"
                        DataKeyNames="SCORING_ID,QUESTION_ID,ORD" OnItemDeleted="fvWcsScoringQsDate_ItemDeleted"
                        OnItemInserted="fvWcsScoringQsDate_ItemInserted" OnItemUpdated="fvWcsScoringQsDate_ItemUpdated"
                        OnItemInserting="fvWcsScoringQsDate_ItemInserting">
                        <EditItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="MIN_VALTitle" runat="server" Text='Минимум :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDate ID="MIN_VAL" runat="server" IsRequired="true" Value='<%# Bind("MIN_VAL") %>'>
                                        </bec:TextBoxDate>
                                        <bec:DDLList ID="MIN_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MIN_SIGN") %>'>
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MAX_VALTitle" runat="server" Text='Максимум :' />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="MAX_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MAX_SIGN") %>'>
                                        </bec:DDLList>
                                        <bec:TextBoxDate ID="MAX_VAL" runat="server" IsRequired="true" Value='<%# Bind("MAX_VAL") %>'>
                                        </bec:TextBoxDate>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SCORETitle" runat="server" Text='Баллы :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                            MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="/Common/Images/default/16/save.png" Text="Сохранить" ToolTip="Сохранить" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            SkinID="ibCancel" />
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="MIN_VALTitle" runat="server" Text='Минимум :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDate ID="MIN_VAL" runat="server" IsRequired="true" Value='<%# Bind("MIN_VAL") %>'>
                                        </bec:TextBoxDate>
                                        <bec:DDLList ID="MIN_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MIN_SIGN") %>'>
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MAX_VALTitle" runat="server" Text='Максимум :' />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="MAX_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MAX_SIGN") %>'>
                                        </bec:DDLList>
                                        <bec:TextBoxDate ID="MAX_VAL" runat="server" IsRequired="true" Value='<%# Bind("MAX_VAL") %>'>
                                        </bec:TextBoxDate>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SCORETitle" runat="server" Text='Баллы :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                            MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" CommandName="Insert"
                                            ImageUrl="/Common/Images/default/16/save.png" Text="Добавить" ToolTip="Добавить" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            SkinID="ibCancel" />
                                    </td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="MIN_VALTitle" runat="server" Text='Минимум :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDate ID="MIN_VAL" runat="server" IsRequired="true" Value='<%# Bind("MIN_VAL") %>'
                                            Enabled="false"></bec:TextBoxDate>
                                        <bec:DDLList ID="MIN_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MIN_SIGN") %>'
                                            Enabled="false">
                                        </bec:DDLList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="MAX_VALTitle" runat="server" Text='Максимум :' />
                                    </td>
                                    <td>
                                        <bec:DDLList ID="MAX_SIGN" runat="server" IsRequired="true" DataSourceID="odsWcsSignTypesMin"
                                            DataTextField="SIGN" DataValueField="ID" SelectedValue='<%# Bind("MAX_SIGN") %>'
                                            Enabled="false">
                                        </bec:DDLList>
                                        <bec:TextBoxDate ID="MAX_VAL" runat="server" IsRequired="true" Value='<%# Bind("MAX_VAL") %>'
                                            Enabled="false"></bec:TextBoxDate>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="SCORETitle" runat="server" Text='Баллы :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                            Enabled="false" MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать" />
                                        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                            SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" />
                                        <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                            ImageUrl="/Common/Images/default/16/new.png" Text="Создать новый отрезок" ToolTip="Создать новый отрезок" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                            ImageUrl="/Common/Images/default/16/new.png" Text="Создать новый отрезок" ToolTip="Создать новый отрезок" />
                                    </td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                    </asp:FormView>
                </div>
            </asp:View>
            <asp:View ID="LIST" runat="server">
                <div class="dataContainer">
                    <asp:ObjectDataSource ID="odsVWcsScoringQsList" runat="server" SelectMethod="SelectScoringQsList"
                        UpdateMethod="Update" DeleteMethod="Delete" TypeName="credit.VWcsScoringQsList"
                        DataObjectTypeName="credit.VWcsScoringQsListRecord" SortParameterName="SortExpression">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx ID="gvVWcsScoringQsList" runat="server" AutoGenerateColumns="False"
                        CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                        CssClass="barsGridView" DataSourceID="odsVWcsScoringQsList" DateMask="dd.MM.yyyy"
                        ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                        FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                        MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                        MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                        ShowFooter="True" ShowPageSizeBox="False" DataKeyNames="SCORING_ID,QUESTION_ID,ORD"
                        AllowSorting="True" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                        EnableModelValidation="True" HoverRowCssClass="hoverRow" ShowExportExcelButton="True">
                        <FooterStyle CssClass="footerRow" />
                        <HeaderStyle CssClass="headerRow" />
                        <EditRowStyle CssClass="editRow" />
                        <PagerStyle CssClass="pagerRow" />
                        <NewRowStyle CssClass="" />
                        <SelectedRowStyle CssClass="selectedRow" />
                        <NewRowStyle CssClass="" />
                        <NewRowStyle CssClass="" />
                        <AlternatingRowStyle CssClass="alternateRow" />
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" EditImageUrl="/Common/Images/default/16/open.png"
                                EditText="Редактировать" DeleteImageUrl="/Common/Images/default/16/delete.png"
                                DeleteText="Удалить" UpdateImageUrl="/Common/Images/default/16/save.png" UpdateText="Сохранить"
                                CancelImageUrl="/Common/Images/default/16/cancel_1.png" CancelText="Отмена" ButtonType="Image">
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:CommandField>
                            <asp:BoundField DataField="ORD" HeaderText="№" SortExpression="ORD" ReadOnly="True">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TEXT" HeaderText="Текст" SortExpression="TEXT" ReadOnly="True" />
                            <asp:TemplateField HeaderText="Баллы" SortExpression="SCORE">
                                <EditItemTemplate>
                                    <bec:TextBoxDecimal ID="SCORE" runat="server" IsRequired="true" Value='<%# Bind("SCORE") %>'
                                        MinValue="-10000" Width="75px"></bec:TextBoxDecimal>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="SCORE" runat="server" Text='<%# Bind("SCORE") %>' />
                                </ItemTemplate>
                                <ItemStyle Width="75px" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="normalRow" />
                    </Bars:BarsGridViewEx>
                </div>
            </asp:View>
            <asp:View ID="BOOL" runat="server">
                <div class="dataContainer">
                    <asp:ObjectDataSource ID="odsVWcsScoringQsBool" runat="server" SelectMethod="SelectScoringQsBool"
                        TypeName="credit.VWcsScoringQsBool" DataObjectTypeName="credit.VWcsScoringQsBoolRecord"
                        DeleteMethod="Delete" UpdateMethod="Update">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="SCORING_ID" QueryStringField="scoring_id" Size="100"
                                Type="String" />
                            <asp:QueryStringParameter Name="QUESTION_ID" QueryStringField="question_id" Size="100"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:FormView ID="fvVWcsScoringQsBool" runat="server" DataSourceID="odsVWcsScoringQsBool"
                        DataKeyNames="SCORING_ID,QUESTION_ID">
                        <EditItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="SCORE_IF_0Title" runat="server" Text='Баллы если ответ "Нет" :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE_IF_0TextBox" runat="server" IsRequired="true" Value='<%# Bind("SCORE_IF_0") %>' MinValue="-10000">
                                        </bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="SCORE_IF_1Title" runat="server" Text='Баллы если ответ "Да" :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE_IF_1TextBox" runat="server" IsRequired="true" Value='<%# Bind("SCORE_IF_1") %>' MinValue="-10000">
                                        </bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="/Common/Images/default/16/save.png" Text="Сохранить" ToolTip="Сохранить" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            SkinID="ibCancel" />
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="SCORE_IF_0Title" runat="server" Text='Баллы если ответ "Нет" :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE_IF_0TextBox" runat="server" IsRequired="true" Value='<%# Bind("SCORE_IF_0") %>' Enabled="false">
                                        </bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="titleCell" style="text-align: left">
                                        <asp:Label ID="SCORE_IF_1Title" runat="server" Text='Баллы если ответ "Да" :' />
                                    </td>
                                    <td>
                                        <bec:TextBoxDecimal ID="SCORE_IF_1TextBox" runat="server" IsRequired="true" Value='<%# Bind("SCORE_IF_1") %>' Enabled="false">
                                        </bec:TextBoxDecimal>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="actionButtonsContainer" colspan="2">
                                        <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать" />
                                        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                            SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
