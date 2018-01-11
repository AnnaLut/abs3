

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STODEALDETAILS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STODEALDETAILS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STODEALDETAILS ("DEAL_ID", "DEAL_NUM", "DEAL_DAT", "GROUP_ID", "CUST_ID", "CUST_NAME", "CUST_CODE", "RECID", "ORD", "DATBEG", "DATEND", "FREQ", "DAT0", "WEND", "DK", "TT", "VOB", "FSUM", "NAZN", "TOBO", "MFOA", "NLSA", "ACC", "RNK", "KVA", "NAMA", "MFOB", "NLSB", "KVB", "NAMB", "IDB", "DR") AS 
  SELECT s.deal_id,
          s.deal_num,
          s.deal_dat,
          s.GROUP_ID,
          s.cust_id,
          s.cust_name,
          s.cust_code,
          d.idd,
          d.ord,
          d.dat1,
          d.dat2,
          d.freq,
          d.dat0,
          d.wend,
          d.dk,
          d.tt,
          d.vob,
          d.fsum,
          d.nazn,
          a.tobo,
          SUBSTR (f_ourmfo, 1, 6),
          a.nls,
          a.acc,
          a.rnk,
          a.kv,
          a.nms,
          d.mfob,
          d.nlsb,
          d.kvb,
          d.polu,
          d.okpo,
          d.DR
     FROM v_stodeals s, sto_det d, accounts a
    WHERE     s.deal_id = d.ids
          AND d.nlsa = a.nls
          AND d.kva = a.kv
          AND D.STATUS_ID = 1;

PROMPT *** Create  grants  V_STODEALDETAILS ***
grant SELECT                                                                 on V_STODEALDETAILS to BARSREADER_ROLE;
grant SELECT                                                                 on V_STODEALDETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STODEALDETAILS to STO;
grant SELECT                                                                 on V_STODEALDETAILS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_STODEALDETAILS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STODEALDETAILS.sql =========*** End *
PROMPT ===================================================================================== 
