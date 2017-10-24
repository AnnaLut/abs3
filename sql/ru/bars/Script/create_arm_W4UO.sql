begin
  insert into applist (codeapp, name, frontend)
  values ('W4UO', 'АРМ "БПК – Way4 (ЮО)"', 1);
exception when dup_val_on_index then
  update applist
     set name = 'АРМ "БПК – Way4 (ЮО)"', frontend = 1
   where codeapp = 'W4UO';
end;
/

delete from operapp where codeapp = 'W4UO';
delete from refapp  where codeapp = 'W4UO';
delete from app_rep where codeapp = 'W4UO';


prompt -- 1. Добавление функций

set define off
declare
  l_app_code varchar2(10 char) := 'W4UO';
  l_funcname varchar2(250 Byte);
  l_name varchar2(250 Byte);
  l_main_oper_code number;
begin
  l_funcname := '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio_uo';
  l_name := 'Way4. Портфель БПК(ЮО)';
  l_main_oper_code := abs_utils.add_func(
                        p_name     => l_name,
                        p_funcname => l_funcname,
                        p_rolename => 'OW',
                        p_frontend => 1,
                        p_runnable => 1
                      );
    begin
      insert into operapp(codeapp,codeoper,approve,grantor)
           values (l_app_code, l_main_oper_code, 1, 1);
    exception when dup_val_on_index then
      null;
    end;
end;
/


declare
  l_funcname varchar2(250 Byte);
  l_name varchar2(250 Byte);
  l_main_oper_code number;
  l_id number;
begin
  l_funcname  := '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.product_uo&formname=\S+&proect_id=(\d+|-\d+)&grp_code=\S+';
  l_name  := 'Way4.product_uo';
  l_main_oper_code := abs_utils.add_func(
                        p_name     => l_name,
                        p_funcname => l_funcname,
                        p_rolename => '',
                        p_frontend => 1,
                        p_runnable => 3
                      );
    
    select t.codeoper
      into l_id 
      from operlist t
     where trim(t.name) = 'Way4. Портфель БПК(ЮО)' and t.frontend = 1 and rownum = 1;

  abs_utils.add_oplist_deps(l_id, l_main_oper_code);
end;
/


declare
  l_funcname varchar2(250 Byte);
  l_name varchar2(250 Byte);
  l_main_oper_code number;
  l_id number;       
begin 
  l_funcname  := '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.newdeal_uo&rnk=\d+&proect_id=(\d+|-\d+)&card_code=\S+';
  l_name  := 'Way4.newdeal_uo';
  l_main_oper_code := abs_utils.add_func(
                        p_name     => l_name,
                        p_funcname => l_funcname,
                        p_rolename => '',
                        p_frontend => 1,
                        p_runnable => 3
                      ); 

  select t.codeoper
      into l_id 
      from operlist t
     where trim(t.name) = 'Way4. Портфель БПК(ЮО)' and t.frontend = 1 and rownum =1;

  abs_utils.add_oplist_deps(l_id, l_main_oper_code);
end;
/

 
declare
  l_funcname varchar2(250 Byte);
  l_name varchar2(250 Byte);
  l_main_oper_code number;
  l_id number;      
begin 
  l_funcname := '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.rnk_uo&proect_id=(\d+|-\d+)&card_code=\S+';
  l_name := 'Way4. rnk_uo';
  l_main_oper_code := abs_utils.add_func(
                        p_name     => l_name,
                        p_funcname => l_funcname,
                        p_rolename => '',
                        p_frontend => 1,
                        p_runnable => 3
                      ); 
    select t.codeoper
      into l_id 
      from operlist t
     where trim(t.name) = 'Way4. Портфель БПК(ЮО)' and t.frontend = 1 and rownum =1;

  abs_utils.add_oplist_deps(l_id, l_main_oper_code);
end;
/


declare
    l_funcname varchar2(250 Byte);
    l_name varchar2(250 Byte);
    l_main_oper_code number;
    l_id number;      
begin 
    l_funcname  := '/barsroot/barsweb/dynform.aspx?form=bpkw4.ref.customer_uo&proect_id=(\d+|-\d+)&card_code=\S+&rnk=\d*&okpo=\S*&nmk=\S*';
    l_name  := 'Way4. customer_uo';
    l_main_oper_code := abs_utils.add_func(
                          p_name     => l_name,
                          p_funcname => l_funcname,
                          p_rolename => '',
                          p_frontend => 1,
                          p_runnable => 3
                        ); 
    select t.codeoper
      into l_id 
      from operlist t
     where trim(t.name) = 'Way4. Портфель БПК(ЮО)' and t.frontend = 1 and rownum =1;

  abs_utils.add_oplist_deps(l_id, l_main_oper_code);
