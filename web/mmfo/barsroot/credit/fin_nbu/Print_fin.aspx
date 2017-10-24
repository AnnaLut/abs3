<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Print_fin.aspx.cs" Inherits="tools_Print_fin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #holder
        {
            height: 630px;
        }
        .navigationButton
        {
            padding: 3px;
            border: 1px solid #29acf7;
            background: white;
        }
        .navigationButton:hover
        {
            background: #29acf7;
            color: white;
            cursor: pointer;
            border: 1px solid #29acf7;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <hr class="navigationButton" />
    <div id="Div_Dat" runat="server">
        <asp:Panel ID="Pn_dat" runat="server">
            <table>
                <tr>
                    <td style="width: 10%">
                        <asp:ImageButton ID="Ib_back" runat="server" ImageUrl="/Common/Images/default/16/arrow_left.png"
                            Style="text-align: right" OnClick="Bt_Back_Click" ToolTip="Повернутись на попередню сторінку"
                            Height="20px" Width="20px" Visible="true" />
                    </td>
                    <td>
                        <asp:Label ID="Lb1" runat="server" Text="Дата з" Visible="false"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="Dl_sFdat1" runat="server" Width="149px" Visible="false">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="Lb2" runat="server" Text="Дата по" Visible="false"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="Dl_sFdat2" runat="server" Width="149px" Visible="false">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:ImageButton ID="Bt_run" runat="server" ImageUrl="/Common/Images/default/24/gear_replace.png"
                            Style="text-align: right" OnClick="Bt_run_Click" ToolTip="Сформувати документ"
                            Height="30px" Width="30px" Visible="false" Enabled="true" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <hr class="navigationButton" />
    <div id="holder" runat="server" />
    <div>
        <hr class="navigationButton" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:DropDownList ID="Dd_list" runat="server" Height="28" Width="80px" CssClass="navigationButton"
            Font-Size="Medium" BackColor="#E0F3FE">
            <asp:ListItem Text="PDF" Value="PDF"></asp:ListItem>
            <asp:ListItem Text="XLS" Value="XLS"></asp:ListItem>
            <asp:ListItem Text="RTF" Value="RTF"></asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Bt_print" runat="server" Text="Зберегти" CssClass="navigationButton"
            OnClick="Bt_print_Click" Height="30px" Width="110px" />
    </div>
    <br />
    <%--  <script type="text/javascript">
        function adjustDynFrame() {
            var popCont = window.parent.document.getElementById('dynPopupContainer');

            if (!popCont || popCont.getAttribute("dshown")) return;

            var holder = document.getElementById('holder');

            var popFrame = window.parent.document.getElementById('dynPopupFrame');
            var popInner = window.parent.document.getElementById('dynPopupInner');

            var width = Math.max(holder.scrollWidth, parseInt(popCont.style.width, 0));
            var height = Math.max(holder.scrollHeight, parseInt(popCont.style.height, 0));

            popCont.style.width = width + 30 + "px";
            popCont.style.height = height + 30 + "px";
            popFrame.style.width = popCont.style.width;
            popFrame.style.height = popCont.style.height;

            if (popCont.style.display == "block")
                popCont.setAttribute("dshown", "1");

        }
        window.onload = adjustDynFrame;

    </script>  --%>
    </form>
</body>
</html>
