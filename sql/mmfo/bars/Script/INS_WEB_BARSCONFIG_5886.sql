prompt ... 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.Url'', ''https://tsws.sb.com.ua/swws/SWWS.asmx'', ''������ ������ (Single Window)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.PointCode'', ''UKRN0001'', ''��� ����� � �� '')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.UserLogin'', ''clerk_oschad'', ''���� � ������ Single Window'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.UserPassword'', ''123123'', ''������ � ������ Single Window'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.CertSearch'', ''tetiana.vlasiuk@unity-bars.com'', ''������������ '')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.BlockOnError'', ''1'', ''���� ������� �������, 1-�������� ���������, 0-������� ���� � ������ ������'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''SingleWindow.Language'', ''ru'', ''����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 



begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, COMM)
 Values
   (1, ''QuickMoney.CertSearch'', ''���������� ��� "������ ������"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.PointCode'', ''COSB'', ''��� ����� � "������ ������"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.Url'', ''http://stpwebuat-00-01.oschadbank.ua:7001/stp2sw/SWSvc'', ''������ ������ "������ ������"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.UserLogin'', ''710904'', ''���� ����������� � ������ "������ ������"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.UserPassword'', ''man*TYe''||chr(38)||''ill90'', ''������ ����������� � ������ "������ ������"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''QuickMoney.Language'', ''ru'', ''����'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
