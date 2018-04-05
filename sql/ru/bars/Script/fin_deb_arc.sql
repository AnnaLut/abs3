begin
   tuda;
   delete from fin_deb_arc where mdat < to_date('01-04-2018','dd-mm-yyyy');
   commit;
   suda;
   dbms_stats.gather_table_stats('BARS','FIN_DEB_ARC',cascade=>TRUE,force=>TRUE);
   commit;
end;
/
