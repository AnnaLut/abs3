

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_OPER_VISA_NAME.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_OPER_VISA_NAME ***

  CREATE OR REPLACE TRIGGER BARS.TI_OPER_VISA_NAME 
before insert on oper_visa for each row
declare
  username_	varchar2(60);
  usertabn_	varchar2(10);
  groupname_	varchar2(50);
begin


  begin
    select fio, tabn
    into username_, usertabn_
    from staff$base
    where id=:new.userid;
  exception when no_data_found then
    username_ := '' ;
    usertabn_ := '' ;
  end;

  begin
    select name
    into groupname_
    from chklist
    where idchk=:new.groupid;
  exception when no_data_found then
    groupname_ := '' ;
  end;

  :new.username  := username_ ;
  :new.usertabn  := usertabn_ ;
  :new.groupname := groupname_ ;

end;
/
ALTER TRIGGER BARS.TI_OPER_VISA_NAME ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_OPER_VISA_NAME.sql =========*** E
PROMPT ===================================================================================== 
