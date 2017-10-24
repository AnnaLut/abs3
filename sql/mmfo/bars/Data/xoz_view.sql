prompt =======================================================
prompt COBUSUPABS-3949
prompt ----------------
prompt АРМ «Деб.заборг за госп.діяльністю банку»: 
prompt  Щодо додатк.реквізитів: № договору, дата,  та можливо признач.платежу (на загальну суму згідно договору) 
prompt  Після оплати загальної суми платежу розносити на окремі рахунки дебіторської заборгованості , 
prompt  що відповідають рахункам із різними значеннями параметра аналітичного розрізу ОВ22 
prompt  та контролювати закриття загальної суми розрахунків. 
prompt =======================================================

begin EXECUTE IMMEDIATE  'drop view OPER_XOZ' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/
 
update meta_tables set  SELECT_STATEMENT = '    SELECT "REF",
          "TT",
          "VOB",
          "ND",
          "PDAT",
          "VDAT",
          "S/100 S",
          "DATD",
          "NAM_A",
          "NLSA",
          "NAM_B",
          "NLSB",
          "MFOB",
          "NAZN",
          "ID_B",
          "KPR"
     FROM (SELECT REF,
                  TT,
                  VOB,
                  ND,
                  PDAT,
                  VDAT,
                  S / 100,
                  DATD,
                  NAM_A,
                  NLSA,
                  NAM_B,
                  NLSB,
                  MFOB,
                  NAZN,
                  ID_B,
                  (SELECT COUNT (*) / 2
                     FROM bars.opldok
                    WHERE REF = o.REF)
                     kpr
             FROM bars.oper o
            WHERE     kv = kv2
                  AND kv = 980
                  AND sos > 0
                  AND O.USERID = bars.USER_ID
                  AND pdat >= TRUNC (SYSDATE))
    WHERE kpr = 1'
where tabname =  'OPER_XOZ';
 
commit;

begin EXECUTE IMMEDIATE  'drop view OPER_XOZ_ADD' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/
 
update meta_tables set  SELECT_STATEMENT = '   SELECT rec,
          NLSA,
          REF,
          s / 100 S,
          ROWID RI
     FROM bars.tmp_oper
    WHERE REF = TO_NUMBER (bars.pul.Get_Mas_Ini_Val (''REFX''))'
where tabname =  'OPER_XOZ_ADD';
 
commit;

begin EXECUTE IMMEDIATE  'drop view OPER_XOZ_NLS' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/
 
update meta_tables set  SELECT_STATEMENT = ' SELECT * FROM bars.accounts  WHERE  tip IN (''XOZ'', ''W4X'')  AND dazs IS NULL    AND kv = 980  AND branch LIKE SYS_CONTEXT (''bars_context'', ''user_branch'') || ''%'''
where tabname =  'OPER_XOZ_NLS';
 
commit;


begin EXECUTE IMMEDIATE  'drop view V_XOZ_IDZ' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/
 
update meta_tables set  SELECT_STATEMENT = '    SELECT a.branch,
          a.ob22,
          a.nls,
          a.nms,
          o.vdat,
          o.s / 100 s,
          o.REF,
          x.REF1,
          x.fdat,
          x.MDATE,
          x.MDATE - x.fdat KOLD
     FROM accounts a,
          XOZ_RU_CA z,
          xoz_ref x,
          oper o
    WHERE     x.acc = a.acc
          AND z.ref1 = x.ref1
          AND z.ref2 IS NULL
          AND x.ref2 IS NULL
          AND o.REF = z.REFD_RU'
where tabname =  'V_XOZ_IDZ';
 
commit;

begin EXECUTE IMMEDIATE  'drop view V_XOZ_RU_CA' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/
 
