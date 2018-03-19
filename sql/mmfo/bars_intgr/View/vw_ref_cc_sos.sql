prompt view/vw_ref_cc_sos.sql
create or replace force view bars_intgr.vw_ref_cc_sos as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											sos, 
											c.name FROM bars.cc_sos c;

comment on table BARS_INTGR.VW_REF_CC_SOS is 'Состояние заявки на кредит';
comment on column BARS_INTGR.VW_REF_CC_SOS.SOS is 'Код состояния';
comment on column BARS_INTGR.VW_REF_CC_SOS.NAME is 'Состояние заявки';

