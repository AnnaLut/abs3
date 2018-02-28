begin
  execute immediate 'drop table test_recovery2620_220218';
  exception when others then null;
end;
/

begin
   execute immediate 'CREATE TABLE test_recovery2620_220218 AS
  (select a.acc, a.nls, a.kf, d.deposit_id,
   ''                                                                                                                                                                                                                 '' note
   from bars.accounts a,
   dpt_deposit d
   where a.acc = d.acc 
     and 1 = 0)';

  exception
  when OTHERS then 
    
    if (sqlcode = -00955) then 
      dbms_output.put_line('Table already exists.');
    else raise;
    end if; 
end;
/
