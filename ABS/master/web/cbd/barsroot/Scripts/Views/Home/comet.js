var clientGuid;

$(function() {
    MessCount();
});

$(window).unload(function() {
    Disconnect();
});

function MessCount() {
  var url = '/barsroot/messagesctrl/count/';
  $.ajax({
    type: 'POST',
    url: url,
    success: function (data, status) {
      if (data != 0) {
        /*var counter = $('<div />', { 'class': 'count' });
        counter.html(data);
        var buttMess = $('#btnMessage');
        buttMess.prepend(counter);*/
        barsUiMess('Перевірте нові повідомлення', 'Нові повідомлення', 1, function () { showMessage(); });
        changeCounter(data);
      }
      Connect();
    },
    error:SendRequest
  });

}

function SendRequest(data, status, respons) {
    var url = '/barsroot/barsweb/comet/CometAsyncHandler.ashx?cid=' + clientGuid;
    $.ajax({
        type: "POST",
        url: url,
        success: function(param1, param2, param3) { ProcessResponse(param1, param2, param3); },
        error: SendRequest
    });
}

function Connect(data, status, respons) {
    var url = '/barsroot/barsweb/comet/CometAsyncHandler.ashx?cpsp=CONNECT';
    $.ajax({
        type: "POST",
        url: url,
        success: function(param1, param2, param3) { OnConnected(param1, param2, param3); },
        error: ConnectionRefused
    });
}

function Disconnect(data, status, respons) {
  var url = '/barsroot/barsweb/comet/CometAsyncHandler.ashx?cpsp=DISCONNECT&cid=' + clientGuid;
  $.ajax({
    type: "POST",
    url: url
  });
}

function ProcessResponse(data, status, respons) {
    //$("#contentWrapper").html(transport);
    //alert(transport);
    //window.open('/barsroot/barsweb/comet/messages.aspx?nocache=' + Math.random(100000), 'cometwin', 'width=600,height=480,location=0,toolbar=0,directories=0,scrollbars=1,resizable=1;');
  barsUiMess(data, 'Нові повідомлення', 1, function () { showMessage(); });
  changeCounter(1);

  SendRequest();
}

function OnConnected(data, status, respons) {
    clientGuid = data;
    SendRequest();
}

function ConnectionRefused() {
    // $("#contentWrapper").html("Unable to connect to Comet server. Reconnecting in 5 seconds...");
    alert('ConnectionRefused');
    window.setTimeout(Connect(), 5000);
}