

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBD_MONEXR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBD_MONEXR ***

  CREATE OR REPLACE TRIGGER BARS.TBD_MONEXR 
   BEFORE DELETE
   ON BARS.MONEXR
   FOR EACH ROW
declare
 sid_    varchar2(64);
begin

sid_:=monex.show_monex_ctx('CLEARING');

 begin
      select sid into sid_ from v$session
       where sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
       bars_audit.info('CLEARING, DELETE_FILE: Процедура Клірингу вже запущена SID '|| sid_);
      raise_application_error(-20112,'Процедура Клірингу вже запущена SID '|| sid_||' Вилучати ФАЙЛ НЕ МОЖНА!');
   exception
      when no_data_found THEN NULL;
   end;       
      

end;
/
ALTER TRIGGER BARS.TBD_MONEXR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBD_MONEXR.sql =========*** End *** 
PROMPT ===================================================================================== 
