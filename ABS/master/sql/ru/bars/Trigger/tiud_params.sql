

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_PARAMS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_PARAMS ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_PARAMS 
INSTEAD OF INSERT OR UPDATE OR DELETE ON params
FOR EACH ROW
DECLARE
  l_kf banks.mfo%type := sys_context('bars_context', 'user_mfo');
BEGIN

  if l_kf is null then
      raise_application_error(-20000, ' орневым пользовател€м запрещено модифицировать представление PARAMS', true);
  end if;

  IF INSERTING THEN

     insert into params$base (par, val, comm, kf)
     values (:new.par, :new.val, :new.comm, l_kf);

  ELSIF UPDATING THEN

    UPDATE params$base
       SET val  = :new.val,
           comm = :new.comm
     WHERE par  = :old.par
       AND kf = l_kf;

  ELSIF DELETING THEN

    DELETE FROM params$base WHERE par = :old.par AND kf = l_kf;

  END IF;

END;
/
ALTER TRIGGER BARS.TIUD_PARAMS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_PARAMS.sql =========*** End ***
PROMPT ===================================================================================== 
