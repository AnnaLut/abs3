/**
 * Created by serhii.karchavets on 22-Dec-17.
 */

angular.module(globalSettings.modulesAreas).factory("utilsService", function () {
    var _isEmpty = function (v) { return v === null || v === undefined || v === ""; };
    var _isEmptyAll = function (o) { for(var k in o){ if(!_isEmpty(o[k])){ return false; } } return true; };

    function _dateDiff(date1, date2) {
        var years = date2.getFullYear() - date1.getFullYear();
        var months = years * 12 + date2.getMonth() - date1.getMonth();
        var days = parseInt((date2 - date1) / (1000 * 60 * 60 * 24));
        years -= date2.getMonth() < date1.getMonth();
        months -= date2.getDate() < date1.getDate();

        return [years, months, days];
    }

    /**
     * Check 2 objects and return true if o1 === o2 else false
     * @param o1: object
     * @param o2: object
     * @return {boolean}
     */
    function equal(o1, o2) {
        var keys1 = [];
        for(var k in o1){ keys1.push(k); }
        var keys2 = [];
        for(var k in o2){ keys2.push(k); }
        var len = keys1.length;
        if(len !== keys2.length){
            return false;
        }

        for(var x = 0; x < len; x++){
            var k = keys1[x];

            if(o2[k] === undefined){
                return false;
            }
            else if(o1[k] === null ||
                typeof o1[k] === "number" ||
                typeof o1[k] === "boolean" ||
                typeof o1[k] === "string" ||
                typeof o1[k] === "function" ||
                typeof o1[k] === "undefined"){
                if(o1[k] !== o2[k]){
                    return false;
                }
            }
            else if(o1[k] instanceof Date){
                var resDate = _dateDiff(o1[k], o2[k]);
                for(var i = 0; i < resDate.length; i++){
                    if(resDate[i] !== 0){
                        return false;
                    }
                }
            }
            else if(o1[k] instanceof Array){
                var l1 = o1[k].length;
                if(l1 !== o2[k].length){
                    return false;
                }
                for (var j = 0; j < l1; j++){
                    var resArr = equal(o1[k][j], o2[k][j]);
                    if(!resArr){
                        return false;
                    }
                }
            }
            else {
                var res = equal(o1[k], o2[k]);
                if(!res){
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * Copy src to dst (deep copy)
     * @param src
     * @param dst
     */
    function copy(src, dst) {
        var keysSrc = [];
        for(var k in src){ keysSrc.push(k); }
        var len = keysSrc.length;

        for(var x = 0; x < len; x++){
            var k = keysSrc[x];

            if(src[k] === null ||
                typeof src[k] === "number" ||
                typeof src[k] === "boolean" ||
                typeof src[k] === "string" ||
                typeof src[k] === "function" ||
                typeof src[k] === "undefined"){
                dst[k] = src[k];
            }
            else if(src[k] instanceof Date){
                dst[k] = new Date(src[k]);
            }
            else if(src[k] instanceof Array){
                dst[k] = [];
                copy(src[k], dst[k]);
            }
            else {
                dst[k] = {};
                copy(src[k], dst[k]);
            }
        }
    }

    return {
        equal: function (o1, o2) { return equal(o1, o2); },
        copy: function (src, dst) { copy(src, dst); },
        dateDiff: function (date1, date2) { return _dateDiff(date1, date2); },
        isEmpty: function (v) { return _isEmpty(v); },
        isEmptyAll: function (o) { return _isEmptyAll(o); }
    };
});