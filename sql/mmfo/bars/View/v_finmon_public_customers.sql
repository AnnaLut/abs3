PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/view/v_finmon_public_customers.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view bars.v_finmon_public_customers as
select c.id, 
       c.rnk, 
       c.nmk, 
       c.crisk, 
       c.cust_risk, 
       c.check_date,
       c.rnk_reel, 
       c.nmk_reel, 
       c.num_reel, 
       c.comments, 
       c.kf,
       to_char(p.bday, 'dd.mm.yyyy')  as person_birth,
       to_char(r.birth, 'dd.mm.yyyy') as public_rels_birth,
       pep_code,
       d.date_of_birth as pep_birth
from finmon_public_customers c
     left join person p on p.rnk = c.rnk
     left join finmon_public_rels r on r.id = c.num_reel
     left join finmon_pep_dict d on c.pep_code = d.id;

comment on table V_FINMON_PUBLIC_CUSTOMERS is '������ �������� �볺��� - �������� �����';
comment on column V_FINMON_PUBLIC_CUSTOMERS.ID is '����� � ������ ���';
comment on column V_FINMON_PUBLIC_CUSTOMERS.RNK is '������������ ����� �볺��� � ��';
comment on column V_FINMON_PUBLIC_CUSTOMERS.NMK is '������������ �볺��� � ��';
comment on column V_FINMON_PUBLIC_CUSTOMERS.CRISK is '�������� ������ �볺��� �� ���� ��������';
comment on column V_FINMON_PUBLIC_CUSTOMERS.CUST_RISK is '������ ������ �볺��� �� ���� ��������';
comment on column V_FINMON_PUBLIC_CUSTOMERS.CHECK_DATE is '���� �������� �볺��� �� ���������� ������� �������� �����';
comment on column V_FINMON_PUBLIC_CUSTOMERS.RNK_REEL is 'RNK ���`����� �����';
comment on column V_FINMON_PUBLIC_CUSTOMERS.NMK_REEL is 'ϲ�/����� ���`����� �����';
comment on column V_FINMON_PUBLIC_CUSTOMERS.NUM_REEL is '� ���`��. ����� � ������� �������� ��� (ʲ�)';
comment on column V_FINMON_PUBLIC_CUSTOMERS.COMMENTS is '��������';
comment on column V_FINMON_PUBLIC_CUSTOMERS.KF is '���';
comment on column V_FINMON_PUBLIC_CUSTOMERS.PERSON_BIRTH is '���� ���������� �볺���';
comment on column V_FINMON_PUBLIC_CUSTOMERS.PUBLIC_RELS_BIRTH is '���� ���������� ����� � ������� ʲ�';
comment on column V_FINMON_PUBLIC_CUSTOMERS.PEP_CODE is '����� � ������ ��� (pep.org.ua)';
comment on column V_FINMON_PUBLIC_CUSTOMERS.PEP_BIRTH is '���� ���������� ����� � ������� ���';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/view/v_finmon_public_customers.sql =========*** End *** =
PROMPT ===================================================================================== 
