

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBD_SWIMTILIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBD_SWIMTILIST ***

  CREATE OR REPLACE TRIGGER BARS.TBD_SWIMTILIST before delete ON BARS.SWI_MTI_LIST for each row
-- ������� ��� ��������  2909, 2809 �� ������ �������, ���� ���������� ��������� �����.
declare
   l_kol  number;
begin
        BEGIN
           SELECT count(1)
             INTO l_kol
             FROM accounts a
            WHERE     a.nbs||a.ob22  IN ('2909'||:OLD.OB22_2909, '2809'||:OLD.OB22_2809)
                  AND a.dazs IS NULL
                  AND a.ostc <> 0
                  AND a.ostb = a.ostc;
        END;

        if (l_kol > 0) then
           raise_application_error( -20444, '���������� ��������� ���������� ��� ���� � ������ � ���, �� ������� �� �������� 2909,2809 �� �������!', true );
        elsif (l_kol = 0) then
           for cur in (SELECT a.acc
                         FROM accounts a
                         WHERE     a.nbs||a.ob22  IN ('2909'||:OLD.OB22_2909, '2809'||:OLD.OB22_2809)
                                   AND a.dazs IS NULL
                                   AND a.ostc = 0
                                   AND a.ostb = a.ostc)
         loop
         update accounts set dazs = glb_bankdate where acc = cur.acc;
         end loop;
         end if;

end TBD_SWIMTILIST;
/
ALTER TRIGGER BARS.TBD_SWIMTILIST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBD_SWIMTILIST.sql =========*** End 
PROMPT ===================================================================================== 
