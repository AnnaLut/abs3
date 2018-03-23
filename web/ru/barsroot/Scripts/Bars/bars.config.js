if (!('bars' in window)) window['bars'] = {};
bars.config = bars.config || {};

bars.config.appName = 'barsroot';
bars.config.urlContent = function (url) {
    return '/' + this.appName + url;
};
