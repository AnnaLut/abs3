//=============================================================================
// ACTION.JS - обробка подій (10.04.2014)
//=============================================================================

// Відмітка про перевірку реквізитів ідентифікуючого документу клієнта
function cbDocVerified_CheckedChanged()
{
    PageMethods.DocumentVerified(OnActionSucceeded, OnActionFailed);
}

// Довідник для вибору ТВБВ
function showBranch(dest) {
    var result = window.showModalDialog('dialog.aspx?type=metatab&role=ABS_ADMIN&tabname=OUR_BRANCH' +
        '&tail="length(BRANCH) >= 15 order by BRANCH"&pk=BRANCH&sk=NAME',
        'dialogHeight:700px; dialogWidth:700px');

    if (result != null) {
        // Бранч Картки
        if (dest = 'Card') {
            if (result[0] != null) {
                document.getElementById('textBranchCode').value = result[0];
                document.getElementById('textBranchName').value = result[1];

                if (confirm('Заповнити відділення доставки вибраним значенням?')) {
                    document.getElementById('textDeliveryBranchCode').value = result[0];
                    document.getElementById('textDeliveryBranchName').value = result[1];
                }
            }
        }

        // Бранч доставки картки
        if (dest = 'Delivery') {
            if (result[0] != null) {
                document.getElementById('textDeliveryBranchCode').value = result[0];
                document.getElementById('textDeliveryBranchName').value = result[1];
            }
        }
    }
}

// Встановлення клієнту «Особливої відмітки»
function SpecialMark_change(elem) {
    var id = elem.value;

    if ((id == '0') || (id == '1')) {
        // Дата народження (текст)
        var stBirth = document.getElementById("textBirthDate").value;

        if (IsNullOrEmpty(stBirth)) {
            alert('Для вибору дної відмітки необхідно вказати дату народження клієнта!');
            elem.selectedIndex = 0;
            document.getElementById("textBirthDate").focus();
        }
        else {
            // Дата народження (дата)
            var dtBirth = new Date(stBirth.substr(6, 4), stBirth.substr(3, 2) - 1, stBirth.substr(0, 2));
            var dtCurnt = new Date();
            var dtTemp = new Date(dtBirth.getFullYear(), dtBirth.getMonth(), dtBirth.getDate());

            if (id == '0') {
                // вибрано „малолітній” та клієнту більше 14 років
                dtTemp.setFullYear(dtBirth.getFullYear() + 14);
            }
            else {
                // вибрано „неповнолітній” та клієнту більше 18 років
                dtTemp.setFullYear(dtBirth.getFullYear() + 18);
            }

            if (dtCurnt > dtTemp) {
                alert('Відмітка не відповідає віку клієнта!');
                elem.selectedIndex = 0;
            }
        }

    }
    else
        return;
}

//
// Встановлення для ознаки [ReadOnly] елеметам форми DepositClient
//
function f_DisableEditCliet() {
    // згортаємо ПІБ клієнта
    if (document.getElementById('full_name').className == "mn") {
        changeStyle();
    }

    // згортаємо адресу прописки клієнта
    if (document.getElementById('fact_address').className == "mn") {
        changeStyleAddress();
    }

    // згортаємо реквізити ДПА
    if (document.getElementById('tax_details').className == "mn") {
        changeStyleTaxDetails();
    }

    document.getElementById('btShowFullName').disabled = true;
    document.getElementById('btShowFactAddress').disabled = true;
    document.getElementById('btCountry').style.visibility = "hidden";
    document.getElementById('btSettlementType').disabled = true;
    document.getElementById('btStreetType').disabled = true;
    document.getElementById('btnDocOrg').style.visibility = "hidden";

    // Disabled
    document.getElementById('textClientName').disabled = true;
    document.getElementById('listSex').disabled = true;
    document.getElementById('listSpecial').disabled = true;
    document.getElementById('listClientCodeType').disabled = true;
    document.getElementById('listDocType').disabled = true;
    document.getElementById('textBirthDate').disabled = true;
    document.getElementById('textCountry').disabled = true;
    document.getElementById('textClientTerritory').disabled = true;
    document.getElementById('textClientIndex').disabled = true;
    document.getElementById('textClientRegion').disabled = true;
    document.getElementById('textClientDistrict').disabled = true;
    document.getElementById('textClientSettlement').disabled = true;
    document.getElementById('textClientAddress').disabled = true;
    document.getElementById('textFactAddressFull').disabled = true;
    document.getElementById('cbSelfEmployer').disabled = true;
    document.getElementById('textClientCode').disabled = true;
    document.getElementById('textDocSerial').disabled = true;
    document.getElementById('textDocNumber').disabled = true;
    document.getElementById('textDocOrg').disabled = true;
    document.getElementById('textDocDate').disabled = true;
    document.getElementById('textPhotoDate').disabled = true;
    document.getElementById('textBirthPlace').disabled = true;
    document.getElementById('textHomePhone').disabled = true;
    document.getElementById('textWorkPhone').disabled = true;
    document.getElementById('textCellPhone').disabled = true;
}

