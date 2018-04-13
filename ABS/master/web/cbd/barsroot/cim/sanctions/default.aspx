<%@ Page Title="Санкції Мінекономіки" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="cim_sanctions_default" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="Server">
     <bars:BarsSqlDataSourceEx runat="server" ID="dsCountries" ProviderName="barsroot.core"
        SelectCommand="select country, country || ' - '|| name name from country union all select null, null from dual order by country nulls first">
    </bars:BarsSqlDataSourceEx>
    <div id="tabs">
        <ul>
            <li><a href="#tabView">Санкції</a></li>
            <li><a href="#tabImport">Імпорт\Синхронізація</a></li>
        </ul>
        <div id="tabView">
            <asp:Label CssClass="ctrl-td-lb" runat="server" ID="lbTotal" Text="Загальна кількість санкцій у базі:"></asp:Label>
            <asp:Label CssClass="ctrl-td-val" runat="server" ID="lbTotalCount" Text="" Font-Bold="True" ></asp:Label>

            <asp:Panel runat="server" ID="pnFiler" GroupingText="Фільтр санкцій">
                <table>
                    <tr>
                        <td>
                            <asp:RadioButtonList runat="server" RepeatDirection="Horizontal" AutoPostBack="true" ID="rblRez" OnSelectedIndexChanged="rblRez_SelectedIndexChanged">
                                <asp:ListItem Value="1" Text="Резидент" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="2" Text="Не резидент"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td colspan="2">
                            <asp:Panel runat="server" ID="pnInterval" GroupingText="Інтервал">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>&nbsp;з&nbsp;</td>
                                        <td class="nw">
                                            <asp:TextBox runat="server" ID="tbStartDate" CssClass="ctrl-date" MaxLength="10"></asp:TextBox></td>
                                        <td>&nbsp;по&nbsp;
                                        </td>
                                        <td class="nw">
                                            <asp:TextBox runat="server" ID="tbFinishDate" CssClass="ctrl-date" MaxLength="10"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td>
                            <asp:CheckBox runat="server" ID="cbZast" Checked="True" Text="Застосування" /><br />
                            <asp:CheckBox runat="server" ID="cbSkas" Checked="True" Text="Скасування" />
                        </td>
                    </tr>
                    <tr>
                        <td>Номер наказу на введення санкцiї:</td>
                        <td>
                            <asp:TextBox runat="server" ID="tbSStartNum"></asp:TextBox>
                        </td>
                        <td>Номер наказу на скасування санкцiї:</td>
                        <td>
                            <asp:TextBox runat="server" ID="tbSStopNum"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="trNameR11">
                        <td>Назва:</td>
                        <td colspan="3">
                            <asp:TextBox runat="server" ID="tbSNameR11" Width="460px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="trNameR4" visible="false">
                        <td>Назва:</td>
                        <td colspan="3">
                            <asp:TextBox runat="server" ID="tbSNameR4" Width="460px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr runat="server" id="trCountry" visible="false">
                        <td>Країна:</td>
                        <td colspan="3">
                            <asp:TextBox runat="server" ID="tbSCountry" Width="80px"></asp:TextBox>
                            <asp:DropDownList runat="server" DataSourceID="dsCountries" ID="ddCountries" DataTextField="NAME" DataValueField="COUNTRY" />
                        </td>
                    </tr>

                    <tr runat="server" id="trOKPO">
                        <td>Iдентифiкацiйний код:</td>
                        <td colspan="3">
                            <asp:TextBox runat="server" ID="tbSOkpo" MaxLength="10" CssClass="numeric"></asp:TextBox>
                            <asp:CheckBox runat="server" ID="cbOurClient" Text="Тільки клієнти банку"/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3">
                            <asp:Button runat="server" ID="btSearch" Text="Пошук" Width="120px" OnClick="btSearch_Click" />
                            <asp:Button runat="server" ID="btClear" Text="Очистити" Width="120px" OnClick="btClear_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <bars:BarsSqlDataSourceEx runat="server" ID="dsSanctions" ProviderName="barsroot.core">
            </bars:BarsSqlDataSourceEx>
            <div style="overflow: scroll; padding: 10px 10px 10px 0; margin-left: -10px">
                <bars:BarsGridViewEx ID="gvSanctionsRez" runat="server" AutoGenerateColumns="False" Visible="false"
                    DataSourceID="dsSanctions"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow"
                    ShowPageSizeBox="true">
                    <Columns>
                        <asp:BoundField DataField="r1_1" HeaderText="Назва" SortExpression="r1_1"></asp:BoundField>
                        <asp:BoundField DataField="k020" HeaderText="Ідентифікаційний код" SortExpression="k020"></asp:BoundField>
                        <asp:BoundField DataField="r2_1" HeaderText="Адреса" SortExpression="r2_1"></asp:BoundField>
                        <asp:BoundField DataField="sanksia1_txt" HeaderText="Вид санкції" SortExpression="sanksia1"></asp:BoundField>
                        <asp:BoundField DataField="status" HeaderText="Статус" SortExpression="status"></asp:BoundField>
                        <asp:BoundField DataField="nomnak" HeaderText="№ наказу" SortExpression="nomnak"></asp:BoundField>
                        <asp:BoundField DataField="datanak" HeaderText="Дата наказу" DataFormatString="{0:dd/MM/yyyy}" SortExpression="datanak"></asp:BoundField>
                        <asp:BoundField DataField="srsank11" HeaderText="Дата початку дії" DataFormatString="{0:dd/MM/yyyy}" SortExpression="srsank11"></asp:BoundField>
                        <asp:BoundField DataField="srsank12" HeaderText="Дата скасування санкції" DataFormatString="{0:dd/MM/yyyy}" SortExpression="srsank12"></asp:BoundField>
                        <asp:BoundField DataField="nomnaksk" HeaderText="№ наказу на скасування санкції" SortExpression="nomnaksk"></asp:BoundField>
                        <asp:BoundField DataField="datnaksk" HeaderText="Дата наказу на скасування санкції" DataFormatString="{0:dd/MM/yyyy}" SortExpression="datnaksk"></asp:BoundField>
                        <asp:BoundField DataField="ko_1_txt" HeaderText="Область" SortExpression="ko_1_txt"></asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
                <bars:BarsGridViewEx ID="gvSanctionsNotRez" runat="server" AutoGenerateColumns="False" Visible="false"
                    DataSourceID="dsSanctions"
                    ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                    AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow"
                    ShowPageSizeBox="true">
                    <Columns>
                        <asp:BoundField DataField="r4" HeaderText="Назва" SortExpression="r4"></asp:BoundField>
                        <asp:BoundField DataField="adrin" HeaderText="Адреса" SortExpression="adrin"></asp:BoundField>
                        <asp:BoundField DataField="k040_txt" HeaderText="Країна" SortExpression="k040"></asp:BoundField>
                        <asp:BoundField DataField="sanksia1_txt" HeaderText="Вид санкції" SortExpression="sanksia1"></asp:BoundField>
                        <asp:BoundField DataField="status" HeaderText="Статус" SortExpression="status"></asp:BoundField>
                        <asp:BoundField DataField="nomnak" HeaderText="№ наказу" SortExpression="nomnak"></asp:BoundField>
                        <asp:BoundField DataField="datanak" HeaderText="Дата наказу" DataFormatString="{0:dd/MM/yyyy}" SortExpression="datanak"></asp:BoundField>
                        <asp:BoundField DataField="srsank11" HeaderText="Дата початку дії" DataFormatString="{0:dd/MM/yyyy}" SortExpression="srsank11"></asp:BoundField>
                        <asp:BoundField DataField="srsank12" HeaderText="Дата скасування санкції" DataFormatString="{0:dd/MM/yyyy}" SortExpression="srsank12"></asp:BoundField>
                        <asp:BoundField DataField="nomnaksk" HeaderText="№ наказу на скасування санкції" SortExpression="nomnaksk"></asp:BoundField>
                        <asp:BoundField DataField="datnaksk" HeaderText="Дата наказу на скасування санкції" DataFormatString="{0:dd/MM/yyyy}" SortExpression="datnaksk"></asp:BoundField>
                    </Columns>
                </bars:BarsGridViewEx>
            </div>
        </div>
        <div id="tabImport">
            <asp:Panel runat="server" ID="pnImportF98" GroupingText="Імпорт файлу санкцій Мінекономіки (F98)" Visible="false">
                <table>
                    <tr>
                        <td>Вкажіть файл</td>
                        <td>
                            <asp:FileUpload runat="server" ID="fuF98" Width="400px" />
                        </td>
                        <td>
                            <asp:Button runat="server" ID="btImportF98" Text="Імпорт файлу" OnClick="btImportF98_Click" OnClientClick="$.ajaxProgress.begin()" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:Label runat="server" ID="lbInfo"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnSyncF98" GroupingText="Синхронізація довідника санкцій Мінекономіки (F98)" Visible="false">
                <table>
                    <tr>
                        <td>
                            <asp:Button runat="server" ID="btSyncF98" Text="Розпочати синхронізацію" OnClick="btSyncF98_OnClick" OnClientClick="$.ajaxProgress.begin()" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:Label runat="server" ID="lbInfoSync"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </div>
</asp:Content>

