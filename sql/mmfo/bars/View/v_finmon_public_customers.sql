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
       to_char(r.birth, 'dd.mm.yyyy') as public_rels_birth
from finmon_public_customers c
     left join person p on p.rnk = c.rnk
     left join finmon_public_rels r on r.id = c.num_reel;

PROMPT *** Create comments on bars.v_finmon_public_customers ***

comment on table bars.v_finmon_public_customers                    is '������ �������� �볺��� - �������� �����';
comment on column bars.v_finmon_public_customers.id                is '��������� ���';
comment on column bars.v_finmon_public_customers.rnk               is '������������ ����� �볺��� � ��';
comment on column bars.v_finmon_public_customers.nmk               is '������������ �볺��� � ��';
comment on column bars.v_finmon_public_customers.crisk             is '�������� ������ �볺��� �� ���� ��������';
comment on column bars.v_finmon_public_customers.cust_risk         is '������ ������ �볺��� �� ���� ��������';
comment on column bars.v_finmon_public_customers.check_date        is '���� �������� �볺��� �� ���������� ������� �������� �����';
comment on column bars.v_finmon_public_customers.rnk_reel          is 'RNK ���`����� �����';
comment on column bars.v_finmon_public_customers.nmk_reel          is 'ϲ�/����� ���`����� �����';
comment on column bars.v_finmon_public_customers.num_reel          is '� ���`��. ����� � ������� �������� ���';
comment on column bars.v_finmon_public_customers.comments          is '��������';
comment on column bars.v_finmon_public_customers.kf                is '���';
comment on column bars.v_finmon_public_customers.person_birth      is '���� ���������� �볺���';
comment on column bars.v_finmon_public_customers.public_rels_birth is '���� ���������� ����� � ������� ���';

PROMPT *** Create  grants  v_finmon_public_customers ***

grant select on bars.v_finmon_public_customers to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/view/v_finmon_public_customers.sql =========*** End *** =
PROMPT ===================================================================================== 
