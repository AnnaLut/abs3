begin
   bc.go('300465');
   for k in (select d.rowid RI, d.* from cc_deal d where d.vidd in (1527,1517))
   LOOP
      update cc_deal set vidd = decode(k.vidd,1527,1524,1513) where rowid = k.RI; 
   end loop;
   commit;
   bc.go('/');
end;
/