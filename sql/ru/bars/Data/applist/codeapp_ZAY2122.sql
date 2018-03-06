PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/codeapp_ZAY2122.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create/replace  ARM  ZAY 21,22  ***

declare 
 l_codeapp operapp.codeapp%type;
 l_codeoper_1 operlist.codeoper%type;
 l_codeoper_2 operlist.codeoper%type;
begin
select operlistnextid into l_codeoper_1 from dual;
insert into operlist (CODEOPER, NAME, DLGNAME, FUNCNAME, SEMANTIC, RUNABLE, PARENTID, ROLENAME, FRONTEND, USEARC)
values (l_codeoper_1, 'ZAY21. Візування введених угод (покупка)', 'N/A', '/barsroot/zay/currencybuysighting/index', 'ZAY', 1, null, 'BARS_ACCESS_DEFROLE', 1, 0);

select operlistnextid into l_codeoper_2 from dual;
insert into operlist (CODEOPER, NAME, DLGNAME, FUNCNAME, SEMANTIC, RUNABLE, PARENTID, ROLENAME, FRONTEND, USEARC)
values (l_codeoper_2, 'ZAY22. Візування введених угод (продаж)', 'N/A', '/barsroot/zay/currencysalesighting/index', 'ZAY', 1, null, 'BARS_ACCESS_DEFROLE', 1, 0);

 
 for rec in ( select * from operlist l where (l.name like 'ZAY22.%' or l.name like 'ZAY21.%') and funcname like '%frm_zay%' and frontend=1)
   loop
     update operlist set name =rec.name||'(OLD)' where codeoper = rec.codeoper;

     begin
      select codeapp into l_codeapp from operapp where codeoper =rec.codeoper;
     exception
       when too_many_rows or no_data_found
	then  l_codeapp:='WBIR';
     end; 

    begin
     insert into operapp (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
     values (l_codeapp, l_codeoper_1, null, 1, null, null, null, null, null, 0, 1);
     insert into operapp (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
     values (l_codeapp, l_codeoper_2, null, 1, null, null, null, null, null, 0, 1);
    exception 
      when dup_val_on_index then null; 
    end;
    delete from operapp where codeoper =rec.codeoper;
   end loop;
end ;
/



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Applist/codeappZAY2122.sql ======*** En
PROMPT ===================================================================================== 
