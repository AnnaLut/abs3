var templateLoader = (function ($, host) {
	return {
		loadExtTemplate: function (path) {
		    var tmplLoader = $.get(path)
		        .success(function(result) {
		            $("body").append(result);
		        })
		        .error(function(result) {
		            alert("Помилка завантаження шаблону розширених парамтерів ордера!");
		        });
		}
	};
})(jQuery, document);