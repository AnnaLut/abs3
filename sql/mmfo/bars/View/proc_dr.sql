prompt -- ======================================================
prompt -- create view PROC_DR
prompt -- ======================================================

create or replace force view PROC_DR
( NBS, G67, V67, SOUR, NBSN, G67N, V67N, NBSZ, REZID, TT, TTV, IO, BRANCH
, KF
) as
select NBS
     , G67
     , V67
     , SOUR
     , NBSN
     , G67N
     , V67N
     , NBSZ
     , REZID
     , TT
     , TTV
     , IO
     , BRANCH
     , KF
  from PROC_DR$BASE
 where BRANCH = sys_context('bars_context','user_branch');

show errors;

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on PROC_DR to BARS_ACCESS_DEFROLE;
grant SELECT on PROC_DR to FOREX;
grant SELECT on PROC_DR to RCC_DEAL;
grant SELECT on PROC_DR to START1;
grant SELECT on PROC_DR to WR_ALL_RIGHTS;
grant SELECT on PROC_DR to WR_REFREAD;
