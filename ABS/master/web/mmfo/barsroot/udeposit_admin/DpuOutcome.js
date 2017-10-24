$(document).ready(function () {

    // create a template using the above definition
    var template = kendo.template($("#template").html());

    //
    var section = [
        { "order": null, "state": null, "title": "Валюта", "code": "CURRENCY" },
        { "order": null, "state": null, "title": "Бал. рах.", "code": "R020" },
        { "order": null, "state": null, "title": "Продукт", "code": "TYPE" },
        { "order": null, "state": null, "title": "Підрозділ", "code": "BRANCH" },
        { "order": null, "state": null, "title": "Виконавець", "code": "USER" }
    ];

    // 
    var dataSource = new kendo.data.DataSource({
        data: section,
        change: function () { // subscribe to the CHANGE event of the data source
            $("#section tbody").html(kendo.render(template, this.view())); // populate the table
        }
    });

    // read data from the "movies" array
    dataSource.read();
});