// Доступність елементів для редагування Картки Клієнта
function f_EnableEditCliet() {
    document.getElementById('btShowFullName').disabled = false;
    document.getElementById('btShowFactAddress').disabled = false;
    document.getElementById('btSettlementType').disabled = false;
    document.getElementById('btStreetType').disabled = false;
    document.getElementById('btnDocOrg').style.visibility = "visible";
    // document.getElementById('btCountry').style.visibility = "visible";

    // Enabled dropdownlist
    document.getElementById('textClientName').disabled = false;
    document.getElementById('listSex').disabled = false;
    document.getElementById('listSpecial').disabled = false;
    document.getElementById('listDocType').disabled = false;
    document.getElementById('listClientCodeType').disabled = false;
    document.getElementById('textBirthDate').disabled = false;
    document.getElementById('textCountry').disabled = false;
    document.getElementById('textClientTerritory').disabled = false;
    document.getElementById('textClientIndex').disabled = false;
    document.getElementById('textClientRegion').disabled = false;
    document.getElementById('textClientDistrict').disabled = false;
    document.getElementById('textClientSettlement').disabled = false;
    document.getElementById('textClientAddress').disabled = false;
    document.getElementById('textFactAddressFull').disabled = false;
    document.getElementById('cbSelfEmployer').disabled = false;
    document.getElementById('textClientCode').disabled = false;
    document.getElementById('textDocSerial').disabled = false;
    document.getElementById('textDocNumber').disabled = false;
    document.getElementById('textDocOrg').disabled = false;
    document.getElementById('textDocDate').disabled = false;
    document.getElementById('textPhotoDate').disabled = false;
    document.getElementById('textBirthPlace').disabled = false;
    document.getElementById('textHomePhone').disabled = false;
    document.getElementById('textWorkPhone').disabled = false;
    document.getElementById('textCellPhone').disabled = false;

    document.getElementById('btEditClient').disabled = true;
    document.getElementById('btCreateRequest').disabled = true;
    document.getElementById('btContracts').disabled = true;

    document.getElementById('eadPrintChange_ibPrint').disabled = false;

    document.getElementById('ScanIdentDocs_btn').disabled = false;

    document.getElementById('Edited').value = "1";

    // відповідно рівня доступу
    PageMethods.FullAccess(OnActionSucceeded, OnActionFailed);
}

//
function SetEnableBaseFields() {
    document.getElementById('listSex').disabled = false;

    document.getElementById('textClientFirstName').disabled = false;

    document.getElementById('textClientPatronymic').disabled = false;

    document.getElementById('textBirthDate').disabled = false;

    document.getElementById('listClientCodeType').disabled = false;

    document.getElementById('textClientCode').disabled = false;
}

//
function SetDisableBaseFields() {
    document.getElementById('listSex').disabled = true;

    document.getElementById('textClientFirstName').disabled = true;

    document.getElementById('textClientPatronymic').disabled = true;

    document.getElementById('textBirthDate').disabled = true;

    document.getElementById('listClientCodeType').disabled = true;

    document.getElementById('textClientCode').disabled = true;

    document.getElementById('eadPrintChange_ibPrint').attachEvent('onclick', SetEnableBaseFields);

    document.getElementById('eadPrintChange_cbSigned').attachEvent('onclick', SetEnableBaseFields);
}

// Callback function invoked on successful completion of the page method.
function OnActionSucceeded(result, userContext, methodName) {
    switch (methodName) {
        case "FullAccess":
            {
                //
                if (result == false)
                {
                    SetDisableBaseFields();
                }

                break;
            }
        case "DocumentVerified":
            {
                document.getElementById('cbDocVerified').disabled = true;

                if (document.getElementById('btCreateRequest'))
                {
                    document.getElementById('btCreateRequest').disabled = false;
                }

                break;
            }
        default:
            {
                break;
            }
    }
}

// Callback function invoked on failure of the page method.
function OnActionFailed(error, userContext, methodName)
{
    switch (methodName) {
        case "DocumentVerified":
            {
                document.getElementById('cbDocVerified').checked = false;
                break;
            }
        default:
            {
                break;
            }
    }

    if (error !== null) {
        var url = "dialog.aspx?type=err";
        url += "&code=" + Math.random();
        window.showModalDialog(url, "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
    }
}

//
function Client_done()
{
 
 var okpo = document.getElementById('textClientCode').value;

 alert('Зареєстровано клієнта РНК = '+ okpo);
 Client_rnk();
        return true;
}

function Client_rnk()
{
 
 var rnk = document.getElementById('textRNK').value;

 alert('Зареєстровано клієнта РНК = '+ rnk);
        return true;
}






