-------------------------
--видадяємо застарілі трансфери біржових заявок  COBUMMFO-9563
-------------------------

begin
 for rec in (select * from mv_kf)
    loop
      bc.go(rec.kf);
      delete from zay_data_transfer 
      where transfer_result=0 and TRANSFER_DATE < to_date('01.09.2018','dd.mm.yyyy') and kf=rec.kf ;
      logger.info ('bars_zay.delete old transfer.'||rec.kf);
      bc.home;
    end loop;   
end ;
/
commit;
/
