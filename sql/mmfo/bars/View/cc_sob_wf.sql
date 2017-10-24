

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_SOB_WF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_SOB_WF ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_SOB_WF ("PRZ", "ND", "CC_ID", "SDATE", "RNK", "SOS", "FDAT", "ID", "ISP", "TXT", "OTM", "FREQ", "PSYS", "FACT_DATE") AS 
  SELECT "PRZ"
       ,"ND"
       ,"CC_ID"
       ,"SDATE"
       ,"RNK"
       ,"SOS"
       ,"FDAT"
       ,"ID"
       ,"ISP"
       ,"TXT"
       ,"OTM"
       ,"FREQ"
       ,"PSYS"
       ,"FACT_DATE"
  FROM (SELECT 1 prz
              ,d.nd
              ,d.cc_id
              ,d.sdate
              ,d.rnk
              ,d.sos
              ,q.fdat
              ,q.id
              ,q.isp
              ,q.txt
              ,q.otm
              ,q.freq
              ,q.psys
              ,q.fact_date
          FROM cc_sob q, cc_deal d, v_sfdat v
         WHERE d.nd = q.nd
           AND d.vidd IN (11, 12, 13)
           AND q.fdat >= v.b
           AND q.fdat <= v.e
        UNION ALL
        SELECT 2
              ,d.nd
              ,d.cc_id
              ,d.sdate
              ,d.rnk
              ,d.sos
              ,o.fdat
              ,o.ref
              ,p.userid
              ,substr(decode(o.dk, 1, 'Крд.', 'Деб.') || a.nls || '/' || a.kv || '=' ||
                      o.s / 100 || ' ' || p.nazn
                     ,1
                     ,250) txt
              ,NULL
              ,NULL
              ,NULL
              ,NULL
          FROM opldok o
              ,oper p
              ,(SELECT ss.fdat, ss.acc
                  FROM saldoa ss, v_sfdat v
                 WHERE ss.fdat >= v.b
                   AND ss.fdat <= v.e) s
              ,nd_acc n
              ,cc_deal d
              ,accounts a
         WHERE o.fdat = s.fdat
           AND s.acc = a.acc
           AND o.sos = 5
           AND o.ref = p.ref
           AND o.acc = a.acc
           AND (a.tip IN ('SS ', 'SL ', 'SP ', 'SPN') OR
               o.dk = 1 AND a.tip = 'SN ')
           AND a.acc = n.acc
           AND n.nd = d.nd
           AND d.vidd IN (11, 12, 13)
        UNION ALL
        SELECT 3
              ,d.nd
              ,d.cc_id
              ,d.sdate
              ,d.rnk
              ,d.sos
              ,r.bdat
              ,r.id
              ,r.idu
              ,'% ст.' || a.nls || '/' || a.kv || '=' || r.ir txt
              ,NULL
              ,NULL
              ,NULL
              ,NULL
          FROM (SELECT rr.*
                  FROM int_ratn rr, v_sfdat v
                 WHERE rr.bdat >= v.b
                   AND rr.bdat <= v.e) r
              ,nd_acc n
              ,accounts a
              ,cc_deal d
         WHERE r.bdat >= a.daos
           AND r.id = 0
           AND r.acc = a.acc
           AND a.tip IN ('SS ', 'SL ', 'SP ')
           AND a.acc = n.acc
           AND n.nd = d.nd
           AND d.vidd IN (11, 12, 13)
        UNION ALL
        SELECT 4
              ,d.nd
              ,d.cc_id
              ,d.sdate
              ,d.rnk
              ,d.sos
              ,d.chgdate
              ,d.idupd
              ,d.doneby
              ,'fin=' || d.fin23 || ', obs=' || d.obs23 || ', d.kat=' ||
               kat23 txt
              ,NULL
              ,NULL
              ,NULL
              ,NULL
          FROM cc_deal_update d, v_sfdat v
         WHERE d.vidd IN (11, 12, 13)
           AND chgdate between  v.b
           and v.e) x;

PROMPT *** Create  grants  CC_SOB_WF ***
grant SELECT                                                                 on CC_SOB_WF       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_SOB_WF.sql =========*** End *** ====
PROMPT ===================================================================================== 
