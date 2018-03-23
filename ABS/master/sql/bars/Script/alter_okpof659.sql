
-- добавление новых полей для формирования показателей 06, 07, 08

exec suda;

-- PAR_SK
begin
    execute immediate 'ALTER TABLE BARS.OKPOF659 ADD PAR_SK VARCHAR2(1)';
exception
    when others then null;
end;
/    

-- PAR_LINK
begin
    execute immediate 'ALTER TABLE BARS.OKPOF659 ADD PAR_LINK VARCHAR2(3)';
exception
    when others then null;
end;
/

-- PAR_INVEST
begin
    execute immediate 'ALTER TABLE BARS.OKPOF659 ADD PAR_INVEST VARCHAR2(1)';
exception
    when others then null;
end;
/    
    
