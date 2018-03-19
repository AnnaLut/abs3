prompt view/vw_ref_tarif.sql
create or replace force view bars_intgr.vw_ref_tarif as
select KOD, 
KV, 
t.NAME, 
TAR, 
PR, 
SMIN, 
SMAX, 
TIP, 
NBS, 
OB22, 
KF as MFO, 
PDV, 
RAZOVA, 
DAT_BEGIN, 
DAT_END, 
KV_SMIN, 
KV_SMAX 
from bars.TARIF t;

comment on table BARS_INTGR.VW_REF_TARIF is 'Тарифы и комиссии';
comment on column BARS_INTGR.VW_REF_TARIF.KOD is 'Код тарифа/комиссии';
comment on column BARS_INTGR.VW_REF_TARIF.KV is 'Код базовой валюты тарифа';
comment on column BARS_INTGR.VW_REF_TARIF.NAME is 'Наименование тарифа/комиссии';
comment on column BARS_INTGR.VW_REF_TARIF.TAR is 'Сумма за 1 документ';
comment on column BARS_INTGR.VW_REF_TARIF.PR is '% от суммы документа';
comment on column BARS_INTGR.VW_REF_TARIF.SMIN is 'минимальная сумма тарифа';
comment on column BARS_INTGR.VW_REF_TARIF.SMAX is 'максимальная сумма тарифа';
comment on column BARS_INTGR.VW_REF_TARIF.TIP is 'Код вычисления суммы 0 - стандарт, 1 - средневзв.ост.за прошлый мес (+диапазон)';
comment on column BARS_INTGR.VW_REF_TARIF.NBS is 'Допустимый БС для сч дох по комиссии этого тарифа';
comment on column BARS_INTGR.VW_REF_TARIF.OB22 is 'Допустимый ob22 для сч дох по комиссии этого тарифа';
comment on column BARS_INTGR.VW_REF_TARIF.PDV is 'Признак ПДВ (1-з ПДВ)';
comment on column BARS_INTGR.VW_REF_TARIF.RAZOVA is 'Признак разової комiсiї (1-разова)';
comment on column BARS_INTGR.VW_REF_TARIF.DAT_BEGIN is 'Дата начала действия тарифа';
comment on column BARS_INTGR.VW_REF_TARIF.DAT_END is 'Дата окончания действия тарифа';
comment on column BARS_INTGR.VW_REF_TARIF.KV_SMIN is 'Валюта минимальной граничной суммы';
comment on column BARS_INTGR.VW_REF_TARIF.KV_SMAX is 'Валюта максиимальной граничной суммы';
