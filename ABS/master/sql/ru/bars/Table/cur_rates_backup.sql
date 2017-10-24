exec BARS_POLICY_ADM.ALTER_POLICY_INFO('CUR_RATES_BACKUP','FILIAL', null, null, null, null);

exec BARS_POLICY_ADM.ALTER_POLICY_INFO('CUR_RATES_BACKUP','WHOLE', null, null, null, null);


begin
execute immediate 
'create table CUR_RATES_BACKUP (FILENAME varchar2(30), DATE_LOAD DATE, FILE_TYPE VARCHAR2(20), USERID_LOAD NUMBER, FILE_BODY CLOB)';
exception when others then 
    if (sqlcode=-955) then null;  else raise;  end if;    
end;
/


grant select, insert, update, delete on cur_rates_backup to bars_access_defrole
/
