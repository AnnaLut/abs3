<%@ Page Language="C#" AutoEventWireup="true" CodeFile="textboxscanner_scan.aspx.cs"
    Inherits="dialogs_textboxscanner_scan" Theme="default" meta:resourcekey="PageResource1"
    Trace="false" %>

<%@ Register Src="~/credit/usercontrols/loading.ascx" TagName="loading" TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Сканирование</title>
    <script language="javascript" type="text/jscript">
        // закрываем диалог
        function CloseDialog(res) {
            window.returnValue = res;
            window.close();
            return false;
        }

        // урл аплоада
        var SessionID = '';
        var UploadUrl = '';
        var DownloadUrl = '';

        var HasScanedData = false;

        // параметры инициализации контрола
        var InitParams = new Object();

        // установка параметров устройства
        function SetupDevice() {
            // отображать интерфейс сканера
            if (csxi.CanDisableTwainInterface) csxi.UseTwainInterface = (InitParams.UseTwainInterface ? InitParams.UseTwainInterface : false);

            // единицы измерения
            csxi.TwainUnits = (InitParams.TwainUnits ? InitParams.TwainUnits : 0); // unInches
            csxi.TwainPixelType = (InitParams.TwainPixelType ? InitParams.TwainPixelType : 1); // ptGray
            csxi.TwainResolution = (InitParams.TwainResolution ? InitParams.TwainResolution : 100);

            // автоматический поворот и зумирование
            csxi.TwainAutoDeskew = (InitParams.TwainAutoDeskew ? InitParams.TwainAutoDeskew : true);
            csxi.TwainAutoBorder = (InitParams.TwainAutoBorder ? InitParams.TwainAutoBorder : true);

            // ожидаем конца сканирования и показываем прогресс бар
            csxi.AutoZoom = (InitParams.AutoZoom ? InitParams.AutoZoom : true);
            csxi.WaitForAcquire = (InitParams.WaitForAcquire ? InitParams.WaitForAcquire : true);
            csxi.ShowTwainProgress = (InitParams.ShowTwainProgress ? InitParams.ShowTwainProgress : true);

            // тип сжатия для TIF
            csxi.Compression = (InitParams.Compression ? InitParams.Compression : 1); // cmPackBits
        }

        // получение изображения со сканера
        function AcquireImage() {
            // установка параметров устройства
            SetupDevice();
            // получаем изображение
            csxi.Acquire();
        }

        // загружаем сканкопию
        function DownloadImage() {
            try {
                var ImageCount = csxi.ImageCount(DownloadUrl);

                for (var i = 1; i <= ImageCount; i++) {
                    csxi.ReadImageNumber = i;
                    csxi.LoadFromURL(DownloadUrl);
                    csxi.AddToTIF(0);
                }
            }
            catch (e) {
                // если данных нет, то ничего не делаем
            }
        }

        // первичная инициализация
        function Initialisation(sid, hasValue) {
            SessionID = sid;
            UploadUrl = location.protocol + '//' + location.host + '/barsroot/credit/usercontrols/dialogs/textboxscanner_upload.aspx?sid=' + sid + '&rnd=' + Math.random();
            DownloadUrl = location.protocol + '//' + location.host + '/barsroot/credit/usercontrols/dialogs/byteimage_tiffile.ashx?sid=' + sid + '&rnd=' + Math.random();

            // загружаем сканкопию
            DownloadImage();

            // первичный выбор устройства
            FirstSelectDevice();

            // получение изображения со сканера
            AcquireImage();
        }

        // первичный выбор устройства
        function FirstSelectDevice() {
            // если незадано устройство и доступно только одно устройство Twain, то берем его по дефолту
            if (csxi.CurrentTwainDevice == -1) {
                // недоступно ниодно устройство
                if (csxi.TwainDeviceCount == 0) {
                    alert("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_nodevices %>' />");
                    SelectDevice(true);
                }
                // доступно одно устройство
                if (csxi.TwainDeviceCount == 1) {
                    csxi.CurrentTwainDevice = 0;
                    // если устройство не подключено говорим об этом и переходим на диалог выбора устройства
                    SelectDevice(false);
                }
                // если доступно несколько устройств то выбираем одно из них через диалог
                if (csxi.TwainDeviceCount > 1) SelectDevice(true);
            }
        }
        // выбор устройства из доступных
        function SelectDevice(showSelectDialog) {
            if (showSelectDialog) csxi.SelectTwainDevice();
            if (!csxi.TwainConnected) {
                if (confirm("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_devicenotconnected %>' />"))
                    SelectDevice(true);
            }
        }

        // обрабатываем нажатие кнопки AddToMemory
        function AddToMemoryClick() {
            csxi.AddToTIF(0);
            alert("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_successfullyaddedtomemory %>' />");

            HasScanedData = true;
        }

        // пересканирование
        function ReScanClick() {
            // получение изображения со сканера
            AcquireImage();
        }

        // просмотр
        function ViewClick(sid) {
            var DialogOptions = 'width=600, height=620, toolbar=no, location=no, directories=no, menubar=no, scrollbars=yes, resizable=yes, status=no';
            var result = window.open('/barsroot/credit/usercontrols/dialogs/byteimage_show.aspx?sid=' + sid + '&rnd=' + Math.random(), 'view_window', DialogOptions);
        }

        // сохранить
        function SaveClick() {
            // если в память ничего не добавили, то предлагаем добавить текущий скан
            if (!HasScanedData && csxi.ImageLoaded) {
                if (confirm("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_addcurrentdocumenttomemory %>' />")) {
                    AddToMemoryClick();
                }
            }

            // если картинок нет, то удаляем данные
            if (!csxi.ImageLoaded) {
                if (confirm("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_savedeletion %>' />")) {
                    PageMethods.DeleteAllFromMemory(SessionID);
                }
            }
            else {
                var success = csxi.PostImage(UploadUrl, 'scan.tif', '', 7); // gfTIF
            }

            CloseDialog(true);
        }

        // удалить последнюю картинку
        function DeleteFromMemory() {
            // сохраняем картинки в память
            var Images = csxi.WriteBinary(7); // gfTIF
            var ImageCount = csxi.ImageCountBinary(7, Images); // gfTIF

            // чистим текущее отображение
            csxi.ClearTIF();

            // если осталась одна картинка то чистим полностью
            if (ImageCount == 1) {
                DeleteAllFromMemory();
            }
            else {
                // добавляем в текущее отображение все картинки кроме последней
                for (var i = 1; i < ImageCount; i++) {
                    csxi.ReadImageNumber = i;
                    csxi.ReadBinary(7, Images); // gfTIF
                    csxi.AddToTIF(0);
                }
            }

            alert("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_lastimage_deleted %>' />");
        }

        // удалить все картинки
        function DeleteAllFromMemory() {
            csxi.ClearTIF();
            csxi.Clear();

            alert("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_allimages_deleted %>' />");
        }

        // обрезать картинку
        function Crop() {
            csxi.MouseSelectRectangle();
            csxi.CropToSelection();
        }
    </script>
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
</head>
<body>
    <table border="0" cellpadding="3" cellspacing="0" width="99%">
        <tr>
            <td class="pageTitle" align="center" style="padding-top: 20px">
                <asp:Label ID="lbScanTitle" runat="server" Text="Сканированый документ" meta:resourcekey="lbScanTitleResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="border: solid 1px #94ABD9" align="center" valign="middle">
                <object classid="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
                    <param name="LPKPath" value="csximage.lpk">
                </object>
                <object id="csxi" classid="clsid:62E57FC5-1CCD-11D7-8344-00C1261173F0" codebase="csximage.cab"
                    width="600" height="500">
                </object>
            </td>
        </tr>
        <tr>
            <td align="center">
                <form id="form1" runat="server">
                <asp:ScriptManager ID="sm" runat="server" EnablePageMethods="true">
                </asp:ScriptManager>
                <table border="0" cellpadding="3" cellspacing="0">
                    <tr>
                        <td align="left" style="width: 30px">
                            <asp:ImageButton ID="ibSelectDevice" runat="server" ImageUrl="/Common/Images/default/24/gear_replace.png"
                                Text="Сменить источник" ToolTip="Сменить источник" OnClientClick="SelectDevice(true); ReScanClick(); return false;"
                                meta:resourcekey="ibSelectDeviceResource1" />
                        </td>
                        <td align="left" style="width: 100px">
                            <asp:ImageButton ID="ibReScan" runat="server" ImageUrl="/Common/Images/default/24/gear_run.png"
                                Text="Сканировать" ToolTip="Сканировать" OnClientClick="ReScanClick(); return false;"
                                meta:resourcekey="ibReScanResource1" />
                        </td>
                        <td align="center" style="width: 30px">
                            <asp:ImageButton ID="ibAddToMemory" runat="server" ImageUrl="/Common/Images/default/24/document_add.png"
                                Text="Добавить в память" ToolTip="Добавить в память" OnClientClick="AddToMemoryClick(); return false;"
                                meta:resourcekey="ibAddToMemoryResource1" />
                        </td>
                        <td align="center" style="width: 30px">
                            <asp:ImageButton ID="ibDeleteFromMemory" runat="server" ImageUrl="/Common/Images/default/24/document_delete.png"
                                Text="Удалить последний из памяти" ToolTip="Удалить последний из памяти" OnClientClick="DeleteFromMemory(); return false;"
                                meta:resourcekey="ibDeleteFromMemoryResource1" />
                        </td>
                        <td align="center" style="width: 30px">
                            <asp:ImageButton ID="ibDeleteAllFromMemory" runat="server" ImageUrl="/Common/Images/default/24/documents_delete.png"
                                Text="Удалить все из памяти" ToolTip="Удалить все из памяти" OnClientClick="DeleteAllFromMemory(); return false;"
                                meta:resourcekey="ibDeleteAllFromMemoryResource1" />
                        </td>
                        <td align="center" style="width: 30px">
                            <asp:ImageButton ID="ibView" runat="server" ImageUrl="/Common/Images/default/24/documents_view.png"
                                Text="Просмотр" ToolTip="Просмотр" meta:resourcekey="ibViewResource1" />
                        </td>
                        <td align="center" style="width: 30px">
                            <asp:ImageButton ID="ibCrop" runat="server" ImageUrl="/Common/Images/default/24/cut.png"
                                Text="Обрезать" ToolTip="Обрезать" meta:resourcekey="ibCropResource1" OnClientClick="Crop(); return false;" />
                        </td>
                        <td align="right" style="width: 100px">
                            <asp:ImageButton ID="ibSave" runat="server" ImageUrl="/Common/Images/default/24/disk_blue.png"
                                Text="Сохранить" ToolTip="Сохранить" OnClientClick="SaveClick(); return false;"
                                meta:resourcekey="ibSaveResource1" />
                        </td>
                        <td align="right" style="width: 30px">
                            <asp:ImageButton ID="ibCancel" runat="server" ImageUrl="/Common/Images/default/24/delete2.png"
                                Text="Отмена" ToolTip="Отмена" OnClientClick="CloseDialog(null); return false;"
                                meta:resourcekey="ibCancelResource1" />
                        </td>
                    </tr>
                </table>
                </form>
            </td>
        </tr>
    </table>
</body>
</html>
