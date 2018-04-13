Modul: BarsWeb
Author: tv_Sukhov :-)
Date:13.09.05

Набор файлов для реализации модально всплывающих справочников.

Инструкция по установке:
1. Из СоурсСейфай слить папки:
		\Common\Images\
		\Common\ManualTable\
		\Common\WebGrid\
		\Common\WebService\js\
		\Assembly\ (обновить Глобал Асембли Кеш)
2. Установить проекты (Слить себе на машину и откомпилить)
		\Application\BarsWeb.WebServices\
3. В проекте, в котором Вы хотите использовать даный компонент, добавте референс на длл Bars.Web.Dialog
3. В проекте, в котором Вы хотите использовать даный компонент, добавте код в WebConfig 
<?xml version="1.0" encoding="utf-8" ?>
<configuration>    
  <system.web>
  	|<httpHandlers>
этот код   |  <add verb="*" path="dialog.aspx" 	type="Bars.Web.Dialog.Dialogs,Bars.Web.Dialog,Version=1.0.0.0,Culture=neutral,PublicKeyToken=464dd68da967e56c" />
	|</httpHandlers>
4. Компонент "справочник" возвращает выбраное значение или undefined в случае экстренного выхода
5. Для вызова используйте следующий javascript-код:
	var result = window.showModalDialog('dialog.aspx?type=mnltab&message='+tblName,'', 'dialogHeight:560px; dialogWidth:550px');
	где tblName - имя таблицы справочника