

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_DPTPROCDR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_DPTPROCDR ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_DPTPROCDR 
INSTEAD OF INSERT OR UPDATE OR DELETE ON v_dpt_proc_dr FOR EACH ROW
DECLARE
  l_kf  banks.mfo%type := sys_context('bars_context', 'user_mfo');
  sour_ proc_dr$base.sour%type :=4;
BEGIN

  IF INSERTING THEN

     insert into proc_dr$base (nbs     ,g67,     v67,     sour, nbsn,     g67n,     v67n,     rezid,     io,     branch,     kf)
                       values (:new.nbs,:new.g67,:new.g67,sour_,:new.nbsn,:new.g67n,:new.g67n,:new.rezid,:new.io,:new.branch,l_kf);

  ELSIF UPDATING THEN

       UPDATE proc_dr$base
         SET nbs    = :new.nbs,
             g67    = :new.g67,
             v67    = :new.g67,
             nbsn   = :new.nbsn,
             g67n   = :new.g67n,
             v67n   = :new.g67n,
             rezid  = :new.rezid,
             branch = :new.branch,
             io     = :new.io
       WHERE branch = :old.branch
         AND rezid  = :old.rezid
         AND nbs    = :old.nbs
         AND sour   = sour_
         AND kf     = l_kf;

  ELSIF DELETING THEN

    DELETE FROM proc_dr$base
          WHERE branch = :old.branch
            AND rezid  = :old.rezid
            AND nbs    = :old.nbs
            AND sour   = sour_
            AND kf     = l_kf;



  END IF;

END;




/
ALTER TRIGGER BARS.TIUD_DPTPROCDR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_DPTPROCDR.sql =========*** End 
PROMPT ===================================================================================== 
