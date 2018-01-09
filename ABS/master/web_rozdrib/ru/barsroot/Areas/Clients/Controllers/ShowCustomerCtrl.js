angular.module(globalSettings.modulesAreas)
    .controller('Clients.ShowCustomer',
        ['$scope', 'customersService',
        function ($scope, customersService) {
            'use strict';

            var vm = this;
           
            vm.custParamTabsOptions = {
                animation: { open: { effects: "fadeIn" } },
                dataTextField: "text",
                //dataSpriteCssClass: "spriteCssClass",
                dataContentField: "content"/*,

                dataSource: [
                    {
                        text: 'Основна інформація',
                        spriteCssClass: "brazilFlag",
                        content: '0'
                    }, {
                        text: "Рекв. платника под.",
                        spriteCssClass: "indiaFlag",
                        contentUrl: "/barsroot/board/index/?partial=true"
                    }, {
                        text: "Ек. нормативи",
                        spriteCssClass: "netherlandsFlag",
                        content: '2'
                    },{
                        text: "Реквізити клієнта",
                        spriteCssClass: "brazilFlag",
                        content: '3'
                    }, {
                        text: "Додаткова інф.",
                        spriteCssClass: "indiaFlag",
                        content: '4'
                    }, {
                        text: "Деталі",
                        spriteCssClass: "netherlandsFlag",
                        content: '5'
                    }, {
                        text: "Зв'зки",
                        spriteCssClass: "netherlandsFlag",
                        content: '6'
                    }, {
                        text: "Історія",
                        spriteCssClass: "netherlandsFlag",
                        content: '7'
                    }
                ],
                contentUrls: [
            '/barsroot/board/index/?partial=true',
            '/barsroot/board/index/?partial=true',
            '/barsroot/board/index/?partial=true'
                ]*/
            };
            /*$scope.$watch('vm.custParamTabs', function () {
                vm.custParamTabs.select(0);
            });*/
        }
    ]);