create or replace view V_NBUR_1PB_EXPORT_CNDT
( KF
, DOC_REF
, DOC_DT
, CCY_ID
, ACC_DB_NUM
, ACC_DB_NM
, ACC_CR_NUM
, ACC_CR_NM
, DOC_AMNT
, DOC_DSC
) as
select d.KF, d.REF, d.DATD, d.KV, d.NLSA, d.NAM_A, d.NLSB, d.NAM_B, d.S/100, d.NAZN
  from OPER d
  join ( select t.ref
           from ACCOUNTS a
           join SALDOA   s
             on ( s.kf = a.kf and s.acc = a.acc and s.fdat >= add_months(trunc(sysdate,'MM'),-1) and s.fdat < trunc(sysdate,'MM') )
           join OPLDOK   t
             on ( t.kf = s.kf and t.acc = s.acc and t.fdat = s.fdat and t.dk = 0 )
          where a.nbs = '1500'
         intersect
         select t.ref
           from ACCOUNTS a
           join SALDOA   s
             on ( s.kf = a.kf and s.acc = a.acc and s.fdat >= add_months(trunc(sysdate,'MM'),-1) and s.fdat < trunc(sysdate,'MM') )
           join OPLDOK   t
             on ( t.kf = s.kf and t.acc = s.acc and t.fdat = s.fdat and t.dk = 1 )
          where a.nbs = '1600'
       ) l
    on ( l.REF = d.REF )
--  left
--  join OPERW w
--    on ( w.kf = d.kf and w.ref = d.ref and w.tag = 'KOD_N' )
-- where w.VALUE Is Null
;

show err

grant select on V_NBUR_1PB_EXPORT_CNDT to BARS_ACCESS_DEFROLE;
