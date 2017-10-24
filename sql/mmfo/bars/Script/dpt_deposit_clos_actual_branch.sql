prompt Актуализируем поле branch в dpt_deposit_clos для последней записи
begin 
  for rec in (select * from mv_kf) 
    loop 
      bc.go(rec.kf);
      insert into dpt_deposit_clos
      (idupd, deposit_id, nd, vidd, acc, kv, rnk,
       freq, datz, dat_begin, dat_end, dat_end_alt,
       mfo_p, nls_p, name_p, okpo_p,
       dpt_d, acc_d, mfo_d, nls_d, nms_d, okpo_d,
       limit, deposit_cod, comments,
       action_id, actiion_author, "WHEN", bdate, stop_id,
       cnt_dubl, cnt_ext_int, dat_ext_int, userid, archdoc_id, forbid_extension, branch, kf)
      select bars_sqnc.get_nextval('s_dpt_deposit_clos'), d.deposit_id, d.nd, d.vidd, d.acc, d.kv, d.rnk,
         d.freq, d.datz, d.dat_begin, d.dat_end, d.dat_end_alt,
         d.mfo_p, d.nls_p, d.name_p, d.okpo_p,
         d.dpt_d, d.acc_d, d.mfo_d, d.nls_d, d.nms_d, d.okpo_d,
         d.limit, d.deposit_cod, d.comments,
         4, 1, sysdate, gl.bd, d.stop_id,
         d.cnt_dubl, d.cnt_ext_int, d.dat_ext_int, d.userid, d.archdoc_id, d.forbid_extension, d.branch, d.kf
      from dpt_deposit d, 
      (SELECT deposit_id, branch
                   FROM (SELECT cw.*,
                                ROW_NUMBER ()
                                   OVER (PARTITION BY deposit_id ORDER BY idupd DESC)
                                   rn
                           FROM dpt_deposit_clos cw)
                  WHERE rn = 1) DC
      where d.branch != dc.branch
      and d.deposit_id = dc.deposit_id
    ; 
    end loop;
end;
/
commit;
/