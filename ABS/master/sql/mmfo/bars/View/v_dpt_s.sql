

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_S.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_S ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_S ("ID", "ND", "KV", "BRANCH", "ACC", "NLS", "RNK", "NMK", "OST", "OSTQ", "SN", "SNQ", "VIDD", "NAM", "PR", "DATN", "DATK", "PROL", "ISP", "REAL_EXPIRE", "DOS", "KOS", "FDAT", "IDUPD", "KT", "PASP", "PASPDAT", "PASPORG", "DOCTYP", "UNDO_EXT") AS 
  SELECT dc.deposit_id,
            dc.nd,
            dc.kv,
            b.branch,
            dc.acc,
            (SELECT nls
               FROM accounts
              WHERE acc = dc.acc)
               AS nls,
            dc.rnk,
            (SELECT nmk
               FROM customer
              WHERE rnk = dc.rnk)
               AS nmk,
            fost (dc.acc, f.CDAT) ostd,
            fostq (dc.acc, f.CDAT) ostdQ,
            DECODE (dc.acc,
                    (SELECT acra
                       FROM int_accn
                      WHERE acc = dc.acc AND id = 1), 0,
                    fost ( (SELECT acra
                              FROM int_accn
                             WHERE acc = dc.acc AND id = 1),
                          f.CDAT))
               ostp,
            DECODE (dc.acc,
                    (SELECT acra
                       FROM int_accn
                      WHERE acc = dc.acc AND id = 1), 0,
                    fostq ( (SELECT acra
                               FROM int_accn
                              WHERE acc = dc.acc AND id = 1),
                           f.CDAT))
               ostpQ,
            dc.vidd,
            (SELECT type_name
               FROM dpt_vidd
              WHERE vidd = dc.vidd)
               AS vidd_name,
            acrn.fproc (dc.acc, f.CDAT) AS ir,
            dc.dat_begin,
            dc.dat_end,
            dc.CNT_DUBL,
            dc.userid,
            (SELECT dazs
               FROM accounts
              WHERE acc = dc.acc)
               AS DAZS,
            fdos (acc, DAT_BEGIN, f.CDAT) dos,
            GREATEST (fkos (dc.acc, DAT_BEGIN, f.CDAT) - dc.LIMIT, 0) kos,
            f.CDAT,
            dc.IDUPD,
            1,
            ser || ' ' || numdoc,
            pdate,
            organ,
            (SELECT name
               FROM passp
              WHERE passp = p.passp),
            (select da.BANKDATE
               from dpt_agreements da
              where da.DPT_ID = dc.deposit_id
                and da.AGRMNT_TYPE = 17 /* відмова від авто-пролонгації*/
                and da.AGRMNT_STATE = 1) as UNDO_EXT
       FROM dpt_deposit_clos dc,
            dpt_deposit_all b,
            person p,
            (SELECT NVL (
                       TO_DATE (pul.Get_Mas_Ini_Val ('dpt_dat'), 'dd.mm.yyyy'),
                       bankdate)
                       CDAT
               FROM DUAL) f
      WHERE     (dc.idupd, dc.deposit_ID) IN (  SELECT MAX (idupd) idupd,
                                                       deposit_ID
                                                  FROM dpt_deposit_clos
                                                 WHERE bdate <= f.CDAT
                                              GROUP BY deposit_ID)
            AND dc.action_id NOT IN (1, 2)
            AND dc.deposit_id = b.deposit_id
            AND b.branch LIKE
                      DECODE (pul.Get_Mas_Ini_Val ('dpt_branch'),
                              '-', '/' || f_ourmfo_g || '/',
                              pul.Get_Mas_Ini_Val ('dpt_branch'))
                   || '%'
            AND dc.rnk = p.rnk
   ORDER BY deposit_id;

PROMPT *** Create  grants  V_DPT_S ***
grant SELECT                                                                 on V_DPT_S         to ABS_ADMIN;
grant SELECT                                                                 on V_DPT_S         to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_S         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_S         to DPT;
grant SELECT                                                                 on V_DPT_S         to START1;
grant SELECT                                                                 on V_DPT_S         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_S.sql =========*** End *** ======
PROMPT ===================================================================================== 
