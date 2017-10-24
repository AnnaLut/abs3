

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_KOB2.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_KOB2 ***

  CREATE OR REPLACE TRIGGER BARS.TU_KOB2 
  BEFORE UPDATE OF MFOA ON "BARS"."OPER"
  REFERENCING FOR EACH ROW
    WHEN (
OLD.mfoa is null AND NEW.mfoa is not null or
      OLD.nazn is null AND NEW.nazn is not null
      ) declare
  REF_ oper.REF%type;
  ACC_ accounts.ACC%type;
  MFOA_  oper.MFOA%type ; nTmp_ int ;
  NLSA_  oper.NLSA%type ;
  nazn_  oper.NAZN%type ;
  PREF_  varchar2(3)    ; Len_  int ;
BEGIN

--logger.info('KOB-1 nazn='|| :new.nazn ||'  mfoa='|| :new.mfoa);
  MFOA_ := :NEW.MFOA;
  NLSA_ := :NEW.NLSA;
  NAZN_ := :NEW.NAZN;
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

  ref_ := TO_NUMBER(pul.Get_Mas_Ini_Val('KOB_REF'));

--logger.info('KOB-2 ref='|| ref_|| ' gl.Aref='|| gl.Aref);

  -- Наш ли это реф ?
  If gl.Aref <> ref_ then RETURN;
  end if;

  acc_:= TO_NUMBER(pul.Get_Mas_Ini_Val('KOB_ACC'));
--KOB_P (2, acc_, ref_,:new.nazn, :new.mfoa,:new.NLSA );

--logger.info('KOB-3 acc='|| acc_);

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

--logger.info('KOB-4 pr='|| pref_);

     len_ := NVL(length(PREF_),0);

--logger.info('KOB-5 len='|| len_|| ' ' || substr(NAZN_,1,LEN_)|| ' = '|| PREF_ );

     If Len_=0   OR   substr(NAZN_,1,LEN_) = PREF_ then

        update kob set otm=1 where acc=acc_ and ref1=REF_;
        if SQL%rowcount = 0 then
           insert into KOB (acc, ref1,otm) values (ACC_,REF_,1);
        end if;

     else
        insert into KOB (acc, ref1,otm) values (ACC_,REF_,0);

     end if;
  EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
            WHEN NO_DATA_FOUND    THEN null;
  end;
END tu_KOB2;


/
ALTER TRIGGER BARS.TU_KOB2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_KOB2.sql =========*** End *** ===
PROMPT ===================================================================================== 
