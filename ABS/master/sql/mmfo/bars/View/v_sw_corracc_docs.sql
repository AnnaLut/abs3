

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_CORRACC_DOCS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_CORRACC_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_CORRACC_DOCS ("DOC_TYPE", "REF", "TT", "VOB", "ND", "VDAT", "DK", "MFOA", "NLSA", "NAM_A", "ID_A", "MFOB", "NLSB", "NAM_B", "ID_B", "NAZN", "D_REC", "KV", "KV2", "S", "TRN_AMOUNT", "SOS", "NEXTVISAGRP", "LCV_D", "DIG_D", "LCV_C", "DIG_C", "BANK_BIC", "BANK_NAME", "EXIST_BANK_KEY", "CAN_USE_COVER") AS 
  select 'PLAN' doc_type, o.ref, o.tt, o.vob, o.nd, o.vdat, o.dk,
       o.mfoa, o.nlsa, o.nam_a, o.id_a,
       o.mfob, o.nlsb, o.nam_b, o.id_b,
       o.nazn, o.d_rec, o.kv, o.kv2,
       decode(o.kv2, o.kv, o.s/100, o.s2/100) s,
       (select sum(decode(dk, 1, 1, -1) *s)/100
          from opl
         where ref = o.ref
           and kv  = o.kv2
           and nls = o.nlsb) trn_amount,
       o.sos, o.nextvisagrp, td.lcv lcv_d, td.dig dig_d, tc.lcv lcv_c, tc.dig dig_c,
       (select rpad(decode(substr(value, 1, 1), '/', substr(value, instr(value, chr(10))+1), value), 11, 'X')
          from operw w
         where w.ref = o.ref
          and  w.tag like '57A  ') bank_bic,
       (select b.name
          from operw w, sw_banks b
         where w.ref = o.ref
           and w.tag like '57A  '
           and rpad(decode(substr(w.value, 1, 1), '/', substr(w.value, instr(value, chr(10))+1), w.value), 11, 'X') = b.bic) bank_name,
       (select 'Y'
          from operw w, sw_bank_key k
         where w.ref = o.ref
           and exists (select 1 from operw w2
                        where w2.ref = w.ref
                          and w2.tag = rpad('f', 5, ' ')
                          and substr(w2.value, 4, 3) = '103')
          and w.tag like '57A  '
          and k.bic = rpad(decode(substr(value, 1, 1), '/', substr(value, instr(value, chr(10))+1), value), 11, 'X')) exist_bank_key,
       (select 'Y'
          from operw w
         where w.ref = o.ref
           and w.tag = rpad('f', 5, ' ')
           and substr(w.value, 4, 3) = '103') can_use_cover
  from sw_nostro_que q, oper o, tabval td, tabval tc
 where q.ref = o.ref
   and o.sos > 0
   and o.sos < 5
   and exists (select 1
                 from operw w
                where w.ref   = o.ref
                  and w.tag   = 'NOS_A'
                  and w.value = '0'    )
   and o.kv  = td.kv
   and o.kv2 = tc.kv
union all
select 'FACT' doc_type, o.ref, o.tt, o.vob, o.nd, o.vdat, o.dk,
       o.mfoa, o.nlsa, o.nam_a, o.id_a,
       o.mfob, o.nlsb, o.nam_b, o.id_b,
       o.nazn, o.d_rec, o.kv, o.kv2,
       decode(o.kv2, o.kv, o.s/100, o.s2/100) s,
       (select sum(decode(dk, 1, 1, -1) *s)/100
          from opl
         where ref = o.ref
           and kv  = o.kv2
           and nls = o.nlsb) trn_amount,
       o.sos, o.nextvisagrp, td.lcv lcv_d, td.dig dig_d, tc.lcv lcv_c, tc.dig dig_c,
       (select rpad(decode(substr(value, 1, 1), '/', substr(value, instr(value, chr(10))+1), value), 11, 'X')
          from operw w
         where w.ref = o.ref
          and  w.tag like '57A  ') bank_bic,
       (select b.name
          from operw w, sw_banks b
         where w.ref = o.ref
           and w.tag like '57A  '
           and rpad(decode(substr(w.value, 1, 1), '/', substr(w.value, instr(value, chr(10))+1), w.value), 11, 'X') = b.bic) bank_name,
       (select 'Y'
          from operw w, sw_bank_key k
         where w.ref = o.ref
           and exists (select 1 from operw w2
                        where w2.ref = w.ref
                          and w2.tag = rpad('f', 5, ' ')
                          and substr(w2.value, 4, 3) = '103')
          and w.tag like '57A  '
          and k.bic = rpad(decode(substr(value, 1, 1), '/', substr(value, instr(value, chr(10))+1), value), 11, 'X')) exist_bank_key,
       (select 'Y'
          from operw w
         where w.ref = o.ref
           and w.tag = rpad('f', 5, ' ')
           and substr(w.value, 4, 3) = '103') can_use_cover
  from sw_nostro_que q, oper o, tabval td, tabval tc
 where q.ref = o.ref
   and o.sos = 5
   and exists (select 1
                 from operw w
                where w.ref   = o.ref
                  and w.tag   = 'NOS_A'
                  and w.value = '0'    )
   and o.kv  = td.kv
   and o.kv2 = tc.kv
 ;

PROMPT *** Create  grants  V_SW_CORRACC_DOCS ***
grant SELECT                                                                 on V_SW_CORRACC_DOCS to BARS013;
grant SELECT                                                                 on V_SW_CORRACC_DOCS to BARSREADER_ROLE;
grant SELECT                                                                 on V_SW_CORRACC_DOCS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_CORRACC_DOCS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_CORRACC_DOCS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_CORRACC_DOCS.sql =========*** End 
PROMPT ===================================================================================== 
