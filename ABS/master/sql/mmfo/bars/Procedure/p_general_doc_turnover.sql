

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_GENERAL_DOC_TURNOVER.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_GENERAL_DOC_TURNOVER ***

  CREATE OR REPLACE PROCEDURE BARS.P_GENERAL_DOC_TURNOVER ( FDat_ VARCHAR2, UserID_ VARCHAR2 ) IS
  UserFIO           VARCHAR2(60);
  kas_kol           NUMBER;
  kas_uah_summa     NUMBER;
  CheckDate         DATE;
  Kol_Prov          NUMBER;
  Kol_Doc           NUMBER;
  Sum_Eqv           NUMBER;
  OtdelNo           NUMBER;
  Auto_Kol          NUMBER;
  Auto_Summa        NUMBER;
  Folder_Kol        NUMBER;
  Folder_Summa      NUMBER;
BEGIN

  ---------------------------------------------------------
  DELETE FROM tmp_general_doc_turnover WHERE userid=UserID_;
  ---------------------------------------------------------
  SELECT fio INTO UserFIO FROM staff  WHERE id=UserID_;
  ---------------------------------------------------------
  CheckDate := TO_DATE(FDat_,'DD/MM/YYYY');
  ---------------------------------------------------------

  -- выберем общее количество документов, проводок, сумму гривневого эквивалента --
  SELECT sum(KOL_PR) KOL_PROV, sum(KOLDOC) KOL_DOC, sum(SQ) SUM_EQV
    INTO Kol_Prov, Kol_Doc, Sum_Eqv
    FROM ( SELECT sum(KOLPROV) KOL_PR, sum(S) S, sum(SQ) SQ, sum(KOLD) KOLDOC
             FROM ( SELECT k.kolprov, k.s_nom S, k.s_eqv SQ, 0 KOLD
                      FROM (   SELECT o2.fdat, o1.userid, a.kv, o2.tt, count(*) kolprov, sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv
                                 FROM oper o1, opl o2, accounts a
                                WHERE o2.fdat = CheckDate
                                  AND o2.fdat = decode(o1.nlsa, '29242000', o2.fdat,
                                                                decode(o1.nlsa,'2924311',o2.fdat,
                                                                decode(o1.nlsb,'2924311',o2.fdat,
                                                                decode(o1.nlsa,'292490411',o2.fdat,
                                                                decode(o1.nlsb,'292490411',o2.fdat,
                                                                decode(o1.nlsa,'292460412',o2.fdat,
                                                                decode(o1.nlsb,'292460412',o2.fdat,
                                                                decode(o1.nlsa,'292421312',o2.fdat,
                                                                decode(o1.nlsa,'29240100000001',o2.fdat,
                                                                decode(o1.tt,'PKF',trim(o1.vdat),
                                                                decode(o1.tt,'PKK',trim(o1.vdat),
                                                                decode(o1.tt,'PKR',trim(o1.vdat),
                                                                decode(o1.tt,'PKQ',trim(o1.vdat),
                                                                decode(o1.tt,'PKY',trim(o1.vdat),
                                                                o2.fdat))))))))))))))
                                  AND o1.sos  = 5
                                  AND o1.ref  = o2.ref
                                  AND o1.tt   = o2.tt
                                  AND o1.tt NOT IN ('PVP','PO1','PO3')
                                  AND o1.kv   = o2.kv
                                  AND o1.dk   = o2.dk
                                  AND o2.acc  = a.acc
                                  AND o2.acc NOT IN (select acc from accounts where nls like '8%')
                                  AND o1.userid = UserID_
                             GROUP BY o2.fdat, o1.userid, a.kv, o2.tt
                            UNION ALL -------------------------------------------
                               SELECT o2.fdat, o1.userid, a.kv, o2.tt, count(*) kolprov, sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv
                                 FROM oper o1, opl o2, accounts a
                                WHERE o2.fdat = CheckDate
                                  AND o1.sos = 5
                                  AND o1.ref = o2.ref
                                  AND o1.tt  = o2.tt
                                  AND o1.kv  <> o2.kv
                                  AND o1.dk  = o2.dk
                                  AND o2.acc = a.acc
                                  AND o1.userid = UserID_
                             GROUP BY o2.fdat, o1.userid, a.kv, o2.tt
                            UNION ALL -------------------------------------------
                               SELECT o2.fdat, o1.userid, a.kv, o2.tt, count(*) kolprov, sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv
                                 FROM oper o1, opl o2, accounts a
                                WHERE o2.fdat = CheckDate
                                  AND o1.sos = 5
                                  AND o1.ref = o2.ref
                                  AND o1.tt  <> o2.tt
                                  AND o2.tt not in ('PO3')
                                  AND o1.kv  = o2.kv
                                  AND o1.dk  = o2.dk
                                  AND o2.acc = a.acc
                                  AND o1.userid = UserID_
                             GROUP BY o2.fdat, o1.userid, a.kv, o2.tt
                            UNION ALL -------------------------------------------
                               SELECT o2.fdat, o1.userid, a.kv, o2.tt, count(*) kolprov, sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv
                                 FROM oper o1, opl o2, accounts a
                                WHERE o2.fdat = CheckDate
                                  AND o1.sos = 5
                                  AND o1.ref = o2.ref
                                  AND o1.tt  <> o2.tt
                                  AND o1.kv  <> o2.kv
                                  AND o2.tt not in ('PO3')
                                  AND o1.dk  = o2.dk
                                  AND o2.acc = a.acc
                                  AND o1.userid = UserID_
                             GROUP BY o2.fdat, o1.userid, a.kv, o2.tt
                            UNION ALL -------------------------------------------
                               SELECT o2.fdat, decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk, 3,4)),
                                                             'ISG', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CR9', hex_to_num(substr(o1.chk, 3,4)),
                                                             'ZAL', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CI1', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CI2', hex_to_num(substr(o1.chk, 3,4)),
                                                             'OVR', hex_to_num(substr(o1.chk, 3,4)),
                                                             'IME', hex_to_num(substr(o1.chk,21,4)),
                                                             'IMI', hex_to_num(substr(o1.chk,21,4)),
                                                             'KLO', hex_to_num(substr(o1.chk,21,4)),
                                                             'KL7', hex_to_num(substr(o1.chk,21,4)),
                                                             'KL8', hex_to_num(substr(o1.chk,21,4)) ) userid,
                                      a.kv, o2.tt, count(*) kolprov,
                                      sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv
                                 FROM oper o1, opl o2, accounts a
                                WHERE o2.fdat= CheckDate
                                  AND o2.sos = 5
                                  AND o1.ref = o2.ref
                                  AND o1.dk  = o2.dk
                                  AND (select 1 from otd_user where userid=UserID_ and otd=5) = 1
                                  AND UserID_ = decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk, 3,4)),
                                                              'ISG', hex_to_num(substr(o1.chk, 3,4)),
                                                              'CR9', hex_to_num(substr(o1.chk, 3,4)),
                                                              'ZAL', hex_to_num(substr(o1.chk, 3,4)),
                                                              'CI1', hex_to_num(substr(o1.chk, 3,4)),
                                                              'CI2', hex_to_num(substr(o1.chk, 3,4)),
                                                              'OVR', hex_to_num(substr(o1.chk, 3,4)),
                                                              'IME', hex_to_num(substr(o1.chk,21,4)),
                                                              'IMI', hex_to_num(substr(o1.chk,21,4)),
                                                              'KLO', hex_to_num(substr(o1.chk,21,4)),
                                                              'KL7', hex_to_num(substr(o1.chk,21,4)),
                                                              'KL8', hex_to_num(substr(o1.chk,21,4)) )
                                  AND o2.acc = a.acc
                             GROUP BY o2.fdat, decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk, 3,4)),
                                                             'ISG', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CR9', hex_to_num(substr(o1.chk, 3,4)),
                                                             'ZAL', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CI1', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CI2', hex_to_num(substr(o1.chk, 3,4)),
                                                             'OVR', hex_to_num(substr(o1.chk, 3,4)),
                                                             'IME', hex_to_num(substr(o1.chk,21,4)),
                                                             'IMI', hex_to_num(substr(o1.chk,21,4)),
                                                             'KLO', hex_to_num(substr(o1.chk,21,4)),
                                                             'KL7', hex_to_num(substr(o1.chk,21,4)),
                                                             'KL8', hex_to_num(substr(o1.chk,21,4)) ), a.kv, o2.tt
                           ) k
                     WHERE k.userid = UserID_
                   UNION ALL --================================================================================
                    SELECT 0 KOL, 0 S, 0 SQ, v.koldoc
                      FROM (   SELECT o2.fdat, o1.userid, o1.tt, o1.kv, count(*) KOLDOC -- all payed documents
                                 FROM oper o1, opl o2
                                WHERE o1.sos    = 5
                                  AND o2.fdat   = CheckDate
                                  AND o2.fdat = decode(o1.nlsa, '29242000', o2.fdat,
                                                                decode(o1.nlsa,'2924311',o2.fdat,
                                                                decode(o1.nlsb,'2924311',o2.fdat,
                                                                decode(o1.nlsa,'292490411',o2.fdat,
                                                                decode(o1.nlsb,'292490411',o2.fdat,
                                                                decode(o1.nlsa,'292460412',o2.fdat,
                                                                decode(o1.nlsb,'292460412',o2.fdat,
                                                                decode(o1.nlsa,'292421312',o2.fdat,
                                                                decode(o1.nlsa,'29240100000001',o2.fdat,
                                                                decode(o1.tt,'PKF',trim(o1.vdat),
                                                                decode(o1.tt,'PKK',trim(o1.vdat),
                                                                decode(o1.tt,'PKR',trim(o1.vdat),
                                                                decode(o1.tt,'PKQ',trim(o1.vdat),
                                                                decode(o1.tt,'PKY',trim(o1.vdat),
                                                                o2.fdat))))))))))))))
                                  AND o1.ref    = o2.ref
                                  AND o1.dk     = o2.dk
                                  AND o1.kv     = o2.kv
                                  AND o1.tt     = o2.tt
                                  AND o1.s      = o2.s
                                  AND o1.userid = UserID_
                                  AND o2.acc NOT IN (select acc from accounts where nls like '8%')
                                  AND o1.tt not in ('SIF','PVP','PO1','PO3')
                             GROUP BY o2.fdat, o1.userid, o1.tt, o1.kv
                            UNION ALL ------------------------------------------- INFORM KREDIT documents
                               SELECT o1.vdat, o1.userid, o1.tt, o1.kv, count(*) KOLDOC
                                 FROM oper o1
                                WHERE o1.sos    = 5
                                  AND o1.vdat   = CheckDate
                                  AND o1.userid = UserID_
                                  AND o1.tt in ('C12','114')
                             GROUP BY o1.vdat, o1.userid, o1.tt, o1.kv
                            UNION ALL ------------------------------------------- PRIOCOM, WEB-Klient-Bank documents
                               SELECT o2.fdat, decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk, 3,4)),
                                                             'ISG', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CR9', hex_to_num(substr(o1.chk, 3,4)),
                                                             'ZAL', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CI1', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CI2', hex_to_num(substr(o1.chk, 3,4)),
                                                             'OVR', hex_to_num(substr(o1.chk, 3,4)),
                                                             'IME', hex_to_num(substr(o1.chk,21,4)),
                                                             'IMI', hex_to_num(substr(o1.chk,21,4)),
                                                             'KLO', hex_to_num(substr(o1.chk,21,4)),
                                                             'KL7', hex_to_num(substr(o1.chk,21,4)),
                                                             'KL8', hex_to_num(substr(o1.chk,21,4)) ) userid, o1.tt, o1.kv, count(*) KOLDOC
                                 FROM oper o1, opl o2
                                WHERE o2.sos  = 5
                                  AND o2.fdat = CheckDate
                                  AND o1.ref  = o2.ref
                                  AND o1.dk   = o2.dk
                                  AND o1.tt   in ('ZAL','ISG','CR9','PRI','IME','IMI','KLO','KL7','KL8','CI1','CI2','OVR')
                                  AND (select 1 from otd_user where userid=UserID_ and otd=5) = 1
                                  AND UserID_ = decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk, 3,4)),
                                                              'ISG', hex_to_num(substr(o1.chk, 3,4)),
                                                              'CR9', hex_to_num(substr(o1.chk, 3,4)),
                                                              'ZAL', hex_to_num(substr(o1.chk, 3,4)),
                                                              'CI1', hex_to_num(substr(o1.chk, 3,4)),
                                                              'CI2', hex_to_num(substr(o1.chk, 3,4)),
                                                              'OVR', hex_to_num(substr(o1.chk, 3,4)),
                                                              'IME', hex_to_num(substr(o1.chk,21,4)),
                                                              'IMI', hex_to_num(substr(o1.chk,21,4)),
                                                              'KLO', hex_to_num(substr(o1.chk,21,4)),
                                                              'KL7', hex_to_num(substr(o1.chk,21,4)),
                                                              'KL8', hex_to_num(substr(o1.chk,21,4)) )
                             GROUP BY o2.fdat, decode(o1.tt, 'PRI', hex_to_num(substr(o1.chk, 3,4)),
                                                             'ISG', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CR9', hex_to_num(substr(o1.chk, 3,4)),
                                                             'ZAL', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CI1', hex_to_num(substr(o1.chk, 3,4)),
                                                             'CI2', hex_to_num(substr(o1.chk, 3,4)),
                                                             'OVR', hex_to_num(substr(o1.chk, 3,4)),
                                                             'IME', hex_to_num(substr(o1.chk,21,4)),
                                                             'IMI', hex_to_num(substr(o1.chk,21,4)),
                                                             'KLO', hex_to_num(substr(o1.chk,21,4)),
                                                             'KL7', hex_to_num(substr(o1.chk,21,4)),
                                                             'KL8', hex_to_num(substr(o1.chk,21,4)) ), o1.tt, o1.kv ) v
            WHERE v.userid=UserID_ ) tabl1
         );

  -- выберем количество кассовых документов и сумму гривневого эквивалента --
  SELECT count(*), sum(k.sq)
    INTO kas_kol, kas_uah_summa
    FROM ( -- выборка кассовых документов по валюте <> 980
           select distinct o1.ref, gl.p_icurval(o1.kv,o1.s,CheckDate) sq
             from oper o1, opl o2
            where o2.fdat = CheckDate
              and o1.sos  = 5
              and o1.ref  = o2.ref
              and (    substr(o2.nls,1,4) in ('1001','1101')
                   or (substr(o2.nls,1,4)='3800' and o2.tt='F14') )
              and o2.kv <> 980
              and o1.tt = o2.tt
              and o1.kv = o2.kv
              and o1.userid = UserID_
           UNION ALL
           select o2.ref, gl.p_icurval(o2.kv,o2.s,CheckDate) sq
             from oper o1, opl o2
            where o2.fdat = CheckDate
              and o1.sos  = 5
              and o2.ref  = o1.ref
              and substr(o2.nls,1,4) in ('1001','1101')
              and o2.kv <> 980
              and o1.tt =  o2.tt
              and o1.kv <> o2.kv
              and o1.userid = UserID_
           UNION ALL
           select o2.ref, gl.p_icurval(o2.kv,o2.s,CheckDate) sq
             from oper o1, opl o2
            where o2.fdat = CheckDate
              and o1.sos  = 5
              and o2.ref  = o1.ref
              and substr(o2.nls,1,4) in ('1001','1101')
              and o2.kv <> 980
              and o1.tt <> o2.tt
              and o1.kv =  o2.kv
              and o1.userid = UserID_
           UNION ALL
           select o2.ref, gl.p_icurval(o2.kv,o2.s,CheckDate) sq
             from oper o1, opl o2
            where o2.fdat = CheckDate
              and o1.sos  = 5
              and o2.ref  = o1.ref
              and substr(o2.nls,1,4) in ('1001','1101')
              and o2.kv <> 980
              and o1.tt <> o2.tt
              and o1.kv <> o2.kv
              and o1.userid = UserID_
           UNION ALL
           -- выборка кассовых документов по валюте = 980
           select o2.ref, gl.p_icurval(o2.kv,o2.s,CheckDate) sq
             from oper o1, opl o2
            where o2.fdat = CheckDate
              and o1.sos  = 5
              and o2.ref  = o1.ref
              and substr(o2.nls,1,4) in ('1001','1101')
              and o2.kv = 980
              and o1.tt = o2.tt
              and o1.kv = o2.kv
              and o1.userid = UserID_
           UNION ALL
           select o2.ref, gl.p_icurval(o2.kv,o2.s,CheckDate) sq
             from oper o1, opl o2
            where o2.fdat = CheckDate
              and o1.sos  = 5
              and o2.ref  = o1.ref
              and substr(o2.nls,1,4) in ('1001','1101')
              and o2.kv = 980
              and o1.tt =  o2.tt
              and o1.kv <> o2.kv
              and o1.userid = UserID_
           UNION ALL
           select o2.ref, gl.p_icurval(o2.kv,o2.s,CheckDate) sq
             from oper o1, opl o2
            where o2.fdat = CheckDate
              and o1.sos  = 5
              and o2.ref  = o1.ref
              and substr(o2.nls,1,4) in ('1001','1101')
              and o2.kv =  980
              and o1.tt <> o2.tt
              and o1.kv =  o2.kv
              and o1.userid = UserID_
           UNION ALL
           select o2.ref, gl.p_icurval(o2.kv,o2.s,CheckDate) sq
             from oper o1, opl o2
            where o2.fdat = CheckDate
              and o1.sos  = 5
              and o2.ref  = o1.ref
              and substr(o2.nls,1,4) in ('1001','1101')
              and o2.kv =  980
              and o1.tt <> o2.tt
              and o1.kv <> o2.kv
              and o1.userid = UserID_
           UNION ALL
           -- внебалансове кассовые документы --
           select p.ref, gl.p_icurval(p.kv,p.s,CheckDate) sq
             from oper p, opl o
            where (     o.fdat = CheckDate
                    and p.sos = 5 and p.ref = o.ref and p.s = o.s
                    and o.nls = p.nlsa and p.tt not in ('102','012')
                    and p.kv  = o.kv and o.tt <> 'K25'
                    and substr(o.nls,1,1)='9'
                    and substr(o.nls,1,4) not in (case NEWNBS.GET_STATE when 0 then '9020' else '9000' end,
                                                  '9030','9031',
                                                  '9111','9122','9129',
                                                  '9500','9510','9520','9521','9523',
                                                  '9601','9603','9611',
                                                  '9802','9809','9831','9898','9899',
                                                  '9900','9910')
                    and p.userid = UserID_ )
               or
                 (      o.fdat = CheckDate
                    and p.sos = 5 and p.ref = o.ref and p.s = o.s
                    and o.nls = p.nlsa and p.tt in ('012','102','022','100')
                    and p.kv  = o.kv and substr(o.nls,1,1)='9'
                    and substr(o.nls,1,4) not in ('9129','9831','9900','9500','9031','9521','9520')
                    and p.userid = UserID_ )
           UNION ALL
           -- документы на инкассо --
           select o1.ref, gl.p_icurval(o1.kv,o1.s,CheckDate) sq
             from oper o1, opl o2
            where o2.fdat = CheckDate
              and o1.sos  = 5
              and o1.ref  = o2.ref
              and o1.kv   = o2.kv
              and o1.s    = o2.s
              and o1.nlsa = o2.nls
              and substr(o2.nls,1,4)='9831'
              and o2.dk   = 0
              and o1.userid = UserID_
           UNION ALL
           -- пластиковые карточки и пин-коды --
           select o1.ref, gl.p_icurval(o1.kv,o1.s,CheckDate) sq
             from oper o1, provodki p
            where p.fdat = CheckDate
              and o1.sos = 5
              and o1.ref = p.ref
              and p.tt in ('BPK','BPP')
              and o1.userid = UserID_
         ) k;

  -- выберем количество автоматических проводок и сумму гривневого эквивалента --
  SELECT count(*), sum(k.sq)
    INTO Auto_Kol, Auto_Summa
    FROM ( SELECT distinct o2.ref, gl.p_icurval(o2.kv,o2.s,CheckDate) sq
             FROM opl o2, oper o1
            WHERE o2.fdat   = CheckDate
              AND o2.sos    = 5
              AND o1.ref    = o2.ref
              AND o1.dk     = o2.dk
              AND decode(o1.tt,'ISG',hex_to_num(substr(o1.chk, 3,4)),o1.userid) = UserID_
              AND (   (    o1.tt <> o2.tt
                       and o1.kv =  o2.kv
                       -- hide this operations --
                       and o2.tt not in ('PO3','074','K28','077','K2E') )
                   or
                      (    o1.tt <> o2.tt
                       and o1.kv <> o2.kv
                       -- hide this operations --
                       and o2.tt not in ('PO3','K91','117','128') )
                   or
                      (    o1.tt =  o2.tt
                       and o1.kv <> o2.kv )
                   or
                      (    o1.tt = o2.tt
                       and o1.kv = o2.kv
                       and o1.s  <> o2.s
                       -- hide this operations --
                       and o2.nls not like '8%' )
                  )
              AND substr(o2.nls,1,4) not in ('1001') ) k;

  -- выберем количество документов и сумму гривневого эквивалента "в отдельной папке" --
  -- счета в проводках по ƒт/ т принадлежат группам 220,223,206,207,208,210,211,950,952,903,912 --
  SELECT count(*), sum(k.sq)
    INTO Folder_Kol, Folder_Summa
    FROM ( SELECT distinct o2.ref, gl.p_icurval(o2.kv,o2.s,CheckDate) sq
             FROM opl o2, oper o1
            WHERE o2.fdat   = CheckDate
              AND o2.sos    = 5
              AND o1.ref    = o2.ref
              AND (
                    substr(o2.nls,1,3) in ('206','207','208',
                                           '210','211',
                                           '220','223',
                                           case NEWNBS.GET_STATE when 0 then '902' else '900' end,'903',
                                           '911',
                                           '912',
                                           '950','951','952',
                                           '960','961')
                   or
                    substr(o2.nls,1,4) in ('2607',
                                           '3600','3648')
                  )
              AND substr(o1.nlsa,1,4) <> '1001'
              AND substr(o1.nlsb,1,4) <> '1001'
              AND (   o1.userid = UserID_
                   or hex_to_num(substr(o1.chk,3,4)) = UserID_ ) ) k;

