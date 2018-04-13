<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testseckey.aspx.cs" Inherits="testseckey" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Перевірка працездатності таємного ключа</title>
    <script type="text/javascript" src="/barsroot/scripts/jquery/jquery.js"></script>
    <script type="text/javascript" src="/barsroot/japplet/js/barsSigner.js"></script>
    <script type="text/javascript" language="javascript">
        var strBuf = "   300465      29093066   385048 29091066000001              73 6190051    980110426110423Розрахунки з вкладниками банку РодовідМЕЛЬНИЧУК ЛЮБОВ ОЛЕКСАНДРІВНА         2620;0;1721702603;20.02.1947;м.Львів;804;1;KB;559012;ФРАНКІВСЬКИМ РВ ЛМУ УМВС УКРАЇНИ У ЛЬВІВ;21.03.2001                                                        #CЛЬВІВСЬКА - М.ЛЬВІВ ВУЛ НАУКОВА БУД 26 КВ 48#                11      00032129      02762524   289336NNLCCQ 0        ";
        var strBufHex = "202020333030343635202020202020323930393330363620202033383530343820323930393130363630303030303120202020202020202020202020203733203631393030353120202020393830313130343236313130343233D0EEE7F0E0F5F3EDEAE820E720E2EAEBE0E4EDE8EAE0ECE820E1E0EDEAF320D0EEE4EEE2B3E4CCC5CBDCCDC8D7D3CA20CBDEC1CEC220CECBC5CAD1C0CDC4D0B2C2CDC0202020202020202020323632303B303B313732313730323630333B32302E30322E313934373BEC2ECBFCE2B3E23B3830343B313B4B423B3535393031323BD4D0C0CDCAB2C2D1DCCAC8CC20D0C220CBCCD320D3CCC2D120D3CAD0C0AFCDC820D320CBDCC2B2C23B32312E30332E3230303120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202343CBDCC2B2C2D1DCCAC0202D20CC2ECBDCC2B2C220C2D3CB20CDC0D3CACEC2C020C1D3C420323620CAC220343823202020202020202020202020202020203131202020202020303030333231323920202020202030323736323532342020203238393333364E4E4C43435120302020202020202020";

        function barsAppletDemo() {
            // установка вывода тестовых сообщений
            barsSign.setDebug(false);
            // параметры инициализации
            var options = {};
            options.KeyId = document.getElementById("hKeyId").value;
            options.BankDate = document.getElementById("hBankDate").value;
            options.ModuleType = (document.getElementById("rbAx").checked) ? (barsSign.ModuleTypes.AX) : (barsSign.ModuleTypes.JAVA);
            // инициализация
            barsSign.init(options);
            // подписываем буфер
            strSignBuf = barsSign.signBuffer(strBuf);
            if (strSignBuf) {
                barsSign.checkSign(strBufHex, strSignBuf, "289YID01");
                barsSign.checkSign("00" + strBufHex, strSignBuf, "289YID01");
            }
        }
        var strSignBuf = "";

        // инициализация
        function InitSign() {
            // установка вывода тестовых сообщений
            barsSign.setDebug(false);
            // параметры инициализации
            var options = {};
            options.KeyId = document.getElementById("hKeyId").value;
            options.BankDate = document.getElementById("hBankDate").value;
            options.ModuleType = (document.getElementById("rbAx").checked) ? (barsSign.ModuleTypes.AX) : (barsSign.ModuleTypes.JAVA);
            options.CallBackOnSuccess = onInit;
            // инициализация
            barsSign.init(options);

            document.getElementById("spStep1").innerHTML = "";
            document.getElementById("spStep2").innerHTML = "";
            document.getElementById("spStep3").innerHTML = "";
        }

        function onInit(res) {
            document.getElementById("spStep1").innerHTML = "Криптографічну систему успішно ініціалізовано. Спробуйте накласти ЕЦП.";
            document.getElementById("taBuffer").value = strBuf;
            document.getElementById("pnStep1").disabled = true;
            document.getElementById("pnStep2").disabled = false;
            return true;
        }

        function SignBuffer() {
            strSignBuf = barsSign.signBuffer(strBuf);
            document.getElementById("taSignBuffer").value = strSignBuf;
            document.getElementById("hSignedBuffer").value = strSignBuf;
            document.getElementById("spStep2").innerHTML = "Підпис успішно накладено. Спробуйте перевірити підпис.";
            //document.getElementById("pnStep2").disabled = true;
            document.getElementById("pnStep3").disabled = false;
        }
        function CheckSign() {
            strSignBuf = document.getElementById("taSignBuffer").value;
            var res = barsSign.checkSign(strBufHex, strSignBuf, barsSign.getOptions().KeyId);
            if (!res) {
                document.getElementById("spStep3").innerHTML = "Помилка перевірки підпису. Зверніться до адміністратора.";
                return false;
            }
            else {
                document.getElementById("spStep3").innerHTML = "Всі тести успішно пройдені. Робоче місце готове до роботи.";
                return false;
            }
        }

        function SL_Message() {
            document.getElementById('barsSL').content.barsSL.ShowMessage("Hello from JS");
        }
        function SL_Exec() {
            document.getElementById('barsSL').content.barsSL.ExecFile("Hello from JS");
        }
        function SL_Read() {
            document.getElementById('barsSL').content.barsSL.ReadFile("C:\\readme.txt");
        }
        function SL_Show() {
            document.getElementById('barsSL').style.display = (document.getElementById('cbSLShow').checked) ? ("none") : ("block");
        }
    </script>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
