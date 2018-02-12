function fileUpload() {
    var form = $('#uploadForm')[0];

    // Create the iframe...
    var iframe = document.createElement("iframe");
    iframe.setAttribute("id", "upload_iframe");
    iframe.setAttribute("name", "upload_iframe");
    iframe.setAttribute("width", "0");
    iframe.setAttribute("height", "0");
    iframe.setAttribute("border", "0");
    iframe.setAttribute("style", "width: 0; height: 0; border: none;");

    // Add to document...
    form.parentNode.appendChild(iframe);
    window.frames['upload_iframe'].name = "upload_iframe";

    iframeId = document.getElementById("upload_iframe");

    // Add event...
    var eventHandler = function () {

        if (iframeId.detachEvent) iframeId.detachEvent("onload", eventHandler);
        else iframeId.removeEventListener("load", eventHandler, false);

        bars.ui.loader('fieldset', false);

        // Message from server...
        if (iframeId.contentDocument) {
            content = iframeId.contentDocument.body.innerHTML;
        } else if (iframeId.contentWindow) {
            content = iframeId.contentWindow.document.body.innerHTML;
        } else if (iframeId.document) {
            content = iframeId.document.body.innerHTML;
        }

        //checking if response is json or fileContent
        if (isJsonString(content)) {
            var response = $.parseJSON(content);
            if (response.status == 'ok') {
                bars.ui.success({ text: "Файл успішно завантажено!" });
            }
            else {
                //commented as causing an error on productive version of IE
                //if (response.data != null)
                //    alert += response.data;
                bars.ui.error({ title: "Помилка", text: response.message });
            }
        }
        //if response is file
        else {

            bars.ui.error({ title: "Помилка", text: "Помилка при завантаженні довідника. Детальну інформацію дивіться у лозі." });
            var fileContent = $(content).text();
            showLoadErrorLog(fileContent);
        }

        // Del the iframe...
        setTimeout('iframeId.parentNode.removeChild(iframeId)', 250);
    }

    if (iframeId.addEventListener) iframeId.addEventListener("load", eventHandler, true);
    if (iframeId.attachEvent) iframeId.attachEvent("onload", eventHandler);

    onUploadFormSubmit();
    bars.ui.loader('fieldset', true);

    // Set properties of form...
    form.setAttribute("target", "upload_iframe");
    form.setAttribute("action", "/barsroot/LinkedGroupReference/LGroupsReference/UploadDocument");
    form.setAttribute("method", "post");
    form.setAttribute("enctype", "multipart/form-data");
    form.setAttribute("encoding", "multipart/form-data");

    // Submit the form...
    form.submit();
}

//reset parameters after file is changed
$("#uploadInput").on('change', function () {
    hideLoadErrorLog();
});

function isJsonString(str) {
    try {
        JSON.parse(str);
    }
    catch (e) {
        return false;
    }
    return true;
}

function showLoadErrorLog(logContent) {
    var logForm = document.getElementById("logForm");
    logForm.style.display = "block";

    var logArea = document.getElementById("ErrorLogArea");
    logArea.value = logContent;
}

function hideLoadErrorLog() {
    $("#ErrorLogArea").val("");
    $("#logForm").css("display", "none");
}

function showProcLog(logContent) {
    var logForm = document.getElementById("ProcedureLogForm");
    logForm.style.display = "block";

    var logArea = document.getElementById("ProcedureLogArea");
    logArea.value = logContent;
}

function hideProcLog() {
    $("#ProcedureLogArea").val("");
    $("#ProcedureLogForm").css("display", "none");
}

function onUploadFormSubmit() {
    hideLoadErrorLog();
    hideProcLog();
}

function onProcFormSubmit() {
    hideProcLog();
}

function launchClick() {

    onProcFormSubmit();
    bars.ui.loader('fieldset', true);

    $.get('/barsroot/LinkedGroupReference/LGroupsReference/LaunchProcedure')
        .done(function (result) {
            bars.ui.loader('fieldset', false);

            if (isJsonString(result)) {
                var response = $.parseJSON(result);
                if (response.status == 'ok') {
                    bars.ui.success({ text: "Проставлення кодів груп пов'язаних осіб на картки контрагентів виконане успішно." });
                }
                else {
                //commented as causing an error on productive version of IE
                //if (response.data != null)
                //    alert += response.data;
                    bars.ui.error({ title: "Помилка", text: response.message });
                }
            }
            //if response is file
            else {
                bars.ui.error({ title: "Помилка", text: "Виникли помилки при виставленні Кодів груп пов'язаних осіб. Детальну інформацію дивіться у лозі." });
                showProcLog(result);
            }

        })
        .fail(function (result) {
            bars.ui.loader('fieldset', false);
            bars.ui.error({ title: "Помилка", text: "Виникли помилки при Виставленні кодів груп пов'язаних осіб." });
        });
}