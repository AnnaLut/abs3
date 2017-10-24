declare 
 l_cnt number;
begin 
  select count(*)
    into l_cnt  
    from tts t
   where t.tt in ('CL2','CL5');
  if l_cnt = 2 then 
    update chklist_tts t 
       set t.idchk = 25,
           t.f_in_charge = 0
     where t.tt in ('CL2','CL5')
       and t.idchk = 5;
       
    update chklist_tts t 
       set t.priority = 3
     where t.tt = 'CL5'
       and t.idchk = 30;
       
    update chklist_tts t 
       set t.sqlval = (select t1.sqlval
                        from chklist_tts t1
                       where t1.tt = 'IB2'
                         and t1.idchk = t.idchk)
     where t.tt = 'CL2' 
       and t.idchk in (7, 38, 94);

    update chklist_tts t 
       set t.sqlval = (select t1.sqlval
                        from chklist_tts t1
                       where t1.tt = 'IB5'
                         and t1.idchk = t.idchk)
     where t.tt = 'CL5' 
       and t.idchk in (30);
       
    delete from chklist_tts t where t.tt = 'CL2' and t.idchk = 11;

    insert into chklist_tts (tt,idchk,priority,f_big_amount,sqlval,f_in_charge,flags)
    values ('CL5', 7, 2, null, 'kv<>980', 0, null);
    commit;
  else 
    raise_application_error (-20111,'Операции для обновления не найдены!!!');  
  end if;  
end;

select * from chklist_tts t where t.tt in ('CL2','IB2','CL5','IB5')
