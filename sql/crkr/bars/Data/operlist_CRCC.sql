set define off
begin
    execute immediate 'insert into APPLIST(CODEAPP,
                    NAME,
                    HOTKEY,
                    FRONTEND)
values (''CRCC'',
''АРМ Бек-офіс ЦРКР ЦА'',
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
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Не актуалізовані вклади ЦРКР(БЕК)',
        p_funcname =>  '/barsroot/crkr/clientprofile/crkrbag?load=true',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCC', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/

declare
   l_funcid  operlist.codeoper%type;
   l_funcid2  operlist.codeoper%type;
begin

delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/crkr_params.aspx?type_id=\S*');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/crkr_params.aspx?type_id=\S*');
delete from operlist where funcname = '/barsroot/crkr_forms/crkr_params.aspx?type_id=\S*';


delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/add_or_edit_params.aspx?id=\S*');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/add_or_edit_params.aspx?id=\S*');
delete from operlist where funcname = '/barsroot/crkr_forms/add_or_edit_params.aspx?id=\S*';

  begin
    l_funcid := abs_utils.add_func(
    p_name     => 'Налаштування лімітів та параметрів ЦРКР(БЕК)',
    p_funcname =>  '/barsroot/crkr_forms/crkr_params.aspx?type_id=\S*',
    p_rolename => NULL,   
    p_frontend => 1
    );
  end;
  
  begin 
  insert into bars.operapp
    (codeapp, codeoper, approve, grantor)
  values
    ('CRCC', l_funcid, 1, 1);
  exception when dup_val_on_index then null;
  end;
  
  begin
    l_funcid2 := abs_utils.add_func(
    p_name     => 'Додавання/Редагування лімітів та параметрів',
    p_funcname =>  '/barsroot/crkr_forms/add_or_edit_params.aspx?id=\S*',
    p_rolename => NULL,   
    p_frontend => 1,
	p_runnable => 2
    );
  end;
  
  begin 
  insert into bars.operapp
    (codeapp, codeoper, approve, grantor)
  values
    ('CRCC', l_funcid2, 1, 1);
  exception when dup_val_on_index then null;
  end;
  
  abs_utils.add_oplist_deps(l_funcid, l_funcid2);
end;
/



declare
   l_funcid  operlist.codeoper%type;
   l_funcid2  operlist.codeoper%type;
begin
--видалити стару непотрібну взагалі
delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname = '/barsroot/crkr_forms/customer_crkr.aspx?flag=1');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname = '/barsroot/crkr_forms/customer_crkr.aspx?flag=1');
delete from operlist where funcname = '/barsroot/crkr_forms/customer_crkr.aspx?flag=1';
--ще одна заміна
delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname = '/barsroot/crkr_forms/customer_crkr_bak.aspx');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname = '/barsroot/crkr_forms/customer_crkr_bak.aspx');
delete from operlist where funcname = '/barsroot/crkr_forms/customer_crkr_bak.aspx';

     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Актуалізовані вклади ЦРКР(БЕК)',
        p_funcname =>  '/barsroot/crkr/clientprofile/clientbag?button=true',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCC', l_funcid, 1, 1);
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
end;
/
declare
   l_funcid  operlist.codeoper%type;
begin

delete from operlist_deps   where id_parent in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/rebranch.aspx');
delete from operapp where codeoper in ( select codeoper  from operlist where funcname like '/barsroot/crkr_forms/rebranch.aspx');
delete from operlist where funcname = '/barsroot/crkr_forms/rebranch.aspx';

     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Ребранчинг вкладів',
        p_funcname =>  '/barsroot/crkr/rebranch/index',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCC', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/

declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Реєстр виплат на поховання',
        p_funcname =>  '/barsroot/crkr/regpay/paymregistry?type=bur',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCC', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/

declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Запити на відміну операцій',
        p_funcname =>  '/barsroot/crkr/sighting/back',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  

/*insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCC', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;
*/
--вилучено з АРМ так як функція контролера підрозділа тільки в бєка і логіку змінено запит відразу по візі відпрацювує
  delete from operapp where codeapp='CRCC' and codeoper=l_funcid;
end;
/

declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Візування документів підрозділу(ЦРКР)',
        p_funcname =>  '/barsroot/crkr/sighting/control',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCC', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

end;
/
