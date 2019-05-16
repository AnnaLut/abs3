begin 
   bc.go('300465'); 
   for k in (select c.rowid ri,c.nd,c.nls,c.nbs, r.* 
             from rez_cr c, (SELECT 90593701 RNK ,'164216517' KOL26 FROM DUAL UNION ALL
                             SELECT 94636101,     '164100000;164216501;164216504;164216505;164216516;164216517;164216606;164216607' FROM DUAL UNION ALL
                             SELECT 30024501,     '000000000' FROM DUAL UNION ALL
                             SELECT 90608001,     '164216501;164216516;164216517' FROM DUAL UNION ALL
                             SELECT 30016301,     '164216501;164216504;164216505;164216517;164216606;164216607;164216608' FROM DUAL UNION ALL
                             SELECT 90346601,     '#' FROM DUAL UNION ALL
                             SELECT 327605201,    '000000000' FROM DUAL UNION ALL
                             SELECT 94312801,     '000000000' FROM DUAL UNION ALL
                             SELECT 90321001,     '164100000;164216501' FROM DUAL UNION ALL
                             SELECT 93789501,     '164100000;164216501' FROM DUAL UNION ALL
                             SELECT 93922501,     '164216517' FROM DUAL ) r 
             where c.fdat=to_date('01-05-2019','dd-mm-yyyy') and c.rnk = r.rnk and (c.tipa=15 or c.nbs in ('3541'))
            )
   LOOP
      update rez_cr set kol26=k.kol26 where rowid=k.RI;
   end loop;
   commit;
end;
/
