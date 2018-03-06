declare 
 l_codeoper_1 operlist.codeoper%type;

begin
For k in (select codeoper from operlist where name like 'ZAY3%')
Loop
update operlist set name=name||'(OLD)' where codeoper = k.codeoper;
delete from operapp where codeoper = k.codeoper;
End loop;

select operlistnextid into l_codeoper_1 from dual;
insert into operlist (CODEOPER, NAME, DLGNAME, FUNCNAME, SEMANTIC, RUNABLE, PARENTID, ROLENAME, FRONTEND, USEARC)
values (l_codeoper_1, 'ZAY3. Підтвердження ПРІОРИТЕТНИХ заявок', 'N/A', '/barsroot/zay/confirmprimaryzay/index', 'ZAY', 1, null, 'BARS_ACCESS_DEFROLE', 1, 0);

insert into operapp (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
values ('WBIR', l_codeoper_1, null, 1, null, null, null, null, null, 0, 1);

end ;
/