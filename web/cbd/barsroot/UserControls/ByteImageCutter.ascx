<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ByteImageCutter.ascx.cs" Inherits="Bars.UserControls.ByteImageCutter" %>

<table border="0" cellpadding="3" cellspacing="0" width="99%" style="text-align: center">
    <tr>
        <td style="padding-top: 10px">
            <asp:ImageButton ID="ibCrop" runat="server" ImageUrl="/Common/Images/default/24/cut.png"
                Text="Обрезать" ToolTip="Обрезать" />
            <asp:ImageButton ID="ibSave" runat="server" ImageUrl="/Common/Images/default/24/disk_blue.png"
                Text="Сохранить" ToolTip="Сохранить" OnClick="ibSave_Click" />
        </td>
    </tr>
    <tr>
        <td colspan="2" id="ph" runat="server" style="border: 1px solid #94ABD9"></td>
    </tr>
    <tr>
        <td>
            <asp:ImageButton ID="ibPrev" runat="server" ImageUrl="/Common/Images/default/16/navigate_left.png"
                Text="Предидущая" ToolTip="Предидущая страница" meta:resourcekey="ibPrevResource1" />
            <asp:Label ID="lbPageCount" runat="server" Text="Зображення 0 з 0" Font-Bold="True"
                Font-Italic="True" ForeColor="#94ABD9" meta:resourcekey="lbPageCountResource1"></asp:Label>
            <asp:ImageButton ID="ibNext" runat="server" ImageUrl="/Common/Images/default/16/navigate_right.png"
                Text="Следующая" ToolTip="Следующая страница" meta:resourcekey="ibNextResource1" />
        </td>
    </tr>
</table>

<script>
	
	//массив загруженных изображений
	var Images = new Array();
	
	//добавить изображение в массив загруженных изображений
	Images.GetImageData = function(imgNumber) {
		for (var i = 0; i < Images.length; i++) {
			if (Images[i].Number == imgNumber) {
				return Images[i].ByteData;
			}
		}
		return null;
	};
	//получить данные изображения в виде массива байт по переданному номеру изображения
	Images.SetImageData = function(imgNumber, imgData) {
		for (var i = 0; i < Images.length; i++) {
			if (Images[i].Number == imgNumber) {
				Images[i].ByteData = imgData;
			}
		}
	};
	//добавить изображение в массив отсканенных изображений
	Images.AddImage = function(imgNumber, imgData) {
		var newImgObj = {};
		newImgObj.Number = imgNumber;
		newImgObj.ByteData = imgData;
		Images.push(newImgObj);
	};
		
	function InitByteImage(csxi_id, sid, pcount_id, imgcount, type) {
	
		var csxi_obj = $('#' + csxi_id);
		// ид. сессии
		csxi_obj.attr('sid', sid);
		// контролы пейджера
		csxi_obj.attr('pcount_id', pcount_id);
		// значения пейджера
		csxi_obj.attr('imgcount', 0);
		csxi_obj.attr('curimg', 0);
		// устанавливаем кол-во картинок и загружаем первую если есть
		csxi_obj.attr('imgcount', imgcount);
		csxi_obj.attr('curimg', 1);
		
		//настройки контрола и изображения
		SetImageOptons(csxi_id);
		
		//загружаем по очереди все картинки
		var downloadUrl = location.protocol + '//' + location.host + '/barsroot/credit/usercontrols/dialogs/byteimage_tiffile.ashx?sid=' + csxi_obj.attr('sid') + '&type=original';
		for (var i = 1; i <= csxi_obj.attr('imgcount'); i++) {
			var image = $get(csxi_id).CopyBinaryFromURL(downloadUrl + '&page=' + i);
			//добавляем в массив изображений
			Images.AddImage(i, image);
		}
		
		ShowCurrentImage(csxi_id);
		
		// отображем подпись
		RedrawPagerTitle(csxi_id);
	}
	
	function SetImageOptons(csxi_id) {
		//для установки размеров изображения в соответствие размерам контрола
		var csxi_obj = $get(csxi_id);
		csxi_obj.AutoZoom = true;
	}
	
	function ShowPrevImage(csxi_id) {
		var csxi_obj = $('#' + csxi_id);
		var curimg = parseInt(csxi_obj.attr('curimg'), 10);
		if (curimg - 1 >= 1) {
			csxi_obj.attr('curimg', curimg - 1);
			ShowCurrentImage(csxi_id);
			RedrawPagerTitle(csxi_id);
		}
	}
	
	function ShowNextImage(csxi_id) {
		var csxi_obj = $('#' + csxi_id);
		var curimg = parseInt(csxi_obj.attr('curimg'), 10);
		var imgcount = parseInt(csxi_obj.attr('imgcount'), 10);
		if (curimg + 1 <= imgcount) {
			csxi_obj.attr('curimg', curimg + 1);
			ShowCurrentImage(csxi_id);
			RedrawPagerTitle(csxi_id);
		}
	}
	
	function ShowCurrentImage(csxi_id) {
		var csxi_obj = $('#' + csxi_id);
		var imageByteData = Images.GetImageData(csxi_obj.attr('curimg'));
        $get(csxi_id).ReadBinary2(imageByteData);
	}
	
	function RedrawPagerTitle(csxi_id) {
		var csxi_obj = $('#' + csxi_id);

		// если нет контрола для отображенияы пейджера то выходим
		if (csxi_obj.attr('pcount_id') == null || $(csxi_obj.attr('pcount_id')) == null) return;
		
		var pcount_obj = $('#' + csxi_obj.attr('pcount_id'));
		pcount_obj.html('Зображення ' + csxi_obj.attr('curimg') + ' з ' + csxi_obj.attr('imgcount'));
	}
	
	// обрезать картинку
	function Crop(csxi_id) {
		var csxi_obj = $get(csxi_id);

		csxi_obj.MouseSelectRectangle();
		csxi_obj.CropToSelection();
	}

	// сохранить
	function SaveClick(csxi_id) {
		var csxi_obj = $get(csxi_id);
		
		//var imgNumber = $(csxi_obj).attr('curimg');
		//var imageData = csxi_obj.WriteBinary(2);
		//Images.SetImageData(imgNumber, imageData);
		
		// добавляем в память текущую картинку
		//for (var i = 1; i <= $(csxi_obj).attr('imgcount'); i++) {
			 //получаем картинку по номеру
			 //var imageData = Images.GetImageData(i);
			 //загружаем картинку в контрол csxi и добавляем в конец многостаничного PDF 
			 //csxi_obj.ReadBinary2(imageData);
			 //csxi_obj.AddToPDF(0);
		//}

		csxi_obj.AddToPDF(0);
		var uploadUrl = location.protocol + '//' + location.host + '/barsroot/credit/usercontrols/dialogs/textboxscanner_upload.aspx?sid=' + csxi_obj.sid + '&rnd=' + Math.random();
		
		// сохранием на сервере
		var success = csxi_obj.PostImage(uploadUrl, 'scan.pdf', '', 8); 

		return success;
	}
	
</script>