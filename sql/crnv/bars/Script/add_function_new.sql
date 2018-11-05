prompt start add new function 

begin
    insert into OPERLIST_ACSPUB (FUNCNAME, FRONTEND)
    values ('/barsroot/customerlist/custhistory.aspx?key=\d+', 1);
exception
    when dup_val_on_index then
         null;
end;
/
commit;
prompt done add new function 