

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STOSCHEDULES_WEB.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STOSCHEDULES_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STOSCHEDULES_WEB ("RUN", "DEAL_ID", "DEAL_NUM", "DEAL_DAT", "GROUP_ID", "CUST_ID", "CUST_NAME", "CUST_CODE", "RECID", "ORD", "DATBEG", "DATEND", "FREQ", "DAT0", "WEND", "DK", "TT", "VOB", "FSUM", "NAZN", "TOBO", "MFOA", "NLSA", "KVA", "NAMA", "MFOB", "NLSB", "KVB", "NAMB", "IDB", "DR", "PAYDAT", "REF") AS 
  SELECT 0 as run,
          s.deal_id,
          s.deal_num,
          s.deal_dat,
          s.GROUP_ID,
          s.cust_id,
          s.cust_name,
          s.cust_code,
          s.recid,
          s.ord,
          s.datbeg,
          s.datend,
          s.freq,
          s.dat0,
          s.wend,
          s.dk,
          s.tt,
          s.vob,
          sto_all.fsumFunction(fSum =>s.fsum, KVA  =>  s.kva, KVB => s.kvb, NLSA => s.nlsa, NLSB => s.nlsb, tt => s.tt) fsum,
          s.nazn,
          s.tobo,
          s.mfoa,
          s.nlsa,
          s.kva,
          s.nama,
          s.mfob,
          s.nlsb,
          s.kvb,
          s.namb,
          s.idb,
          s.DR,
          t.dat,
          t.REF
     FROM v_stodealdetails s, sto_dat t
    WHERE s.recid = t.idd
      and t.ref is null
      and t.dat <= sysdate 
      --and nvl(dat0, s.datbeg - 1) <= sysdate;

PROMPT *** Create  grants  V_STOSCHEDULES_WEB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_STOSCHEDULES_WEB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STOSCHEDULES_WEB to STO;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STOSCHEDULES_WEB.sql =========*** End
PROMPT ===================================================================================== 
