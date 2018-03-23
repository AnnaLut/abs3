

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_SALFORM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_SALFORM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_SALFORM ("ID", "SOS", "SVIZA", "CUST_BRANCH", "RNK",
 "NMK", "ACC0", "ACC1", "NLS", "OSTC", "S2", "DIG", "S2S", "MFO0", "NLS0", "KV_CONV", "LCV_CONV",
 "NLS_ACC0", "FDAT", "ND", "KOM", "SKOM", "KURS_Z", "KURS_F", "VDATE", "META", "AIM_NAME", 
 "CONTRACT", "DATC", "NUM_VMD", "VMD1", "BASIS", "DATZ", "COMM", "CONTACT_FIO", "CONTACT_TEL",
 "COVERED", "KB", "KV", "DOC_DESC", "DATT","OBZ","F092") AS 
  select v.id,
          v.sos,
          decode(v.viza,-1, '-1-Відмовлено у візі',0,'0-Чекає на візу',2,'2-Підтверджено як пріоритетну','1-Завізовано') sviza,
          v.cust_branch,
          v.rnk,
          v.nmk,
          v.acc0,
          v.acc1,
          v.nls,
          v.ostc/power(10,v.dig) ostc,
          v.s2,
          v.dig,
          v.s2s,
          v.mfo0,
          v.nls0,
          v.kv_conv,
          v.lcv_conv,
          v.nls_acc0,
          v.fdat,
          v.nd,
          v.kom,
          v.skom,
          v.kurs_z,
          v.kurs_f,
          v.vdate,
          v.meta,
          to_char(v.meta,'09')||' '||v.aim_name aim_name,
          v.contract,
          v.dat2_vmd datc,
          v.num_vmd,
          v.dat_vmd vmd1,
          substr(v.basis,1,254) basis,
          nvl(v.datz,v.vdate) datz,
          v.comm,
          v.contact_fio,
          v.contact_tel,
          bars_zay.get_request_cover(v.id) covered,
          decode(nvl(v.identkb,0),0,0,1) kb,
          v.kv2 kv,
          nvl(zc.doc_desc,null) doc_desc,
          v.datt,
          v.obz,
          v.f092
          from v_zay_queue v , country c, country cc, zay_corpdocs zc
          where v.dk  in (2,4)
          and 2>v.sos
          and v.branch like sys_context('bars_context','user_branch')||'%'
          and v.country = c.country(+)
          and v. benefcountry = cc.country(+)
          and v.id = zc.id(+)
          order by id desc;

PROMPT *** Create  grants  V_ZAY_SALFORM ***
grant SELECT                                                                 on V_ZAY_SALFORM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_SALFORM   to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_SALFORM.sql =========*** End *** 
PROMPT ===================================================================================== 
