create or replace force view bars.v_static_layout
as
   select id,
            nvl (dk, 1) dk,
            name,
            nls,
            bs1 bs,
            ob1 ob,
            nazn1 nazn,
            datp,
            alg,
            grp
       from ope_lot
      where ob22 != '~~' and (id < 0 or grp > 0)
   order by id desc;
/
   comment on table bars.v_static_layout is '������� ������ ������';
/
comment on column bars.v_static_layout.id is '�������������';
/
comment on column bars.v_static_layout.name is '������������ ������';
/
comment on column bars.v_static_layout.nls is '������� �';
/
comment on column bars.v_static_layout.bs is '���������� �������';
/
comment on column bars.v_static_layout.ob is '��22';
/
comment on column bars.v_static_layout.nazn is '��������� ����������� �������';
/
comment on column bars.v_static_layout.datp is '���� ������������ ���������';
/
comment on column bars.v_static_layout.alg is '� ���';
/
grant select on bars.v_static_layout to bars_access_defrole;
/
