

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_GUARD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_GUARD ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_GUARD 
before update of
  nd,datd,dk,mfoa,nlsa,kv,s,mfob,nlsb,kv2,s2
ON BARS.OPER for each row
-- триггер срабатывает только для уже подписанных внутренней подписью документов
 WHEN (
new.signed='Y'
      ) declare
	err          EXCEPTION;
	erm          VARCHAR2(80);
begin

  	if :old.nd <> :new.nd
  	or :old.nd is not null and :new.nd is     null
  	or :old.nd is     null and :new.nd is not null
  	then
  	  -- 'ND (Номер документа)';
          erm := 'GUARD_ND';
  	  raise err;
  	end if;
  	if :old.datd <> :new.datd
  	or :old.datd is not null and :new.datd is     null
  	or :old.datd is     null and :new.datd is not null
  	then
  	  -- 'DATD (Дата документа)';
          erm := 'GUARD_DATD';
  	  raise err;
  	end if;
  	if :old.dk <> :new.dk
  	or :old.dk is not null and :new.dk is     null
  	or :old.dk is     null and :new.dk is not null
  	then
  	  -- 'DK (Признак дебет/кредит)';
          erm := 'GUARD_DK';
  	  raise err;
  	end if;
  	if :old.mfoa <> :new.mfoa
  	or :old.mfoa is not null and :new.mfoa is     null
  	or :old.mfoa is     null and :new.mfoa is not null
  	then
  	  -- 'MFOA (МФО отправителя)';
          erm := 'GUARD_MFOA';
  	  raise err;
  	end if;
  	if :old.nlsa <> :new.nlsa
  	or :old.nlsa is not null and :new.nlsa is     null
  	or :old.nlsa is     null and :new.nlsa is not null
  	then
  	  -- 'NLSA (Счет отправителя)';
          erm := 'GUARD_NLSA';
  	  raise err;
  	end if;
  	if :old.kv <> :new.kv
  	or :old.kv is not null and :new.kv is     null
  	or :old.kv is     null and :new.kv is not null
  	then
  	  -- 'KV (Валюта А)';
          erm := 'GUARD_KV';
  	  raise err;
  	end if;
  	if :old.s <> :new.s
  	or :old.s is not null and :new.s is     null
  	or :old.s is     null and :new.s is not null
  	then
  	  -- 'S (Сумма)';
          erm := 'GUARD_S';
  	  raise err;
  	end if;
  	if :old.mfob <> :new.mfob
  	or :old.mfob is not null and :new.mfob is     null
  	or :old.mfob is     null and :new.mfob is not null
  	then
  	  -- 'MFOB (МФО получателя)';
          erm := 'GUARD_MFOB';
  	  raise err;
  	end if;
  	if :old.nlsb <> :new.nlsb
  	or :old.nlsb is not null and :new.nlsb is     null
  	or :old.nlsb is     null and :new.nlsb is not null
  	then
  	  -- 'NLSB (Счет получателя)';
          erm := 'GUARD_NLSB';
  	  raise err;
  	end if;
  	if :old.kv2 <> :new.kv2
  	or :old.kv2 is not null and :new.kv2 is     null
  	or :old.kv2 is     null and :new.kv2 is not null
  	then
  	  -- 'KV2 (Валюта Б)';
          erm := 'GUARD_KV2';
  	  raise err;
  	end if;
  	if :old.s2 <> :new.s2
  	or :old.s2 is not null and :new.s2 is     null
  	or :old.s2 is     null and :new.s2 is not null
  	then
  	  -- 'S2 (Сумма 2)';
          erm := 'GUARD_S2';
  	  raise err;
  	end if;
exception when err then
  -- 'Модификация реквизита '||erm||' запрещена системой. Документ подписан.';
  --bars_error.raise_nerror('BRS', erm);
  raise_application_error(-20000, 'Попытка модификации реквизита '''||erm||''', ref='||:new.ref, true);
end; 
/
ALTER TRIGGER BARS.TU_OPER_GUARD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_GUARD.sql =========*** End *
PROMPT ===================================================================================== 
