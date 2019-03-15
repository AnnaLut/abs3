CREATE OR REPLACE VIEW V_ZAY22 AS
SELECT v.kv2
      ,v.dk
      ,v.id
      ,v.fdat
      ,v.rnk
      ,v.nmk
      ,v.cust_branch
      ,v.s2
      ,v.kurs_z
      ,v.acc0
      ,v.nls_acc0
      ,v.mfo0
      ,v.okpo0
      ,v.acc1
      ,v.nls
      ,v.ostc
      ,v.dig
      ,v.kom
      ,v.skom
      ,to_char(v.meta, '09') || ' ' || v.aim_name meta_aim_name
      ,v.viza
      ,v.priority
      ,v.priorname
      ,v.comm
      ,bars_zay.get_request_cover(v.id) cover_id
      ,v.verify_opt
      ,v.obz
      ,v.aims_code
      ,null txt
      ,v.kv_conv
      ,v.req_type
      ,v.ATTACHMENTS_COUNT
      ,v.FNAMEKB
      ,v.f092 F092_Code
      ,v.f092 || ' ' || (select z.txt
                         from   f092 z
                         where  v.f092 = z.f092) F092_Text
      ,v.mfo
FROM   v_zay_queue v
WHERE  v.sos = 0
       AND v.viza <= 0
       and v.mfo = f_ourmfo
       AND fdat >=(sysdate - 30)
ORDER  BY v.fdat desc, v.id desc;

grant SELECT                                                          on V_ZAY22      to BARS_ACCESS_DEFROLE;