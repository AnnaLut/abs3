prompt ... 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.Url'', ''https://tsws.sb.com.ua/swws/SWWS.asmx'', ''Адреса сервіса (Single Window)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.PointCode'', ''UKRN0001'', ''Код точки в ОЕ '')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.UserLogin'', ''clerk_oschad'', ''Логін у системі Single Window'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.UserPassword'', ''123123'', ''Пароль у системі Single Window'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.CertSearch'', ''tetiana.vlasiuk@unity-bars.com'', ''Найменування '')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.BlockOnError'', ''1'', ''Флаг обробки помилок, 1-документ блокується, 0-помилка лише в журналі аудиту'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.Language'', ''ru'', ''Мова'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 



begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, COMM)
 Values
   (1, ''QuickMoney.CertSearch'', ''Сертифікат для "Швидкої копійки"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.PointCode'', ''COSB'', ''Код точки в "Швидка копійка"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.Url'', ''http://stpwebuat-00-01.oschadbank.ua:7001/stp2sw/SWSvc'', ''Адреса сервіса "Швидка копійка"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.UserLogin'', ''710904'', ''Логін користувача в системі "Швидка копійка"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.UserPassword'', ''man*TYe''||chr(38)||''ill90'', ''Пароль користувача в системі "Швидка копійка"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.Language'', ''ru'', ''Мова'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
