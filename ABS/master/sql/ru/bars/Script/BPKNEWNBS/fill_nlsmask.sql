delete from nlsmask where maskid in('W4G', 'W4S', 'W4W', 'W4A');

begin
    execute immediate 'insert into NLSMASK (MASKID, DESCR, MASK, MASKNMS, SQLNMS)
values (''W4G'', ''БПК W4G'', ''????_FPRRRRRRR'', null, ''select substr(trim(nmk), 1, 70) from customer where rnk=:RNK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into NLSMASK (MASKID, DESCR, MASK, MASKNMS, SQLNMS)
values (''W4S'', ''W4S'', ''????_FPRRRRRRR'', null, ''select substr(trim(nmk), 1, 70) from customer where rnk=:RNK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into NLSMASK (MASKID, DESCR, MASK, MASKNMS, SQLNMS)
values (''W4A'', ''Выплаты пособия по безработице'', ''????_FPRRRRRRR'', null, ''select substr(trim(nmk), 1, 70) from customer where rnk=:RNK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into NLSMASK (MASKID, DESCR, MASK, MASKNMS, SQLNMS)
values (''W4W'', ''W4W'', ''????_FPRRRRRRR'', null, ''select substr(''''БПК ''''||trim(nmk), 1, 70) from customer where rnk=:RNK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

