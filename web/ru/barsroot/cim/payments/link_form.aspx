<%@ Page Title="Форма лінкування" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="link_form.aspx.cs" Inherits="cim_payments_link_form" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="Server">
    <bars:BarsSqlDataSourceEx runat="server" ID="dsLinks" ProviderName="barsroot.core">
        <SelectParameters>
            <asp:QueryStringParameter Name="BOUND_ID" QueryStringField="bound_id" DbType="Decimal" />
            <asp:QueryStringParameter Name="TYPE_ID" QueryStringField="type_id" DbType="Decimal" />
            <asp:QueryStringParameter Name="CONTR_ID" QueryStringField="contr_id" DbType="Decimal" />
        </SelectParameters>
    </bars:BarsSqlDataSourceEx>

    <asp:Panel runat="server" ID="pnLinkDecl">
        <fieldset style="margin-top: -10px">
            <legend>Інформація про платіж</legend>
            <div>
                <div style="float: right">
                    <button type="button" id="btFormMailVmd">Друкувати лист-повідомлення</button></div>
                <table>
                    <tr>
                        <td class="ctrl-td-lb">Референс:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbRef" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Тип платежу:</td>
                        <td class='ctrl-td-val'>
                            <asp:Label runat="server" ID="lbType" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb" runat="server" id="tdZS_VP1">Неприв'язаний залишок у валюті платежу:</td>
                        <td class='ctrl-td-val ctrl-right' runat="server" id="tdZS_VP2">
                            <asp:Label runat="server" ID="lbZS_VP" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Дата валютування</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbVDAT" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ctrl-td-lb">Сума:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbSumVK" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Валюта платежу:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbKv" Font-Bold="true"></asp:Label>
                        </td>
                        <td id="tdZS_VK1" runat="server" class="ctrl-td-lb">Неприв'язаний залишок у валюті контракту:</td>
                        <td class='ctrl-td-val ctrl-right' id="tdZS_VK2" runat="server">
                            <asp:Label runat="server" ID="lbZS_VK" Font-Bold="true"></asp:Label>
                        </td>

                    </tr>
                    <tr id="trConcCol1" runat="server" visible="false">
                        <td class="ctrl-td-lb">Сума пов'язаних висновків:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbConclusionTotalSum" Font-Bold="true"></asp:Label>
                        </td>
                        <td colspan="4"></td>
                    </tr>
                    <tr id="trLicenseCol1" runat="server" visible="false">
                        <td class="ctrl-td-lb">Сума пов'язаних ліцензій:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbLicenseTotalSum" Font-Bold="true"></asp:Label>
                        </td>
                        <td colspan="4"></td>
                    </tr>
                    <tr id="trApeCol1" runat="server" visible="false">
                        <td class="ctrl-td-lb">Сума пов'язаних актів цінової еспертизи:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbApeTotalSum" Font-Bold="true"></asp:Label>
                        </td>
                        <td colspan="4" id="tdAddApe" runat="server" visible="false">
                            <button id="btAddApes" type="button" class="btn-add-ico" onclick="curr_module.AddApe()">Добавити акт</button>
                            <div id="dialogApeInfo" style="display: none; text-align: left">
                                <table>
                                    <tr>
                                        <td>Номер акту
                                        </td>
                                        <td class="field">
                                            <input type="text" id="tbApeNum" name="tbApeNum" title="Вкажіть номер акту" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Валюта
                                        </td>
                                        <td class="field">
                                            <input type="text" id="tbApeKv" title="Вкажіть валюту" class="numeric" maxlength="3" style="width: 25px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Сума
                                        </td>
                                        <td class="field">
                                            <input type="text" id="tbApeSum" title="Вкажіть суму у валюті акту" class="numeric" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Курс
                                        </td>
                                        <td class="field">
                                            <input type="text" id="tbApeRate" title="Вкажіть курс" class="numeric" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Сума  у валюті контракту
                                        </td>
                                        <td class="field">
                                            <input type="text" id="tbApeSumVK" title="Вкажіть суму у валюті контракту" class="numeric" />
                                            <span id="lbContrKv"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Дата початку дії акту
                                        </td>
                                        <td class="field" style="white-space: nowrap">
                                            <input type="text" id="tbApeBeginDate" class="datepick" name="tbApeBeginDate" title="Вкажіть дату початку дії акту"
                                                style="text-align: center; width: 80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Дата закінчення дії акту
                                        </td>
                                        <td class="field" style="white-space: nowrap">
                                            <input type="text" id="tbApeEndDate" class="datepick" name="tbApeEndDate" title="Вкажіть дату закінчення дії акту"
                                                style="text-align: center; width: 80px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Примітка
                                        </td>
                                        <td class="field">
                                            <input type="text" id="tbApeComment" title="Вкажіть примітку" style="width: 300px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <div id="dvApeError" style="float: left; clear: left; color: Red;">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <asp:Panel runat="server" ID="pnLinks1" GroupingText="МД для лінкування">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="gvCimBoundVmd" runat="server" AutoGenerateColumns="False"
                    DataSourceID="dsLinks" ShowExportExcelButton="false"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="vmd_id"
                    ShowPageSizeBox="true" OnRowDataBound="gvCimBoundVmd_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkDecl($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати" onclick="curr_module.LinkDecl($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Сума зв'язку з платежем" Visible="true" DataField="f_sum" SortExpression="f_sum" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="vmd_id" HeaderText="Референс" SortExpression="vmd_id">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DOC_TYPE" HeaderText="Тип" SortExpression="DOC_TYPE"></asp:BoundField>
                        <asp:BoundField DataField="num" HeaderText="Номер" SortExpression="num"></asp:BoundField>
                        <asp:BoundField DataField="allow_date" HeaderText="Дата дозволу" SortExpression="allow_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="vt" HeaderText="Валюта МД\акту" SortExpression="vt">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vt" HeaderText="Сума у валюті МД\акту" SortExpression="s_vt" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="rate_vk" HeaderText="Курс" SortExpression="rate_vk" DataFormatString="{0:F8}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_pl_vk" HeaderText="Сума пов’язаних платежів" SortExpression="s_pl_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Z_VT" HeaderText="Заборгованість по платежах у валюті МД\акту" SortExpression="Z_VT" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="z_vk" HeaderText="Заборгованість по платежах у валюті контракту" SortExpression="z_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="control_date" HeaderText="Контрольна дата " SortExpression="control_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_pl_after_vk" HeaderText="Сума пов’язаних платежів після контрольної дати" SortExpression="s_pl_after_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="file_name" HeaderText="№ реєстру" SortExpression="file_name">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="file_date" HeaderText="Дата реєстру " SortExpression="file_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="comments" HeaderText="Примітка " SortExpression="comments"></asp:BoundField>
                        <asp:BoundField DataField="link_date" HeaderText="Дата прив'язки" SortExpression="link_date"></asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnConclusions1" GroupingText="Висновки для лінкування">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="gvCimConclusions" runat="server" AutoGenerateColumns="False"
                    DataSourceID="dsLinks"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="ID"
                    ShowPageSizeBox="true" OnRowDataBound="gvCimConclusions_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img3" runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkConclusionToPayment($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img4" runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати" onclick="curr_module.LinkConclusionToPayment($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Сума зв'язку з платежем" Visible="true" DataField="f_sum" SortExpression="f_sum" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="id" HeaderText="Референс" SortExpression="id">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="out_num" HeaderText="Вихідний №" SortExpression="out_num"></asp:BoundField>
                        <asp:BoundField DataField="out_date" HeaderText="Вихідна дата" SortExpression="out_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="org_name" HeaderText="Орган" SortExpression="org_name">
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="KV" HeaderText="Валюта" SortExpression="KV">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s" HeaderText="Сума" SortExpression="s" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_doc" HeaderText="Сума пов'язаних документів" SortExpression="s_doc" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="begin_date" HeaderText="Дата початку строку" SortExpression="begin_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="end_date" HeaderText="Дата закінчення строку" SortExpression="end_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="create_date" HeaderText="Дата редагування" SortExpression="create_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="create_uid" HeaderText="Користувач" SortExpression="create_uid">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnLicenses1" GroupingText="Ліцензії для лінкування" Visible="false">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="gvCimLicenses" runat="server" AutoGenerateColumns="False"
                    DataSourceID="dsLinks"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="LICENSE_ID"
                    ShowPageSizeBox="true" OnRowDataBound="gvCimLicenses_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img3" runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkLicenseToPayment($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img4" runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати" onclick="curr_module.LinkLicenseToPayment($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Сума зв'язку з платежем" Visible="true" DataField="f_sum" SortExpression="f_sum" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NUM" HeaderText="№ ліцензії" SortExpression="NUM">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="type_txt" HeaderText="Тип" SortExpression="type_txt"></asp:BoundField>
                        <asp:BoundField DataField="kv" HeaderText="Валюта" SortExpression="kv">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s" HeaderText="Сума" SortExpression="s" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_doc" HeaderText="Сума пов’язаних платежів" SortExpression="s_doc" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="begin_date" HeaderText="Дата ліцензії" SortExpression="begin_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="end_date" HeaderText="Дата закінчення ліцензії" SortExpression="end_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="comments" HeaderText="Примітка" SortExpression="comments"></asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnApes1" GroupingText="Акти цінової експертизи для лінкування" Visible="false">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="gvCimApes" runat="server" AutoGenerateColumns="False"
                    DataSourceID="dsLinks"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="APE_ID"
                    ShowPageSizeBox="true" OnRowDataBound="gvCimApes_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img3" runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkApeToPayment($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img4" runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати" onclick="curr_module.LinkApeToPayment($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="F_SUM" HeaderText="Сума зв'язку з платежем" DataFormatString="{0:N}" SortExpression="F_SUM">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="num" HeaderText="Номер" SortExpression="num">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="KV" HeaderText="Валюта" SortExpression="KV">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s" HeaderText="Сума у валюті акту" SortExpression="s" DataFormatString="{0:N}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="rate" HeaderText="Курс" SortExpression="rate" DataFormatString="{0:F8}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:N}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="zs_vk" HeaderText="Залишок суми у валюті контракту" SortExpression="zs_vk" DataFormatString="{0:N}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="begin_date" HeaderText="Дата акту" SortExpression="begin_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="end_date" HeaderText="Дата закінчення" SortExpression="end_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="comments" HeaderText="Примітка" SortExpression="comments">
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnLinkPayment">
        <fieldset style="margin-top: -10px">
            <legend>Інформація про МД</legend>
            <div>
                <div style="float: right">
                    <button type="button" id="btFormMail">Друкувати лист-повідомлення</button></div>
                <table class="headTab">
                    <tr>
                        <td class="ctrl-td-lb">Вн. номер МД:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbDeclId" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Тип документу:</td>
                        <td class='ctrl-td-val'>
                            <asp:Label runat="server" ID="lbDeclType" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Сума у валюті МД\акту:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbDeclSVT" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Дата дозволу:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbDeclDocDate" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ctrl-td-lb">Номер МД:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbDeclNum" Font-Bold="true"></asp:Label>
                        </td>

                        <td class="ctrl-td-lb">Валюта МД\акту:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbDeclKv" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Сума у валюті контракту:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbDeclSVK" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trDeclCol1" runat="server" visible="false">
                        <td class="ctrl-td-lb">Сума пов'язаних платежів:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbDeclarationTotalSum" Font-Bold="true"></asp:Label>
                        </td>
                        <td colspan="6"></td>
                        <td></td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <asp:Panel runat="server" ID="pnLinks2" GroupingText="Платежі для лінкування">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="gvCimTradePayments" runat="server" AutoGenerateColumns="False" ShowExportExcelButton="false"
                    DataSourceID="dsLinks"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="REF"
                    ShowPageSizeBox="true" OnRowDataBound="gvVCimBoundPayments_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkPayment($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати1" onclick="curr_module.LinkPayment($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Сума зв'язку з МД\актом" Visible="true" DataField="f_sum" SortExpression="f_sum" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REF" HeaderText="Референс" SortExpression="REF">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TYPE" HeaderText="Тип" SortExpression="TYPE"></asp:BoundField>
                        <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                        <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                        <asp:BoundField DataField="v_pl" HeaderText="Валюта платежу" SortExpression="v_pl">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vpl" HeaderText="Сума у валюті платежу" SortExpression="s_vpl" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="rate" HeaderText="Курс" SortExpression="rate" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_pd" HeaderText="Сума МД\актів" SortExpression="s_pd" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="zs_vp" HeaderText="Неприв`язаний залишок у валюті платежу" SortExpression="zs_vp" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="zs_vk" HeaderText="Неприв`язаний залишок у валюті контракту" SortExpression="zs_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="control_date" HeaderText="Контрольна дата " SortExpression="control_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_pd_after" HeaderText="Сума МД\актів після контрольної дати" SortExpression="s_pd_after" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="link_date" HeaderText="Дата прив'язки" SortExpression="link_date"></asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnLinks5" GroupingText="Висновки для лінкування" Visible="false">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="gvCimConclusionsToDecl" runat="server" AutoGenerateColumns="False"
                    DataSourceID="dsLinks"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="ID"
                    ShowPageSizeBox="true" OnRowDataBound="gvCimConclusions_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img3" runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkConclusionToDecl($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img4" runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати" onclick="curr_module.LinkConclusionToDecl($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Сума зв'язку з МД" Visible="true" DataField="f_sum" SortExpression="f_sum" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="id" HeaderText="Референс" SortExpression="id">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="out_num" HeaderText="Вихідний №" SortExpression="out_num"></asp:BoundField>
                        <asp:BoundField DataField="out_date" HeaderText="Вихідна дата" SortExpression="out_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="org_name" HeaderText="Орган" SortExpression="org_name">
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="kv" HeaderText="Валюта" SortExpression="kv">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s" HeaderText="Сума" SortExpression="s" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_doc" HeaderText="Сума пов'язаних документів" SortExpression="s_doc" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="begin_date" HeaderText="Дата початку строку" SortExpression="end_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="end_date" HeaderText="Дата закінчення строку" SortExpression="end_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="create_date" HeaderText="Дата редагування" SortExpression="create_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="create_uid" HeaderText="Користувач" SortExpression="create_uid">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnLinkConclusion">
        <fieldset style="margin-top: -10px">
            <legend>Інформація про висновок</legend>
            <div>
                <table class="headTab">
                    <tr>
                        <td class="ctrl-td-lb">Вихідний №:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbConclNum" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Сума:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbConclSum" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Вихідна дата:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbConclOutDat" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Орган:</td>
                        <td class='ctrl-td-val'>
                            <asp:Label runat="server" ID="lbConclOrgan" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ctrl-td-lb">Валюта:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbConclKv" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Сума пов'язаних документів:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbConclSumDoc" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Дата початку строку:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbConclBeginDat" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Дата закінчення строку:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbConclEndDat" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <asp:Panel runat="server" ID="pnLinks3" GroupingText="Платежі для лінкування до висновку">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="gvCimConclusionLink" runat="server" AutoGenerateColumns="False"
                    DataSourceID="dsLinks"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="REF"
                    ShowPageSizeBox="true" OnRowDataBound="gvCimConclusionLink_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img1" runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkPaymentToConclusion($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img2" runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати" onclick="curr_module.LinkPaymentToConclusion($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Сума зв'язку з висновком" Visible="true" DataField="f_sum" SortExpression="f_sum" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REF" HeaderText="Референс" SortExpression="REF">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TYPE" HeaderText="Тип" SortExpression="TYPE"></asp:BoundField>
                        <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                        <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                        <asp:BoundField DataField="v_pl" HeaderText="Валюта платежу" SortExpression="v_pl">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vpl" HeaderText="Сума у валюті платежу" SortExpression="s_vpl" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="rate" HeaderText="Курс" SortExpression="rate" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_pd" HeaderText="Сума підтверджуючих документів" SortExpression="s_pd" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="zs_vp" HeaderText="Неприв`язаний залишок у валюті платежу" SortExpression="zs_vp" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="zs_vk" HeaderText="Неприв`язаний залишок у валюті контракту" SortExpression="zs_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="control_date" HeaderText="Контрольна дата " SortExpression="control_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_pd_after" HeaderText="Сума підтверджуючих документів після контрольної дати" SortExpression="s_pd_after" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnLinks4" GroupingText="МД для лінкування" Visible="False">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="BarsGridViewEx1" runat="server" AutoGenerateColumns="False"
                    DataSourceID="dsLinks"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="vmd_id"
                    ShowPageSizeBox="true" OnRowDataBound="gvCimBoundVmd_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkDeclToConclusion($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати" onclick="curr_module.LinkDeclToConclusion($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Сума зв'язку з МД" Visible="true" DataField="f_sum" SortExpression="f_sum" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="vmd_id" HeaderText="Референс" SortExpression="vmd_id">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DOC_TYPE" HeaderText="Тип" SortExpression="DOC_TYPE"></asp:BoundField>
                        <asp:BoundField DataField="num" HeaderText="Номер" SortExpression="num"></asp:BoundField>
                        <asp:BoundField DataField="allow_date" HeaderText="Дата дозволу" SortExpression="allow_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="vt" HeaderText="Валюта МД\акту" SortExpression="vt">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vt" HeaderText="Сума у валюті МД\акту" SortExpression="s_vt" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="rate_vk" HeaderText="Курс" SortExpression="rate_vk" DataFormatString="{0:F8}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_pl_vk" HeaderText="Сума пов’язаних платежів" SortExpression="s_pl_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Z_VT" HeaderText="Заборгованість по платежах у валюті МД\акту" SortExpression="Z_VT" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="z_vk" HeaderText="Заборгованість по платежах у валюті контракту" SortExpression="z_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="control_date" HeaderText="Контрольна дата " SortExpression="control_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_pl_after_vk" HeaderText="Сума пов’язаних платежів після контрольної дати" SortExpression="s_pl_after_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="file_name" HeaderText="№ реєстру" SortExpression="file_name">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="file_date" HeaderText="Дата реєстру " SortExpression="file_date" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="comments" HeaderText="Примітка1" SortExpression="comments"></asp:BoundField>
                        <asp:BoundField DataField="link_date" HeaderText="Дата прив'язки" SortExpression="link_date"></asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>

    </asp:Panel>

    <asp:Panel runat="server" ID="pnLinkLicenses" Visible="false">
        <fieldset style="margin-top: -10px">
            <legend>Інформація про ліцензію</legend>
            <div>
                <table class="headTab">
                    <tr>
                        <td class="ctrl-td-lb">№  ліцензії:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbLicenseNum" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Сума ліцензії:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbLicenseSum" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Дата ліцензії:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbLicenseBeginDate" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Тип:</td>
                        <td class='ctrl-td-val'>
                            <asp:Label runat="server" ID="lbLicenseType" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ctrl-td-lb">Валюта:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbLicenseKv" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Сума пов'язаних документів:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbLicenseSDoc" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Дата закінчення ліцензії:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbLicenseEndDate" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Примітка:</td>
                        <td class='ctrl-td-val'>
                            <asp:Label runat="server" ID="lbLicenseComment" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <asp:Panel runat="server" ID="pnLinkLicensesGrid" GroupingText="Платежі для лінкування до ліцензії">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="gvnLinkLicenses" runat="server" AutoGenerateColumns="False"
                    DataSourceID="dsLinks"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="REF"
                    ShowPageSizeBox="true" OnRowDataBound="gvnLinkLicenses_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img1" runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkPaymentToLicense($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img2" runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати" onclick="curr_module.LinkPaymentToLicense($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Сума зв'язку з ліцензією." Visible="true" DataField="f_sum" SortExpression="f_sum" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REF" HeaderText="Референс" SortExpression="REF">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TYPE" HeaderText="Тип" SortExpression="TYPE"></asp:BoundField>
                        <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CONTR_ID" HeaderText="ID контракту" SortExpression="CONTR_ID"></asp:BoundField>
                        <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                        <asp:BoundField DataField="v_pl" HeaderText="Валюта платежу" SortExpression="v_pl">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vpl" HeaderText="Сума у валюті платежу" SortExpression="s_vpl" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="rate" HeaderText="Курс" SortExpression="rate" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>
    </asp:Panel>


    <asp:Panel runat="server" ID="pnLinkApes" Visible="false">
        <fieldset style="margin-top: -10px">
            <legend>Інформація про акт цінової експертизи</legend>
            <div>
                <table class="headTab">
                    <tr>
                        <td class="ctrl-td-lb">№ акту:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbApeNum" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Сума акту:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbApeSum" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Сума у валюті контракту:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbApeSumVK" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Дата початку акту:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbApeBeginDate" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ctrl-td-lb">Валюта:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbApeKv" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Курс:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbApeRate" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Залишок суми у валюті контракту:</td>
                        <td class='ctrl-td-val ctrl-right'>
                            <asp:Label runat="server" ID="lbApeZS_VK" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Дата закінчення акту:</td>
                        <td class='ctrl-td-val ctrl-center'>
                            <asp:Label runat="server" ID="lbApeEndDate" Font-Bold="true"></asp:Label>
                        </td>
                        <td class="ctrl-td-lb">Примітка:</td>
                        <td class='ctrl-td-val'>
                            <asp:Label runat="server" ID="lbApeComment" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <asp:Panel runat="server" ID="pnLinkApesGrid" GroupingText="Платежі для лінкування до акту">
            <div style="overflow: auto">
                <bars:BarsGridViewEx ID="gvLinkApes" runat="server" AutoGenerateColumns="False"
                    DataSourceID="dsLinks"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="REF"
                    ShowPageSizeBox="true" OnRowDataBound="gvLinkApes_RowDataBound">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img1" runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати" onclick="curr_module.UnLinkPaymentToApe($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <img id="Img2" runat="server" src="/Common/Images/default/16/new.png" alt="" title="Прив'язати" onclick="curr_module.LinkPaymentToApe($(this))" />
                            </ItemTemplate>
                            <ItemStyle Width="18px" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Сума зв'язку з актом" Visible="true" DataField="f_sum" SortExpression="f_sum" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REF" HeaderText="Референс" SortExpression="REF">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TYPE" HeaderText="Тип" SortExpression="TYPE"></asp:BoundField>
                        <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                        <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                        <asp:BoundField DataField="v_pl" HeaderText="Валюта платежу" SortExpression="v_pl">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vpl" HeaderText="Сума у валюті платежу" SortExpression="s_vpl" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="rate" HeaderText="Курс" SortExpression="rate" DataFormatString="{0:F8}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </asp:Panel>
    </asp:Panel>

    <div id="dialogLinkInfo" style="display: none; text-align: left">
        <table>
            <tr>
                <td>Сума зв'язку
                </td>
                <td class="field">
                    <input type="text" id="tbSum" title="Вкажіть суму зв'язку" class="numeric" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="dvPayError" style="float: left; clear: left; color: Red">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogSendToBank" style="display: none; text-align: left">
        <table>
            <tr>
                <td>Частина суми, що передається</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbUnboundSum" disabled="disabled" title="Вкажіть частину суми, що передається" class="numeric" />
                </td>
            </tr>
            <tr>
                <td>Банк, в який передається платіж</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBBankMfo" title="Вкажіть МФО банку" maxlength="6" class="numeric" style="width: 55px" />
                    <input type="button" id="btSelBank" value="..." title="Вибрати з довідника" style="height: 21px; vertical-align: bottom" />
                    <input type="text" id="tbSBBankName" title="Вкажіть найменування банку" style="width: 300px" />
                </td>
            </tr>
            <tr>
                <td>Номер запиту</td>
                <td class="field">
                    <input type="text" id="tbSBZapNum" title="Вкажіть номер запиту" />
                </td>
                <td colspan="4" class="field">Дата запиту
                    <input type="text" id="tbSBZapDate" title="Вкажіть дата запиту" class="ctrl-date" />
                </td>
            </tr>
            <tr>
                <td>Посада керівника установи</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBDir" title="Вкажіть посада керівника установи" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td>ПІБ керівника установи</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBDirFio" title="Вкажіть ПІБ керівника установи" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td>ПІБ виконавця</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBPerFio" title="Вкажіть ПІБ виконавця" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td>Телефон виконавця</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBPerTel" title="Вкажіть Телефон виконавця" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div id="dvSendToBank" style="float: left; clear: left; color: Red">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogRegDateInfo" style="display: none; text-align: left">
        <table>
            <tr>
                <td>Дата реєстрації
                </td>
                <td class="field" style="white-space: nowrap">
                    <input type="text" id="tbRegDate" name="tbRegDate" title="Вкажіть дату реєстрації в журналі"
                        style="text-align: center; width: 80px" />
                    <span id="lbHintDate">* у форматі <b>DD/MM/YYYY</b></span>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="dvRegDateError" style="float: left; clear: left; color: Red">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div style="float: right; padding-top: 10px" runat="server" id="dvBack">
        <button runat="server" id="btExpImpPay" onserverclick="btExpImpPay_OnClick" class="btn-disk-ico" style="margin-left: 10px" visible="false">Вигрузка в Excel</button>
        <button id="btCancel" type="button" class="btn-back-ico" onclick="curr_module.GoBack();">Повернутися</button>
    </div>
</asp:Content>

