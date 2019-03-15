CREATE OR REPLACE VIEW V_ZAY21 AS
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
      ,v.ostc0 / 100 ostc0
      ,v.okpo0
      ,v.acc1
      ,v.nls
      ,v.kom
      ,v.skom
      ,v.mfop
      ,v.nlsp
      ,v.okpop
      ,v.dig
      ,trim(to_char(v.meta, '09') || ' ' || v.aim_name) meta_aim_name
      ,v.contract
      ,v.dat2_vmd
      ,v.dat_vmd
      ,v.dat5_vmd
      ,trim(c.country || ' ' || c.name) country_name
      ,trim(substr(v.basis || ' ' || k7.txt, 1, 100)) basis_txt
      ,bc.name
      ,v.bank_code
      ,v.bank_name
      ,trim(to_char(v.product_group, '09') || ' ' || v.product_group_name) product_group_name
      ,v.num_vmd
      ,v.viza
      ,v.priority
      ,v.priorname
      ,v.comm
      ,bars_zay.get_request_cover(v.id) cover_id
      ,v.verify_opt
      ,v.identkb
      ,v.kv_conv
      ,v.req_type
      ,v.code_2c
      ,v.p12_2c
      ,v.ATTACHMENTS_COUNT
      ,v.FNAMEKB
      ,v.f092 F092_Code
      ,v.f092 || ' ' || (select z.txt
                         from   f092 z
                         where  v.f092 = z.f092) F092_Text
FROM   bars.v_zay_queue v
      ,bars.country     c
      ,bars.country     bc
      ,bars.v_kod_70_2  k7
WHERE  v.sos = 0
       and v.viza <= 0
       AND v.country = c.country(+)
       AND v.benefcountry = bc.country(+)
       AND v.basis = k7.p63(+)
       and mfo = f_ourmfo
       AND fdat >=(sysdate - 30)
ORDER  BY v.fdat desc, v.id desc;

grant SELECT                                                          on V_ZAY21      to BARS_ACCESS_DEFROLE;
