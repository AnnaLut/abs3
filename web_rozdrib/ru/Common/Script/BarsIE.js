// Скрипт для работы с BarsIE.dll
var barsie$version = "1,1,0,0";

function addEvent(element, event, fn) {
  if (element.addEventListener) element.addEventListener(event, fn, false);
  else if (element.attachEvent) element.attachEvent('on' + event, fn);
  else { element['on' + event] = fn; }
}

addEvent(window, 'load', function () { barsie$init(); });

function barsie$init()
{
  var strObjectBarsie = '<object id="BarsPrint" ' +
                            'classid="CLSID:0E21DB0E-5A6E-435B-885B-04D3D92AA3BE" ' +
                            'style="border:0; width:0; height:0;"></object>';
  if (window['jQuery']) {
    $('body').append(strObjectBarsie);
  } else {
    var elem = document.createElement(strObjectBarsie);
    document.body.insertAdjacentElement('beforeEnd', elem);
  }
}

function barsie$print(filename) {
  if (filename.substring(0, 1) == "/") {
    var type=1;
    var arr = filename.split('printnoconfirm=');
    if (arr.length > 1) {
      type = arr[1].substring(0, 1)=='1'?'1':'2';
    }
    PrintPDF2(type, filename);
  } else {
    try {
      var ax = document.getElementById('BarsPrint');
      ax.CallDPrint(filename, "");
    } catch(e) {
      alert("Не вдалося завантажити активний копонент BarsIE. Зверніться до адміністратора.");
    }
  }
}
//function for JQUERY
function PrintPDF(type, url) {
    if (url == undefined || url == '') {
        url = document.location.href + '&typePrint=pdf&rnd='+Math.random();
    }
    if (type == 5) {
      document.location.href = url;
      return true;
    }
  //перевіримо чи встановлено плагін
  try {
    var test = new ActiveXObject('AcroPDF.PDF');
  } catch (e) {
    document.location.href = url;
    return true;
  }
    $('#objPDF').remove();
    var obj = $('<object  width="0" height="0"  id="objPDF" type="application/pdf" data="' + url + '"></object>');
    var interval = setInterval(function () {
        if ('printAll' in obj.get(0)) {
            clearInterval(interval);
            switch (type) {
                case 1: obj.get(0).printAll();
                    break;
                case 2: obj.get(0).printWithDialog();
                    break;
              case 3:
                    var docH = $(document).height();
                    var docW = $(document).width();
                    var div = $('<div style="height:0px;width:0px;position:absolute;top:' + docH / 2 + 'px;left:' + docW / 2 + 'px;background-color:#fff"></div>');
                    div.html(obj.html());
                    $('body').append(div);
                    div.append(obj);
                    var btClose = $('<div/>');
                    btClose.css({
                        border: '1px solid #565656',
                        position: 'relative',
                        'background-color': '#9a9a9a',
                        height: '16px',
                        width: '16px',
                        top: '0',
                        right: '0',
                        'background-image': 'url(/common/images/default/16/delete2.png)'
                    }).click(function () { div.remove(); });
                    div.prepend(btClose);
                    div.animate({
                        width: (docW - 20) + 'px',
                        height: (docH - 20) + 'px',
                        top: '-=' + ((docH / 2) - 5),
                        left: '-=' + ((docW / 2) - 5)
                    }, 500, function () { div.find('object').attr({ height: (docH - 40) + 'px', width: (docW - 20) + 'px' }); })
                        .css({ border: '3px solid #9a9a9a' });

                    break;
              case 4: obj.get(0).print();
                break;
              case 5: document.location.href = url;
                break;
              default: obj.get(0).printWithDialog();
                    break;
            }
        }
    }, 500);
}
//javaScript all
function PrintPDF2(type, url) {
  if (url == undefined || url == '') {
    url = document.location.href + '&typePrint=pdf&rnd='+Math.random();
  }
  if (type == 5) {
    document.location.href = url;
    return true;
  }
  var objPdf = document.getElementById('objPDF');
  if (objPdf != null) {
    objPdf.removeNode(true);
  }
  //перевіримо чи встановлено плагін
  try {
    var test = new ActiveXObject('AcroPDF.PDF');
  } catch(e) {
    document.location.href = url;
    return true;
  }
  objPdf = document.createElement('<object width="0" height="0" id="objPDF" type="application/pdf" data="' + url + '"></object>');
  document.body.appendChild(objPdf);

  var interval = setInterval(function () {
      if ('printAll' in objPdf) {
        clearInterval(interval);
        switch (type.toString()) {
          case '1':objPdf.printAll();
            break;
          case '2':objPdf.printWithDialog();
            break;
          case '3':objPdf.printWithDialog();
            break;
          case '4': objPdf.print();
            break;
          case '5': document.location.href = url;
            break;
          default: objPdf.printWithDialog();
            break;
        }
      }
    }, 3000);
}