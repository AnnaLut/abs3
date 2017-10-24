Sys.Application.add_load(function () {
    // инициализация табов
    $('#tabs').tabs();
    if ($('#hAccessFlag').val() === '1') {
        var disTabs = [1];
        $('#tabs').tabs("option", "disabled", disTabs);
    }
    var ctrlCountries = $('select[name$="ddCountries"]');
    var ctrlCountry = $('input[name$="tbSCountry"]');
    ctrlCountries.bind("change", function () { if (ctrlCountry.val() != $(this).val()) ctrlCountry.val($(this).val()); });
    ctrlCountry.bind("change", function () { if (ctrlCountries.val() != $(this).val()) ctrlCountries.val($(this).val()); });
});