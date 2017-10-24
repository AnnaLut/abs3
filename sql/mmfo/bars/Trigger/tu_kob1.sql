

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_KOB1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_KOB1 ***

  CREATE OR REPLACE TRIGGER BARS.TU_KOB1 
   BEFORE UPDATE OF OSTC
   ON ACCOUNTS
   REFERENCING FOR EACH ROW
  WHEN (
OLD.tip='KOB' AND NEW.ostc>OLD.ostc
      ) declare
  nazn_  oper.NAZN%type;
  MFOA_  oper.MFOA%type; nTmp_ int;
  NLSA_  oper.NLSA%type;
  REF_   oper.ref%type;
  ACC_   number(38);
  PREF_  varchar2(3);    Len_  int;
BEGIN

 REF_:= gl.aRef;
 ACC_:= :NEW.ACC;

 begin
   -- реквизиты платежa
   select mfoa,NLSA,nazn into MFOA_,NLSA_,NAZN_ from oper where ref=REF_;
 EXCEPTION WHEN NO_DATA_FOUND THEN MFOA_:=null;
 end;

 If MFOA_ is null OR NLSA_ is null or NAZN_ is null then
    -- Пока неизвестно. Отложить проверку, но запомнить РЕФ
    PUL.Set_Mas_Ini('KOB_REF', to_char(REF_), 'Ref для KOB' );
    PUL.Set_Mas_Ini('KOB_ACC', to_char(:old.ACC), 'Acc для KOB' );
    return;
 end if;

 --из невыясненных тоже пока отложимm (по подсказке Шпырки Л.В.)
 If MFOA_= gl.aMFO and NLSA_ like '3720%' then
    return;
 end if;

/*  Перечень Бал.счетов
 4. Оказывается, комиссию надо брать не со всех
    пришедших на счет клиента платежей.
    Надо брать зашедшие со счетов 2902 и, может быть, еще некоторых.
    Необходимо это как-то прописать: или прямо в триггере,
                                         -----------------
   !!! или создать некий справочник. !!!
*/
 If substr(NLSA_,1,4) not in ('2902') then
    RETURN;
 end if;

 -------------------
 -- От др.МФО: ОБ - работаем далее, чужой(КБ) -  выход по NO_DATA_FOUND
 If MFOA_ <>  gl.aMFO then
    BEGIN
      select 1 into nTmp_ from banks where mfo=MFOA_ and mfou=gl.aMFO;
    EXCEPTION WHEN NO_DATA_FOUND THEN    RETURN;
    end;
 end if;
------------------------------------
 begin
    select trim(substr(NAZN,1,3)) into  PREF_ from kob_acc where acc26=ACC_;
    len_ := NVL(length(PREF_),0);
    If Len_=0   OR   substr(NAZN_,1,LEN_) = PREF_ then
       insert into KOB (acc, ref1,otm) values (ACC_,REF_,1);
    else
       insert into KOB (acc, ref1,otm) values (ACC_,REF_,0);
    end if;
 EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
           WHEN NO_DATA_FOUND    THEN null;
 end;
END tu_KOB1;



/
ALTER TRIGGER BARS.TU_KOB1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_KOB1.sql =========*** End *** ===
PROMPT ===================================================================================== 
