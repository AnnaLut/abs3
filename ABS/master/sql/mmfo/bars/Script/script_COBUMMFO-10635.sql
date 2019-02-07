begin
    execute immediate 'Insert into BARS.WEB_BARSCONFIG
   (GROUPTYPE, KEY, VAL, COMM)
 Values
   (1, ''StatFiles.path'', ''D:\'', ''Каталог файлів статзвітності'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 



begin
    execute immediate 'insert into web_barsconfig (grouptype, key, val, comm) 
  values 
  (1, ''StatFiles.upload.path'', ''D:\Work\StatFiles\Reults'', ''Шлях до каталогу у який юудуть вивантажуватись p7s пакети'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into web_barsconfig (grouptype, key, val, comm) values (1, ''StatFiles.cipher.url'', ''http://signer.cipher.kiev.ua:9092/api/v1/ticket/'', ''Шлях до сервісу Cipher'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 



insert into REFERENCES (  TABID,  TYPE)
    select tabid, 60
    from meta_tables m 
    where tabname LIKE 'V_STAT_%' and not exists
    ( select 1 from REFERENCES where tabid =m.tabid);
/
  insert into  REFAPP (  TABID, CODEAPP,  ACODE,  APPROVE )
    select tabid, '$RM_MAIN','RW',1
    from meta_tables m 
    where tabname LIKE 'V_STAT_%' and not exists
    ( select 1 from REFAPP where codeapp ='$RM_MAIN' and tabid =m.tabid);
/
commit;
/
