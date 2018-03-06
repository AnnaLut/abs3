angular.module('BarsWeb.Controllers')
    .factory('bridge', function() {
        return {
            birjaBackRequestModel: {
                Mode: null,
                Id: null,
                BackReasonId: null,
                Comment: null
            },
            activeTabGrid: null,
            bDk: 1,
            sDk: 2
        }
    });

