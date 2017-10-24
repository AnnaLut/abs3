begin
 execute immediate   'alter table nbu23_cck_ul_kor add (VKR varchar2(3)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN nbu23_cck_ul_kor.VKR  IS 'Внутрішній кредитний рейтинг';

