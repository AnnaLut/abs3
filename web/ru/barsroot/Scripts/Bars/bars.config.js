if (!('bars' in window)) window['bars'] = {};
bars.config = bars.config || {};

bars.config.appName = 'barsroot';
bars.config.baseUrl = '/' + bars.config.appName;
bars.config.urlContent = function (url, params) {
    var result = this.baseUrl;
    if (url) {
        if (result.lastIndexOf('/') !== (result.length - 1) && url.slice(0, 1) !== '/') {
            result += '/';
        } else if ((result.lastIndexOf('/') === (result.length - 1) && url.slice(0, 1) === '/')) {
            result = result.slice(0, result.length - 1);
        }
        result += url;
    }
    if (params) {
        if (result.indexOf('?') === -1) {
            result += '?';
        }
        if (window['$']) {
            result += $.param(params);
        }
    }
    return result;
};
