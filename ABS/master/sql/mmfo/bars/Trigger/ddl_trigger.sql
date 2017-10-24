

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/DDL_TRIGGER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger DDL_TRIGGER ***

  CREATE OR REPLACE TRIGGER BARS.DDL_TRIGGER 
before create or alter or drop on schema
declare
   l_opertype   sec_ddl_audit.operation_type%type;
   l_sql        ora_name_list_t;
   l_sql_text   varchar2(4000);
   n            pls_integer;
   l_machine    sec_ddl_audit.machine%type;
   l_module     varchar2(200);
   l_appModule  varchar2(200);
   l_appAction  varchar2(200);

   pragma autonomous_transaction;

begin

   select ora_sysevent into l_opertype from dual;
   n := sql_txt(l_sql);
   for i in 1..n loop
       if length(l_sql_text) + length(l_sql(i)) >= 4000 then
          l_sql_text := l_sql_text || trim(substr(l_sql(i),1,4000-length(l_sql_text)));
          exit;
       else
          l_sql_text := l_sql_text || trim(l_sql(i));
       end if;
   end loop;

   -- Имя машины устанавливается в контексте
   l_machine := substr( sys_context('bars_global', 'host_name') , 1, 100);

   -- Отдельно для заданий имя машины
   if(l_machine is null and sys_context('userenv', 'bg_job_id') is not null) then
      l_machine := 'LOCALHOST';
   end if;

   -- Это для обхода bug в версии 9.2.0.4
   if (l_machine is null) then
       l_machine := 'NOT AVAILABLE';
   end if;

   dbms_application_info.read_module(l_appModule, l_appAction);
   l_module := substr(l_appModule, 1, 200);

      insert into sec_ddl_audit(
         rec_id,
         rec_date,
         rec_bdate,
         rec_uname,
         rec_module,
         obj_name,
         obj_owner,
         sql_text,
         machine,
         operation_type)
      select  s_ddl_sec_audit.nextval,
              sysdate,
              glb_bankdate,
              user,
              l_module,
              ora_dict_obj_name,
              ora_dict_obj_owner,
              l_sql_text,
              l_machine,
              l_opertype
        from dual;
     commit;
   exception when others then
      dbms_output.put_line(SQLERRM);
      null;
END ddl_trigger;


/
ALTER TRIGGER BARS.DDL_TRIGGER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/DDL_TRIGGER.sql =========*** End ***
PROMPT ===================================================================================== 
