prompt create VIEW V_STO_LST
create or replace force view v_sto_lst
as
select
s.ids,
s.rnk,
c.nmk,
s.name,
s.sdat,
s.idg,
s.kf,
s.branch,
s.date_close
from sto_lst s
join customer c on s.rnk = c.rnk and s.kf = c.kf;

grant select on v_sto_lst to bars_access_defrole;

comment on table v_sto_lst is 'Договора на регулярные платежи (ВЕБ)';
COMMENT ON COLUMN BARS.V_STO_LST.IDS IS 'Реф Договора';
COMMENT ON COLUMN BARS.V_STO_LST.RNK IS 'RNK Поручителя';
COMMENT ON COLUMN BARS.V_STO_LST.NMK IS 'Наименование клиента / ФИО';
COMMENT ON COLUMN BARS.V_STO_LST.NAME IS 'Детали Договора / название';
COMMENT ON COLUMN BARS.V_STO_LST.SDAT IS 'Дата Договора';
COMMENT ON COLUMN BARS.V_STO_LST.IDG IS 'Ид группы';
COMMENT ON COLUMN BARS.V_STO_LST.KF IS 'Код филиала';
COMMENT ON COLUMN BARS.V_STO_LST.BRANCH IS 'Бранч договора';
COMMENT ON COLUMN BARS.V_STO_LST.DATE_CLOSE IS 'Дата закрытия договора';