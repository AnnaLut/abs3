<%@ Page Language="C#" AutoEventWireup="true" CodeFile="textboxscanner_scan.aspx.cs"
    Inherits="dialogs_textboxscanner_scan" Theme="default" meta:resourcekey="PageResource1"
    Trace="false" %>

<link rel="stylesheet" href="/barsroot/content/themes/modernui/css/jquery-ui.css">
<link rel="stylesheet" href="/barsroot/content/themes/modernui/css/style.css">
<script src="/barsroot/scripts/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/barsroot/scripts/jquery/jquery-ui.js" type="text/javascript"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Сканирование</title>
    <style>
        .thumb-selected {
            border: solid 2px #94ABD9;
        }
        .thumb-selected div {
            background-color: #94ABD9;
        }
        .thumb-nonselected {
            border: solid 1px #CCE5FF;
        }
        .thumb-nonselected div {
            background-color: #CCE5FF;
        }

        /*переопределение цвета для jquery slider*/
        .ui-slider-handle {
            background-color: #d3d3d3;
        }
        .ui-slider {
            border: 1px solid #aaaaaa;
        }
    </style>
    <script language="javascript" type="text/jscript">
        //массив загруженных/отсканированных изображений
        var Images = new Array();
        
        //добавить изображение в массив отсканенных изображений
        Images.AddImage = function(imgNumber, imgData) {
            var newImgObj = {};
            newImgObj.Number = imgNumber;
            newImgObj.ByteData = imgData;
            Images.push(newImgObj);
        };
        //удалить изображение из массива по переданному номеру изображения
        Images.DeleteImage = function(imgNumber) {
            for (var i = 0; i < Images.length; i++) {
                if (Images[i].Number == imgNumber) {
                    Images.splice(i, 1);
                }
            }
        };
        //получить данные изображения в виде массива байт по переданному номеру изображения
        Images.GetImageData = function(imgNumber) {
            for (var i = 0; i < Images.length; i++) {
                if (Images[i].Number == imgNumber) {
                    return Images[i].ByteData;
                }
            }
            return null;
        };

        // праметры сканирования, значения по умолчанию
        var ScanSettings = {
            // отображать интерфейс сканера, 1-отображать, 0-не отображать
            UseTwainInterface: false,
            // тип изображения 0: Черно-белое, 1: Оттенки серого, 2: R/G/B цветное
            TwainPixelType: 2,
            // разрешение dpi
            TwainResolution: 100,
            // яркость
            TwainBrightness: 0,
            // контрастность
            TwainContrast:0,
            // разрешить автоматическую коррекцию (выравнивает изображение) 
            TwainAutoDeskew: true,
            // автоматический поворот и зумирование
            TwainAutoBorder: true,
            // ожидаем конца сканирования и показываем прогресс бар
            AutoZoom: true,
            ShowTwainProgress: true
        };

        var SessionID = '';
        var UploadUrl = '';
        var DownloadUrl = '';
        //Формат ПДФ
        var UploadFormat = 8;

        var imgHeight = 0;
        var imgWidth = 0;

        //если "0" - в csxi текущее изображение со сканера, иначе номер уже загруженого изображения
        var viewImageNumber = 0;
        //проверка добавили ли текущую отсканированную картинку в память
        var ScanAddedToMemory = false;

        var ContinueScan = true;
        
        var TwainDeviceName;

        //размеры тамбнейла
        var thumbnailHeight = 120;
        var thumbnailWidth = 120;

		//переменная для прогресс-бара задержки перед сканированием
		var interval;
		
        // закрываем диалог сканирования
        function CloseDialog(res) {
            window.returnValue = res;
            window.close();
            return false;
        }

        // установка параметров устройства
        function SetupDevice() {
            // отображать интерфейс сканера
            if (csxi.CanDisableTwainInterface) {
                csxi.UseTwainInterface = ScanSettings.UseTwainInterface;
            }
            // обходим проблему заглушки от FSC
            if (csxi.TwainPixelTypeAllowed(ScanSettings.TwainPixelType) && TwainDeviceName != 'FSC Camera') {
                csxi.TwainPixelType = ScanSettings.TwainPixelType;
            }
            csxi.TwainResolution = ScanSettings.TwainResolution;
            csxi.TwainBrightness = ScanSettings.TwainBrightness;
            csxi.TwainContrast = ScanSettings.TwainContrast;
            // автоматический поворот и зумирование
            csxi.TwainAutoDeskew = ScanSettings.TwainAutoDeskew;
            csxi.TwainAutoBorder = ScanSettings.TwainAutoBorder;
            csxi.AutoZoom = ScanSettings.AutoZoom;
            // ожидаем конца сканирования и показываем прогресс бар
            csxi.ShowTwainProgress = ScanSettings.ShowTwainProgress;
            csxi.HTTPTimeout = 0;
        }

        // первичная инициализация
        function Initialisation(sid, hasValue, pageCount, imageHeight, imageWidth) {
            SessionID = sid;
            UploadUrl = location.protocol + '//' + location.host + '/barsroot/credit/usercontrols/dialogs/textboxscanner_upload.aspx?sid=' + sid + '&rnd=' + Math.random();
            DownloadUrl = location.protocol + '//' + location.host + '/barsroot/credit/usercontrols/dialogs/byteimage_tiffile.ashx?sid=' + sid + '&rnd=' + Math.random();


            imgHeight = imageHeight;
            imgWidth = imageWidth;

            // загружаем сканкопию
            DownloadImage(pageCount);

            // первичный выбор устройства
            FirstSelectDevice();
            //инициализация контролов (jQueryUI и прочее)
            InitControls(WaitForAcquireImage);
            
            
        }
		
        //инициализация элементов управления
        function InitControls(doScanProc) {
            //добавляем возможность сортировки тамбнейлов
            $("#thumbnails tbody").sortable().disableSelection();

            //для большинства устройств значение яркости и контрастности должно быть в интервале от -1000 до 1000
            //но, к примеру, у того же проблемного CanoScan LiDE 210 нижнее значение почему-то -999,999948...
            //поэтому берем пока что от -900 до 900, а если будут проблемы с еще каким-то конкретным видом сканера то будем решать по ходу
            var minBrightContrast = -900;
            var maxBrightContrast = 900;

            //слайдеры для настройки якрости и контрастности сканирования, 
            $("#scanBrightness, #scanContrast").slider({ min: minBrightContrast, max: maxBrightContrast });

            //событие изменения состояния чекбокса, который отвечает за использование стандартного диалога настроек сканирования
            $("#scanInterface").on("change", function () {
                $('.noScanInterface').attr('disabled', this.checked);
            });

            //задаем настройки сканирования - если есть берем из cookie, иначе остаются значения по умолчанию
            if (getCookie('scanInterface') != null) {
                ScanSettings.UseTwainInterface = getCookie('scanInterface');
                ScanSettings.TwainPixelType = getCookie('scanType');
                ScanSettings.TwainResolution = parseInt(getCookie('scanResolution'));
                ScanSettings.TwainBrightness = parseInt(getCookie('scanBrightness'));
                ScanSettings.TwainContrast =  parseInt(getCookie('scanContrast'));
                ScanSettings.FlowScan = getCookie('flowScan') === 'true';
                ScanSettingsFromObjectToControls();

                if (ScanSettings.FlowScan && doScanProc) {
                    doScanProc();
                }
            } else {
                Bars.UserControls.WebServices.TextBoxScanner.GetObjectParams(
                    function(data) {
                        ScanSettings.TwainPixelType = data.TwainPixelType;
                        ScanSettings.TwainResolution = data.TwainResolution;
                        ScanSettings.TwainBrightness = data.TwainBrightness;
                        ScanSettingsFromObjectToControls();

                        if (ScanSettings.FlowScan && doScanProc) {
                            doScanProc();
                        }
                    });
            }
            
            $('.noScanInterface').attr('disabled', $("#scanInterface")[0].checked);
        }

        function ScanSettingsFromControlsToObject() {
            //div с настройками
            var settingsContainer = $("#settingsContainer");
            //контролы с настройками
            ScanSettings.UseTwainInterface = settingsContainer.find("#scanInterface")[0].checked;
            ScanSettings.TwainPixelType = settingsContainer.find("#scanType")[0].value;
            ScanSettings.TwainResolution = settingsContainer.find("#scanResolution")[0].value;
            ScanSettings.TwainBrightness = settingsContainer.find("#scanBrightness").slider("value");
            ScanSettings.TwainContrast = settingsContainer.find("#scanContrast").slider("value");
            ScanSettings.FlowScan = settingsContainer.find("#flowScan")[0].checked;

            //сохраняем новые значения настроек в cookie чтобы при следующем запуске подтянуть их
            setCookie('scanInterface', ScanSettings.UseTwainInterface);
            setCookie('scanType', ScanSettings.TwainPixelType);
            setCookie('scanResolution', ScanSettings.TwainResolution);
            setCookie('scanBrightness', ScanSettings.TwainBrightness);
            setCookie('scanContrast', ScanSettings.TwainContrast);
            setCookie('flowScan', ScanSettings.FlowScan ? 'true' : 'false');
        }

        function ScanSettingsFromObjectToControls() {
            //div с настройками
            var settingsContainer = $("#settingsContainer");
            //контролы с настройками
            settingsContainer.find("#scanInterface")[0].checked = ScanSettings.UseTwainInterface == "true";
            settingsContainer.find("#scanType")[0].value = ScanSettings.TwainPixelType;
            settingsContainer.find("#scanResolution")[0].value = ScanSettings.TwainResolution;
            settingsContainer.find("#scanBrightness").slider("value", ScanSettings.TwainBrightness);
            settingsContainer.find("#scanContrast").slider("value", ScanSettings.TwainContrast);
            settingsContainer.find("#flowScan")[0].checked = ScanSettings.FlowScan;
        }

        // первичный выбор устройства
        function FirstSelectDevice() {
		
            // если незадано устройство и доступно только одно устройство Twain, то берем его по дефолту
            if (csxi.CurrentTwainDevice == -1) {
			
				var deviceName = GetSelectedDevice();
				//пробуем выбрать устройство по его имени в сохраненных cookie
				var hasSelectedDevice = deviceName && csxi.SelectTwainDeviceByName(deviceName);
				if (!hasSelectedDevice) {
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
        }

        // выбор устройства из доступных
        function SelectDevice(showSelectDialog) {
            if (showSelectDialog) csxi.SelectTwainDevice();
            if (!csxi.TwainConnected) {
                if (confirm("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_devicenotconnected %>' />"))
                SelectDevice(true);
            }
            else {
                TwainDeviceName = csxi.TwainDeviceName(csxi.CurrentTwainDevice);
				SetSelectedDevice(TwainDeviceName);
            }
        }

        // показываем прогресс-бар с задержкой перед сканированием
        function WaitForAcquireImage() {
				// установка параметров устройства
				SetupDevice();

                //продолжать сканирование пока не нажмем отмену
				ContinueScan = ScanSettings.FlowScan;

				//если устройство подключено
				if (csxi.TwainConnected) {
				    
				    if (!ContinueScan) {
				        AcquireImage();
				        AddToMemoryClick();
				    } else {
				        //показать progress-bar и скрыть панель кнопок
				        $('#progressContainer').css("display", "");
				        $('#buttonsContainer').css("display", "none");

				        var progressBar = $("#progressbar");
				        //по окончании прогрес-бара - сканирование
				        progressBar.unbind().bind("progressbarcomplete", function(event, ui) {
				            CancelProgressBar();
				            //сканируем пока не нажмем кнопку отмены
				            AcquireImageMultiple();
				        });
				        var progressValue = 1;
				        progressBar.progressbar({
				            max: 20, //длительность 20 секунд
				            value: progressValue //текущее значение прогрес-бара
				        });

				        //ежесекундно увеличиваем значение прогрес-бара
				        interval = setInterval(function() {
				            progressValue++;
				            progressBar.progressbar({ value: progressValue });
				        }, 1000);
				    }
				}
        }
		
        // получение изображения со сканера
        function AcquireImageMultiple() {
            //если пользователь не нажал отмену, продолжаем сканирование
            if (ContinueScan) {
                //сканировать
                AcquireImage();
                //сразу же добавляем отсканированное изображение в память
                AddToMemoryClick();
                //продолжаем сканировать, пока не нажмем отмену
                WaitForAcquireImage();
            }
        }

		// получение изображения со сканера
        function AcquireImage() {
			//получить изображение со сканера
            csxi.Acquire();

			//текущее просматриваемое изображение - если "0" - в csxi текущее изображение со сканера
			viewImageNumber = 0;
			//удалить все выделения в тамбнейлах
			ClearAllSelection();
			
			//текущее просматриваемое изображение ещё не было добавлено в память
			ScanAddedToMemory = false;
        }

        //останавливает сканирование
        function CancelScan() {
            ContinueScan = false;
        }

        // загружаем сканкопию
        function DownloadImage(pageCount) {
            try {
                for (var i = 1; i <= pageCount; i++) {
                    //загружаем по очереди все картинки
                    var image = csxi.CopyBinaryFromURL(DownloadUrl + '&page=' + i);
                    
                    //добавляем в массив изображений
                    Images.AddImage(i, image);
                    //добавляем тамбнейл текущей картинки 
                    AppendThumbnailsTable(i, image);
                }
            }
            catch (e) {
                alert(e.message + e.description);
                // если данных нет, то ничего не делаем
            }
        }

        //добавить картинку в табицу тамбнейлов
        function AppendThumbnailsTable(thumbnailNumber, imageData) {
            var thumbnailsTable = $('#thumbnails');
            //передаем объект thumbnail в метод удаления
            var deleteOnclick = "DeleteClick($(this).parent().find('object').filter('[id^=csxi]')); return false;";
            thumbnailsTable.append(
                "<tr>" +
                    //ширину ячейки устанавливаем как ширину тамбнейла
                    "<td class='thumb-nonselected' style='position:relative; width:" + thumbnailWidth + "px;'>" +
						"<div style='cursor:move; height=10px;'></div>" +
						"<object id='csxi" + thumbnailNumber + "' data-number = '" + thumbnailNumber + "' classid='clsid:62E57FC5-1CCD-11D7-8344-00C1261173F0'" +
							"codebase='csxiimage.cab' width=" + thumbnailWidth + " height=" + thumbnailHeight + ">" +
						"</object>" +
						'<img src="/Common/Images/default/16/cancel.png" style="cursor:pointer;" onclick="' + deleteOnclick + '" style="position:absolute; top:0px; right:2px;" ></img>' +
                    "</td>" +
                "</tr>");
            
            //загружаем картинку в тамбнейл
            var currCsXImage = document.getElementById('csxi' + thumbnailNumber);
            currCsXImage.ReadBinary2(imageData);
            currCsXImage.ResizeImage(thumbnailHeight, thumbnailWidth);
            //добавляет click event для тамбнейла(в функцию передаем текущий объект тамбнейла)
            //в IE 11 нет attachEvent, а addEventListener не работает, нужно разбираться
            if (currCsXImage.attachEvent) {
                currCsXImage.attachEvent("onclick", function(x) { return function() { SelectThumbnail(x); return false; } }(currCsXImage));
            }
        }
        
        //удалить изображение по клику на иконку удаления тамбнейла
        function DeleteClick(thumbnail) {
            //проверяем добавлена ли в память текущаю отсканированная картинка 
            AskAddToMemory();

            if (confirm("Видалити зображення?")) {
                // если осталась одна картинка то чистим полностью
                if (Images.length == 1) {
                    DeleteAllFromMemory();
                }
                else {
                    //удалить изображение из массива
                    var delImageNumber = thumbnail.data('number');
                    Images.DeleteImage(delImageNumber);

                    //удалить строку таблицы с текущим thumbnail
                    thumbnail.parent().parent().remove();
                    
                    //если удалили изображение которое просматривали - очистить текущее просматриваемое изображение
                    if (viewImageNumber == delImageNumber) {
                        csxi.Clear();
                        viewImageNumber = 0;
                    }
                }
            }
        }

        //выбор тамбнейла для просмотра большой картинки
        function SelectThumbnail(thumbnail) {
            //проверяем добавлена ли в память текущаю отсканированная картинка 
            //(т.к. просмотр картинки с тамбнейла перетрет текущую отсканеную картинку)
            AskAddToMemory();
            
            //получаем номер картинки из тамбнейла и отображаем большое изображение 
            var thumbnailNumber = $(thumbnail).data('number');
            var imageByteData = Images.GetImageData(thumbnailNumber);
            csxi.ReadBinary2(imageByteData);

            //чистим рамки выделения всех тамбнейлов
            ClearAllSelection();
            //устанавливаем рамку на текущем
            $(thumbnail).parent().attr("class", "thumb-selected");

            //устанавливаем номер текущей просматриваемой картинки
            viewImageNumber = thumbnailNumber;
        }

        // настройки сканирования
        function SettingsClick() {
            //показать панель настроек и скрыть панель кнопок
            $('#settingsContainer').css("display", "");
            $('#buttonsContainer').css("display", "none");
        }

        // сохранение настроек сканирования
        function SaveSettings() {
            //скрыть панель настроек и показать панель кнопок
            $('#settingsContainer').css("display", "none");
            $('#buttonsContainer').css("display", "");

            //инициализируем новые настройки сканирования (сохраняем значения контролов в javascript объект)
            ScanSettingsFromControlsToObject();
        }

        // пересканирование
        function ReScanClick() {
            // получение изображения со сканера
            WaitForAcquireImage();
        }

        // обрабатываем нажатие кнопки AddToMemory
        function AddToMemoryClick() {
            //если есть загруженная картинка
            if (csxi.ImageLoaded) {

                //текущее отсканенное изображение считываем в формате Jpeg
                var imageData = csxi.WriteBinary(2); 
                var addImageNumber;

                //определяем номер добавляемого изображения как "1" если первая картинка или "номер последней + 1"
                if (Images.length == 0) {
                    addImageNumber = 1;
                } else {
                    addImageNumber = Images[Images.length - 1].Number + 1; 
                }

                //добавить в массив изображений
                Images.AddImage(addImageNumber, imageData);
                //добавить в таблицу тамбнейлов текущее добавленное изображение 
                AppendThumbnailsTable(addImageNumber, imageData);

                //выделяем его рамкой как просматриваемое
                ClearAllSelection();
                $("#csxi" + addImageNumber).parent().attr("class", "thumb-selected");
                
                //признак что текущий скан добавлен в память
                ScanAddedToMemory = true;
            }
        }
        
        // удалить все картинки
        function DeleteAllFromMemory() {
            
            //удалисть все изображения из массива и очистить текущее просматриваемое изображение
            Images.splice(0, Images.length);
            csxi.Clear();

            //очистить все тамбнейлы
            $('#thumbnails tr').empty();
            alert("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_allimages_deleted %>' />");
        }

        // обрезать картинку
        function Crop() {
            csxi.MouseSelectRectangle();
            csxi.CropToSelection();
        }
        // повернуть картинку
        function Rotate() {
            csxi.Rotate(90);
        }
        
        // сохранить
        function SaveClick() {
            // если в память ничего не добавили, то предлагаем добавить текущий скан
            AskAddToMemory();

            var imageCount = $('#thumbnails object').length;
            // если картинок нет, то удаляем данные
            if (!csxi.ImageLoaded && imageCount == 0) {
                if (confirm("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_savedeletion %>' />")) {
                    Bars.UserControls.WebServices.TextBoxScanner.DeleteAllFromMemory(SessionID, null, null);
                }
            }
            else {
                //перезаписать картинки в правильном порядке (т.к. могли перетаскивать)
                var thumbnails = $('#thumbnails object');
                    for (var i = 0; i < thumbnails.length; i++) {
                        //получаем номер картинки у текущего тамбнейла
                        var imageNumber = $(thumbnails[i]).data('number');
                        //получаем картинку по номеру
                        var imageData = Images.GetImageData(imageNumber);
                        //загружаем картинку в контрол csxi и добавляем в конец многостаничного PDF 
                        csxi.ReadBinary2(imageData);
                        if (imgHeight > 0 && imgWidth > 0) {
                            csxi.ResizeImage(imgWidth, imgHeight);
                        }
                        csxi.AddToPDF(0);
                    }
                    var success = csxi.PostImage(UploadUrl, 'scan.pdf', '', UploadFormat); //передаем файл формата PDF на сервер
                    if (success == false) {
                        alert('Не вдалося завантажити файл на веб-сервер, код відповіді від серверу: ' + csxi.PostReturnCode);
                    }
                }
            CloseDialog(true);
        }
        
        //запрос на добавление текущей отсканированной картинки в память
        function AskAddToMemory() {
            //если отображается текущая отсканированная картинка и не было добавления её в память
            if (viewImageNumber == 0 && csxi.ImageLoaded && !ScanAddedToMemory) {
                if (confirm("<asp:Literal runat=server text='<%$ Resources: usercontrols, textboxscanner_scan_addcurrentdocumenttomemory %>' />")) {
                    AddToMemoryClick();
                }
            }
        }
        
        //очистить рамки выделения всех тамбнейлов
        function ClearAllSelection() {
            var thumbnailsCells = $('#thumbnails td');
            if (thumbnailsCells) {
                thumbnailsCells.attr('class', 'thumb-nonselected');
            }
        }
		
		function CancelProgressBar() {
			//больше не вызывать setInterval для увеличения значения progressbar
			clearInterval(interval);
			//скрыть progress-bar и показать панель кнопок
			$('#progressContainer').css("display", "none");
			$('#buttonsContainer').css("display", "");
		}

		function CancelSettings() {
		    //скрыть панель настроек и показать панель кнопок
		    $('#settingsContainer').css("display", "none");
		    $('#buttonsContainer').css("display", "");

            //при отмене ничего не сохраняем и инициализируем контролы значениями которые были до этого
		    ScanSettingsFromObjectToControls();
		}
		
		// установка и получение cookie
		function getCookie(c_name) {
			var c_value = document.cookie;
			var c_start = c_value.indexOf(" " + c_name + "=");
			if (c_start == -1) {
				c_start = c_value.indexOf(c_name + "=");
			}
			if (c_start == -1) {
				c_value = null;
			}
			else {
				c_start = c_value.indexOf("=", c_start) + 1;
				var c_end = c_value.indexOf(";", c_start);
				if (c_end == -1) {
					c_end = c_value.length;
				}
				c_value = unescape(c_value.substring(c_start, c_end));
			}
			return c_value;
		}
		function setCookie(c_name, value, exdays) {
		    if (!exdays) {
		        exdays = 365;
		    }
			var exdate = new Date();
			exdate.setDate(exdate.getDate() + exdays);
			var c_value = escape(value) + "; expires=" + exdate.toUTCString();
			document.cookie = c_name + "=" + c_value;
		}

		// текущее выбранное устройство для сканирования
		var _selectedDevice;
		function SetSelectedDevice(deviceName) {
			_selectedDevice = deviceName;
			setCookie('ScanSelectedDevice', deviceName);
		}
		function GetSelectedDevice() {
			if (!_selectedDevice)
				_selectedDevice = getCookie('ScanSelectedDevice');

			return _selectedDevice;
		}

    </script>
    <base target="_self" />
</head>
<body style="font-family: tahoma, arial, sans-serif; font-size: 9pt">
    <table border="0" cellpadding="3" cellspacing="0" width="99%">
        <tr>
            <td colspan="2" class="pageTitle" style="padding-top: 20px; text-align: center">
                <asp:Label ID="lbScanTitle" runat="server" Text="Сканкопія/Фото"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="border: solid 1px #94ABD9; width: 700px" align="center" valign="middle">
                <div id="mainContainer">
                    <object classid="clsid:5220cb21-c88d-11cf-b347-00aa00a28331">
                        <param name="LPKPath" value="csximage.lpk">
                    </object>
                    <object id="csxi" classid="clsid:62E57FC5-1CCD-11D7-8344-00C1261173F0" codebase="csximage.cab" width="600" height="500">
                    </object>
                </div>
            </td>
            <td style="border: solid 1px #94ABD9; text-align: center; vertical-align: top; width: 130px">
                <div style="overflow: auto; height: 500px;">
                    <table id="thumbnails" border="0" cellpadding="0" cellspacing="5" width="125px" >
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <%--font-family: tahoma, arial, sans-serif; font-size: 9pt--%>
            <td colspan="2" style="padding-left: 40px;">
				<div id="progressContainer" style="display:none;">
					<table width="640px">
					    <tr>
					        <td width="600px">
					           Вставте нову сторінку та виконайте "Сканувати"
					        </td>
                            <td width="20px" style="padding-left: 50px">
					            <a title = "Почати сканування зараз" style="cursor:pointer;" onclick="CancelProgressBar(); AcquireImageMultiple(); return false;">
						            <img src="/Common/Images/default/24/gear_run.png"></img>
					            </a>
					        </td>
                            <td width="20px">
                                <a title = "Відміна" style="cursor:pointer;" onclick="CancelScan(); CancelProgressBar(); return false;">
						            <img src="/Common/Images/default/24/delete2.png"></img>
					            </a> 
                            </td>
                        </tr>
                        <tr>
                            <td width="700px">
					            <div id="progressbar"></div>
					        </td>
                        </tr>
                    </table>
				</div>
                <div id="settingsContainer" style="display:none;">
					<table width="640px" style="font-size: 10pt">
					    <tr>
					        <td width="300px">
					            Стандартне вікно налаштувань сканера
					        </td>
                            <td width="50px" >
                                <input id="scanInterface" type="checkbox">
                            </td>
                            <td width="80px">
			                    Яскравість
                            </td>
                            <td width="220px" >
                                <div id="scanBrightness" class="noScanInterface"></div>
                            </td>
                            <td width="20px" style="padding-left: 50px">
					            <a title = "Зберегти налаштування" style="cursor:pointer;" onclick="SaveSettings(); return false;">
			                        <img src="/Common/Images/default/24/disk_blue.png"></img>
		                        </a>
					        </td>
                            <td width="20px">
                                <a title = "Відміна" style="cursor:pointer;" onclick="CancelSettings(); return false;">
			                        <img src="/Common/Images/default/24/delete2.png"></img>
		                        </a> 
                            </td>
                        </tr>
                        <tr style="border:#cce5ff 1px dashed;" >
                            <td width="300px">
			                    Тип зображення
                            </td>
                            <td width="50px" >
                                <select id="scanType" class="noScanInterface" style="margin-right:5px;" >
                                    <option value="0">Чорно-біле</option>
			                        <option value="1">Відтінки сірого</option>
			                        <option value="2">Кольорове</option>
			                    </select>
                            </td>
                            
                            <td width="80px">
					            Контрасність
					        </td>
                            <td width="220px" >
                                <div id="scanContrast" class="noScanInterface"></div>
                            </td>
                        </tr>
                        <tr style="border:#cce5ff 1px dashed;" >
                            <td width="400px">
			                    Чіткість зображення (dpi)
                            </td>
                            <td width="50px" >
                                <select id="scanResolution" class="noScanInterface">
			                        <option value="100">100</option>
			                        <option value="200">200</option>
			                        <option value="300">300</option>
			                        <option value="400">400</option>
                                    <option value="500">500</option>
			                    </select>
                            </td>
                            <td width="350px">
					            Потокове сканування
					        </td>
                            <td width="50px" >
                                <input id="flowScan" type="checkbox">
                            </td>
                        </tr>
                    </table>
				</div>
				<div id="buttonsContainer">
					<form id="form1" runat="server">
						<asp:ScriptManager ID="sm" runat="server">
							<Services>
								<asp:ServiceReference Path="/barsroot/credit/usercontrols/webservices/TextBoxScanner.asmx" />
							</Services>
						</asp:ScriptManager>
						<table border="0" cellpadding="3" cellspacing="0">
							<tr>
							    <td align="left" style="width: 30px">
									<asp:ImageButton ID="ibReScan" runat="server" ImageUrl="/Common/Images/default/24/gear_run.png"
										Text="Сканировать" ToolTip="Сканировать" OnClientClick="ReScanClick(); return false;"
										meta:resourcekey="ibReScanResource1" />
								</td>
                                <td align="left" style="width: 30px">
									<asp:ImageButton ID="ibSelectDevice" runat="server" ImageUrl="/Common/Images/default/24/gear_replace.png"
										Text="Сменить источник" ToolTip="Сменить источник" OnClientClick="SelectDevice(true); ReScanClick(); return false;"
										meta:resourcekey="ibSelectDeviceResource1" />
								</td>
							    <td align="left" style="width: 200px">
									<asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="/Common/Images/default/24/gear_settings.png"
										Text="Параметри сканування" ToolTip="Параметри сканування" OnClientClick="SettingsClick(); return false;"/>
								</td>
								<td align="center" style="width: 30px">
									<asp:ImageButton ID="ibAddToMemory" runat="server" ImageUrl="/Common/Images/default/24/document_add.png"
										Text="Добавить в память" ToolTip="Добавить в память" OnClientClick="AddToMemoryClick(); return false;"
										meta:resourcekey="ibAddToMemoryResource1" />
								</td>
								<td align="center" style="width: 30px">
									<asp:ImageButton ID="ibDeleteAllFromMemory" runat="server" ImageUrl="/Common/Images/default/24/documents_delete.png"
										Text="Удалить все из памяти" ToolTip="Удалить все из памяти" OnClientClick="DeleteAllFromMemory(); return false;"
										meta:resourcekey="ibDeleteAllFromMemoryResource1" />
								</td>
								<td align="center" style="width: 30px">
									<asp:ImageButton ID="ibCrop" runat="server" ImageUrl="/Common/Images/default/24/cut.png"
										Text="Обрезать" ToolTip="Обрезать" meta:resourcekey="ibCropResource1" OnClientClick="Crop(); return false;" />
								</td>
								<td align="center" style="width: 30px">
									<asp:ImageButton ID="ibRotate" runat="server" ImageUrl="/Common/Images/default/24/recycle.png"
										Text="Повернути" ToolTip="Повернути" OnClientClick="Rotate(); return false;" />
								</td>
								<td align="right" style="width: 182px">
									<asp:ImageButton ID="ibSave" runat="server" ImageUrl="/Common/Images/default/24/disk_blue.png"
										Text="Сохранить" ToolTip="Сохранить" OnClientClick="SaveClick(); return false;"
										meta:resourcekey="ibSaveResource1" />
								</td>
								<td style="width: 20px">
									<asp:ImageButton ID="ibCancel" runat="server" ImageUrl="/Common/Images/default/24/delete2.png"
										Text="Отмена" ToolTip="Отмена" OnClientClick="CloseDialog(null); return false;"
										meta:resourcekey="ibCancelResource1" />
								</td>
							</tr>
						</table>
					</form>
				</div>
            </td>
        </tr>
    </table>
</body>
</html>
