//Цифровая подпись документа с исользованием CAPICOM

//Объект для CAPICOM
var str_object_capicom = '<OBJECT id="oCAPICOM" '+
						 'codeBase="/Common/Script/capicom.cab#version=2,0,0,3" '+
	                     'classid="clsid:A996E48C-D3DC-4244-89F7-AFA33EC60679" '+
						 'VIEWASTEXT></OBJECT>';

//При загрузке скрипта сразу создаем объект для CAPICOM
window.attachEvent("onload",onLoad);
function onLoad()
{
	try{
		var elem = document.createElement(str_object_capicom);
		document.body.insertAdjacentElement("beforeEnd",elem);
	}
	catch(e)
	{
		alert("Невозможно создать объект ActiveX CAPICOM.")
	}	
}

function GetSignForDocument(strHash,certName)
{
	strHash = strHash.toString();
	if(!IsCAPICOMInstalled())
	{
		alert("Не обнаружен компонент ActiveX CAPICOM.")
		return null;	
	}
	if(strHash == null || strHash == '') 
		alert("Невозможно подписать: пустой хеш.");
	var certificates = FindCertificate(certName);
	if(certificates == null) return;
	var selectedCertificate = null;
	if(certificates.Count > 1)
	{
		alert("Обнаружено больше одного сертификата. Выберите нужный из списка.");
		selectedCertificate = certificates.Select();
	}
	else
	{
		selectedCertificate = certificates;
	}
	
	var txtCertificateValue = selectedCertificate.Item(1).GetInfo(CAPICOM_INFO_SUBJECT_SIMPLE_NAME);
	var txtCertificateHash = selectedCertificate.Item(1).Thumbprint;
	
	var sign = SignBuffer(strHash,txtCertificateHash);
	
	return sign;
}

//Функция проверки наличия ActiveX компонента 
function IsCAPICOMInstalled()
{
	if(typeof(oCAPICOM) == "object")
	{	
		if( (oCAPICOM.object != null) )
			return true;
 	}
}

// CAPICOM constants 
var CAPICOM_STORE_OPEN_READ_ONLY = 1;
var CAPICOM_CURRENT_USER_STORE = 2;
var CAPICOM_CERTIFICATE_FIND_SHA1_HASH = 0;
var CAPICOM_CERTIFICATE_FIND_SUBJECT_NAME = 1;
var CAPICOM_CERTIFICATE_FIND_EXTENDED_PROPERTY = 6;
var CAPICOM_CERTIFICATE_FIND_TIME_VALID = 9;
var CAPICOM_CERTIFICATE_FIND_KEY_USAGE = 12;
var CAPICOM_DIGITAL_SIGNATURE_KEY_USAGE = 0x00000080;
var CAPICOM_AUTHENTICATED_ATTRIBUTE_SIGNING_TIME = 0;
var CAPICOM_INFO_SUBJECT_SIMPLE_NAME = 0;
var CAPICOM_ENCODE_BASE64 = 0;
var CAPICOM_E_CANCELLED = -2138568446;
var CERT_KEY_SPEC_PROP_ID = 6;

