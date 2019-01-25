
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/sequence/s_teller_oper_history_id.sql ======
 PROMPT ===================================================================================== 

declare 
  v_num integer;
begin
  select count(1) into v_num  from user_sequences where sequence_name = 'S_TELLER_OPER_HISTORY_ID';
  if v_num = 0 then
    execute immediate 'CREATE SEQUENCE  BARS.S_TELLER_OPER_HISTORY_ID  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ';
  end if;
end;
/
 
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/sequence/s_teller_oper_history_id.sql ======
 PROMPT ===================================================================================== 
 