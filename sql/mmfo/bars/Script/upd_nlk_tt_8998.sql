insert into nlk_tt (id, tt)
  select  '99','013' from dual where not exists (select 1 from nlk_tt where id = '99' and tt = '013');