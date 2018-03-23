prompt bars_intgr.VW_REF_BANKS

create or replace view bars_intgr.VW_REF_BANKS
as
select t.mfo, t.nb from bars.v_banks_xrm t;