app.factory("LS", function ($window) {
    return {
        setData: function (val) {
            $window.localStorage && $window.localStorage.setItem('columnsFilter', val);
            return this;
        },
        getData: function () {
            return $window.localStorage && $window.localStorage.getItem('columnsFilter');
        }
    };
});