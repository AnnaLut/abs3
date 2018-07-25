begin
update SW_CAUSE_ERR t
   set t.name = replace(t.name,'מננו','מנו')
where name like '%מננו%';
end;
/
commit;
/
