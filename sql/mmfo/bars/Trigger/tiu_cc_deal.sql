

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CC_DEAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CC_DEAL ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CC_DEAL before insert or update
  ON BARS.CC_DEAL for each row
DECLARE
  nd_ int;  ret_ int;  erm varchar2 (1024);
begin
/*
   06-07-2011 Сухова. Добавила.
   Перенос класса заемщика из карточки клиента в карточку КД
   cc_deal.FIN
*/
 If :NEW.FIN is null     then
    select crisk into :NEW.FIN from customer where rnk = :NEW.RNK ;
 end if;
 If :NEW.FIN23 is null     then
  begin
    select c.crisk into :NEW.FIN23 from customer c, stan_fin f  where c.rnk = :NEW.RNK and c.crisk = F.FIN;
  exception when NO_DATA_FOUND then
    null; -- Нет соответсвия поэтому ничего не ставим
  end;
 end if;
:NEW.OBS:=:NEW.OBS23;
:NEW.FIN:=:NEW.FIN23;
 -----------------
 if inserting then
    if :NEW.ND is null then
       select bars_sqnc.get_nextval('S_CC_DEAL') into :NEW.ND from dual;
    end if;
    if :NEW.SDATE   is null then :NEW.SDATE   := gl.BDATE; end if;
    if :NEW.USER_ID is null then :NEW.USER_ID := gl.aUID ; end if;
    if :NEW.VIDD    is null then :NEW.VIDD    := 11      ; end if;
    if :NEW.sos     is null then :NEW.sos     := 0       ; end if;
    if :NEW.RNK     is null then :NEW.RNK     := 0       ; end if;
 end if;
 ----------------
 if updating then
    if :NEW.vidd not in (3,13) and :OLD.vidd in (3,13) then
       select count(kv) into ret_
       from (select kv from nd_acc n, accounts a
             where n.nd=:OLD.ND and a.acc=n.acc and a.dazs is null
               and a.tip in ('SS ','SP ','SL ')
             group by kv     );
       if ret_>1 then
          erm := 'CCK: Есть Мульти-Вал. транши по КД, реф=' || :OLD.ND;
          raise_application_error(-(20000+111),'\' ||erm,TRUE);
       end if;
    end if;
 end if;
 -----------------
end tiu_cc_DEAL;


/
ALTER TRIGGER BARS.TIU_CC_DEAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CC_DEAL.sql =========*** End ***
PROMPT ===================================================================================== 
