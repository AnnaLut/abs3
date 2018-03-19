prompt view/vw_ref_dpt_vidd.sql
CREATE OR REPLACE FORCE VIEW VW_REF_DPT_VIDD AS
SELECT cast(bars.F_OURMFO_G as varchar2(6)) MFO,
       FLAG,
       VIDD,
       d.TYPE_NAME,
       BASEM,
       FREQ_N,
       FREQ_K,
       DURATION,
       TERM_TYPE,
       MIN_SUMM,
       COMMENTS,
       TYPE_COD,
       KV,
       DATN,
       DATK,
       FL_DUBL,
       FL_2620,
       COMPROC,
       LIMIT,
       TERM_ADD,
       TERM_DUBL,
       DURATION_DAYS,
       MAX_LIMIT,
       DISABLE_ADD,
       DURATION_MAX,
       DURATION_DAYS_MAX,
       IRREVOCABLE,
       BR_ID,
       (select br_type from bars.brates where br_id = d.BR_ID) br_type,
       bars.getbrat(sysdate, BR_ID, d.kv, d.limit) as BR_IDrate,
       BR_WD,
       bars.getbrat(sysdate, BR_WD, d.kv, d.limit) as BR_WDrate,
       BR_ID_L,
       bars.getbrat(sysdate, BR_ID_L, d.kv, d.limit) as BR_ID_Lrate,
       (select val from bars.dpt_vidd_params where vidd = d.vidd and tag = 'FORB_EARLY') as FORB_EARLY,
       (select val from bars.dpt_vidd_params where vidd = d.vidd and tag = 'FORB_EARLY_DATE') as FORB_EARLY_DATE,
       nvl((select case when fl_demand = 1 then 'N' else 'Y' end from bars.dpt_types where type_code = d.type_cod), 'Y') used_ebp,
       T.TYPE_NAME as FAMILY
  FROM bars.dpt_vidd d, bars.DPT_TYPES t
 where BSD in ('2630', '2635') -- ��� ������� ������ 2620
   and flag = 1 -- ������ ��������
   and D.TYPE_ID = T.TYPE_ID;


comment on table VW_REF_DPT_VIDD is '���� �������';
comment on column VW_REF_DPT_VIDD.FLAG is '���� ���������';
comment on column VW_REF_DPT_VIDD.VIDD is '��� ������';
comment on column VW_REF_DPT_VIDD.TYPE_NAME is '�������� ���� ������';
comment on column VW_REF_DPT_VIDD.BASEM is '������ ��������� ��������� ������';
comment on column VW_REF_DPT_VIDD.FREQ_N is '����������� ����������� �������';
comment on column VW_REF_DPT_VIDD.FREQ_K is '����������� ������� �������';
comment on column VW_REF_DPT_VIDD.DURATION is '����� ���� ������ � ������';
comment on column VW_REF_DPT_VIDD.TERM_TYPE is '��� �����: 1-����, 0-����, 2-��������';
comment on column VW_REF_DPT_VIDD.MIN_SUMM is '̳������� ���� ������';
comment on column VW_REF_DPT_VIDD.COMMENTS is '��������';
comment on column VW_REF_DPT_VIDD.TYPE_COD is '��� ���� ����� ��������';
comment on column VW_REF_DPT_VIDD.KV is '������ (�������� ISO-���)';
comment on column VW_REF_DPT_VIDD.DATN is '���� ������� 䳿 ������';
comment on column VW_REF_DPT_VIDD.DATK is '���� ��������� 䳿 ������';
comment on column VW_REF_DPT_VIDD.FL_DUBL is '���� ��������������� (0 - ��� ��������������, 1 - �������������� ��� ���������� ������, 2 - �������������� � ����������� ������)';
comment on column VW_REF_DPT_VIDD.FL_2620 is '����������� �� ����� "�� ������"';
comment on column VW_REF_DPT_VIDD.COMPROC is '����������� �������';
comment on column VW_REF_DPT_VIDD.LIMIT is '̳������� ���� ����������';
comment on column VW_REF_DPT_VIDD.TERM_ADD is '����� ���������� ������';
comment on column VW_REF_DPT_VIDD.TERM_DUBL is '����������� �-�� ��������������� ������';
comment on column VW_REF_DPT_VIDD.DURATION_DAYS is '����� ���� ������ � ����';
comment on column VW_REF_DPT_VIDD.MAX_LIMIT is '����������� ���� ����������';
comment on column VW_REF_DPT_VIDD.DISABLE_ADD is '������ ��������������� ��������';
comment on column VW_REF_DPT_VIDD.DURATION_MAX is '������������ ����� ������ � ������';
comment on column VW_REF_DPT_VIDD.DURATION_DAYS_MAX is '������������ ����� ������ � � ����';
comment on column VW_REF_DPT_VIDD.IRREVOCABLE is '������������ ���������� ������';
comment on column VW_REF_DPT_VIDD.BR_ID is '��� ������� ������?';
comment on column VW_REF_DPT_VIDD.BR_TYPE is '��� ������� ������';
comment on column VW_REF_DPT_VIDD.BR_IDRATE is '�������� ������� ������';
comment on column VW_REF_DPT_VIDD.BR_WD is '��� ������ ��� ��������� ������';
comment on column VW_REF_DPT_VIDD.BR_WDRATE is '�������� ������ ��� ��������� ������';
comment on column VW_REF_DPT_VIDD.BR_ID_L is '��� ������ �����������';
comment on column VW_REF_DPT_VIDD.BR_ID_LRATE is '�������� ������ �����������';
comment on column VW_REF_DPT_VIDD.FORB_EARLY is '�������� ������������ ���������';
comment on column VW_REF_DPT_VIDD.FORB_EARLY_DATE is '����, � ��� 䳺 �������� ������������ ���������';
comment on column VW_REF_DPT_VIDD.USED_EBP is '������� ���������� ������-�������� (Y/N)';
comment on column VW_REF_DPT_VIDD.FAMILY is '�������� ��������� (�������� "̳� ������� ����������", "���������", "������")';