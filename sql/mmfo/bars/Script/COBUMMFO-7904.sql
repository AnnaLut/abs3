begin
update SW_CAUSE_ERR t
   set t.name = replace(t.name,'����','���')
where name like '%����%';
end;
/
commit;
/
