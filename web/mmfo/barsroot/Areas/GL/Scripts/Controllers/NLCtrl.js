angular.module(globalSettings.modulesAreas)
	.constant("NLConfig", {
		"baseApiUrl": "/api/gl/nl/",
		"operApiUrl": "/api/gl/operlist/"
	})
	.controller('NLController', ['$scope', 'NLConfig', 'NLService', function($scope, config, service) {
		'use strict';

		var vm = this;

		vm.subFileDisplay = false;
		vm.subFileSwift = false;

		vm.ShowSWIFTs = ShowSWIFTs();

		function ShowSWIFTs() {
		    var array_of_types = ['nlf', 'nl9', 'nli', 'nlj', 'nll'];
		    var type = getUrlParameter('tip');
		    if (type)
		        return array_of_types.indexOf(type.toLowerCase()) > -1;
		    else
		        return false;
		}

		function getUrlParameter(param) {             
            var PageURL = window.location.search.substring(1);
            var URLVariables = PageURL.split('&');
            for (var i = 0; i < URLVariables.length; i++) {
                var ParameterName = URLVariables[i].split('=');
                if (ParameterName[0] == param) {
                    return ParameterName[1] ? ParameterName[1].toUpperCase() : ParameterName[1];
                }
            }
        };

        function getCteateDocModeFunc() {
        	var tt = getUrlParameter('tt'),
        		ttList = getUrlParameter('ttList'),
        		createMode = 'single';
    		if (tt) {
    			createMode = 'single';
    		} else if (ttList) {
    			createMode = 'multi';
    		} else if (!tt && !ttList) {
    			createMode = 'single';
    		}
    		return createMode;
        };

        vm.cteateDocDisplayMode = getCteateDocModeFunc();

        vm.tipTitle = getUrlParameter('tip');

		var selectedFileGridRow = function () {
            return vm.fileGrid.dataItem(vm.fileGrid.select());
        };

        var selectedSubFileGridRow = function () {
            return vm.subFileGrid.dataItem(vm.subFileGrid.select());
        };

        vm._fileToolbarOptions = {
        	resizable: false,
        	items: [
                    {
                        type: 'button',
                        id: 'showAccStory',
                        text: '<i class="pf-icon pf-16 pf-document_header_footer-ok2"></i> Історія рахунку',
                        click: function () {
                        	var fileRow = selectedFileGridRow();
                            if (fileRow) {
                            	window.location = '/barsroot/customerlist/showhistory.aspx?acc=' + fileRow.acc + '&type=' + fileRow.tip;
                            } else {
                            	bars.ui.notify('Увага!', 'Для ознайомлення з історією рахунку, слід обрати відповідний запис.', 'error');
                            }
                        }
                    }
                ]
        };

        vm._fileGridOptions = {
        	autoBind: true,
            selectable: 'row',            
            sortable: true,            
            filterable: true,
            scrollable: true,
            /*height: function () {
                return $(window).height() / 4 * 3;
            },*/
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100, 200],
                buttonCount: 5
            },
            change: function () {
                vm.subFileGrid.dataSource.read();
                vm.subFileDisplay = true;
                vm.subFileSwift = false;
            },
            dataBinding: function (e) {
                vm.subFileDisplay = false;
                vm.subFileSwift = false;
            	$scope.$apply();
            },
            dataSource: {
            	type: 'webapi',
                pageSize: 5,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                transport: {
                    read: {
                        url: bars.config.urlContent(config.baseApiUrl + 'get'),
                        dataType: 'json',
                        data: { tip: getUrlParameter('tip') }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            acc: { type: 'number' },
                            kv: { type: 'number' },
                            nls: { type: 'string' },
                            nms: { type: 'string' },
                            ost_fk: { type: 'number' },
                            ost_pl: { type: 'number' },
                            sum_kar: { type: 'number' },
                            kount_pl: { type: 'number' },
                            tip: { type: 'string' }
                        }
                    }
                }
            },
            columns: [
               /*{
                   field: 'acc',
                   title: 'acc',
                   hidden: true
               },*/ {
                   field: 'kv',
                   width: '10%',
                   attributes: { 'class': "text-center" },
                   title: 'Валюта'
               }, {
                   field: 'nls',
                   width: '15%',
                   attributes: { 'class': "text-center" },
                   title: 'Рахунок'
               }, {
                   field: 'nms',
                   width: '20%',
                   attributes: { 'class': "text-center" },
                   title: 'Назва рахунку'
               }, {
                   field: 'ost_fk',
                   width: '15%',
                   format: "{0:n2}",
                   attributes: { 'class': "text-right" },
                   title: 'Фактичний залишок'
               }, {
                   field: 'ost_pl',
                   width: '15%',
                   format: "{0:n2}",
                   attributes: { 'class': "text-right" },
                   title: 'Плановий залишок'
               }, {
                   field: 'kount_pl',
                   width: '10%',
                   attributes: { 'class': "text-center" },
                   title: 'Кількість документів'
               }, {
                   field: 'sum_kar',
                   width: '15%',
                   format: "{0:n2}",
                   attributes: { 'class': "text-right" },
                   title: 'Сума картотеки'
               }, {
                   field: 'tip',
                   title: 'TIP',
                   hidden: true
               }
            ],
            dataBound: function() {
            	var grid = this;
            	grid.tbody.find('>tr').each(function() {
            		var dataItem = grid.dataItem(this);
            		if (dataItem.ost_fk !== dataItem.sum_kar || dataItem.ost_pl !== dataItem.sum_kar) {
            			var elem = this;
            			elem.className = 'equalError';
            		}
            	});
            }
        };

        // subFile region =================================================================

        function serializeData( data ) { 
		    // If this is not an object, defer to native stringification.
		    if ( ! angular.isObject( data ) ) { 
		        return( ( data == null ) ? "" : data.toString() ); 
		    }
		    var buffer = [];
		    // Serialize each key in the object.
		    for ( var name in data ) { 
		        if ( ! data.hasOwnProperty( name ) ) { 
		            continue; 
		        }
		        var value = data[ name ];
		        buffer.push(
		            encodeURIComponent( name ) + "=" + encodeURIComponent( ( value == null ) ? "" : value )
		        ); 
		    }
		    // Serialize the buffer and clean it up for transportation.
		    var source = buffer.join("&").replace(/%20/g, "+").replace("'",'%27');
		    return( source ); 
		}

		var dataSource = new kendo.data.DataSource({
			type: 'webapi',
			transport: {
                read: {
                    url: bars.config.urlContent('/api/gl/operlist/get'),
                    dataType: 'json',
                    data: { type: getUrlParameter('ttList') || ''}
                }
            },
            schema: {
                data: "Data",
                total: "Total"
            }
		});

		vm._ttListOptions = {
			dataSource: dataSource,
            dataTextField: "NAME",
            dataValueField: "TT",
            optionLabel: "Оберіть значення..."
		};

        vm._subFileToolbarOptions = {
        	resizable: false,
        	items: [
        			{
        				type: 'button',
        				id: 'InputFileReview',
        				text: '<i class="pf-icon pf-16 pf-info"></i> Перегляд вхідного документа',
        				click: function() {
        					var subFileRow = selectedSubFileGridRow();
        					if (subFileRow) {
        					    //window.location = '/barsroot/documentview/default.aspx?ref=' + subFileRow.REF;
        					    bars.ui.dialog({
        					        content: bars.config.urlContent('/documentview/default.aspx?ref=' + subFileRow.REF),
        					        iframe: true,
        					        height: 600,
        					        width: 800
        					    });
        					} else {
                            	bars.ui.notify('Увага!', 'Не обрано документу для перегляду', 'error');
                            }
        				}
        			},
        			{
        				type: 'button',
        				id: 'FileRemove',
        				text: '<i class="pf-icon pf-16 pf-delete_button_error"></i> Видалити з картотеки',
        				click: function() {
        					var subFileRow = selectedSubFileGridRow();
        					if (subFileRow) {
        						bars.ui.confirm({ text: 'Ви дійсно бажаєте видалити документ ' + subFileRow.REF + ' з картотеки?' }, function() {
        							service.removeDocument(subFileRow.REF).then(function(response) {        								
        								if (response.Msg === 'Ok') {
        									bars.ui.notify('Повідомлення!', 'Документ успішно вилучено', 'success');
        								} else {
        									bars.ui.notify('Увага!', 'Сталася помилка. Причина: ' + response.Msg, 'error');
        								}

        								if(vm.subFileGrid.dataSource._data.length > 0) {
        									vm.subFileGrid.dataSource.read();
        								} else {
        									vm.fileGrid.dataSource.read();
        								}
        							});
        						});
        					} else {
                            	bars.ui.notify('Увага!', 'Не обрано документу', 'error');
                            }
        				}
        			},
                    {
                        type: 'button',
                        id: 'cteateDoc',
                        text: '<i class="pf-icon pf-16 pf-document_header_footer-ok2"></i> Створити документ',
                        click: function () {
                        	var subFileRow = selectedSubFileGridRow();
                            if (subFileRow) {
                            	var params = {
		                            tt: getUrlParameter('tt') || '024',
		                            kv_a: subFileRow.KVA,
		                            kv_b: subFileRow.KVA,
		                            reqv_REF92: subFileRow.REF,
		                            nazn: subFileRow.NAZNO,
		                            sumc_t: subFileRow.S2,
		                            sumA_t: subFileRow.S2,
		                            nls_a: subFileRow.NLSA,
		                            dk: 1,
		                            BPROC: subFileRow.BPROC,
		                            APROC: subFileRow.APROC
		                        };

                                //window.location = '/barsroot/docinput/docinput.aspx?' + serializeData(params);
                            	bars.ui.dialog({
                            	    content: bars.config.urlContent('/docinput/docinput.aspx?' + serializeData(params)),
                            	    iframe: true,
                            	    height: document.documentElement.offsetHeight * 0.9,
                            	    width: 625,
                            	    close: function () {
                            	        vm.subFileGrid.dataSource.read();
                            	    } 
                            	});
                            } else {
                            	bars.ui.notify('Увага!', 'Не обрано значення для створення документу', 'error');
                            }
                        },
                        hidden: !(vm.cteateDocDisplayMode === 'single' || getUrlParameter('ttList') === 'NL9')
                    },
                    {
                        type: 'button',
                        id: 'selectOperForDoc',
                        text: '<i class="pf-icon pf-16 pf-document_header_footer-ok2"></i> Створити документ (вибір операції)',
                        click: function () {
                        	var subFileRow = selectedSubFileGridRow();
                            if (subFileRow) {
                            	$scope.selectOperWindow.center().open();                          	
                            } else {
                            	bars.ui.notify('Увага!', 'Не обрано значення для створення документу', 'error');
                            }
                        },
        				hidden: vm.cteateDocDisplayMode === 'single' ? true : false
                    }
                ]
        };

        vm.submit = function(value) {
        	if(value) {
        		var subFileRow = selectedSubFileGridRow();
	        	var params = {
	                tt: value ? value.TT : '024',
	                kv_a: subFileRow.KVA,
	                kv_b: subFileRow.KVA,
	                reqv_REF92: subFileRow.REF,
	                nazn: subFileRow.NAZNO,
	                sumc_t: subFileRow.S2,
	                sumA_t: subFileRow.S2,
	                nls_a: subFileRow.NLSA,
	                dk: 1,
	                BPROC: subFileRow.BPROC,
	                APROC: subFileRow.APROC
	            };
        	    //window.location = '/barsroot/docinput/docinput.aspx?' + serializeData(params);
	        	bars.ui.dialog({
	        	    content: bars.config.urlContent('/docinput/docinput.aspx?' + serializeData(params)),
	        	    iframe: true,
	        	    height: document.documentElement.offsetHeight * 0.9,
	        	    width: 625,
	        	    close: function () {
	        	        $scope.selectOperWindow.close();
	        	        vm.subFileGrid.dataSource.read();
	        	    }
	        	});
        	} else {
        		bars.ui.notify('Увага!', 'Для створення документу необхідно обрати значення операції.', 'error');
        	}
        };

        vm._subFileGridOptions = {
        	autoBind: false,
            selectable: 'row',            
            sortable: true,            
            filterable: true,
            scrollable: true,
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100, 200],
                buttonCount: 5
            },
            dataSource: {
            	type: 'webapi',
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                transport: {
                    read: {
                        url: bars.config.urlContent(config.baseApiUrl + 'getsubfiles'),
                        dataType: 'json',
                        data: { acc: function() {
                        	var fileRow = selectedFileGridRow();
                        	return fileRow.acc;
                        }}
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            REF: { type: 'number' },
                            NLSA: { type: 'string' },
                            S: { type: 'number' },
                            DATD: { type: 'date' },
                            NAZNO: { type: 'string' },
                            BPROC: { type: 'string' },
                            APROC: { type: 'string' },
                            ACC: { type: 'number' },
                            KVA: { type: 'number' },
                            TIP: { type: 'string' },
                            S2: { type: 'number' }
                        }
                    }
                }
            },
            columns: [
               {
                   field: 'REF',
                   width: '15%',
                   attributes: { 'class': "text-center" },
                   title: 'Референс'
               }, {
                   field: 'ACC',
                   width: '15%',
                   attributes: { 'class': "text-center" },
                   title: 'Рахунок'
               }, {
                   field: 'S',
                   width: '15%',
                   format: "{0:n2}",
                   attributes: { 'class': "text-right" },
                   title: 'Сума документу'
               }, {
                   field: 'NAZNO',
                   width: '40%',
                   title: 'Призначення платежу'
               }, {
                   field: 'DATD',
                   width: '15%',
                   template: "<div style='text-align:center;'>#=kendo.toString(DATD,'dd/MM/yyyy')#</div>",
                   title: 'Дата документа'
               }
            ],
            change: function () {
                vm.subFileSwift = false;
                if (vm.ShowSWIFTs)
                    TryToLoadSwift();
            }
        };


        function TryToLoadSwift() {
            $.ajax({
                type: "GET",
                dataType: "json",
                contentType: 'application/json',
                data: { REFID: selectedSubFileGridRow().REF },
                url: bars.config.urlContent(config.baseApiUrl + 'GetSwiftInfo'),
                success: function (data) {

                    if (data.RESULT === null)
                        return false;

                    var line = "";
                    line += "Sender  :\t" + data.RESULT.SENDER + "\n";
                    line += "Receiver:\t" + data.RESULT.RECEIVER + "\n";

                    if (data.RESULT.SWIFTDATA && data.RESULT.SWIFTDATA.length > 0) {
                        line += data.RESULT.SWIFTDATA;
                    }

                    vm.subFileSwift = true;
                    $("#SwiftInfo").val(line);
                    $scope.$apply();

                }
            });
        }

	}]);