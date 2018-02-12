begin 
   for kf in (select * from mv_kf)   loop 
   bc.go (kf.kf); 
   update accountsw set value = '09' where  tag = 'TERM_LIM' and value = '10' ; 
   end loop;
end;
/

commit;
