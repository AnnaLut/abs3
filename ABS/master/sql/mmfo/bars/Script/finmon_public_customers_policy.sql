prompt Политизируем finmon_public_customers

prompt truncate finmon_public_customers
truncate table bars.finmon_public_customers;
/

prompt add kf
begin
    execute immediate 'alter table bars.finmon_public_customers add kf varchar2(6) DEFAULT sys_context(''bars_context'', ''user_mfo'')';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

prompt alter policies
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_PUBLIC_CUSTOMERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_PUBLIC_CUSTOMERS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FINMON_PUBLIC_CUSTOMERS'', ''WHOLE'' , null, null, null, null);
               bpa.alter_policies(''FINMON_PUBLIC_CUSTOMERS'');
               null;
           end; 
          '; 
END; 
/
prompt Заново наполняем finmon_public_customers. Может занять существенное время
begin
    for rec in (select kf from mv_kf)
        loop
            bc.go('/'||rec.kf||'/');
            finmon_check_public(1);
            commit;
        end loop;
    bc.go('/');
end;
/