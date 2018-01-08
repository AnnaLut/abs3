

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F36.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F36 ***

create or replace force view v_cim_f36 as
select f.b041, f.k020, f.p17, f.p16, f.p21, f.p21_new, f.p14, f.p01, f.p22, nvl(b.p02, f.p02) as p02, f.p02_old, nvl(b.p06, f.p06)as p06, f.p06_old, nvl(b.p07, f.p07) as p07,
         f.p07_old, nvl(b.p08, f.p08) as p08, f.p08_old, nvl(b.p09, f.p09) as p09, nvl(b.p15, f.p15) as p15, nvl(b.p18, f.p18) as p18, nvl(b.p19, f.p19) as p19,
         nvl(b.p20, f.p20) as p20, nvl(b.p23, f.p23) as p23, f.create_date, f.doc_date, f.branch
    from cim_f36 f
         left outer join (select b041, k020, p17, p16, p21, p14, p01, doc_date, max(create_date) as create_date, substr(branch, 1,8) as mfo from cim_f36 group by b041, k020, p17, p16, p21, p14, p01, doc_date, substr(branch, 1,8)) z
           on z.p01=f.p01 and z.b041=f.b041 and z.p14=f.p14 and z.p21=f.p21 and z.k020=f.k020 and z.p16=f.p16 and z.p17=f.p17 and f.doc_date=z.doc_date and z.mfo = substr(f.branch, 1,8)
         left outer join cim_f36 b
           on b.p01=f.p01 and b.b041=f.b041 and b.k020=f.k020 and b.p17=f.p17 and b.p16=f.p16 and b.p21=f.p21 and b.p14=f.p14 and b.doc_date=f.doc_date and b.create_date=z.create_date and substr(b.branch, 1,8) = substr(f.branch, 1,8)
   where f.p22=1 and
         (select count(*) from cim_f36 s
            where s.create_date>=f.create_date and s.p01=f.p01 and s.b041=f.b041 and s.p14=f.p14 and s.p21=f.p21 and s.k020=f.k020 and s.p16=f.p16 and s.p17=f.p17 and s.doc_date=f.doc_date
                  and s.p22=3)=0;
comment on table V_CIM_F36 is '��������� ������ ���������� v 1.01.01';
comment on column V_CIM_F36.B041 is '��� ��������';
comment on column V_CIM_F36.K020 is '��� ����';
comment on column V_CIM_F36.P17 is '� ���������';
comment on column V_CIM_F36.P16 is '���� ���������';
comment on column V_CIM_F36.P21 is '���� ������� ��� ���������';
COMMENT ON COLUMN V_CIM_F36.P21_NEW IS '��������� ���� ������� ��� ���������';
comment on column V_CIM_F36.P14 is '��� ������';
comment on column V_CIM_F36.P01 is '��� ����������������� �������� 1 - ����, 2 - ���';
comment on column V_CIM_F36.P22 is '��� 䳿';
comment on column V_CIM_F36.P02 is '���';
comment on column V_CIM_F36.P02_OLD is '��� (�����)';
comment on column V_CIM_F36.P06 is '����� ���������';
comment on column V_CIM_F36.P06_OLD is '����� ��������� (�����)';
comment on column V_CIM_F36.P07 is '������ ���������';
comment on column V_CIM_F36.P07_OLD is '������ ��������� (�����)';
comment on column V_CIM_F36.P08 is '����� �����������';
comment on column V_CIM_F36.P08_OLD is '����� ����������� (�����)';
comment on column V_CIM_F36.P09 is '��� ����� �����������';
comment on column V_CIM_F36.P15 is '���� ������';
comment on column V_CIM_F36.P18 is '1 - �������� ������, 2 - ��������� �����';
comment on column V_CIM_F36.P19 is '³����� ��� ��������� �������������';
comment on column V_CIM_F36.P20 is '������� ���������� �������������';
comment on column V_CIM_F36.P23 is '���� �������� ��� �� ���������� ��� ���������';
comment on column V_CIM_F36.CREATE_DATE is '���� ���������';
comment on column V_CIM_F36.BRANCH is 'ϳ������';

PROMPT *** Create  grants  V_CIM_F36 ***
grant SELECT                                                                 on V_CIM_F36       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F36       to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F36.sql =========*** End *** ====
PROMPT ===================================================================================== 
