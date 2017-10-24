

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_STAFFBAX.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_STAFFBAX ***

  CREATE OR REPLACE TRIGGER BARS.TU_STAFFBAX 
after update of bax on staff$base
for each row
begin

    insert into sec_user_io(id,io_mode,io_date, branch)
	values (:new.id, :new.bax, sysdate, :new.branch);

end tu_staffbax;
/
ALTER TRIGGER BARS.TU_STAFFBAX ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_STAFFBAX.sql =========*** End ***
PROMPT ===================================================================================== 
