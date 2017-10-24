<%@ Page Title="Перегляд журналів" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="cim_journals_default" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">
    <bars:BarsSqlDataSourceEx runat="server" ID="dsBranches" ProviderName="barsroot.core"
        SelectCommand="select branch, name from branch where branch like sys_context('bars_context', 'user_branch_mask') order by 1">
    </bars:BarsSqlDataSourceEx>

    <bars:BarsSqlDataSourceEx runat="server" ID="dsJournals" ProviderName="barsroot.core"
        SelectCommand="select journal_num, num, num_txt, create_date, rnk, okpo, nmk, benef_id, benef_name, country_id, country_name, contr_id, contr_num, contr_date, control_date, comments, modify_date, delete_date, direct, doc_kind, doc_type, doc_type_name, bound_id, doc_id, val_date, kv_p, s_p, allow_date, kv_v, s_v, vmd_num, file_date, file_name, str_level, del_journal 
                       from v_cim_journal where branch=:branch and journal_num=:journal_num and modify_date between :StartDate and :FinishDate">
        <SelectParameters>
            <asp:ControlParameter ControlID="rblJTypes" Name="journal_num" DbType="Decimal" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="tbStartDate" Name="StartDate" PropertyName="Text" DbType="Date" />
            <asp:ControlParameter ControlID="tbFinishDate" Name="FinishDate" PropertyName="Text" DbType="Date" />
            <asp:SessionParameter SessionField="cim.BranchMask" Name="branch" DbType="String" />
        </SelectParameters>
    </bars:BarsSqlDataSourceEx>
    <table style="width: 100%;">
        <tr>
            <td>
                <table>
                    <tr style="vertical-align: top">
                        <td>
                            <asp:Panel ID="Panel1" runat="server" GroupingText="Тип журналу">
                                <asp:RadioButtonList runat="server" ID="rblJTypes" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rblJTypes_SelectedIndexChanged">
                                    <asp:ListItem Text="Експорт" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Імпорт" Value="2"></asp:ListItem>
                                    <%--<asp:ListItem Text="Послуги" Value="3"></asp:ListItem>--%>
                                    <asp:ListItem Text="Загальний" Value="4" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:Panel>
                        </td>
                        <td>
                            <asp:Panel runat="server" ID="pnBranches" GroupingText="Відділення">
                                <asp:DropDownList runat="server" AutoPostBack="true" DataTextField="NAME" DataValueField="BRANCH" ID="ddJBranch" DataSourceID="dsBranches" OnSelectedIndexChanged="ddJBranch_SelectedIndexChanged"></asp:DropDownList>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel runat="server" ID="pnInterval" GroupingText="Інтервал">
                                <table>
                                    <tr>
                                        <td>&nbsp;з&nbsp;</td>
                                        <td class="nw">
                                            <asp:TextBox runat="server" ID="tbStartDate" Width="80px" CssClass="ctrl-date" MaxLength="10"></asp:TextBox></td>
                                        <td>&nbsp;по&nbsp;
                                        </td>
                                        <td class="nw">
                                            <asp:TextBox runat="server" ID="tbFinishDate" Width="80px" CssClass="ctrl-date" MaxLength="10"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btRefresh" runat="server" OnClick="btRefresh_Click" Text="Перечитати" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td>
                            <fieldset style="margin-top: -10px">
                                <legend id="dvInfo"></legend>
                                <div class="ctrl-btn-block">
                                    <asp:CheckBox runat="server" ID="cbLikeBranch" Text="Включаючи підпорядковані" />
                                    <button onclick="PrintReport('excel')">
                                        Друк
                                    <img title="Друк журналу в excel" alt="" style="vertical-align: baseline" src="/barsroot/cim/style/img/ms-excel.gif" />
                                    </button>
                                    <button onclick="PrintReport('word')">
                                        Друк
                                        <img title="Друк журналу в word" alt="" style="vertical-align: baseline" src="/barsroot/cim/style/img/ms-word.gif" />
                                    </button>
                                </div>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="vertical-align: top">
                <div style="float: right; position: relative">
                    <input type="button" value="Перенумерація журналів" onclick="enumJournal()" style="width: 170px" />
                </div>
            </td>
        </tr>
    </table>
    <asp:Panel runat="server" ID="pnJournalBlock">
        <div style="overflow: scroll; padding: 10px 10px 10px 0; margin-left: -10px">

            <bars:BarsGridViewEx ID="gvVCimJournal" runat="server" AutoGenerateColumns="False"
                DataSourceID="dsJournals"
                ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True" PageSize="20"
                AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="NUM"
                ShowPageSizeBox="true" OnRowCreated="gvVCimJournal_RowCreated" OnRowDataBound="gvVCimJournal_RowDataBound">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton runat="server" CausesValidation="false" ID="imgDelete" Width="16px"
                                ToolTip="Видалити запис із журналу"
                                OnClientClick='<%# "deleteRecord(" + Eval("DOC_KIND") + "," + Eval("DOC_TYPE") + "," + Eval("BOUND_ID") +"," + Eval("STR_LEVEL") + ");return false;" %>'
                                Visible='<%# (Convert.ToInt32(Eval("DEL_JOURNAL")) == 0)?(false):(true) %>' ImageUrl="/Common/Images/default/16/cancel_blue.png"></asp:ImageButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="NUM_TXT" HeaderText="№ з/п" SortExpression="NUM">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CREATE_DATE" HeaderText="Дата реєстрації" SortExpression="CREATE_DATE" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="OKPO" HeaderText="ОКПО" SortExpression="OKPO"></asp:BoundField>
                    <asp:BoundField DataField="nmk" HeaderText="Назва" SortExpression="nmk"></asp:BoundField>
                    <asp:BoundField DataField="country_name" HeaderText="Країна" SortExpression="country_name"></asp:BoundField>
                    <asp:BoundField DataField="benef_name" HeaderText="Назва" SortExpression="benef_name"></asp:BoundField>
                    <asp:BoundField DataField="contr_num" HeaderText="№" SortExpression="contr_num"></asp:BoundField>
                    <asp:BoundField DataField="contr_date" HeaderText="Дата" SortExpression="contr_date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="direct" HeaderText="Напрям документу" SortExpression="direct"></asp:BoundField>
                    <asp:BoundField DataField="doc_type_name" HeaderText="Тип документу" SortExpression="doc_type_name"></asp:BoundField>
                    <asp:BoundField DataField="kv_p" HeaderText="Валюта" SortExpression="kv_p">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="s_p" HeaderText="Сума" SortExpression="s_p" DataFormatString="{0:F}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="val_date" HeaderText="Дата" SortExpression="val_date" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                    <asp:BoundField DataField="kv_v" HeaderText="Валюта" SortExpression="kv_p">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="s_v" HeaderText="Сума" SortExpression="s_v" DataFormatString="{0:F}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="allow_date" HeaderText="Дата" SortExpression="allow_date" DataFormatString="{0:dd/MM/yyyy}">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="vmd_num" HeaderText="№ МД" SortExpression="vmd_num"></asp:BoundField>
                    <asp:BoundField DataField="file_name" HeaderText="Назва файлу" SortExpression="file_name"></asp:BoundField>
                    <asp:BoundField DataField="file_date" HeaderText="Дата файлу" SortExpression="file_date" DataFormatString="{0:dd/MM/yyyy}">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="control_date" HeaderText="Контрольна дата" SortExpression="control_date" DataFormatString="{0:dd/MM/yyyy}">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Коментар">
                        <ItemTemplate>
                            <asp:TextBox runat="server" TextMode="MultiLine" Width="250px" Text='<%# Eval("COMMENTS") %>'></asp:TextBox>
                            <asp:ImageButton runat="server" AlternateText="Зберегти" ImageUrl="/Common/Images/default/16/save.png"
                                Width="16px" Height="16px" OnClientClick='<%# "updateComment($(this)," + Eval("DOC_KIND") + "," + Eval("DOC_TYPE") + "," + Eval("BOUND_ID") +"," + Eval("STR_LEVEL") + ",\"" + Eval("DOC_ID") + "\");return false;" %>' />
                        </ItemTemplate>
                        <ItemStyle Wrap="true" />
                    </asp:TemplateField>

                </Columns>
            </bars:BarsGridViewEx>
        </div>
    </asp:Panel>
</asp:Content>

