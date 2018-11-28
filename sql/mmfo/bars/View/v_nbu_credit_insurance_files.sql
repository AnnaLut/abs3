create or replace view v_nbu_credit_insurance_files as
select F.ID,
       F.NAME,
       to_char(F.DDATE,'mm.yy') DDATE,
       S.FIO,
       F.CHGDATE,
       --F.KF,
       case F.STATE when 0 then '�����������' when 1 then '���������' when 2 then '����������� � ���������' end state 
from NBU_CREDIT_INSURANCE_FILES F,
     STAFF$BASE                 S
where s.id = f.idupd
order by f.id desc;

comment on table V_NBU_CREDIT_INSURANCE_FILES is '���������� �����';
comment on column V_NBU_CREDIT_INSURANCE_FILES.ID is '��� �����';
comment on column V_NBU_CREDIT_INSURANCE_FILES.NAME is '��''� �����';
comment on column V_NBU_CREDIT_INSURANCE_FILES.DDATE is '���� �����';
comment on column V_NBU_CREDIT_INSURANCE_FILES.FIO is '����������';
comment on column V_NBU_CREDIT_INSURANCE_FILES.CHGDATE is '�������� ����';
--comment on column V_NBU_CREDIT_INSURANCE_FILES.KF is '��';
comment on column V_NBU_CREDIT_INSURANCE_FILES.STATE is '������';

grant SELECT on v_nbu_credit_insurance_files to BARS_ACCESS_DEFROLE;