//Найти сертификат по имени
function FindCertificate(certName)
{
   // instantiate the CAPICOM objects
   var MyStore = new ActiveXObject("CAPICOM.Store");
   var FilteredCertificates = new ActiveXObject("CAPICOM.Certificates");

   // open the current users personal certificate store
   try
   {
   		MyStore.Open(CAPICOM_CURRENT_USER_STORE, "My", CAPICOM_STORE_OPEN_READ_ONLY);
   }
   catch (e)
   {
	if (e.number != CAPICOM_E_CANCELLED)
	{
   		alert("Произошла ошибка при открытии персонального хранилища сертификатов.");
		return null;
	}
   }

   var FilteredCertificates;
   
   //Фильтруем серификаты по заданому имени
   FilteredCertificates = MyStore.Certificates.Find(CAPICOM_CERTIFICATE_FIND_SUBJECT_NAME,certName);
   if(FilteredCertificates.Count == 0){ 
   		alert("Не найден клиентский сертификат <"+certName+">.");
   		return null;
   }
   //Фильтруем по пригодности для цифровой подписи
   FilteredCertificates = FilteredCertificates.Find(CAPICOM_CERTIFICATE_FIND_KEY_USAGE,CAPICOM_DIGITAL_SIGNATURE_KEY_USAGE);
   if(FilteredCertificates.Count == 0){
   		alert("Клиентский сертификат <"+certName+"> не пригоден для цифровой подписи.");
   		return null;
   }
   //Фильтруем по пригодности по дате
   FilteredCertificates = FilteredCertificates.Find(CAPICOM_CERTIFICATE_FIND_TIME_VALID);
   if(FilteredCertificates.Count == 0){
   		alert("Клиентский сертификат <"+certName+"> просрочен.");
   		return null;
   }
   //Фильтруем по наличию секретного ключа для даного сертификата
   FilteredCertificates = FilteredCertificates.Find(CAPICOM_CERTIFICATE_FIND_EXTENDED_PROPERTY,CERT_KEY_SPEC_PROP_ID);
   if(FilteredCertificates.Count == 0){
   		alert("Для клиентского сертификата <"+certName+"> нет секретного ключа.");
   		return null;
   }
   
   return FilteredCertificates;

   // Clean Up
   MyStore = null;
   FilteredCertificates = null;
}

//Найти сертификат по хеш-ключу
function FindCertificateByHash(szThumbprint)
{
   var MyStore = new ActiveXObject("CAPICOM.Store");
   try
   {
   	MyStore.Open(CAPICOM_CURRENT_USER_STORE, "My", CAPICOM_STORE_OPEN_READ_ONLY);
   }
   catch (e)
   {
	if (e.number != CAPICOM_E_CANCELLED)
	{
   		alert("Произошла ошибка при открытии персонального хранилища сертификатов.");
		return false;
	}
   }

   // find all of the certificates that have the specified hash
   var FilteredCertificates = MyStore.Certificates.Find(CAPICOM_CERTIFICATE_FIND_SHA1_HASH, szThumbprint);
   return FilteredCertificates.Item(1);

   // Clean Up
   MyStore = null;
   FilteredCertificates = null;
}

//Подписать хеш
function SignBuffer(strHash,certHash)
{
   // instantiate the CAPICOM objects
   var SignedData = new ActiveXObject("CAPICOM.SignedData");
   var Signer = new ActiveXObject("CAPICOM.Signer");
   var TimeAttribute = new ActiveXObject("CAPICOM.Attribute");

   // Set the data that we want to sign
   SignedData.Content = strHash;
   try
   {
 	// Set the Certificate we would like to sign with
   	Signer.Certificate = FindCertificateByHash(certHash);
   	
   	// Set the time in which we are applying the signature
	var Today = new Date();
	TimeAttribute.Name = CAPICOM_AUTHENTICATED_ATTRIBUTE_SIGNING_TIME;
	TimeAttribute.Value = Today.getVarDate();
	Today = null;
   	Signer.AuthenticatedAttributes.Add(TimeAttribute);
	
   	// Do the Sign operation
	var szSignature = SignedData.Sign(Signer, true, CAPICOM_ENCODE_BASE64);
	
	return szSignature;
   }
   catch (e)
   {
 	if (e.number != CAPICOM_E_CANCELLED)
	{
		alert("An error occurred when attempting to sign the content, the errot was: " + e.description);
		return false;
	}
  }
}

//Проверка подписи
function verifySign(sign, hash)
{	
 var CAPICOM_VERIFY_SIGNATURE_ONLY = 0;
 var CAPICOM_VERIFY_SIGNATURE_AND_CERTIFICATE = 1;
 
 var SignedData = new ActiveXObject('CAPICOM.SignedData');
 try
 {
	SignedData.Content = hash;
	SignedData.Verify(sign, true, CAPICOM_VERIFY_SIGNATURE_AND_CERTIFICATE);
 }
 catch (e)
 {
	alert(e.description);
	return false;
 }
 return true;
}