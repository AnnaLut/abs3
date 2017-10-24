

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_SKRYNKA_TARIFF2.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_SKRYNKA_TARIFF2 ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_SKRYNKA_TARIFF2 
AFTER INSERT OR UPDATE
ON SKRYNKA_TARIFF2
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
declare
l_id number;
l_tarif number;
BEGIN


  select etalon_id
    into l_id
    from skrynka_tip s, SKRYNKA_TARIFF t
   where s.o_sk = T.O_SK
     and T.TARIFF = :new.TARIFF;


     if nvl(l_id,0) = 0 then
       raise_application_error (- (20777), '\'|| '     Для виду ячейки не прописано код еталонної ячейки', TRUE);
     end if;


 select v.TARIFF_AMOUNT
   into l_tarif
   from SKRYNKA_TIP_ETALON s,
        SKRYNKA_ETALON_TARIFF p,
        SKRYNKA_ETALON_TARIFF_value v
  where S.id = P.etalon_id
    and p.id = v.TARIFF_ID
    and s.id = l_id
    and (P.DAYS_COUNT, P.ID) in (select min(DAYS_COUNT), P.ID from SKRYNKA_ETALON_TARIFF where days_count >= :new.DAYSTO)
    and (TARIFF_ID, APPLY_DATE) in (select TARIFF_ID, max(APPLY_DATE) from SKRYNKA_ETALON_TARIFF_value where APPLY_DATE <= :new.TARIFF_DATE  group by TARIFF_ID);


  if l_tarif > :new.S then
       raise_application_error (- (20777), '\'|| '     Встановлення тарифу менше Мінімального тарифи з надання в оренду індивідуальних сейфів АТ "Ощадбанк" заборонено', TRUE);
  else null;
  end if;


END ;
/
ALTER TRIGGER BARS.TAIU_SKRYNKA_TARIFF2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_SKRYNKA_TARIFF2.sql =========**
PROMPT ===================================================================================== 
