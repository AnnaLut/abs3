exec BPA.DISABLE_POLICIES( 'DPT_DEPOSITW_UPDATE' );

insert /*+ APPEND */
  into DPT_DEPOSITW_UPDATE
     ( EFFDT, CHGID, CHGACTN, CHGDT, DONEBY
     , KF, DPT_ID, TAG, VALUE )
select GL.GBD(),  S_DPT_DEPOSITW_UPDATE.NextVal, 'I', sysdate, 1
     , t1.KF, t1.DPT_ID, t1.TAG, t1.VALUE
  from DPT_DEPOSITW t1
  left outer 
  join DPT_DEPOSITW_UPDATE t2
   on ( t2.KF = t1.KF and t2.DPT_ID = t1.DPT_ID and t2.TAG = t1.TAG and t2.CHGACTN = 'I' )
 where t2.DPT_ID is null;

commit;

exec BPA.DISABLE_POLICIES( 'DPT_DEPOSITW' );

delete DPT_DEPOSITW w
 where not exists ( select 1 from DPT_DEPOSIT d where d.KF = w.KF and d.DEPOSIT_ID = w.DPT_ID );

commit;

exec BPA.ENABLE_POLICIES( 'DPT_DEPOSITW' );

exec BPA.ENABLE_POLICIES( 'DPT_DEPOSITW_UPDATE' );
