declare
 l_OKPO varchar2(30);
begin
   for k in (select n.rowid rw, n.* from nd_val n)
   Loop
      l_okpo := F_RNK_gcif (null, k.rnk); 
      update nd_val set okpo = l_okpo where rowid = k.rw;
   end loop;
end;
/