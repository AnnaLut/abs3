exec bars.bpa.alter_policy_info( 'OBPC_SALARY_IMPORT_LOG', 'WHOLE' , null, null, null, null );
/

exec bars.bpa.alter_policy_info( 'OBPC_SALARY_IMPORT_LOG ', 'FILIAL', null , null, null, null );
/

begin
   execute immediate '     
   create table obpc_salary_import_log (
    file_id                number,
    file_name              varchar2(400),
    crt_date               date,
    NLS                    varchar2(20),
    FIO                    varchar2(160),
    INN                    varchar2(20),
    SUMMA                  number,
    status                 varchar2(100),
    ref                    number,
    error                  varchar2(400),
    link                   varchar2(400)
 
    )';
exception
   when others
   then
      if sqlcode = -00955
      then
         null;
      else
         raise;
      end if;
end;
/
exec  bars.bpa.alter_policies('OBPC_SALARY_IMPORT_LOG');
/
grant select,delete,update,insert on bars.OBPC_SALARY_IMPORT_LOG to bars_access_defrole;
/


