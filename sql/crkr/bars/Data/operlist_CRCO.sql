set define off

begin
    execute immediate 'insert into APPLIST(CODEAPP,
                    NAME,
                    HOTKEY,
                    FRONTEND)
values (''CRCO'',
''АРМ Операціоніст ЦРКР'',
null,
1
)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 




declare
   l_funcid  operlist.codeoper%type;
begin
delete from operapp where codeoper in ( select codeoper  from operlist where funcname like '/barsroot/crkr/clientprofile/crkrbag/');
delete from operlist where funcname = '/barsroot/crkr/clientprofile/crkrbag/';

     begin
        l_funcid := abs_utils.add_func(
        p_name     => '1. Актуалізація компенсанційних рахунків',
        p_funcname =>  '/barsroot/crkr/clientprofile/crkrbag/',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCO', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/

declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => '6. Реєстр актуалізованих вкладів',
        p_funcname =>  '/barsroot/crkr/regpay/payments',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCO', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/



declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => '7. Реєстр актуалізованих вкладів на поховання',
        p_funcname =>  '/barsroot/crkr/regpay/payments?funeral=true',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCO', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/


declare
   l_funcid  operlist.codeoper%type;
   l_funcid2  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => '3. Оформлення спадщини',
        p_funcname =>  '/barsroot/crkr/clientprofile/crkrbag?burial=true',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCO', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

update  operlist 
set funcname = '/barsroot/crkr/clientprofile/clientbag?burial=true&herid=\d+'
where funcname = '/barsroot/crkr_forms/customer_crkr.aspx?burial=true&herid=\d+';

delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname = '/barsroot/crkr/clientprofile/clientbag?burial=true&herid=\d+');
delete from operlist_deps   where id_child in ( select codeoper  from operlist where funcname = '/barsroot/crkr/clientprofile/clientbag?burial=true&herid=\d+');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname = '/barsroot/crkr/clientprofile/clientbag?burial=true&herid=\d+');
delete from operlist where funcname = '/barsroot/crkr/clientprofile/clientbag?burial=true&herid=\d+';


  begin
    l_funcid2 := abs_utils.add_func(
    p_name     => 'Актуалізовані вклади ЦРКР(спадщина)',
    p_funcname =>  '/barsroot/crkr/clientprofile/clientbag?burial=true&herid=\d+',
    p_rolename => NULL,   
    p_frontend => 1,
	p_runnable => 3
    );
  end;

  abs_utils.add_oplist_deps(l_funcid, l_funcid2);


end;
/

declare
   l_funcid  operlist.codeoper%type;
   l_funcid2  operlist.codeoper%type;
begin

update  operlist 
set funcname = '/barsroot/crkr/clientprofile/clientbag'
where funcname = '/barsroot/crkr_forms/customer_crkr.aspx';


delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname like '/barsroot/crkr/clientprofile/clientbag');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname like '/barsroot/crkr/clientprofile/clientbag');
delete from operlist where funcname = '/barsroot/crkr/clientprofile/clientbag';

     begin
        l_funcid := abs_utils.add_func(
        p_name     => '4. Актуалізовані вклади ЦРКР',
        p_funcname =>  '/barsroot/crkr/clientprofile/clientbag',
        p_rolename => 'START1',   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCO', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

  begin
    l_funcid2 := abs_utils.add_func(
    p_name     => 'Картка клієнта(ЦРКР)',
    p_funcname =>  '/barsroot/Crkr/ClientProfile/Index?rnk=\d+&button=true',
    p_rolename => NULL,   
    p_frontend => 1,
	p_runnable => 3
    );
  end;

  abs_utils.add_oplist_deps(l_funcid, l_funcid2);

  begin
    l_funcid2 := abs_utils.add_func(
    p_name     => 'Картка клієнта(ЦРКР)',
    p_funcname =>  '/barsroot/Crkr/ClientProfile/Index?rnk=\d+',
    p_rolename => NULL,   
    p_frontend => 1,
	p_runnable => 3
    );
  end;

  abs_utils.add_oplist_deps(l_funcid, l_funcid2);


end;
/

declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => '2. Актуалізація вкладів на поховання',
        p_funcname =>  '/barsroot/crkr/clientprofile/crkrbag?funeral=true',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCO', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/

declare

  l_id number;
  l_id_ number;
  l_id1 number;
  l_id2 number;

  procedure func2arm(p_func_id in number) is
  begin
    insert into operapp (codeapp, codeoper, approve)
    values ('CRCO', p_func_id, 1);
  exception when dup_val_on_index then 
    null;
  end;  
  
  procedure add2deps(p_idpar in number, p_idchild in number) is
  begin
    insert into operlist_deps (id_parent, id_child) values (p_idpar, p_idchild);
  exception when dup_val_on_index then 
    null;
  end;    
 
  function add_func(
    p_fname in varchar2, 
    p_ftext in varchar2,
    p_runable in number) return number
  is
   l_id number;
  begin
  
    select codeoper into l_id from operlist where funcname = p_fname;
    return l_id;
    
  exception when no_data_found then
  
    select OperListNextId into l_id from dual;
  
    insert into operlist
      (codeoper, name, dlgname, funcname, semantic, runable, rolename, frontend, usearc)
    values
      (l_id, p_ftext, 'N/A', p_fname , '', p_runable, 'START1', 1, 0);    
      
    return l_id;  
   
  end;

begin 

update  operlist 
set funcname = '/barsroot/crkr/clientprofile/clientbag'
where funcname = '/barsroot/crkr_forms/customer_crkr.aspx';


delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname like '/barsroot/crkr/clientprofile/clientbag');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname like '/barsroot/crkr/clientprofile/clientbag');
delete from operlist where funcname = '/barsroot/crkr/clientprofile/clientbag';

delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname like '/barsroot/Crkr/ClientProfile/Index?rnk=\d+') or id_child in ( select codeoper  from operlist where funcname like '/barsroot/Crkr/ClientProfile/Index?rnk=\d+');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname like '/barsroot/Crkr/ClientProfile/Index?rnk=\d+');
delete from operlist where funcname = '/barsroot/Crkr/ClientProfile/Index?rnk=\d+';

delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/crkr_link_deposit.aspx?rnk=\d+') or id_child in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/crkr_link_deposit.aspx?rnk=\d+');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/crkr_link_deposit.aspx?rnk=\d+');
delete from operlist where funcname = '/barsroot/crkr_forms/crkr_link_deposit.aspx?rnk=\d+';

delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/crkr_customer_history.aspx?rnk=\d+') or id_child in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/crkr_customer_history.aspx?rnk=\d+');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/crkr_customer_history.aspx?rnk=\d+');
delete from operlist where funcname = '/barsroot/crkr_forms/crkr_customer_history.aspx?rnk=\d+';

     l_id := add_func('/barsroot/crkr/clientprofile/clientbag', '4. Актуалізовані вклади ЦРКР', 1);
     l_id_ := add_func('/barsroot/Crkr/ClientProfile/Index?rnk=\d+', 'Картка клієнта(ЦРКР)', 3);
     l_id1 := add_func('/barsroot/crkr_forms/crkr_link_deposit.aspx?rnk=\d+', 'Потенціальні вклади клієнта(ЦРКР)', 3);
     l_id2 := add_func('/barsroot/crkr_forms/crkr_customer_history.aspx?rnk=\d+', 'Історія змін клієнта(ЦРКР)', 3);
  func2arm(l_id);
  add2deps(l_id, l_id_);
  add2deps(l_id_, l_id1);
  add2deps(l_id_, l_id2);
 end;  
/

declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => '5. Візування "своїх" операцій(ЦРКР)',
        p_funcname =>  '/barsroot/crkr/sighting/oper',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCO', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/

declare
   l_funcid  operlist.codeoper%type; 
begin
  
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Друк звітів',
        p_funcname =>  '/barsroot/cbirep/rep_list.aspx?codeapp=\S*',
        p_rolename => NULL,   
        p_frontend => 1
        );
        exception
          when too_many_rows then
            select o.codeoper into l_funcid from operlist o where o.funcname = '/barsroot/cbirep/rep_list.aspx?codeapp=\S*' and rownum < 2;
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCO', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/

commit
/
