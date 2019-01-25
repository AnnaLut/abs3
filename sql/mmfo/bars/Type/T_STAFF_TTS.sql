
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_staff_tts.sql =========*** Run *** ==
 PROMPT ===================================================================================== 

declare
  v_num integer;
begin
  select count(1) into v_num
    from user_types 
    where type_name = 'T_STAFF_TTS';
  if v_num = 0 then
    execute immediate 'CREATE OR REPLACE TYPE BARS.T_STAFF_TTS force as object (tt varchar2(3), id number(38), approve number(1), adate1 date, adate2 date, rdate1 date, rdate2 date, revoked number(1), grantor number(38))';
  end if;
end;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_staff_tts.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 