begin
   bc.go('300465'); 
   for k in (select p.rowid RI from cc_accp p, accounts s where p.accs=s.acc and nd in (25539502101,50126769501,28356682201,28356622201,25539559601,25539589601) and substr(nls,1,4)='3118')
   LOOP
      delete from cc_accp where rowid=k.RI;
   end loop;
   commit; 
   bc.go('/'); 
end;
/   