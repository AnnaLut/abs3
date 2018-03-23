begin
   tuda;
   for k in (select p.rowid RI from cc_accp p, accounts s where p.accs=s.acc and nd=25539502101 and substr(nls,1,4)='3118')
   LOOP
      delete from cc_accp where rowid=k.RI;
   end loop;
   commit; 
   suda; 
end;
/   