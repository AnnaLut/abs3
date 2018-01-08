

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_CP_ARCH.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_CP_ARCH ***

  CREATE OR REPLACE TRIGGER BARS.TAI_CP_ARCH AFTER insert ON CP_ARCH FOR EACH ROW

/* Добавление полей в CP_DEAL для ГОУ
   Создан: 30-01-2014  Срок: 21/фев/14
   Исходная оценка:	 3d
   Банк:	 Sberbank
   Добавить такие колонки в cp_deal

1) Код портфеля
2) Тип помещения (1 - покупка, 3 - перемещение)
3) Дата заключения договора

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
