

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_CLOSE_MFO.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_ARCRRP_CLOSE_MFO ***

  CREATE OR REPLACE TRIGGER BARS.TI_ARCRRP_CLOSE_MFO 
  AFTER INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
new.kv=980 and new.fn_a like '$A%'
      ) declare
  l_mfo_b     banks.mfo%type;
  l_num       number;
begin
  --
  -- триггер служит для блокировки платежей от закрываемых филиалов ВПС
  -- на все банки, кроме ЦА и филиалов ВПС
  --

--   if :new.mfoa in ( 394244,364296,364230,320263,337579,336536 )    -- закрываемые филиалы ВПС
--    then
--      begin
--        select mfo into l_mfo_b from banks
--            where mfo=:new.mfob and mfop<>321024;     -- платежи на НБУ запрещены
--         exception when no_data_found then
--           raise_application_error(-20000, '\0977 - Блокування початкових від учасника забороняє цей платіж', TRUE);
--      end;
--  end if;

  begin
      select 1
        into l_num
        from close_mfo
       where :new.mfoa = mfo
--         and to_date(data_clos||' '||decode(length(time_clos),5,time_clos||':00',time_clos),'DD/MM/YY hh24:mi:ss')
         and to_date(data_clos||' '||time_clos,'DD/MM/YY hh24:mi:ss')
             <= sysdate;
      begin
        select mfo
          into l_mfo_b
          from banks
         where mfo=:new.mfob and mfop<>'321024';     -- платежи на НБУ запрещены
      exception
        when no_data_found then
        raise_application_error(-20000, '\0977 - Блокування початкових від учасника забороняє цей платіж', TRUE);
      end;
  exception when NO_DATA_FOUND then
      NULL;
  end;

end;


/
ALTER TRIGGER BARS.TI_ARCRRP_CLOSE_MFO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_CLOSE_MFO.sql =========***
PROMPT ===================================================================================== 
