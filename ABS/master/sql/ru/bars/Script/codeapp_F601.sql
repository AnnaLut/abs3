set define off

declare
    l_funcid integer;
begin
    update applist t
    set    t.name = 'АРМ "Форма 601 РУ"',
           t.frontend = 1
    where t.codeapp = 'F601';

    if (sql%rowcount = 0) then
        insert into applist (codeapp, name, frontend)
        values ('F601', 'АРМ "Форма 601 РУ"', 1);
    end if;

    begin
        l_funcid := abs_utils.add_func(p_name     => 'Підготовка даних для передачі на ЦА',
                                       p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_NBU_FORM_601[NSIFUNCTION]',
                                       p_rolename => NULL,
                                       p_frontend => 1);
    end;

    begin 
        insert into bars.operapp (codeapp, codeoper, approve, grantor)
         values ('F601', l_funcid, 1, 1);
    exception
        when dup_val_on_index then
             null;
    end;

    commit;
end;
/

set define on