end;
/

declare
    l_app_code varchar2(10 char) := 'W4UO';
    l_funcname varchar2(250 Byte);
    l_name varchar2(250 Byte);
    l_main_oper_code number;
begin 
    l_funcname  := '/barsroot/bpkw4/ActivationReservedAccounts/index';
    l_name  := 'Way4. Підтвердження активації зарезервованих рахунків (ЮО)';
    l_main_oper_code := abs_utils.add_func(
                              p_name     => l_name,
                              p_funcname => l_funcname,
                              p_rolename => '',
                              p_frontend => 1,
                              p_runnable => 1
                             ); 
    begin
          insert into operapp(codeapp,codeoper,approve,grantor)
          values (l_app_code, l_main_oper_code, 1, 1);
    exception  when dup_val_on_index then
         null;         
    end;
end;
/


declare
    l_app_code varchar2(10 char) := 'W4UO';
    l_funcname varchar2(250 Byte);
    l_name varchar2(250 Byte);
    l_main_oper_code number;
begin 
  l_funcname  := '/barsroot/bpkw4/instantcard/index';
  l_name  := 'Way4. Запит на миттєві картки ЮО';
  l_main_oper_code := abs_utils.add_func(
                              p_name     => l_name,
                              p_funcname => l_funcname,
                              p_rolename => '',
                              p_frontend => 1,
                              p_runnable => 1
                             ); 
    begin
          insert into operapp(codeapp,codeoper,approve,grantor)
          values (l_app_code, l_main_oper_code, 1, 1);
    exception  when dup_val_on_index then
         null;         
    end;
end;
/


declare
  l_id   operlist.codeoper%type;
  l_name operlist.funcname%type := '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.cmrequest';
begin
  begin
     select codeoper into l_id from operlist
      where trim(replace(replace(replace(funcname, chr(39), ''), chr(34), ''), ' ', '')) = l_name and rownum = 1;
  exception when no_data_found then null;
  end;
  if l_id is not null then
    begin
      insert into operapp (codeapp, codeoper, approve)
           values ('W4UO', l_id, 1);
    exception when dup_val_on_index then null;
    end;
  end if;
end;
/


commit;


prompt 
prompt @sql\web_form_confirm_acc.sql
declare
    l_app_code varchar2(10 char) := 'W_W4';
    l_funcname varchar2(250 Byte);
    l_name varchar2(250 Byte);
    l_main_oper_code number;
    v_is_exist number;  
begin 
           
    l_funcname  := '/barsroot/bpkw4/ActivationReservedAccounts/index';
    l_name  := 'Way4. Підтвердження активації зарезервованих рахунків';
    select count(*) into v_is_exist from operlist where funcname = l_funcname;
    IF v_is_exist = 0 THEN
        l_main_oper_code := abs_utils.add_func(
                              p_name        => l_name,
                              p_funcname    => l_funcname,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             ); 
    ELSE
        select codeoper into l_main_oper_code from operlist where funcname = l_funcname and rownum = 1;
        update operlist set funcname = l_funcname where codeoper = l_main_oper_code;
    END IF;
    begin
          insert into operapp(codeapp,codeoper,approve,grantor)
          values (l_app_code, l_main_oper_code, 1, 1);
    exception  when dup_val_on_index then
         null;         
    end;
                                          
end;
/
commit;



prompt 
prompt @sql\web_form_request_instanr_uo.sql

declare
    l_app_code varchar2(10 char) := 'W_W4';
    l_funcname varchar2(250 Byte);
    l_name varchar2(250 Byte);
    l_main_oper_code number;
    v_is_exist number;  
begin 
           
    l_funcname  := '/barsroot/bpkw4/instantcard/index';
    l_name  := 'Way4. Запит на миттєві картки ЮО';
    select count(*) into v_is_exist from operlist where funcname = l_funcname;
    IF v_is_exist = 0 THEN
        l_main_oper_code := abs_utils.add_func(
                              p_name        => l_name,
                              p_funcname    => l_funcname,
                              p_rolename    => '',
                              p_frontend    => 1,
                              p_runnable    => 1
                             ); 
    ELSE
        select codeoper into l_main_oper_code from operlist where funcname = l_funcname and rownum = 1;
        update operlist set funcname = l_funcname where codeoper = l_main_oper_code;
    END IF;
    begin
          insert into operapp(codeapp,codeoper,approve,grantor)
          values (l_app_code, l_main_oper_code, 1, 1);
    exception  when dup_val_on_index then
         null;         
    end;
                                          
end;
/
commit;