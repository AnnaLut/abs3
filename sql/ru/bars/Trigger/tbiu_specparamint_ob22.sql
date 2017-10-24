

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_SPECPARAMINT_OB22.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_SPECPARAMINT_OB22 ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_SPECPARAMINT_OB22 
before insert or update of ob22
  ON BARS.SPECPARAM_INT   for each row
declare
  l_nbs      accounts.nbs%type;
  l_ob22     sb_ob22.ob22%type;
  l_d_open   sb_ob22.d_open%type;
  l_d_close  sb_ob22.d_close%type;
  l_count    number;
begin
   select nbs into l_nbs from accounts where acc = :new.acc and nbs is not null;
   if :new.ob22 is not null and (:old.ob22 is null or :new.ob22<>:old.ob22) then
      -- для счетов 1-7,9кл. ищем в sb_ob22
      if substr(l_nbs, 1, 1) <> '8' then
         begin
            select distinct ob22, d_open, d_close
              into l_ob22, l_d_open, l_d_close
              from sb_ob22
             where r020 = l_nbs
               and ob22 = :new.ob22;

            if l_d_open > gl.bd then
               raise_application_error(-20000, 'Код OB22 "'||:new.ob22||'" для бал.рах. "'||l_nbs||'" діє з '||to_char(l_d_open, 'dd.MM.yyyy'), true);
            end if;

            if l_d_close is not null and l_d_close <= gl.bd then
               raise_application_error(-20000, 'Код OB22 "'||:new.ob22||'" для бал.рах. "'||l_nbs||'" закрито з '||to_char(l_d_close, 'dd.MM.yyyy'), true);
            end if;

         exception when no_data_found then
            raise_application_error(-20000, 'Код OB22 "'||:new.ob22||'" для бал.рах. "'||l_nbs||'" не знайдений в довіднику', true);
         end;
      end if;
   end if;
exception when no_data_found then null;
end tbiu_specparamint_ob22;
/
ALTER TRIGGER BARS.TBIU_SPECPARAMINT_OB22 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_SPECPARAMINT_OB22.sql =========
PROMPT ===================================================================================== 
