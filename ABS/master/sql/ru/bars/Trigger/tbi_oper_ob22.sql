

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_OB22.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPER_OB22 ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPER_OB22 
BEFORE INSERT
ON BARS.OPER REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
  OB22_  PS_TTS.ob22%TYPE  ;
  NBSD_  accounts.nbs%TYPE ;
  NBSK_  accounts.nbs%TYPE ;
  NLSD_  accounts.nls%TYPE ;
  NLSK_  accounts.nls%TYPE ;
  KVD_   accounts.KV%TYPE  ;
  KVK_   accounts.KV%TYPE  ;
  nTmp_  int;
ern  CONSTANT POSITIVE := 803 ;
err  EXCEPTION;
erm  VARCHAR2(250);

begin
-- временно !!! - до внесения аналога в GL (Миша)
gl.aRef := :new.REF;
---------------
   if :new.TT not like 'M__' AND :new.TT NOT IN
      ('139','BMY','BMU','BMF','016','025','401','402','403','404','406')
      then
      return;
   end if;
   -----------------

   If :new.dk = 0 then
      If :new.mfoa=gl.aMFO then
         NLSK_:= :new.nlsa;
         KVK_ := :new.kv;
         If :new.mfob=gl.aMFO then
            NLSD_:= :new.nlsb;
            KVD_ := Nvl(:new.kv2,:new.kv);
         end if;
      end if;
   else
      If :new.mfoa=gl.aMFO then
         NLSD_:= :new.nlsa;
         KVD_ := :new.kv;
         If :new.mfob=gl.aMFO then
            NLSK_:= :new.nlsb;
            KVK_ := Nvl(:new.kv2,:new.kv);
         end if;
      end if;
   end if;
   NBSD_:= substr(NLSD_,1,4);  NBSK_:= substr(NLSK_,1,4);

   begin
      -- контролируется Ли дебет ?
      select ob22 into OB22_  from PS_TTS
      where tt=:new.TT and dk=0 and nbs=NBSD_
        and ob22 is not null and rownum=1 and NBSD_ is not null;
      begin
         -- ДА !
         SELECT 1 into nTmp_  FROM specparam_int s, accounts a, PS_TTS p
         WHERE a.acc=s.acc and a.nls=NLSD_ and a.kv=KVD_
           and s.ob22=p.OB22 and p.dk=0 and p.nbs=NBSD_ and p.tt=:new.TT;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         erm := '     Ошиб.ОБ22 для счета ДЕБЕТ - ' || NLSD_;
         RAISE err;
      end;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
      -- НЕТ !
   end;

   begin
      -- контролируется Ли кредит ?
      select ob22 into OB22_  from PS_TTS
      where tt=:new.TT and dk=1 and nbs=NBSK_
        and ob22 is not null and rownum=1 and NBSK_ is not null;
      begin
         -- ДА !
         SELECT 1 into nTmp_
         FROM specparam_int s, accounts a, PS_TTS p
         WHERE a.acc=s.acc and a.nls=NLSK_ and a.kv=KVK_
           and s.ob22=p.OB22 and p.dk=1 and p.nbs=NBSK_ and p.tt=:new.TT;

      EXCEPTION WHEN NO_DATA_FOUND THEN
         erm := '     Ошиб.ОБ22 для счета КРЕДИТ - ' || NLSK_;
         RAISE err;
      end;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
      -- НЕТ !
   end;

   RETURN ;

EXCEPTION
 WHEN err    THEN raise_application_error(-(20000+ern),'\'||erm,TRUE);
 WHEN OTHERS THEN raise_application_error(-(20000+ern),SQLERRM,TRUE);

END tbi_oper_OB22 ;
/
ALTER TRIGGER BARS.TBI_OPER_OB22 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_OB22.sql =========*** End *
PROMPT ===================================================================================== 
