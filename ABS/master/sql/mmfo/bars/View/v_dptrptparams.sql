PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPTRPTPARAMS.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  view V_DPTRPTPARAMS ***

create or replace force view V_DPTRPTPARAMS
( MODCODE
, DEALID
, DEALNUM
, DATBEG
, DATEND
, TYPENAME
, CUSTID
, CUSTNAME
, CURRENCYID
) AS
select 'DPT', d.deposit_id, d.nd, to_char(d.dat_begin, 'dd.mm.yyyy'),
       to_char(d.dat_end, 'dd.mm.yyyy'), v.type_name, c.rnk, c.nmk, d.kv
  from DPT_DEPOSIT d
  join DPT_VIDD    v
    on ( v.VIDD = d.VIDD )
  join CUSTOMER c
    on ( c.RNK = d.RNK )
 where d.branch = sys_context('bars_context','user_branch')
--select 'DPT', d.deposit_id, d.nd, to_char(d.dat_begin, 'dd.mm.yyyy'),
--       to_char(d.dat_end, 'dd.mm.yyyy'), v.type_name, c.rnk, c.nmk, d.kv
--  from DPT_DEPOSIT_CLOS d,
--       DPT_VIDD         v,
--       CUSTOMER         c
-- where d.RNK    = c.rnk
--   and d.VIDD   = v.vidd
--   and d.BRANCH = sys_context('bars_context', 'user_branch')
--   and d.IDUPD in ( select max(IDUPD)
--                      from DPT_DEPOSIT_CLOS
--                     where BDATE <= GL.BD()
--                     group by DEPOSIT_ID )
;

show errors;

PROMPT *** Create grants V_DPTRPTPARAMS ***

grant SELECT on V_DPTRPTPARAMS to BARSREADER_ROLE;
grant SELECT on V_DPTRPTPARAMS to BARS_ACCESS_DEFROLE;
grant SELECT on V_DPTRPTPARAMS to UPLD;
