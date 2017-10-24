

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_VCENTRKUBM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_VCENTRKUBM ***

  CREATE OR REPLACE TRIGGER BARS.TU_VCENTRKUBM 
   INSTEAD OF UPDATE
ON v_centr_kubm REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW

/* 03.06.2011 Сухова.
   Для поддержки справочника курсов изделий из БМ
   - добавка новых записей,
   - синхронизация с ЦА
   - изменение локальных
*/
declare
   l_branch BANK_METALS$LOCAL.branch%type ;
   l_cena   BANK_METALS$LOCAL.cena%type   ;
   l_cena_k BANK_METALS$LOCAL.cena_k%type ;
BEGIN

   If :old.branch is null and :new.branch is null and :new.otm is null then
      -- ничего НЕ делать
      RETURN;
   end if;
   ------------
   If :old.branch is NOT null and :new.branch is null then
      -- удалить запись
      delete from BANK_METALS$LOCAL where kod= :old.kod and branch= :old.branch;
      RETURN;
   end if;
   -----------------------------
   If :NEW.otm=1 then
      -- взять курсы ЦА
      l_cena   := nvl(:new.cena_prod,:new.cena   ) ;
      l_cena_k := nvl(:new.cena_kupi,:new.cena_k ) ;
   else
      -- изменить свои курсы
      l_cena   := :new.cena    ;
      l_cena_k := :new.cena_k  ;
    end if;
   -----------------------------
    l_cena   := l_cena   * 100 ;
    l_cena_k := l_cena_k * 100 ;
   -----------------------------

    -- по умолчанию - бранч пользователя
    l_branch := Nvl(:new.branch, sys_context('bars_context','user_branch') );

    If :old.branch = l_branch then
       -- для существующей записи
       update BANK_METALS$LOCAL set cena   = l_cena, cena_k = l_cena_k
        where kod    = :old.kod and branch = :old.branch;
       RETURN;
    end if;
   -----------------------------
   -- для нового бранча (вставка)
   begin
     insert into BANK_METALS$LOCAL (   cena,   cena_k,      kod,   branch , branch_old)
                            values ( l_cena, l_cena_k, :new.kod, l_branch , l_branch);
   EXCEPTION WHEN DUP_VAL_ON_INDEX THEN  NULL;
   end;

END tu_vcentrkubm ;



/
ALTER TRIGGER BARS.TU_VCENTRKUBM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_VCENTRKUBM.sql =========*** End *
PROMPT ===================================================================================== 
