

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBD_SWIMTILIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBD_SWIMTILIST ***

  CREATE OR REPLACE TRIGGER BARS.TBD_SWIMTILIST before delete ON BARS.SWI_MTI_LIST for each row
-- триггер для проверки  2909, 2809 на нулевіе остатки, если обнулились закрываем счета.
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
           raise_application_error( -20444, 'Заборонено видалення інформації про СМГП у зв’язку з тим, що залишки по рахунках 2909,2809 не розібрані!', true );
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
