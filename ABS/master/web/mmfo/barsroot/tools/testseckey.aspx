<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testseckey.aspx.cs" Inherits="testseckey" EnableSessionState="ReadOnly" %>

<!doctype html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="IE=EmulateIE10" />
    <title>Перевірка працездатності таємного ключа</title>
    <script type="text/javascript" src="/barsroot/scripts/jquery/jquery.js"></script>
    
    <script type="text/javascript" src="/Common/Script/json.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.iecors.js"></script>
    <script type="text/javascript" src="/Common/Script/BarsIe.js?v1.2"></script>
    <script type="text/javascript" src="/barsroot/Scripts/crypto/barsCrypto.js?v1.0.5"></script>
    <script type="text/javascript">

        function appendError(errMessage) {
            document.getElementById("spError").innerHTML += errMessage + '<br/>';
        }

        function doAxCheck() {
            barsie$print("selftest");
        }

        function startIE() {
            var data = { "url": location.href };
            barsCrypto.startIe(data,
                function (res) {
                },
                function (err) {
                })
        }

        function doBcUpdate() {
            var data = {};
            data.UpdateServer = document.getElementById('__BC_UPDATE_SERVER').value;
            barsCrypto.getUpdate(data,
                function (res) {
                },
                function (err) {
                })
        }
        function saveUserTrace(status, errorMessage) {
            var info = {};
            var data = barsCrypto.getStatus();
            info.keyId = document.getElementById('__USER_KEYID').value;
            info.bcVersion = document.getElementById("lbBcVersion").innerText;
            info.userAddress = document.getElementById('__USER_ADDRESS').value;
            info.browserInfo = 'CA=' + data.userCaKey + ', hash=' + data.userKeyHash + ',' + document.getElementById('__USER_INFO').value;
            info.checkStatus = status;
            info.checkError = errorMessage;
            $.ajax({
                type: "POST",
                data: JSON.stringify(info),
                url: '/barsroot/webservices/CryptoService.asmx/TraceUserSign',
                dateType: "json",
                contentType: "application/json; charset=UTF-8",
                success: function (data) {
                },
                error: function (err) {
                }
            });
        }

        function versionCompare(v1, v2) {
            // Сравнение численных версий (1.0.10 etc.)
            var v1parts = v1.split('.');
            var v2parts = v2.split('.');
            for (var i = 0; i < v1parts.length; ++i) {
                if (v2parts.length == i) {
                    return 1;
                }

                if (parseInt(v1parts[i], 10) == parseInt(v2parts[i], 10)) {
                    continue;
                }
                else if (parseInt(v1parts[i], 10) > parseInt(v2parts[i], 10)) {
                    return 1; // v1 > v2
                }
                else {
                    return -1; // v1 < v2
                }
            }
            return 0; // v1 = v2
        }
        
        
        function doBcCheck() {
            document.getElementById("spSuccess").innerHTML = "";
            document.getElementById("spError").innerHTML = "";

            var options = {};
            options.KeyId = document.getElementById('__USER_KEYID').value;
            options.KeyHash = document.getElementById('__USER_KEYHASH').value;
            options.CaKey = document.getElementById('__CRYPTO_CA_KEY').value;
            options.RegionCode = '';
            options.PassCheckCa = true;
            options.BankDate = document.getElementById('__BDATE.value');
            if (document.getElementById('__USER_SIGN_TYPE').value === 'VG2')
                options.ModuleType = barsCrypto.ModuleTypes.VG2;
            else
                options.ModuleType = barsCrypto.ModuleTypes.VEG;
            barsCrypto.setDebug(true); // режим отладки
            var actualVersion = document.getElementById('__BC_VERSION').value;
            var minVersion = document.getElementById('__BC_MIN_VERSION').value;

            // инициализация
            barsCrypto.init(options);
            barsCrypto.getModuleVersions(
                function (resp) {
                    var res;
                    try
                    {
                        res = JSON.parse(resp);
                    }
                    catch (e)
                    {
                        res = resp;
                    }
                    if (res.Versions.vega2 && res.Versions.vega2.indexOf('1.0.7') < 0) { // проверка версии с CORS тут еще не доступна была
                        barsCrypto.getVersion(function (resp) {
                            var res;
                            try
                            {
                                res = JSON.parse(resp);
                            }
                            catch (e)
                            {
                                res = resp;
                            }
                            var version = res.version;
                            document.getElementById("lbBcVersion").innerText = version;
                            if (versionCompare(minVersion, version) == -1) {
                                if (versionCompare(version, actualVersion) == -1)
                                    $('#btBcUpdate').show();
                            }
                            else {
                                appendError("Необхідно оновити BarsCryptor до версії " + actualVersion);
                                $('#btBcUpdate').show();
                            }
                        }, function (err) {
                            appendError("Помилка отримання версії BarsCryptor [" + err + "]");
                        });
                    }
                    else {
                        document.getElementById("lbBcVersion").innerText = "1.0.3.3";
                        appendError("Необхідно оновити BarsCryptor до версії " + actualVersion);
                    }
                },
                function (err) {
                    appendError("Помилка отримання версії BarsCryptor [" + err + "]");
                }
                );

            var result = {
                KeyId: options.KeyId,
                KeyHash: options.KeyHash,
                ModuleType: options.ModuleType,
                intSign: {},
                extSign: {}
            }

            var buffer = "74657374";
            barsCrypto.signBuffer(buffer,
                function (sign) {
                    document.getElementById("spSuccess").innerHTML += "Роботу BarsCryptor успішно протестовано.";
                    saveUserTrace(0, '');
                },
                function (errorText, errCode) {
                    saveUserTrace(1, errorText);
                    document.getElementById("spError").innerHTML += 'Помилка накладання підпису.\n' + errorText;
                    if (errCode && errCode === barsCrypto.constants.ENotStarted) {
                        alert("Буде виконано спробу запуску BarsCryptor, якщо він був встановлений в системі. У наступномі вікні потрбіно дозволити запуск та повторити операцію.")
                        barsCrypto.startBarsCryptor();
                    }
                });
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
        <asp:HiddenField runat="server" ID="hSignedBuffer" />
        <input id="__BDATE" type="hidden" runat="server" />
        <input id="__SIGN_MIXED_MODE" type="hidden" runat="server" />
        <input id="__USER_SIGN_TYPE" type="hidden" runat="server" />
        <input id="__USER_KEYID" type="hidden" runat="server" />
        <input id="__USER_KEYHASH" type="hidden" runat="server" />
        <input id="__CRYPTO_USE_VEGA2" type="hidden" runat="server" />
        <input id="__CRYPTO_CA_KEY" type="hidden" runat="server" />
        <input id="__BC_MIN_VERSION" type="hidden" runat="server" />
        <input id="__BC_VERSION" type="hidden" runat="server" />
        <input id="__BC_UPDATE_SERVER" type="hidden" runat="server" />
        <input id="__USER_ADDRESS" type="hidden" runat="server" />
        <input id="__USER_INFO" type="hidden" runat="server" />

        <fieldset style="float: right">
            <table>
                <tr>
                    <td>Режим роботи з підписом:</td>
                    <td>
                        <asp:Label runat="server" ID="lbMode" Font-Bold="true"></asp:Label></td>
                </tr>
                <tr>
                    <td>Адреса сервісу:</td>
                    <td>
                        <asp:Label runat="server" ID="lbServiceUrl" Font-Bold="true"></asp:Label></td>
                </tr>
                <tr>
                    <td>Режим діагностики:</td>
                    <td>
                        <asp:Label runat="server" ID="lbDebugMode" Font-Bold="true"></asp:Label>
                        <asp:Button runat="server" ID="btChangeDebugMode" Text="Hidden" ForeColor="White" BackColor="Transparent" BorderStyle="None" Width="40px" OnClick="btChangeDebugMode_Click" /></td>
                </tr>
                <tr>
                    <td>Актуальна версія BarsCryptor:</td>
                    <td>
                        <asp:Label runat="server" ID="lbActualBcVersion" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <div class="pageTitle">
            <asp:Label ID="lbPageTitle" runat="server" Text="Перевірка робочого місця"></asp:Label>
        </div>
        <br />

        <div>
            Серійний номер ключа:&nbsp;&nbsp;&nbsp;<asp:TextBox ID="tbKeyID" ReadOnly="true" runat="server" ToolTip="Ідентифікатор ключа" Width="120px"></asp:TextBox>
            <br />
            Версія BarsCryptor:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="lbBcVersion" style="font-weight: bold"></span>
            &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="btBcUpdate" style="display: none" value="Оновити" onclick="doBcUpdate()" />
        </div>
        <br />
        <input type="button" value="Перевірка BarsCryptor" onclick="doBcCheck(); return false;" style="width: 180px" />
        <input type="button" value="Перевірка друку" onclick="doAxCheck(); return false;" style="width: 180px" />
        <br />
        <br />
        <span id="spSuccess" style="font-weight: bold; color: green"></span>
        <br />
        <span id="spError" style="font-weight: bold; color: red"></span>
    </form>
</body>
</html>
