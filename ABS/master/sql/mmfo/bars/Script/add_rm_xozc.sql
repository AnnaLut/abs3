set define off;
/
begin
insert into applist (CODEAPP, NAME, HOTKEY, FRONTEND, ID)
values ('$RM_XOZC', 'АРМ-ЦА ДЗ за госп. діяльністю банку', null, 1, 2371);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
insert into operlist (CODEOPER, NAME, DLGNAME, FUNCNAME, SEMANTIC, RUNABLE, PARENTID, ROLENAME, FRONTEND, USEARC)
values (187, 'XOZ:1.Продукти ДЗ (перегляд)', 'N/A', '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=XOZ_OB22_CL[showDialogWindow=>false]', null, 1, null, 'BARS_ACCESS_DEFROLE', 1, 0);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
insert into operlist (CODEOPER, NAME, DLGNAME, FUNCNAME, SEMANTIC, RUNABLE, PARENTID, ROLENAME, FRONTEND, USEARC)
values (188, 'XOZ:2.Моделi закриття ДЗ (перегляд)', 'N/A', '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=XOZ_OB22[showDialogWindow=>false]', null, 1, null, 'BARS_ACCESS_DEFROLE', 1, 0);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
delete from OPERAPP op where op.codeoper = 3965;
exception
  when others then
    null;
end;
/
commit;
/
begin
delete from OPERLIST ol where ol.codeoper = 3965;
exception
  when others then
    null;
end;
/
commit;
/
begin
insert into operlist (CODEOPER, NAME, DLGNAME, FUNCNAME, SEMANTIC, RUNABLE, PARENTID, ROLENAME, FRONTEND, USEARC)
values (3965, 'ДЗ-4) Відшкодування в ЦА госп.ДЗ, що виникла в РУ', 'N/A', '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_XOZ_RU_CA[NSIFUNCTION][CONDITIONS=>V_XOZ_RU_CA.REC in (1,2)][showDialogWindow=>false]', null, 1, null, 'BARS_ACCESS_DEFROLE', 1, 0);
exception
  when dup_val_on_index then
    null;
end;
/
begin
insert into OPERAPP (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
values ('$RM_XOZC', 89, null, 1, null, null, null, null, null, 0, 1);
exception
  when dup_val_on_index then
    null;
end;
/
begin
insert into OPERAPP (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
values ('$RM_XOZC', 187, null, 1, null, null, null, null, null, 0, 1);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
insert into OPERAPP (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
values ('$RM_XOZC', 188, null, 1, null, null, null, null, null, 0, 1);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
insert into OPERAPP (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
values ('$RM_XOZC', 2178, null, 1, null, null, null, null, null, 0, 1);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
insert into OPERAPP (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
values ('$RM_XOZC', 2179, null, 1, null, null, null, null, null, 0, 1);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
insert into OPERAPP (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
values ('$RM_XOZC', 3015, null, 1, null, null, null, null, null, 0, 1);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
insert into OPERAPP (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
values ('$RM_XOZC', 3381, null, 1, null, null, null, null, null, 0, 1);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
insert into OPERAPP (CODEAPP, CODEOPER, HOTKEY, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR)
values ('$RM_XOZC', 3965, null, 1, null, null, null, null, null, 0, 1);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/