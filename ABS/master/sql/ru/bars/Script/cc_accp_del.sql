begin
   for k in ( select * from mv_kf where kf='300465' )
   loop 
      bc.go ( k.KF);
      for cc in (select rowid RI from cc_accp 
                 where accs in (select acc from rez_cr where fdat = to_date('01-07-2018','dd-mm-yyyy')
                   and tip in ('SDA','SDF','SDM','SDI','SRR') )
		 		) 
      loop
	     delete from cc_accp where rowid = cc.RI;
      end loop;	 
	  commit;
   end loop;	 
   commit; 
end;
/   