
begin
    execute immediate 'insert into APPLIST(CODEAPP,
                    NAME,
                    HOTKEY,
                    FRONTEND)
values (''CRCK'',
''АРМ Контролер Бек-офісу РУ ЦРКР'',
null,
1
)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

update APPLIST set NAME = 'АРМ Контролер РУ ЦРКР' where CODEAPP = 'CRCK';


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
     delete from OPERAPP where codeapp = 'CRCK' and codeoper = l_funcid;
/*  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCK', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;

    insert into applist_staff (id, codeapp, approve, grantor)
    select s.id, 'CRCK', 1, 1
    from   staff$base s
    where  s.logname = 'ABSADM' and
           not exists (select 1 from applist_staff astf where astf.id = s.id and astf.codeapp = 'CRCK');  

*/
end;
/


declare
   l_funcid  operlist.codeoper%type;
begin

update  operlist 
set funcname = '/barsroot/crkr/clientprofile/clientbag?control=1'
where funcname = '/barsroot/crkr_forms/customer_crkr.aspx?control=1';


     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Актуалізовані вклади ЦРКР(Контролер)',
        p_funcname =>  '/barsroot/crkr/clientprofile/clientbag?control=1',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCK', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;



end;
/

declare
   l_funcid  operlist.codeoper%type;
begin
     begin
        l_funcid := abs_utils.add_func(
        p_name     => 'Не актуалізовані вклади ЦРКР(Контролер)',
        p_funcname =>  '/barsroot/crkr/clientprofile/crkrbag?control=1',
        p_rolename => NULL,   
        p_frontend => 1
        );
     end;
  
begin 
insert into bars.operapp
   (codeapp, codeoper, approve, grantor)
 values
   ('CRCK', l_funcid, 1, 1);
 exception when dup_val_on_index then null;
end;



end;
/
