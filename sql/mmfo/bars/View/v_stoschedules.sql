

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STOSCHEDULES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STOSCHEDULES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STOSCHEDULES ("DEAL_ID", "DEAL_NUM", "DEAL_DAT", "GROUP_ID", "CUST_ID", "CUST_NAME", "CUST_CODE", "RECID", "ORD", "DATBEG", "DATEND", "FREQ", "DAT0", "WEND", "DK", "TT", "VOB", "FSUM", "NAZN", "TOBO", "MFOA", "NLSA", "KVA", "NAMA", "MFOB", "NLSB", "KVB", "NAMB", "IDB", "DR", "PAYDAT", "REF") AS 
  SELECT s.deal_id,
          s.deal_num,
          s.deal_dat,
          s.GROUP_ID,
          s.cust_id,
          case when substr(s.nlsa,0,4) in (select nbs from NBS_PRINT_BANK) and (s.mfoa <> s.mfob or (s.tt='445' and s.dk = 1))
               then GetGlobalOption('NAME')
               else s.cust_name
          end as cust_name,
          case when substr(s.nlsa,0,4) in (select nbs from NBS_PRINT_BANK) and (s.mfoa <> s.mfob or (s.tt='445' and s.dk = 1))
               then (select val from params$base where par = 'OKPO')
               else s.cust_code
          end as cust_code,
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
          s.fsum,
          s.nazn,
          s.tobo,
          s.mfoa,
          s.nlsa,
          s.kva,
          case when substr(s.nlsa,0,4) in (select nbs from NBS_PRINT_BANK) and s.tt='445'
               then GetGlobalOption('NAME')
               else s.nama
          end as nama,
          s.mfob,
          s.nlsb,
          s.kvb,
          s.namb,
          s.idb,
          s.DR,
          t.dat,
          t.REF
     FROM v_stodealdetails s, sto_dat t
    WHERE s.recid = t.idd;

PROMPT *** Create  grants  V_STOSCHEDULES ***
grant SELECT                                                                 on V_STOSCHEDULES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STOSCHEDULES  to STO;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_STOSCHEDULES  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STOSCHEDULES.sql =========*** End ***
PROMPT ===================================================================================== 
