

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_CP_ARCH.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_CP_ARCH ***

  CREATE OR REPLACE TRIGGER BARS.TAI_CP_ARCH AFTER insert ON CP_ARCH FOR EACH ROW

/* ���������� ����� � CP_DEAL ��� ���
   ������: 30-01-2014  ����: 21/���/14
   �������� ������:	 3d
   ����:	 Sberbank
   �������� ����� ������� � cp_deal

1) ��� ��������
2) ��� ��������� (1 - �������, 3 - �����������)
3) ���� ���������� ��������

*/

BEGIN
  update cp_deal E set E.op     = :new.op     ,
                       E.DAT_UG = :new.DAT_UG ,
                       E.pf     = (SELECT v.pf
                                   FROM cp_kod k, accounts a, accounts p, cp_vidd v
                                   WHERE v.vidd IN ( SUBSTR(a.nls,1,4), NVL(SUBSTR(p.nls,1,4),''))
                                     AND k.ID = E.ID AND a.acc = E.acc AND p.acc(+) = E.accp AND v.emi = k.emi )
  where E.ref = :new.ref;

end TaI_CP_ARCH;


/
ALTER TRIGGER BARS.TAI_CP_ARCH DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_CP_ARCH.sql =========*** End ***
PROMPT ===================================================================================== 
