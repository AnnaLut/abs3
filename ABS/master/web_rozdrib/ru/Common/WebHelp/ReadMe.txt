Для вывода на каждой странице приложения значка "Помощь" необходимо:

1. В приложении в файле Web.config внутри секци <system.web> нужно добавить:

 <httpModules>
	<add name="BarsModule" type="Bars.Application.BarsModule, Bars.Application,version=1.0.0.0,Culture=neutral, PublicKeyToken=464dd68da967e56c" />
 </httpModules>

2. Из VSS взять последний Common и Assembly (добавить в GAC).

3. Убедиться, что в файле  \Common\Configuration\Bars.config есть строка 
    	<add key="Help.OnPage" value="On"/>
(Режимы: On - включено, Off - выключено).

4. Если есть необходимость отключить Help для некоторой странички, то необходимо в файле
\Common\Configuration\Bars.config в строке 
	<add key="Help.ExcludePage" value="\barsweb\welcome.aspx;\barsweb\settobocookie.aspx"/>
необходимо в атрибуте value добавить через разделитель ';' строку следующего формата
	\<имя приложения>\<имя странички c расширением> 
(в конце не нужно ставить ';').