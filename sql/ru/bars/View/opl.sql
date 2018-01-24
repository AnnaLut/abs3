create or replace force view OPL
( ACC
, TT
, REF
, NBS
, OB22
, KV
, NLS
, NMS
, DK
, S
, SQ
, FDAT
, SOS
, NAZN
, STMT
, TIP
)as
select o.ACC
     , o.TT
     , o.REF
     , a.NBS
     , a.OB22
     , a.KV
     , a.NLS
     , a.NMS
     , o.DK
     , o.S
     , o.SQ
     , o.FDAT
     , o.SOS
     , p.NAZN
     , o.STMT
     , a.TIP
  from ACCOUNTS a
     , OPLDOK o
     , OPER p
 where A.ACC = O.ACC
   and O.REF = P.REF;

show errors;

COMMENT ON TABLE  OPL      IS '���������� ��������';

comment on column OPL.ACC  is '���������� ����� �����';
comment on column OPL.TT   is '��� ��������';
comment on column OPL.REF  is '�������� ���������';
comment on column OPL.NBS  is 'R020';
comment on column OPL.OB22 is '��22';
comment on column OPL.KV   is '������ ���������';
comment on column OPL.NLS  is '����� �����';
comment on column OPL.NMS  is '������������ �����';
comment on column OPL.DK   is '�����/������';
comment on column OPL.S    is '�����';
comment on column OPL.SQ   is '���������� �����';
comment on column OPL.FDAT is '���� ���������';
comment on column OPL.SOS  is '��������� ������';
comment on column OPL.NAZN is '����������� �������';
comment on column OPL.STMT is '������������� ����������';
comment on column OPL.TIP  is '��� �����';


GRANT SELECT ON OPL TO ABS_ADMIN;
GRANT SELECT ON OPL TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON OPL TO INSPECTOR;
GRANT SELECT ON OPL TO PYOD001;
GRANT SELECT ON OPL TO RPBN001;
GRANT SELECT ON OPL TO START1;
GRANT SELECT ON OPL TO TEST;
GRANT SELECT ON OPL TO UPLD;
GRANT SELECT ON OPL TO WR_ALL_RIGHTS;
