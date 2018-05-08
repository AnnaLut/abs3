begin
  execute immediate q'[alter table BARS.SW_CA_FILES drop constraint PK_SW_CA_FILES cascade]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.SW_CA_FILES drop constraint UK_SW_CA_FILES ]';
exception
  when OTHERS then
  null;
end;
/


begin
  execute immediate q'[ALTER TABLE BARS.SW_CA_FILES ADD pid NUMBER]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "pid" already exists in table.');
    else raise;
    end if;
end;
/

declare
  l_id number;
begin
  for cur in (select t.rowid lrow, t.* from SW_CA_FILES t where t.id is null) 
  loop
    update SW_CA_FILES t 
    set t.pid = t.id,
        t.id  = s_sw_ca_files.nextval
    where t.rowid = cur.lrow    
    return t.id into l_id;
    
    update sw_own s
    set s.prn_file = l_id
    where s.prn_file = cur.id
      and s.kf       = cur.kf; 
      
    update sw_compare s
    set s.prn_file_own = l_id
    where s.prn_file_own = cur.id
      and s.kf       = cur.kf;       
         
  end loop;
end;
/
