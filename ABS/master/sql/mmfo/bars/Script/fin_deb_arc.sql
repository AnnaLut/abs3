begin
   for k in (select * from mv_kf)
   LOOP
      bc.go(k.kf);
      delete from fin_deb_arc where mdat < to_date('01-04-2018','dd-mm-yyyy');
      commit;
   end LOOP;
   bc.go('/');
   dbms_stats.gather_table_stats('BARS','FIN_DEB_ARC',cascade=>TRUE,force=>TRUE);
   commit;
end;
/
