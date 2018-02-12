create or replace trigger tiu_zp_upd
   after insert or update
   on bars.zp_deals
   for each row
declare
   l_idupd       zp_deals_update.idupd%type;
   l_doneby      zp_deals_update.upd_user_fio%type;
   l_doneby_id   zp_deals_update.upd_user_id%type;
begin
   l_idupd := bars_sqnc.get_nextval ('s_zp_deals_update');
   l_doneby_id := user_id;

   begin
      select fio
        into l_doneby
        from staff$base
       where id = user_id;
   exception
      when no_data_found
      then
         l_doneby := user_name;
   end;


   insert into zp_deals_update (idupd,
                                id,
                                deal_id,
                                start_date,
                                close_date,
                                deal_name,
                                rnk,
                                sos,
                                deal_premium,
                                central,
                                kod_tarif,
                                acc_2909,
                                acc_3570,
                                branch,
                                kf,
                                user_id,
                                comm_reject,
                                crt_date,
                                upd_date,
                                fs,
                                upd_user_id,
                                upd_user_fio)
        values (l_idupd,
                :new.id,
                :new.deal_id,
                :new.start_date,
                :new.close_date,
                :new.deal_name,
                :new.rnk,
                :new.sos,
                :new.deal_premium,
                :new.central,
                :new.kod_tarif,
                :new.acc_2909,
                :new.acc_3570,
                :new.branch,
                :new.kf,
                :new.user_id,
                :new.comm_reject,
                :new.crt_date,
                :new.upd_date,
                :new.fs,
                l_doneby_id,
                l_doneby);
end tiu_zp_upd;
/