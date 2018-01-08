

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_CPPEREOCV.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_CPPEREOCV ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_CPPEREOCV 
  INSTEAD OF INSERT OR DELETE OR UPDATE ON "BARS"."CP_PEREOC_V"
  REFERENCING FOR EACH ROW
declare
   ern          CONSTANT POSITIVE := 746;    -- Trigger err code
   err          EXCEPTION;
   erm          VARCHAR2(80) := 'No INSERT allowed';
begin
   if inserting then  return;    end if;
   ------------------------------------
 --  delete from cp_rates_sb where ref = :old.ref;
   if updating then
      if     :new.rate_b   != :old.rate_b  or :new.fl_alg != :old.fl_alg
         or (:old.rate_b is NULL  and :new.rate_b is not NULL)
         or (:new.rate_b is NULL  and :old.rate_b is not NULL) then

         delete from cp_rates_sb where ref = :old.ref;
         -- котировка на угоду
         insert into cp_rates_sb  (     ref,      rate_b,      quot_sign,      fl_alg)
                           values (:old.ref, :new.rate_b, :new.quot_sign, :new.fl_alg);
      end if;
      if    :new.rez23    != :old.rez23
         or :new.fl_alg23 is not null or :new.pereoc23 is not null
         or (:old.rez23 is NULL  and :new.rez23 is not NULL)
         or (:new.rez23 is NULL  and :old.rez23 is not NULL) then
         delete from cp_rezerv23 where ref = :old.ref;         
         if :new.rez23 is not null or :new.fl_alg23 is not null or :new.pereoc23 is not null THEN
            logger.info('REZ_CP23-1 :new.pereoc23='|| :new.pereoc23) ;
            cp_rez23(:new.DATREZ23, :new.REF, :new.REZ23, :new.KOL_CP, :new.pereoc23, :new.fl_alg23);
         end if;
      end if;
   end if;
end;
/
ALTER TRIGGER BARS.TIUD_CPPEREOCV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_CPPEREOCV.sql =========*** End 
PROMPT ===================================================================================== 
