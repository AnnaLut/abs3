
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/trigger/tbir_oper_teller.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TRIGGER BARS.TBIR_OPER_TELLER 
  before insert
  on OPER 
  for each row
 declare
     v_err varchar2(2000);
     v_ret integer;
     v_sql varchar2(2000);
 begin
      begin
        v_sql := 'begin :1 := teller_tools.check_doc('''||:new.tt||''','||:new.s||','||nvl(:new.sq,0)||','''||:new.kv||''','||:new.ref||', '||:new.dk||', '''||:new.nlsa||''', '''||:new.nlsb||''', :2); end;';
        bars_audit.info('Teller: start check ('||v_sql||')');
        execute immediate v_sql using out v_ret, out v_err;
      exception when others then
        bars_audit.info('Teller: check error = '||sqlerrm);
        v_ret := 0;
      end;
      bars_audit.info('Teller: result check ('||v_ret||','||v_err||')');
      case v_ret
        when -1 then
          bars_error.raise_nerror('TEL','TELL_DOC1',v_err);
        when -2 then
          bars_error.raise_nerror('TEL','TELL_DOC2',v_err);
        when -3 then
          bars_error.raise_nerror('TEL','TELL_DOC3',v_err);
        when -4 then
          bars_error.raise_nerror('TEL','TELL_DOC2',v_err);
        else
          null;
      end case;
  
end tbir_oper_teller;

/
ALTER TRIGGER BARS.TBIR_OPER_TELLER ENABLE;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/trigger/tbir_oper_teller.sql =========*** En
 PROMPT ===================================================================================== 
 