prompt insert data into SGN_TYPE

begin
  insert into SGN_TYPE ( ID, NAME, IS_ACTIVE )
  values ( 'VEG', '������������ ����1', 'Y' );
exception
  when dup_val_on_index
  then null;
end;
/

begin
  insert into SGN_TYPE ( ID, NAME, IS_ACTIVE )
  values ( 'VG2', '������������ ����2 (X.509)', 'N' );
exception
  when dup_val_on_index
  then null;
end;
/

commit;