--  -- проверим к какому отделу принадлежит UserID_ --
--  SELECT otd INTO OtdelNo FROM otd_user where userid=UserID_;
--
--  CASE
--    WHEN OtdelNo = 3 THEN -- отдел неторговых операций --

         INSERT INTO tmp_general_doc_turnover ( zvit_date,
                                                userid,
                                                fio,
                                                whole_kol_doc,
                                                whole_kol_prov,
                                                whole_uah_summa,
                                                kassa_kol_doc,
                                                kassa_uah_summa,
                                                auto_kol_doc,
                                                auto_uah_summa,
                                                folder_kol_doc,
                                                folder_uah_summa)
                                       VALUES ( substr(F_DAT_LIT(CheckDate),1,25),
                                                UserID_,
                                                UserFIO,
                                                Kol_Doc,
                                                Kol_Prov,
                                                Sum_Eqv,
                                                kas_kol,
                                                kas_uah_summa,
                                                Auto_Kol,
                                                Auto_Summa,
                                                Folder_Kol,
                                                Folder_Summa );
--  END CASE;

  COMMIT;

END;
/
show err;

PROMPT *** Create  grants  P_GENERAL_DOC_TURNOVER ***
grant EXECUTE                                                                on P_GENERAL_DOC_TURNOVER to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_GENERAL_DOC_TURNOVER.sql =======
PROMPT ===================================================================================== 
