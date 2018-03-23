-- групи користувачів
begin
  insert into GROUPS ( ID, NAME )
  values ( 1025, 'Підрозділ бек-офісу' );
exception
  when dup_val_on_index then
    null;
end;
/

commit;

begin
  insert into GROUPS ( ID, NAME )
  values ( 1026, 'Фронт-офіс' );
exception
  when dup_val_on_index then
    null;
end;
/

commit;
