<%@ Page Language="C#" MasterPageFile="LoginPage.master" AutoEventWireup="true"
    Inherits="barsweb.ChangePsw" CodeFile="ChangePsw.aspx.cs" Culture="uk-UA" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="\Common\Script\StrongPsw.js"></script>
    <script type="text/javascript">

        function addEvent(element, event, fn) {
            if (element.addEventListener) element.addEventListener(event, fn, false);
            else if (element.attachEvent) element.attachEvent('on' + event, fn);
            else { element['on' + event] = fn; }
        }
        addEvent(window, 'load', function () { OnLoad(); });
        function getCookie(par) {
            var pageCookie = document.cookie;
            var pos = pageCookie.indexOf(par + '=');
            if (pos != -1) {
                var start = pos + par.length + 1;
                var end = pageCookie.indexOf(';', start);
                if (end == -1) end = pageCookie.length;
                var value = pageCookie.substring(start, end);
                value = unescape(value);
                return value;
            }
        }
        function OnLoad() {
            var login = getCookie('userLogin');
            if (login)
                document.all.txtUserName.value = login;
            InitPasswordPolicyParams(document.all.__pswMinLength.value, document.all.__pswMaxSeq.value, 2, document.all.__sysUser.value, 'txtPasswordNew', "btChangePsw");
            if (document.all.txtUserName.disabled || document.all.txtUserName.value != "")
                document.all.txtPasswordOld.focus();
            else
                document.all.txtUserName.focus();
            if (location.search.indexOf('techPsw') > 0)
                alert("Вы використовуєте технічний пароль! Необхідно задати новий пароль!");

            if (document.getElementById('txtUserName').value == "") {
                document.getElementById('txtUserName').focus();
            }
            else {
                document.getElementById('txtPasswordOld').focus();
                document.getElementById('txtPasswordOld').select();
            }

        }
        function pressEnter() {
            if (event.keyCode == 13) {
                if (!document.all.btChangePsw.disabled)
                    document.all.btChangePsw.focus();
            }
        }
        function Validate() {
            if (!ConfirmPsw()) return false;
            if (document.all.__InitPassword.value == hex_sha1(document.all.txtPasswordNew.value.toLowerCase())) {
                alert("Ви знову використовуете технічний пароль! Необхідно задати новий пароль!");
                document.getElementById('txtPasswordNew').focus();
                document.getElementById('txtPasswordNew').select();
                return false;
            }
            return true;
        }
        function ConfirmPsw() {
            if (document.getElementById('txtPasswordNew').value != "") {
                window.event.cancelBubble = true;
                var psw = window.showModalDialog("dialog.aspx?type=promptpsw&message=" + escape("Підтвердіть пароль:"), "", "dialogHeight:160px;center:yes;edge:sunken;help:no;status:no;");
                window.event.cancelBubble = true;
                if (null == psw) return false;
                if (document.getElementById('txtPasswordNew').value.toLowerCase() != psw.toLowerCase()) {
                    alert("Невірне підтвердження пароля");
                    document.getElementById('txtPasswordNew').focus();
                    document.getElementById('txtPasswordNew').select();
                    return false;
                }
            }
            return true;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server" ClientIDMode="Static">
    <form id="AuthForm"
        onsubmit="txtPasswordOld_encrypt.value = hex_sha1(txtPasswordOld.value.toLowerCase());txtPasswordNew_encrypt.value = hex_sha1(txtPasswordNew.value.toLowerCase())"
        method="post" runat="server">

        <div>
            <div class="form-group">
                <asp:Label ID="lnEnterSystem" class="form-name" runat="server" Text="Зміна пароля" ></asp:Label>
            </div>
            <div class="form-group">
                <asp:Label ID="lbUser" class="form-label foggy" runat="server" >Користувач:</asp:Label>
                <asp:TextBox ID="txtUserName" class="form-control" TabIndex="1" runat="server" ></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="lbPswOld" class="form-label foggy" runat="server" >Старий пароль:</asp:Label>
                <asp:TextBox ID="txtPasswordOld" class="form-control" TabIndex="2" runat="server" type="password" ></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="lbPswNew" class="form-label foggy" runat="server" >Новий пароль:</asp:Label>
                <asp:TextBox ID="txtPasswordNew" class="form-control" TabIndex="2" runat="server" type="password" ></asp:TextBox>
            </div>            
            
            <div class="form-group" style="text-align: right;">
                <a id="linkChangePsw"
                    class="color-blue float-left"
                    runat="server"
                    href="/barsroot/barsweb/loginpage.aspx">Змінити пароль</a>
                <asp:Button ID="btChangePsw"
                    class="form-button bg-blue"
                    TabIndex="3"
                    runat="server"
                    Text="Змінити"
                    OnClick="btChangePsw_Click"
                    Enabled="False"></asp:Button>
            </div>
            <div class="form-group">
                <div class="error-block" id="errorBlock">
                    <asp:Label ID="lbMessage" runat="server" Visible="False">
                            Невірний старий пароль
                    </asp:Label>
                </div>
            </div>

        </div>

        <input type="hidden" id="__pswMinLength" runat="server"/>
        <input type="hidden" id="__sysUser" runat="server"/>
        <input type="hidden" id="__pswMaxSeq" runat="server"/>
        <input type="hidden" id="__InitPassword" runat="server"/>
        <input id="txtPasswordOld_encrypt" type="hidden" name="txtPasswordOld_encrypt" runat="server"/>
        <input id="txtPasswordNew_encrypt" type="hidden" name="txtPasswordNew_encrypt" runat="server"/>
        


    </form>

</asp:Content>
