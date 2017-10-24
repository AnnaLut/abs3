

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_TABVAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_TABVAL ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_TABVAL 

instead of insert or update or delete ON TABVAL for each row

begin

    if sys_context('bars_context','user_branch')='/' then

        -- в корне модифицируем только глобальную часть

        if inserting then

            insert into tabval$global (kv, grp, name, lcv, nominal, sv,

                 dig, unit, country, basey, gender, prv, d_close)

            values (:new.kv, :new.grp, :new.name, :new.lcv, :new.nominal, :new.sv,

                 :new.dig, :new.unit, :new.country, :new.basey, :new.gender, :new.prv, :new.d_close);

        elsif updating then

            update tabval$global

            set grp  = :new.grp, name = :new.name,  lcv     = :new.lcv,

                nominal = :new.nominal, sv= :new.sv,dig     = :new.dig,

                unit = :new.unit,  country= :new.country,

                basey= :new.basey, gender = :new.gender, d_close= :new.d_close

            where  kv= :old.kv;

        elsif deleting then

            delete from tabval$global where kv=:old.kv;

        end if;

    else

        if updating then

            -- в филиалах модифицируем только локальную часть

            update tabval$local set

                skv   = :new.skv,  s0000 = :new.s0000, s3800 = :new.s3800,

                s3801 = :new.s3801,s3802 = :new.s3802, s6201 = :new.s6201,

                s7201 = :new.s7201,s9282 = :new.s9282, s9280 = :new.s9280,

                s9281 = :new.s9281,s0009 = :new.s0009, g0000 = :new.g0000

            where kv=:new.kv;

            if sql%rowcount=0 then

                insert into tabval$local (kv, skv, s0000, s3800, s3801, s3802,

                   s6201, s7201, s9282, s9280, s9281, s0009, g0000)

                values ( :new.kv, :new.skv, :new.s0000, :new.s3800, :new.s3801,

                  :new.s3802,:new.s6201, :new.s7201, :new.s9282, :new.s9280,

                  :new.s9281, :new.s0009,:new.g0000);

            end if;

        end if;

    end if;

end;

/
ALTER TRIGGER BARS.TIUD_TABVAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_TABVAL.sql =========*** End ***
PROMPT ===================================================================================== 
