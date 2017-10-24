

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_BARS_BOARD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_BARS_BOARD ***

  CREATE OR REPLACE TRIGGER BARS.TI_BARS_BOARD 
  before insert on bars_board
  for each row
begin
  select s_bars_board.nextval into :new.id from dual;
end ti_bars_board;
/
ALTER TRIGGER BARS.TI_BARS_BOARD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_BARS_BOARD.sql =========*** End *
PROMPT ===================================================================================== 
