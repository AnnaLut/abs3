Sys.Application.add_load(function () {
    // инициализация табов
    $('#tabs').tabs({ select: function (event, ui) { $.cookies.set('tabinsan', ui.index); } });
    if ($.cookies.get('tabinsan'))
        $('#tabs').tabs("select", Number($.cookies.get('tabinsan')));

    var ctrlCountries = $('select[name$="ddCountries"]');
    var ctrlCountry = $('input[name$="tbSCountry"]');
    ctrlCountries.bind("change", function () { if (ctrlCountry.val() != $(this).val()) ctrlCountry.val($(this).val()); });
    ctrlCountry.bind("change", function () { if (ctrlCountries.val() != $(this).val()) ctrlCountries.val($(this).val()); });
});