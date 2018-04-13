// скрипт для компонентов из Bars.Grid
function getCharCode(evt) {
  evt = (evt) ? evt : event;
  var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
	((evt.which) ? evt.which : 0));  
  return charCode;
}
