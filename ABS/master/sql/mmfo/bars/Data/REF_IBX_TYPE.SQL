--добавление таблиці в справочник и відача в арм администратора абс
declare
    l_tabid references.tabid%type;
begin 
    begin
        select bars_metabase.get_tabid('IBX_TYPES') into l_tabid from dual;
    exception when no_data_found then
     -- Указанная табица (код %s) не найдена
     bars_error.raise_nerror('BMD', 'TABLE_NOT_FOUND', to_char(l_tabid)||':IBX_TYPES');
    end;
  
    if l_tabid is not null then
    
        bars_metabase.addTableToRef(l_tabid,20); --в робочи справочники

        USER_MENU_UTL.ADD_REFERENCE2ARM_BYTABNAME('IBX_TYPES','$RM_MAIN',2,1);--справочник в АРМ админа
    end if;         

end;
/      
COMMIT;