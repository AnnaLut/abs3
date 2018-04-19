PROMPT *** Create  trigger TAU_OPER_KOMIS_NON_CASH ***

create or replace trigger TAU_OPER_KOMIS_NON_CASH
after insert on OPER
for each row
WHEN ( new.TT = 'R01'         -- ������
   and new.KV = 980           -- ���.������
   and new.DK = 1             -- �����������
   and new.NLSB like '2620%'  -- ������ ���. / �������� �������� ��
   and new.MFOA not like '8%' -- �� �� ������������
   and new.PDAT >= trunc(sysdate)
     )
begin

  insert -- ��������� �������� � ������� �� ������ ��������
    into KOMIS_NON_CASH (ref)
  values (:new.ref);

end TAU_OPER_KOMIS_NON_CASH;
/

show errors;
