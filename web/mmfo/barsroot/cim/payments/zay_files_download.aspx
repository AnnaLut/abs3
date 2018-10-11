<%@ Page Language="C#" AutoEventWireup="true" CodeFile="zay_files_download.aspx.cs" Inherits="cim_payments_zay_files_download" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .selectedRow {
            background-color: #87CEFA;
        }

        .load-file {
            padding: 5px;
            display: block;
            color: rgb(70, 130, 70) !important;
            text-align: justify;
            text-decoration: none !important;
        }

            .load-file:hover {
                background: rgba(130, 180, 130, 0.5);
                color: rgb(70, 130, 70);
            }

            .load-file:first-of-type {
                border-bottom: 1px dashed rgb(70, 130, 70) !important;
                font-weight: 700;
            }

            .load-file td:first-child {
                width: 120px;
            }
    </style>
    <script src="../../Scripts/jquery/jquery.min.js"></script>
    <script src="../../Scripts/jquery/jquery-ui.min.js"></script>
    <script src="../../Scripts/Bars/bars.config.js"></script>
</head>
<body>
    <form id="formZayFilesDownload" runat="server">
        <div id="dialogAttachments" style="display: none;">
        </div>
    </form>
    <script>
 
        var ref = getParamFromUrl('ID');
        //var hasAttachments = true/* = getParamFromUrl('ATTACHMENTS_COUNT') > 0*/;
        var fnamekb = getParamFromUrl('FNAMEKB') == 'CL';
  
        if (ref) {
            showAttachments(ref);
        }
        else {
            window.close();
        }
        //#region Вікно завантаження прикріплених файлів
        function showAttachments(ref) {
        
            //var bidId = obj.REF;
            var filesList = sessionStorage[ref];
            if (filesList) {
                filesList = JSON.parse(filesList);
                OnGetFileInfos(filesList, ref);
            }
            else {
             
                $.ajax({
                    //async: false,
                    url: bars.config.urlContent("/api/ExternalServices/ExternalServices/GetCorpLightFileInfo"),
                    contentType: "application/json",
                    dataType: "json",
                    data: { fileId: ref },
                    success: function (result) {
                        
                        if (result.error) {
                            alert(result.error);
                            window.close();
                        }
                        else if (result.nodata) {
                            alert("По платежу (реф.док.: " + ref + ") файлів не знайдено.");
                            window.close();
                        }
                        else {
                            window.close();
                            window.open(bars.config.urlContent("/api/ExternalServices/ExternalServices/DownLoadCorpLightFile", { fileId: ref }));
                        
                            //filesList = result;
                            //sessionStorage[ref] = JSON.stringify(result);
                            //OnGetFileInfos(filesList, ref);
                        }
                    }
                });
            }
        }
        function loadFileAnchorClick(e) {
            
            e = e || window.event;
            e.preventDefault ? e.preventDefault() : (e.returnValue = false);
            window.location.href = this.href;
            return false;
        }
        function OnGetFileInfos(filesList, bidId) {
           
            if (filesList.length) {
                var diagAttachments = $('#dialogAttachments');
                diagAttachments.empty();
                //var fileIds = [];
                for (var i = 0; i < filesList.length; i++) {
                    var link = document.createElement('a');
                    link.href = bars.config.urlContent("/api/ExternalServices/ExternalServices/GetCorpLightFile", { fileId: filesList[i].Id });
                    //because IE8
                    link.onclick = loadFileAnchorClick;
                    link.innerHTML = '<table><tr><td>' + filesList[i].FileName + '</td><td>' + filesList[i].Comment + '</td></tr></table>';
                    link.className = 'load-file';
                    diagAttachments.append(link);
                    //fileIds.push(filesList[i].Id);
                }
                if (filesList.length > 1) {
                    var link = document.createElement('a');
                    link.href = bars.config.urlContent("/api/ExternalServices/ExternalServices/GetCorpLightAllFiles", { /*fileIds: fileIds,*/ bidId: bidId });
                    link.onclick = loadFileAnchorClick;
                    link.innerHTML = '<table><tr><td colspan="2">Завантажити всі</td></tr></table>';
                    link.className = 'load-file';
                    diagAttachments.prepend(link);
                }

                try {
                    diagAttachments.dialog('destroy');
                }
                catch (e) { };
                diagAttachments.dialog({
                    autoOpen: false,
                    modal: false,
                    width: 600,
                    title: "Прикріплені файли по заявці №" + bidId,
                    buttons: {
                        Закрити: function () {
                            $(this).dialog("close");
                            window.close();
                        }
                    }
                });
                diagAttachments.dialog('open');
                $("[title='Close']").hide();
            }
        }
        //#endregion
        //достать параметер з URL
        function getParamFromUrl(param, url) {
            /// <summary>достать параметер з URL.</summary>
            /// <param name="param" type="String">параметр який шукаємо.</param>
            /// <param name="url" type="String">url</param>  
            /// <returns type="String">значенна параметра або null якщо його не знайдено.</returns>
            if (url === undefined) {
                url = document.location.href;
            }
            url = url.substring(url.indexOf('?') + 1);
            var paramsArray = url.split("&");
            for (var i = 0; i < paramsArray.length; i++) {
                if (paramsArray[i].split("=")[0].toUpperCase() === param.toUpperCase()) {
                    return paramsArray[i].split("=")[1];
                }
            }
            return null;
        }
    </script>
</body>
</html>
