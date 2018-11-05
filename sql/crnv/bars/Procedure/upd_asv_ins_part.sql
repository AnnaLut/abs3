CREATE OR REPLACE procedure BARS.upd_asv_ins_part(p_key_  part_pay_immobile.key%type,
                                                  p_key2_ part_pay_immobile.key%type, 
                                                  p_nls_  part_pay_immobile.nls%type  ,
                                                  p_sum_  part_pay_immobile.sum%type,
                                                  p_mfob_ part_pay_immobile.mfob%type ,
                                                 p_okpob_ part_pay_immobile.okpob%type ,
                                                 p_fio_   part_pay_immobile.fio%type,
                                                 p_type_  part_pay_immobile.owner_type%type,
                                                p_PASP_N_ part_pay_immobile.PASP_N%type,
                                                p_PASP_S_ part_pay_immobile.PASP_S%type,
                                               p_COMMENTS part_pay_immobile.COMMENTS%type)
is
 begin                 
      
                            begin
                             bars_audit.info ('key2_ = '||p_key2_);
                              update asvo_immobile 
                                set fl=10
                                where key=p_key_;
                              insert into part_pay_immobile(key, pdat, nls, sum, userid, status, mfob, okpob, fio, owner_type, PASP_N, PASP_S, COMMENTS) 
                                values(p_key2_, sysdate, p_nls_, to_number(p_sum_)*100, user_id, 0, p_mfob_, p_okpob_, p_fio_, p_type_, p_PASP_N_, p_PASP_S_, substr(p_COMMENTS,1,160));
                             end;
                             
     
     
 end  upd_asv_ins_part;
/