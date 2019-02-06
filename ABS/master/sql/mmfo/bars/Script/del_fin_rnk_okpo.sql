begin
   for k in (select * from  mv_kf) 
   LOOP
      bc.go(k.kf);
      delete from fin_rnk_okpo;
      commit;
   end LOOP;
   bc.go('/');
end;
/