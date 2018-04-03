// Контролер - Операціоніст

function NeedsToReRegister()
{
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
			
	if (_arr[0]== null || _arr[0] == "")
	{
		alert(LocalizedString('Mes36')/*"Не выбран клиент!"*/);
		return false;
	}	
	if (_arr[2] != '1')
	{
		alert(LocalizedString('Mes37')/*'Данный клиент открыт!'*/);
		return false;
	}
	else
	{
		return confirm(LocalizedString('Mes38')/*'Перерегистрировать клиента?'*/);
	}
}
// Редагування клієнта
function editClient(){
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
			
	if (_arr[0]== null || _arr[0] == "")
	{
		alert(LocalizedString('Mes36')/*"Не выбран клиент!"*/);
		return;
	}
	var url = "/barsroot/clientregister/registration.aspx?rnk=" + _arr[0];
	var childWindow = window.open(url,"_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");	
}
// Заведення клієнта
function addClient(){
	var childWindow = window.open("/barsroot/clientregister/registration.aspx?client=person","_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");
}
// Новий договір на вибраного клієнта
function addDeposit(){
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
				
	if (_arr[0]== null || _arr[0] == "")
	{
		alert(LocalizedString('Mes36')/*"Не выбран клиент!"*/);
		return;
	}
	
	if (_arr[2] == '1')
	{
		alert(LocalizedString('Mes39')/*'Данный клиент закрыт!'*/ + '\n' + LocalizedString('Mes40')/*'Для заведения депозита перерегистрируйте клиента.'*/);
		return false;
	}

	var url = "DepositClient.aspx?rnk=" + _arr[0];
	var childWindow = window.open(url,"_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");	
}
// Перегляд вибраного депозита
function viewDeposit(){
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
			
	if (_arr[1]== null || _arr[1] == "" || isNaN(_arr[1]))
	{
		alert(LocalizedString('Mes41')/*"Не выбран депозит!"*/);
		return;
	}
	var url = "DepositContractInfo.aspx?dpt_id=" + _arr[1];
	var childWindow = window.open(url,"_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");	
}
// Зміна рахунків виплати
function editAccounts(){
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
			
	if (_arr[1]== null || _arr[1] == "" || isNaN(_arr[1]))
	{
		alert(LocalizedString('Mes41')/*"Не выбран депозит!"*/);
		return;
	}
	var url = "DepositEditAccount.aspx?dpt_id=" + _arr[1];
	var childWindow = window.open(url,"_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");	
}
/// Поповнення
function addSum(){
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
			
	if (_arr[1]== null || _arr[1] == "" || isNaN(_arr[1]))
	{
		alert(LocalizedString('Mes41')/*"Не выбран депозит!"*/);
		return;
	}
    var url = "DepositAgreement.aspx?agr_id=2&dpt_id=" + _arr[1];
	var childWindow = window.open(url,"_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");	
}
// Виплата відсотків
function percentPay(){
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
			
	if (_arr[1]== null || _arr[1] == "" || isNaN(_arr[1]))
	{
		alert(LocalizedString('Mes41')/*"Не выбран депозит!"*/);
		return;
	}
	var url = "DepositPercentPay.aspx?dpt_id=" + _arr[1];
	var childWindow = window.open(url,"_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");	
}
// Повернення депозиту по завершенні
function depositReturn(){
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
			
	if (_arr[1]== null || _arr[1] == "" || isNaN(_arr[1]))
	{
		alert(LocalizedString('Mes41')/*"Не выбран депозит!"*/);
		return;
	}
	var url = "DepositReturn.aspx?dpt_id=" + _arr[1];
	var childWindow = window.open(url,"_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");	
}
// Дострокове повернення депозиту
function depositClose(){
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
			
	if (_arr[1]== null || _arr[1] == "" || isNaN(_arr[1]))
	{
		alert(LocalizedString('Mes41')/*"Не выбран депозит!"*/);
		return;
	}
	var url = "DepositClosePayIt.aspx?fullpay=1&dpt_id=" + _arr[1];
	var childWindow = window.open(url,"_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");	
}
// Історія депозитного договору
function depositShowHistory(){
	var _dat = document.getElementById("SEL_ROW").value;
	var _arr = _dat.split("?");
			
	if (_arr[1]== null || _arr[1] == "" || isNaN(_arr[1]))
	{
		alert(LocalizedString('Mes41')/*"Не выбран депозит!"*/);
		return;
	}
	var url = "DepositHistory.aspx?dpt_id=" + _arr[1];
	var childWindow = window.open(url,"_blank",
	"height=600,width=800,resizable=yes,scrollbars=yes,menubar=no,status=yes");	
}
// Очистка полів
function clearFields(){
	document.getElementById("textClientName").value = "";
	document.getElementById("textClientCode").value = "";
	document.getElementById("RNK").value = "";
	document.getElementById("textAccount").value = "";
	document.getElementById("textDepositId").value = "";
	document.getElementById("DocNumber").value = "";
}
/// Обробка пошуку 
/// якщо шукаємо лише вкладників - дисактивуємо всі інші поля
/// якщо депозити - повертаємо поля
function ManageFields()
{
    /// Ми шукаємо депозити
    if (event.srcElement.value == '0')
    {
        document.getElementById("textAccount").disabled = false;
        document.getElementById("textDepositId").disabled = false;
    }
    else
    {
        document.getElementById("textAccount").value = '';
        document.getElementById("textDepositId").value = '';    
        document.getElementById("textAccount").disabled = true;
        document.getElementById("textDepositId").disabled = true;        
    }    
}