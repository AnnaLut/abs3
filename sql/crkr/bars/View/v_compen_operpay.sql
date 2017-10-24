create or replace view v_compen_operpay as
select o.reg_id, p.fio, p.ost / 100 ost, o.amount / 100 amount
from compen_oper o, compen_portfolio p 
where o.compen_id = p.id and o.oper_type in (1/*TYPE_OPER_PAY_DEP*/, 2/*TYPE_OPER_PAY_BUR*/);

comment on table v_compen_operpay is '�������� �� ��������';
comment on column v_compen_operpay.reg_id is '������������� ������';
comment on column v_compen_operpay.fio is '������� �� �����';
comment on column v_compen_operpay.ost is '������� ������';
comment on column v_compen_operpay.amount is '���� ��������';

GRANT SELECT ON v_compen_operpay TO BARS_ACCESS_DEFROLE;