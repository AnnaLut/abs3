<%@ Page Language="C#" MasterPageFile="LoginPage.master" AutoEventWireup="true"
    Inherits="barsroot.barsweb.LoginPage" CodeFile="loginpage.aspx.cs" Culture="uk-UA" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function addEvent(element, event, fn) {
            if (element.addEventListener) element.addEventListener(event, fn, false);
            else if (element.attachEvent) element.attachEvent('on' + event, fn);
            else { element['on' + event] = fn; }
        }

        addEvent(window, 'load', function () { DisablePrnScr(); });

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

        function DisablePrnScr() {
            window.history.forward(-1);
            //Get login from cookies
            var login = getCookie('userLogin');
            if (login && document.all.txtUserName) {
                document.all.txtUserName.value = login;
                document.all.txtPassword.focus();
            }

            if (document.all.hDisPrnScr && document.all.hDisPrnScr.value == "On") {
                try {
                    var ax = new ActiveXObject("BARSIE.BARSPRINT");
                    ax.DisablePrintScr();
                }
                catch (e) {
                    return;
                }
            }

            if (document.getElementById('txtUserName')) {
                try {
                    document.getElementById('txtUserName').focus();
                    document.getElementById('txtUserName').select();
                }
                catch (e) { };
            }
            else if (document.getElementById('btNext')) {
                document.getElementById('btNext').focus();
            }

        }
        function doLogin(userName, password) {
            with (document.AuthForm) {
                challenge.value = "<%=GetChallenge()%>";
                var user_key = "<%=GetUserKey()%>";
                var const_key = "<%=GetConstKey()%>";
                encdata.value = base$encodeBase64(rc4Encrypt(user_key,
                    const_key + "\\"
                    + challenge.value + "\\"
                    + user_key + "\\"
                    + base$encodeBase64(userName) + "\\"
                    + base$encodeBase64(hex_sha1(password))));
            }
            return;
        }
        function validateForm() {
            if (!validateUserame())
                return false;
            if (!validatePassword())
                return false;
            document.forms[0].btLogIn.disabled = true;
            document.forms[0].txtUserName.disabled = true;
            document.forms[0].txtPassword.disabled = true;
            with (document.AuthForm) {
                doLogin(txtUserName.value.toLowerCase(), txtPassword.value.toLowerCase());
                var date = new Date((new Date()).getTime() + 24 * 3600000);
                document.cookie = 'userLogin=' + txtUserName.value.toLowerCase() + "; expires=" + date.toGMTString();
                txtUserName.value = "";
                txtPassword.value = "";
                document.forms[0].submit();
            }
            return true;
        }

        function validateUserame() {
            var tempName = document.forms[0].txtUserName.value;

            if (isEmpty(tempName)) {
                //alert("Задайте ім'я користувача.");
                document.getElementById('errorBlock').innerHTML = "Задайте ім'я користувача.";
                document.forms[0].txtUserName.focus();
                document.forms[0].txtUserName.select();
                return false;
            }
            else {
                return true;
            }
        }
        function validatePassword() {
            var tempName = document.forms[0].txtPassword.value;

            if (isEmpty(tempName)) {
                document.getElementById('errorBlock').innerHTML = "Задайте пароль користувача.";
                //alert("Задайте пароль користувача.");
                document.forms[0].txtPassword.focus();
                document.forms[0].txtPassword.select();
                return false;
            }
            else {
                return true;
            }
        }

        function isEmpty(strTextField) {
            if (strTextField == "" || strTextField == null)
                return true;

            var re = /\s/g;
            RegExp.multiline = true;
            var str = strTextField.replace(re, "");

            if (str.length == 0)
                return true;
            else
                return false;
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server" ClientIDMode="Static">
    <form id="AuthForm" method="post" runat="server">
        <div>
            <div class="form-group">
                <asp:Label ID="lnEnterSystem" class="form-name" runat="server" Text="Вхід в систему" Visible="False"></asp:Label>
            </div>
            <div class="form-group">
                <asp:Label ID="lbUser" class="form-label foggy" runat="server" Visible="False">Користувач:</asp:Label>
                <asp:TextBox ID="txtUserName" class="form-control" TabIndex="1" runat="server" Visible="False"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Label ID="lbPsw" class="form-label foggy" runat="server" Visible="False">Пароль:</asp:Label>
                <asp:TextBox ID="txtPassword" class="form-control" TabIndex="2" runat="server" type="password" Visible="False"></asp:TextBox>
            </div>

            <div class="form-group" style="text-align: right;">
                <a id="linkChangePsw"
                    class="color-blue float-left"
                    runat="server"
                    onclick="location.replace('changepsw.aspx'+location.search)"
                    href="#"
                    visible="false">Змінити пароль</a>
                <asp:Button ID="btLogIn"
                    class="form-button bg-blue"
                    TabIndex="3"
                    runat="server"
                    OnClientClick="return validateForm();"
                    Text="Вхід"
                    OnClick="btLogIn_Click"
                    Visible="False"></asp:Button>
            </div>

            <div class="form-group">
                <div class="error-block" id="errorBlock">
                    <asp:Label ID="lbMessage" runat="server" Visible="False">
                            Вхід неможливий: невірний користувач\пароль
                    </asp:Label>
                </div>
            </div>
        </div>

        <div>
            <div class="form-group">
                <asp:Label ID="lbSelectBankDate" class="form-name" runat="server" Text="Банківська дата" Visible="False"></asp:Label>
            </div>
            <div class="form-group">
                <asp:Calendar ID="Calendar"
                    class="asp-calendar"
                    runat="server"
                    Font-Size="14px"
                    NextMonthText=">"
                    PrevMonthText="<"
                    SelectMonthText="»"
                    SelectWeekText="›"
                    CellSpacing="0"
                    Height="230px"
                    Width="300px"
                    Visible="False"
                    OnDayRender="Calendar_DayRender"
                    OnSelectionChanged="Calendar_SelectionChanged">
                    <SelectedDayStyle Font-Bold="True" Font-Size="12px" CssClass="myCalendarSelector" />
                    <TodayDayStyle CssClass="myCalendarToday" />

                    <OtherMonthDayStyle ForeColor="#b0b0b0" />
                    <DayStyle CssClass="myCalendarDay" ForeColor="#2d3338" />
                    <SelectorStyle CssClass="myCalendarSelector" />

                    <NextPrevStyle CssClass="myCalendarNextPrev" />
                    <DayHeaderStyle CssClass="myCalendarDayHeader" ForeColor="#2d3338" />
                    <TitleStyle CssClass="myCalendarTitle" />
                </asp:Calendar>
            </div>
            <div class="form-group">
                <asp:Button ID="btNext"
                    runat="server"
                    class="form-button bg-blue float-right"
                    OnClick="btNext_Click"
                    TabIndex="1"
                    Text="Продовжити"
                    Visible="False"></asp:Button>
            </div>
            <div class="form-group">&nbsp;</div>
        </div>

        <div style="position: absolute; top: 100%; margin-top: -20px; right: 0;">
            <asp:Label ID="lbServer" runat="server" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black"></asp:Label>
        </div>
        <input type="hidden" id="encdata" name="encdata">
        <input type="hidden" id="challenge" name="challenge">
    </form>
</asp:Content>
