prompt view/vw_ref_cust_mark_types.sql
create or replace force view bars_intgr.vw_ref_cust_mark_types as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											MARK_CODE, 
											MARK_NAME, 
											NEED_DOCS, 
											OPEN_SELF 
											from bars.CUST_MARK_TYPES t;

comment on table BARS_INTGR.VW_REF_CUST_MARK_TYPES is 'Довідник "Особливих відміток" клієнта ФО';
comment on column BARS_INTGR.VW_REF_CUST_MARK_TYPES.MARK_CODE is 'Код відмітки';
comment on column BARS_INTGR.VW_REF_CUST_MARK_TYPES.MARK_NAME is 'Назва відмітки';
comment on column BARS_INTGR.VW_REF_CUST_MARK_TYPES.NEED_DOCS is 'Необхідність надання підтверджуючого документу ( 1 - так, 0 - ні )';
comment on column BARS_INTGR.VW_REF_CUST_MARK_TYPES.OPEN_SELF is 'Клієнт відкриває депозит самостійно ( 1 - так, 0 - ні )';

