begin for kf in (select * from mv_kv);
      loop bc.go (k.KV); update accountsw set value = '09' where  tag = 'TERM_LIM' and value = '10' ; end loop;
end;

commit;
