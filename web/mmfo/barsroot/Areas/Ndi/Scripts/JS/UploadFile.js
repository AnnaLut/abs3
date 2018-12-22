$(document).ready(function () {
    
    if ($("#choceDate"))
    $("#choceDate").kendoDatePicker({
        format: "dd/MM/yyyy",
        animation: {
            open: {
                effects: "zoom:in",
                duration: 300
            }
        }
    });

});

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
            if (response.Status == 'OK') {
                bars.ui.success({ title: "Файл  завантажено!", text: response.Message });
            }
            else {
                //commented as causing an error on productive version of IE
                //if (response.data != null)
                //    alert += response.data;
                bars.ui.error({ title: "Помилка", text: response.Message });
            }
        }
        //if response is file
        else {

            bars.ui.error({ title: "Помилка", text: "Помилка при завантаженні файла." });
            var fileContent = $(content).text();
        }

        // Del the iframe...
        setTimeout('iframeId.parentNode.removeChild(iframeId)', 250);
    }

    if (iframeId.addEventListener) iframeId.addEventListener("load", eventHandler, true);
    if (iframeId.attachEvent) iframeId.attachEvent("onload", eventHandler);
    
    bars.ui.loader('fieldset', true);
    var fullPath = $('#uploadInput').val();
    var filename = fullPath.replace(/^.*[\\\/]/, '');
    // Set properties of form...
    form.setAttribute("target", "upload_iframe");
    form.setAttribute("action", "/barsroot/Ndi/ReferenceBook/PostUploadFile?fileName=" + filename + "&tabId=" + window.tabId + '&funcId=' + window.funcId + '&code=' + window.code);
    form.setAttribute("method", "post");
    form.setAttribute("enctype", "multipart/form-data");
    form.setAttribute("encoding", "multipart/form-data");

    // Submit the form...
    form.submit();
}


function fileUploadWithParams() {
    var form = $('#uploadFormWithParams')[0];
    
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
            if (response.Status == 'OK') {
                bars.ui.success({ title: "Файл  завантажено!", text: response.Message });
            }
            else {
                //commented as causing an error on productive version of IE
                //if (response.data != null)
                //    alert += response.data;
                bars.ui.error({ title: "Помилка", text: response.Message });
            }
        }
        //if response is file
        else {

            bars.ui.error({ title: "Помилка", text: "Помилка при завантаженні файла." });
            var fileContent = $(content).text();
        }

        // Del the iframe...
        setTimeout('iframeId.parentNode.removeChild(iframeId)', 250);
    }

    if (iframeId.addEventListener) iframeId.addEventListener("load", eventHandler, true);
    if (iframeId.attachEvent) iframeId.attachEvent("onload", eventHandler);
    
    bars.ui.loader('fieldset', true);
    var date = $('#choceDate').val();
    if (!date) {
        bars.ui.alert("заповніть дату");
        return;
    }

    date = date.split("/");
    console.log(date, $('#date-input').val())
    var month = date[1];
    var year = date[2].substr(2);
    var resDate = month + "." + year;
    fullPath = $('#uploadInput').val();
    var filename = fullPath.replace(/^.*[\\\/]/, '');
    // Set properties of form...
    form.setAttribute("target", "upload_iframe");
    form.setAttribute("action", "/barsroot/Ndi/ReferenceBook/PostUploadFileWithParams?fileName=" + filename + "&tabId=" + window.tabId + '&funcId=' + window.funcId + "&date=" + resDate);
    form.setAttribute("method", "post");
    form.setAttribute("enctype", "multipart/form-data");
    form.setAttribute("encoding", "multipart/form-data");

    // Submit the form...
    form.submit();
}
//reset parameters after file is changed
$("#uploadInput").on('change', function () {
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









function onProcFormSubmit() {

}

function launchClick() {


}