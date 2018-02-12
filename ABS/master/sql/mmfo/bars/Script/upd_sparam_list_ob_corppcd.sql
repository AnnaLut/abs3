begin 

update sparam_list a
set NSISQLWHERE = 'ID!=PARENT_ID'
where a.NSISQLWHERE = 'ID<>PARENT_ID'
and a.NSINAME = 'V_OB_CORPORATION'
and a.TAG = 'OBCORPCD';
dbms_output.put_line('Updated '||to_char(sql%rowcount)||' row in sparam_list');
if sql%rowcount = 1 then
commit;
dbms_output.put_line('Updat sparam_list commited');
else
rollback;
dbms_output.put_line('Updat sparam_list rollback');
end if;

end;
/