update meta_tables set  SELECT_STATEMENT = '    SELECT w.REC,
          w.MFOA,
          w.NLSA,
          w.NAM_A,
          w.S,
          w.D_REC,
          w.NAZN,
          SUBSTR (xoz.DREC (w.D_REC, ''F1''), 1, 38) REF1,
          SUBSTR (xoz.DREC (w.D_REC, ''FD''), 1, 38) REFD_RU,
          SUBSTR (xoz.DREC (w.D_REC, ''OB''), 1, 2) OB22,
          b.ru,
          b.name,
          SUBSTR (w.nlsa, 1, 4) || SUBSTR (xoz.DREC (w.D_REC, ''OB''), 1, 2)
             PROD
     FROM (SELECT a.REc,
                  a.mfoa,
                  a.nlsa,
                  a.nam_a,
                  a.s / 100 s,
                  a.d_rec,
                  a.nazn
             FROM tzaproS z, arc_rrP a
            WHERE     a.rec = Z.rec
                  AND a.dk = 2
                  AND a.mfob = ''300465''
                  AND a.nlsb = ''35105''
                  AND a.id_b = ''00032129''
                  AND a.d_rec LIKE ''#COB:%#CF1:%#CFD:%#'') w,
          banks_ru b
    WHERE b.mfo = w.mfoa'
where tabname =  'V_XOZ_RU_CA';
 
commit;

begin EXECUTE IMMEDIATE  'drop view V_XOZ7_CA' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/

update meta_tables set  SELECT_STATEMENT = 'V_XOZ7_CA
(
   BR7,
   OB7,
   NLS7,
   NMS7,
   S7,
   KODZ,
   OB40,
   RI,
   OB3,
   TRZ,
   MFOA,
   NLSA,
   S,
   NAZN
)
AS
   SELECT a7.branch BR7,
          a7.ob22 OB7,
          a7.nls nls7,
          a7.nms nms7,
          0 S7,
          NULL kodz,
          NULL ob40,
          NULL RI,
          x.ob22 OB3,
          x.nlsb TRZ,
          x.mfoa,
          x.nlsa,
          x.s / 100 S,
          x.nazn
     FROM (SELECT SUBSTR (xoz.DREC (D_REC, ''OB''), 1, 2) ob22,
                  s,
                  nlsb,
                  mfoa,
                  nlsa,
                  nazn,
                  rec
             FROM arc_rrp
            WHERE rec = TO_NUMBER (pul.get (''RECD_CA''))) x,
          (  SELECT a.*
               FROM accounts a, xoz_ob22 z
              WHERE     z.deb = pul.get (''PROD'')
                    AND z.krd = a.nbs || a.ob22
                    AND a.dazs IS NULL
                    AND a.kv = 980
           ORDER BY a.nls) a7
   UNION ALL
   SELECT a7.branch BR7,
          a7.ob22 OB7,
          a7.nls nls7,
          a7.nms nms7,
          a7.S7 / 100 s7,
          a7.kodz,
          a7.ob40,
          a7.RI,
          x.ob22 OB3,
          x.nlsb TRZ,
          x.mfoa,
          x.nlsa,
          x.s / 100 S,
          a7.nazn
     FROM (SELECT SUBSTR (xoz.DREC (D_REC, ''OB''), 1, 2) ob22,
                  s,
                  nlsb,
                  mfoa,
                  nlsa,
                  nazn,
                  rec
             FROM arc_rrp
            WHERE rec = TO_NUMBER (pul.get (''RECD_CA''))) x,
          (SELECT a.branch,
                  a.ob22,
                  a.nls,
                  a.nms,
                  Z.S7,
                  z.nazn,
                  z.kodz,
                  z.ob40,
                  z.ROWID RI
             FROM accounts a, xoz7_ca z
            WHERE     a.acc = z.acc7
                  AND a.dazs IS NULL
                  AND a.kv = 980
                  AND z.rec = TO_NUMBER (pul.get (''RECD_CA''))) a7'
where tabname =  'V_XOZ7_CA';
 
commit;


begin EXECUTE IMMEDIATE  'drop view V_XOZACC' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/

update meta_tables set  SELECT_STATEMENT = ' SELECT a.RNK,  a.ob22,  a.ACC, a.KV, a.NLS, a.NMS, a.ISP, a.BRANCH, c.nmk, c.custtype TYPE, null s180, a.OSTC, NVL(x.KC,0) KOL, NVL(x.SC,0) S,
     (-a.ostc+NVL(x.SC,0)) DEL, a.OSTB, NVL(x.KB,0) KOLB,  NVL(x.SB,0) SB, (-a.ostB+NVL(x.SB,0)) DELB,  ''Архiв'' ARC,  a.NBS||a.ob22 prod,
     ( SELECT MAX (fdat)  FROM saldoa  WHERE acc = a.acc AND ostf >= 0 AND ostf-dos+kos <= 0 ) DAT0
FROM customer c,
     (SELECT RNK, ob22, ACC, KV, NLS, NMS, ISP, tobo BRANCH, -ostc/100 OSTC, -(ostb+ostf)/100 OSTB, nbs  
      FROM accounts   WHERE tip IN (''XOZ'', ''W4X'') ) a,
     (SELECT acc, SUM(kc) kc, SUM(kb) kb, SUM(sc)/100 sc, SUM(sb)/100 sb FROM (SELECT r.acc, 1 KC, 1 KB, r.s SC, r.s SB FROM xoz_ref r WHERE r.s > 0 AND r.ref2 IS NULL)  GROUP BY acc) x
 WHERE a.rnk = c.rnk   AND a.acc = x.acc(+)   AND (a.ostc <> 0 OR NVL (x.SC, 0) <> 0 OR a.ostb <> 0)'
where tabname =  'V_XOZACC';

commit;

begin EXECUTE IMMEDIATE  'drop view V_XOZKWT' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/

update meta_tables set  SELECT_STATEMENT = ' select  a.kv, a.nls, a.ob22, a.branch, a.ostc/100 ost, a.nms, x.REF1, x.STMT1, x.REF2, x.ACC, x.MDATE, x.S/100 s, x.FDAT, x.S0/100 s0, x.DATZ
from xoz_ref x, accounts a  where a.acc= x.acc and  x.datz = NVL( to_date (pul.GET(''DATZ''), ''dd.mm.yyyy'') , gl.bd )'
where tabname =  'V_XOZKWT';

commit;

begin EXECUTE IMMEDIATE  'drop view V_XOZOB22_NLS' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/

update meta_tables set  SELECT_STATEMENT = 'SELECT x.deb,   x.krd,   a.branch,   a.ob22,   a.kv||''/''|| a.nls NLS , a.nms,   a.ostc/100 OST,   a.acc
 FROM (SELECT *  FROM xoz_ob22 WHERE deb= pul.get (''PROD'')) x,         accounts a
 WHERE x.krd = a.nbs || a.ob22 AND a.dazs IS NULL 
  AND a.kv = CASE   WHEN x.krd  like ''6%'' or x.krd  like ''7%''  THEN 980    ELSE        to_number (pul.get (''XOZ_KV''))      END'
where tabname =  'V_XOZOB22_NLS';

commit;


begin EXECUTE IMMEDIATE  'drop view V_XOZREF' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/

update meta_tables set  SELECT_STATEMENT = '   SELECT x.ACC,
          x.ref1,
          x.stmt1,
          x.refD,
          a.kv,
          a.nls,
          a.ob22,
          a.nbs,
          a.nbs || a.ob22 PROD,
          a.branch,
          a.nms,
          -a.ostc / 100 OSTC,
          x.fdat VDAT,
          x.s / 100 S,
          x.s0 / 100 S0,
          a.nms txt,
          o.nazn,
          o.mfob,
          o.nlsb,
          o.nam_b,
          o.id_b,
          o.nd,
          o.datd,
          x.mdate,
          (x.MDATE - gl.bd) DNI,
          (x.MDATE - x.fdat) DNIP,
          x.NOTP
     FROM xoz_ref x, accounts a, oper o
    WHERE x.s > 0 AND x.ref2 IS NULL AND x.acc = a.acc AND x.ref1 = o.REF'
where tabname =  'V_XOZREF';

commit;


begin EXECUTE IMMEDIATE  'drop view V_XOZREF_ADD' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/

update meta_tables set  SELECT_STATEMENT = ' select pul.get(''XOZ_NLS'') NLS,   s.acc, o.ref, o.stmt, o.tt, o.fdat, o.s/100 s, (select nazn from oper where ref = o.ref) nazn
from opldok o,
     (select * from saldoa where acc = pul.get(''XOZ_ACC'') and dos > 0) s
where o.dk = 0 and o.sos = 5 and o.acc = s.acc and o.fdat = s.fdat 
  and not exists ( select 1 from xoz_ref where ref1= o.ref and stmt1 = o.stmt and acc = s.acc)'
where tabname =  'V_XOZREF_ADD';

commit;

begin EXECUTE IMMEDIATE  'drop view V_XOZREF2' ;
exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   --ORA-00942: table or view does not exist
end;
/

update meta_tables set  SELECT_STATEMENT = '   SELECT a.nls,
          a.nms,
          x.ref1,
          x.STMT1,
          x.fdat FDAT1,
          x.s0 / 100 S0,
          x.s / 100 S,
          x.MDATE,
          o1.nam_b,
          o1.id_b,
          o1.nazn NAZN1,
          x.Ref2,
          o2.sos,
          o2.vdat FDAT2,
          o2.nlsa,
          o2.nazn NAZN2,
          x.acc,
          a.rnk,
          a.ob22,
          x.NOTP,
          x.PRG,
          x.BU
     FROM xoz_ref x,
          v_gl a,
          oper o1,
          (SELECT * FROM oper) o2
    WHERE x.acc = a.acc AND x.ref1 = o1.REF AND x.ref2 = o2.REF(+)'
where tabname =  'V_XOZREF2';

commit;

