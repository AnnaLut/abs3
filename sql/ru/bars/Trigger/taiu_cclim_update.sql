

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCLIM_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCLIM_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCLIM_UPDATE 
after insert or delete or update
of ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, KF, SUMK, NOT_SN
on bars.cc_lim
for each row
declare
  l_bankdate   cc_lim_update.effectdate%type;
  l_chgaction  cc_lim_update.chgaction%type;
  l_idupd      cc_lim_update.idupd%type;
begin

  l_bankdate := bars.gl.bd;

  if ( l_bankdate is null )
  then
     select to_date(val,'mm/dd/yyyy')
       into l_bankdate
       from params
      where par='BANKDATE';
  end if;

  if deleting
  then

    l_chgaction:= 'D';

    insert into CC_LIM_UPDATE
      ( IDUPD, CHGACTION, EFFECTDATE, CHGDATE, DONEBY,
        ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, KF, SUMK, NOT_SN )
    values
      ( s_CCLIM_update.nextval, l_chgaction, l_bankdate, sysdate, user_id,
        :old.ND, :old.FDAT, :old.LIM2, :old.ACC, :old.NOT_9129, :old.SUMG, :old.SUMO, :old.OTM, :old.KF, :old.SUMK, :old.NOT_SN );
  else

    if updating
    then

      if (:old.FDAT <> :new.FDAT)
      then -- якщо зм≥нюЇтьс€ значенн€ в пол≥ FDAT що входить в PRIMARY KEY
           -- породжуЇмо запис про видаленн€ запису ≥з старим FDAT ≥ вставку з новим FDAT
           -- дл€ правильного в≥дображенн€ при вивантаженн≥ ≥нф. до DWH

        l_chgaction:= 'D';

        insert into CC_LIM_UPDATE
          ( IDUPD, CHGACTION, EFFECTDATE, CHGDATE, DONEBY,
            ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, KF, SUMK, NOT_SN )
        values
          ( s_CCLIM_update.nextval, l_chgaction, l_bankdate, sysdate, user_id,
            :old.ND, :old.FDAT, :old.LIM2, :old.ACC, :old.NOT_9129, :old.SUMG, :old.SUMO, :old.OTM, :old.KF, :old.SUMK, :old.NOT_SN );

        l_chgaction:= 'I';

      else

        l_chgaction:= 'U';

      end if;

    else

      l_chgaction:= 'I';

    end if;

    insert into CC_LIM_UPDATE
      ( IDUPD, CHGACTION, EFFECTDATE, CHGDATE, DONEBY,
        ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, KF, SUMK, NOT_SN )
    values
      ( s_CCLIM_update.nextval ,l_chgaction, l_bankdate, sysdate, user_id,
        :new.ND, :new.FDAT, :new.LIM2, :new.ACC, :new.NOT_9129, :new.SUMG, :new.SUMO, :new.OTM, :new.KF, :new.SUMK, :new.NOT_SN );

   end if;
end;
/
ALTER TRIGGER BARS.TAIU_CCLIM_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCLIM_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