</head>
<body>
    <form id="formTestSec" runat="server">
        <!-- блок hidden-ов -->
        <asp:HiddenField runat="server" ID="hKeyId" />
        <asp:HiddenField runat="server" ID="hBuffer" />
        <asp:HiddenField runat="server" ID="hBankDate" />
        <asp:HiddenField runat="server" ID="hSignedBuffer" />

        <div class="pageTitle">
            <asp:Label ID="lbPageTitle" runat="server" Text="Перевірка працездатності таємного ключа"></asp:Label>
        </div>
        <br />
        <div>
            Ідентифікатор вашого ключа:&nbsp;&nbsp;&nbsp;<asp:TextBox ID="tbKeyID" ReadOnly="true" runat="server" ToolTip="Ідетифікатор ключа" Width="80px"></asp:TextBox>
        </div>
        <fieldset>
            <legend>Тип софта для подписи
            </legend>
            <input id="rbAx" type="radio" name="rbModeType" />
            <label for="rbAx">ActiveX</label>
            <input id="rbJa" type="radio" name="rbModeType" checked="checked" />
            <label for="rbJa">Java Applet</label>
            <br />    
            <input type="button" value="Опции" onclick="barsSign.showOptions()" />
            <input type="button" value="Лог файл" onclick="barsSign.showLogFile()" />
            <input type="button" value="Проверка" onclick="barsAppletDemo()" />
        </fieldset>
        <fieldset>
            <legend>BarsSigner
            </legend>
            <asp:Panel ID="pnStep1" runat="server" GroupingText="Крок 1. Перевірка програмного забезпечення">
                <input type="button" value="Виконати ініціалізацію" onclick="InitSign()" style="width: 180px" />
                <span id="spStep1" style="font-weight: bold"></span>
            </asp:Panel>

            <asp:Panel ID="pnStep2" runat="server" GroupingText="Крок 2. Перевірка накладення підпису" disabled>
                <table>
                    <tr>
                        <td colspan="2">
                            <input id="btSign" type="button" value="Накласти підпис" onclick="SignBuffer()" style="width: 180px" />
                            <span id="spStep2" style="font-weight: bold"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Буфер:        
                        </td>
                        <td>
                            <textarea id="taBuffer" rows="3" cols="120"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Подпись:        
                        </td>
                        <td>
                            <textarea id="taSignBuffer" rows="3" cols="120"></textarea>
                        </td>
                    </tr>

                </table>

            </asp:Panel>

            <asp:Panel ID="pnStep3" runat="server" GroupingText="Крок 3. Перевірка підпису" disabled>
                <input id="btCheckSign" type="button" value="Перевірити підпис" onclick="CheckSign()" style="width: 180px" />
                <span id="spStep3" style="font-weight: bold"></span>
            </asp:Panel>
            <br />
        </fieldset>
        <asp:Label ID="lbSuccess" runat="server" Visible="false" Text="Робоче місце успішно протестовано." Font-Bold="True" Font-Names="Arial" Font-Size="14pt" ForeColor="Green"></asp:Label>
        <fieldset style="visibility: hidden">
            <legend>Bars Silverlite
            </legend>
            <table>
                <tr>
                    <td>
                        <label for="cbSLShow">Показать визуально</label><input type="checkbox" id="cbSLShow" onclick="SL_Show()" /></td>
                    <td>
                        <input type="button" value="Сообщение из SL" onclick="SL_Message()" />
                        <input type="button" value="Чтение файла SL" onclick="SL_Read()" />
                        <input type="button" value="Запуск SL" onclick="SL_Exec()" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <object id="barsSL" width="420" height="150" data="data:application/x-silverlight-2," type="application/x-silverlight-2">
                            <param name="source" value="/barsroot/tools/sl/bars.sl.app.xap" />
                            <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=4.0.60310.0" style="text-decoration: none;">
                                <img src="http://go.microsoft.com/fwlink/?LinkId=161376" alt="Get Microsoft Silverlight" style="border-style: none" />
                            </a>
                        </object>
                    </td>
                </tr>
            </table>
        </fieldset>
    </form>
</body>
</html>
