<%@ Page Language="C#" MasterPageFile="~/credit/admin/srv_bid_card.master" AutoEventWireup="true"
    CodeFile="bid_card.aspx.cs" Inherits="credit_admin_bid_card" Title="Карточка заявки №{0}"
    Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/admin/srv_bid_card.master" %>

<asp:Content ID="cCommands" ContentPlaceHolderID="cphCommands" runat="Server">
    <script language="javascript" type="text/jscript" src="/Common/jquery/jquery-ui.js"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $('#modalView').dialog({ modal: true, title: 'Зміна статусу заявки', resizable: false, closeOnEscape: true, autoOpen: false });
            $("#<%= this.btRun.ClientID %>").click(function()
            {
                return $("#modalView").dialogCloseAndSubmit($(this).attr('id'));
            });
        });

        $.fn.extend({
            dialogCloseAndSubmit: function (butOkId) {
                var dlg = $(this).clone();
                $(this).dialog('destroy').remove();

                dlg.css('display', 'none');
                $('form:first').append(dlg);
                $('#' + butOkId, dlg).click();

                return true;
            }
        });
    </script>
    <asp:Panel ID="pnlCommands" runat="server" GroupingText="Команди" meta:resourcekey="pnlCommandsResource1" Height="162px">
        <table class="dataTable" style="height: 70px">
            <tr>
                <td>
                    <asp:LinkButton ID="lbSend2PrevStatus" runat="server" CommandName="Send2PrevStatus" OnClientClick="$('#modalView').dialog('open'); return false;"
                        Text="Повернути заявку" meta:resourcekey="lbSend2PrevStatusResource1"></asp:LinkButton>
                    <div id="modalView" style="display: none">
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:RadioButtonList ID="RadioButton" runat="server">
                                        <asp:ListItem Text="Введення данних"></asp:ListItem>
                                        <asp:ListItem Text="Кінець вводу данних"></asp:ListItem>
                                        <asp:ListItem Text="Кредитна служба РУ"></asp:ListItem>
                                        <asp:ListItem Text="Аналіз розгляду службами РУ"></asp:ListItem>
                                        <asp:ListItem Text="Аналіз рішення кредитного комітету РУ"></asp:ListItem>
                                        <asp:ListItem Text="Кредитна служба ЦА"></asp:ListItem>
                                        <asp:ListItem Text="Аналіз розгляду службами ЦА"></asp:ListItem>
                                        <asp:ListItem Text="Аналіз рішення кредитного комітету ЦА"></asp:ListItem>
                                        <asp:ListItem Text="Видача Данні кредиту"></asp:ListItem>
                                        <asp:ListItem Text="Завершення Підписання договору"></asp:ListItem>
                                        <asp:ListItem Text="Віза" Value="rbVisa"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Button Visible="true" ID="btRun" runat="server" Text="Повернути" OnClientClick="__doPostBack('ctl00_ctl00_body_cphCommands_btRun',''); return false;" />
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lbRestartRequest0" runat="server" CommandName="RestartRequest0" OnClick="lbRestartRequest0_Click"
                        Text="Перезапустити інформаційні запити(після авторизації(рівень 0)" meta:resourcekey="lbRestartRequest0Resource1"></asp:LinkButton>
                </td>
            <tr>
                <td>
                    <asp:LinkButton ID="lbRestartRequest1" runat="server" CommandName="RestartRequest1" OnClick="lbRestartRequest1_Click"
                        Text="Перезапустити інформаційні запити(після введення данних(рівень 1)" meta:resourcekey="lbRestartRequest1Resource1"></asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
<asp:Content ID="cProcess" ContentPlaceHolderID="cphProcess" runat="server">
</asp:Content>

