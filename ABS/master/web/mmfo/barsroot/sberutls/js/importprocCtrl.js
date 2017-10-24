$(document).ready(function () {
    function getUrlVars(url) {
        var vars = {};
        var parts = url.replace(/[?&]+([^=&]+)=([^&]*)/gi,
        function (m, key, value) {
            vars[key] = value;
        });
        return vars;
    }
    

    function isDigit(str){
        return /^\d+$/.test(str);
    }
    function dateInputController(e, component) {

        e.preventDefault();
        var char = String.fromCharCode(e.keyCode);
        var currSDate = component.val();
        if (currSDate.length < 10 && isDigit(char)) {
            if (currSDate.length == 2 || currSDate.length == 5) {
                currSDate += '.';
            }
            currSDate += char;      
        }
        component.val(currSDate);
    }

    function addDays(dateObj, numDays) {
        dateObj.setDate(dateObj.getDate() + numDays);
        return dateObj;
    }

    $("input[name='dStart_t']").keypress(function (e) {
        dateInputController(e, $("input[name='dStart']"));
    });


    $("input[name='dStart']").kendoDatePicker({
        culture: "uk-UA",
        format: "dd.MM.yyyy",
        value: addDays(new Date(), - 7)
    });
    $("input[name='dEnd']").kendoDatePicker({
        culture: "uk-UA",
        format: "dd.MM.yyyy",
        value: new Date()
    });

    $("input[name='dEnd_t']").keypress(function (e) {
        dateInputController(e, $("input[name='dEnd']"));
    });
    $("input[name='FilterByDate']").click(function () {     
        var dstart = $("input[name='dStart']").val();
        var dend = $("input[name='dEnd']").val();
        var tp = getUrlVars(document.URL)['tp']
        var nurl = document.URL.split("?")[0] + "?"
         + "tp=" + tp
         + "&dfilt=" + "DAT"
         + "&dstart=" + dstart
         + "&dend=" + dend;
        if (dstart.length == 10 && dend.length == 10) { 
            window.location.href = nurl;
        }
    });
    $("input[name='clearDateFilter']").click(function () {

        var tp = getUrlVars(document.URL)['tp']
        var nurl = document.URL.split("?")[0] + "?"
         + "tp=" + tp;
        window.location.href = nurl;
    });
    setInterval(calkSumOfSelected, 1000);
    function calkSumOfSelected() {
        //select all chosen items
        var lines = $(".selectedRow");
        var lineN =  lines.length;
        var lineSum = 0;
        if (lineN > 0) {
            for (var i = 0; i < lineN; i++) {
                lineSum += parseFloat(lines[i].children[8].innerHTML.replace(/\,/g, ''));
            }
        }
        $("b[name='selNum']")[0].innerText =(lineN);
        $("b[name='selSum']")[0].innerText = lineSum;//(lineSum.toFixed(2));
    }

    function checkIfDateFintExist() {
        if (getUrlVars(document.URL)['dstart']) {
            var dstart = kendo.parseDate(getUrlVars(document.URL)['dstart'], "dd.MM.yyyy");
            $("input[name='dStart']").data("kendoDatePicker").value(dstart);
        }
        if (getUrlVars(document.URL)['dEnd']) {
            var dend = kendo.parseDate(getUrlVars(document.URL)['dEnd'], "dd.MM.yyyy");
            $("input[name='dEnd']").data("kendoDatePicker").value(dend);
        }
    }
    checkIfDateFintExist();
});