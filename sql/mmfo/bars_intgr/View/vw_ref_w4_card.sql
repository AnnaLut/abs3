prompt view/vw_ref_w4_card.sql
create or replace force view bars_intgr.vw_ref_w4_card as
select KF MFO,
t.CODE,
PRODUCT_CODE,
SUB_CODE,
DATE_OPEN,
DATE_CLOSE
from bars.W4_CARD t;

comment on table BARS_INTGR.VW_REF_W4_CARD is 'W4. ���������� ����� ����';
comment on column BARS_INTGR.VW_REF_W4_CARD.CODE is '��� �����';
comment on column BARS_INTGR.VW_REF_W4_CARD.PRODUCT_CODE is '��� ��������';
comment on column BARS_INTGR.VW_REF_W4_CARD.SUB_CODE is '��� �����������';
