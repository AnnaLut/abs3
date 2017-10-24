var dropdown = dropdown || {};
$(document).ready(function () {

    dropdown.picker = function () {
        $(".datepicker").kendoDatePicker({
            value: new Date(),
            max: new Date(),
            format: "dd.MM.yyyy",
            animation: {
                open: {
                    effects: "zoom:in",
                    duration: 300
                }
            }
        });
    };

    dropdown.dropDownLists = function () {
        $("#sexDropList, #benefSex").kendoDropDownList({
            optionLabel: " ",
            dataTextField: "NAME",
            dataValueField: "ID",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/api/crkr/dropdown/clientsex")
                    }
                }
            }
        });

        $("#resDropList").kendoDropDownList({
            value: "1",
            dataTextField: "NAME",
            dataValueField: "REZID",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/api/crkr/dropdown/clientrez")
                    }
                }
            }
        });

        $("#benefDoctype").kendoDropDownList({
            optionLabel: " ",
            dataTextField: "NAME",
            dataValueField: "PASSP",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/api/crkr/dropdown/benefpassp")
                    }
                }
            }
        });
        
        $("#docTypeDropList, #passplist").kendoDropDownList({
            optionLabel: " ",
            dataTextField: "NAME",
            dataValueField: "PASSP",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/api/crkr/dropdown/clientpassp")
                    }
                }
            }
        });

        $("#codeDepDropList").kendoDropDownList({
            optionLabel: " ",
            dataTextField: "NAME",
            dataValueField: "BRANCH",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/api/crkr/dropdown/clientbranch")
                    }
                }
            }
        });

        $("#benefCountry, #country").kendoDropDownList({
            //optionLabel: "Україна",
            value: "804",
            dataTextField: "NAME",
            dataValueField: "COUNTRY",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/api/crkr/dropdown/countries")
                    }
                }
            }
        });

        $("#benefCode").kendoDropDownList({
            optionLabel: " ",
            dataTextField: "DESCR",
            dataValueField: "CODE",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/api/crkr/dropdown/benefcode")
                    }
                }
            }
        });

        $("#mfo").kendoDropDownList({
            optionLabel: " ",
            dataTextField: "NAME",
            dataValueField: "MFO",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/api/crkr/dropdown/mfo")
                    }
                }
            }
        });

        $("#depoOb22").kendoDropDownList({
            optionLabel: " ",
            dataTextField: "TEXT",
            dataValueField: "OB22",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent("/api/crkr/dropdown/ob22")
                    }
                }
            }
        });        
    };
});