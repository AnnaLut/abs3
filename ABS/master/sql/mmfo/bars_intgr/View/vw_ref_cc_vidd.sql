prompt view/vw_ref_cc_vidd.sql
CREATE OR REPLACE force VIEW BARS_INTGR.VW_REF_CC_VIDD AS
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											cc.vidd, 
											cc.name 
											FROM bars.cc_vidd cc 
											WHERE custtype = 3 
											AND tipd = 1
UNION ALL
SELECT cast(bars.F_OURMFO_G as varchar2(6)), 
										19, 
										'БПК Кредити' 
										FROM dual;

comment on table BARS_INTGR.VW_REF_CC_VIDD is 'Виды договоров';
comment on column BARS_INTGR.VW_REF_CC_VIDD.VIDD is 'Код вида договора';
comment on column BARS_INTGR.VW_REF_CC_VIDD.NAME is 'Вид договора';

