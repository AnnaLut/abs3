begin
  for i in (select tt, dk
              from tts t
             where not exists
             (select 1 from obpc_trans_out tt where t.tt = tt.tt)
               and exists
             (select 1
                      from ps_tts p
                     where p.tt = t.tt
                       and p.nbs in ('2620', '2600', '2650'))) loop
    begin
      insert into ttsap
        (ttap, tt, dk)
      values
        ('!!V', i.tt, case i.dk when 1 then 0 else 1 end);
    exception
      when others then
        null;
    end;
  end loop;
  
  begin
     insert into ttsap
        (ttap, tt, dk)
     values
        ('!!U', 'PKR', 0);
  exception
     when others then
        null;
end;

  begin
     insert into ttsap
        (ttap, tt, dk)
     values
        ('!!Z', 'PKR', 1);
  exception
     when others then
        null;
  end;

  begin
     insert into ttsap
       (ttap, tt, dk)
     values
       ('!!U', 'PKD', 1 );
  exception
     when others then
        null;
  end;

  begin
     insert into ttsap
        (ttap, tt, dk)
     values
        ('!!U', 'OW4', 1);
  exception
     when others then
        null;
  end;

  begin
     insert into ttsap
       (ttap, tt, dk)
     values
       ('!!U', 'CL1', 0 );
  exception
     when others then
        null;
  end;

  begin
     insert into ttsap
        (ttap, tt, dk)
     values
        ('!!U', 'CL5', 0);
  exception
     when others then
        null;
  end;

  begin
     insert into ttsap
       (ttap, tt, dk)
     values
       ('!!V', 'DP2', 0);
  exception
     when others then
         null;
  end;

  commit;
end;
/
