declare
  l_spid sparam_list.spid%type;
  cursor cur
      is
  select SPID 
    from SPARAM_LIST
   where NAME = 'K150'
     for update nowait;   
begin
  open cur;
  loop
    fetch cur 
     into l_spid;
    exit when cur%notfound;
    delete PS_SPARAM
     where SPID = l_spid;
    delete W4_SPARAM
     where SP_ID = l_spid;
    delete SPARAM_LIST
     where CURRENT OF cur;
  end loop;
  commit;
  close cur;
end;
/
