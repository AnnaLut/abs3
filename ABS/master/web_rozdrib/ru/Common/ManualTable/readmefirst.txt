Modul: BarsWeb
Author: tv_Sukhov :-)
Date:13.09.05

����� ������ ��� ���������� �������� ����������� ������������.

���������� �� ���������:
1. �� ����������� ����� �����:
		\Common\Images\
		\Common\ManualTable\
		\Common\WebGrid\
		\Common\WebService\js\
		\Assembly\ (�������� ������ ������� ���)
2. ���������� ������� (����� ���� �� ������ � �����������)
		\Application\BarsWeb.WebServices\
3. � �������, � ������� �� ������ ������������ ����� ���������, ������� �������� �� ��� Bars.Web.Dialog
3. � �������, � ������� �� ������ ������������ ����� ���������, ������� ��� � WebConfig 
<?xml version="1.0" encoding="utf-8" ?>
<configuration>    
  <system.web>
  	|<httpHandlers>
���� ���   |  <add verb="*" path="dialog.aspx" 	type="Bars.Web.Dialog.Dialogs,Bars.Web.Dialog,Version=1.0.0.0,Culture=neutral,PublicKeyToken=464dd68da967e56c" />
	|</httpHandlers>
4. ��������� "����������" ���������� �������� �������� ��� undefined � ������ ����������� ������
5. ��� ������ ����������� ��������� javascript-���:
	var result = window.showModalDialog('dialog.aspx?type=mnltab&message='+tblName,'', 'dialogHeight:560px; dialogWidth:550px');
	��� tblName - ��� ������� �����������