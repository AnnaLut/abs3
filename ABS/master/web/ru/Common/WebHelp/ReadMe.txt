��� ������ �� ������ �������� ���������� ������ "������" ����������:

1. � ���������� � ����� Web.config ������ ����� <system.web> ����� ��������:

 <httpModules>
	<add name="BarsModule" type="Bars.Application.BarsModule, Bars.Application,version=1.0.0.0,Culture=neutral, PublicKeyToken=464dd68da967e56c" />
 </httpModules>

2. �� VSS ����� ��������� Common � Assembly (�������� � GAC).

3. ���������, ��� � �����  \Common\Configuration\Bars.config ���� ������ 
    	<add key="Help.OnPage" value="On"/>
(������: On - ��������, Off - ���������).

4. ���� ���� ������������� ��������� Help ��� ��������� ���������, �� ���������� � �����
\Common\Configuration\Bars.config � ������ 
	<add key="Help.ExcludePage" value="\barsweb\welcome.aspx;\barsweb\settobocookie.aspx"/>
���������� � �������� value �������� ����� ����������� ';' ������ ���������� �������
	\<��� ����������>\<��� ��������� c �����������> 
(� ����� �� ����� ������� ';').