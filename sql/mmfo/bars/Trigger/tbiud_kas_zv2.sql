

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_ZV2.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_KAS_ZV2 ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_KAS_ZV2 
   INSTEAD OF UPDATE OR INSERT OR DELETE
   ON BARS.KAS_ZV2 REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
declare
  kodv_ int;  branch_ branch.BRANCH%type;  dat2_ date;  KV_ int; k_ number;
  ob22_ specparam_int.OB22%type;
begin

  If deleting then
     If :old.sos>0 then
        raise_application_error(-20100,'Заявка уже в роботi, вилучення НЕможливе!');
     end if;
     delete from KAS_Z where idz =:old.IDZ;
     return;
  end if;

  kodv_   := to_number(:new.kodv);
  k_      := NVL(:NEW.kol,0);
  branch_ := nvl (:new.branch,sys_context('bars_context','user_branch') );
  KASZ.PDAT2   (1,:new.dat2, K_, dat2_);
--  dat2_   := nvl (to_date(:new.dat2,'dd/mm/yyyy'), gl.bdate + 1);

  begin
    select kv, substr('00'||type_ ,-2)
    into kv_ , ob22_
    from BANK_METALS where kod = kodv_  ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100,'ПОМИЛКА. Код виробу з БМ !');
  end;
  iF k_ <=0 THEN
      raise_application_error(-20100,'Не указано кiлькiсть !');
  END IF;
  -----------

  -- Проверка на открытость счетов
  If branch_ like '%/000000/' or  branch_ like '%/000000/060000/'   then
     KASZ.NLS1 ( kv_, Branch_,'1107',ob22_,
                              '110'||substr(kasz.SX_NBS,4,1),ob22_,
                              '1101',ob22_ );
   else
    KASZ.NLS1 ( kv_, Branch_, '1107',ob22_,
                              '110'||substr(kasz.SX_NBS,4,1),ob22_,
                              '1102',ob22_ );
  end if;

  If inserting THEN
     insert into  KAS_Z(idz, DAT1,SOS, BRANCH, VID, KODV, KV, DAT2, idu, KOL)
     select s_KAS_Z.nextval,sysdate,0, branch_,2, to_char(KODV_),kv_,
           DAT2_, GL.AuID, k_ from dual;
     return;
  end if;

  update KAS_Z set BRANCH=branch_, KV=kv_, DAT2=dat2_, kol= k_, kodV=to_char(KODV_)
    where idz = :old.idz;

end tbiud_KAS_Zv2;



/
ALTER TRIGGER BARS.TBIUD_KAS_ZV2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_ZV2.sql =========*** End *
PROMPT ===================================================================================== 
