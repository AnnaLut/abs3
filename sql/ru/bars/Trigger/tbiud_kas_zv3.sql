

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_ZV3.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_KAS_ZV3 ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_KAS_ZV3 
   INSTEAD OF UPDATE OR INSERT OR DELETE
   ON BARS.KAS_ZV3 REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
declare
  type_ int;
  kodv_ varchar2(20);
  branch_ branch.BRANCH%type; dat2_ date; nom_ number;
  kv_   int := 980;
begin
  If deleting then
     If :old.sos>0 then
        raise_application_error(-20100,'Заявка уже в роботi, вилучення НЕможливе!');
     end if;
     delete from KAS_Z where idz =:old.IDZ;
     return;
  end if;

  branch_ := nvl (:new.branch,sys_context('bars_context','user_branch') );

  KASZ.PDAT2   (1,:new.dat2, NVL(:NEW.kol,0), dat2_);
--dat2_   := nvl (to_date(:new.dat2,'dd/mm/yyyy'), gl.bdate + 1);
  kodv_   := :new.kodv;

  begin
    select n.pr_no,    decode(n.PR_KUPON, null, n.NOMINAL, 0)
    into type_, nom_
    from spr_mon n
    where n.KOD_MONEY = kodv_;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100,'ПОМИЛКА. Код монети/футляру !');
  end;

  iF NVL(:NEW.kol,0) <=0 THEN
      raise_application_error(-20100,'Не указано кiлькiсть !');
  END IF;

  -- Проверка на открытость счетов
  If nom_ > 0 then

    If branch_ like '%/000000/' or  branch_ like '%/000000/060000/'   then
       KASZ.NLS1 ( kv_, Branch_, '1007','01', kasz.SX_NBS,'01', '1001','01' );
    else
       KASZ.NLS1 ( kv_, Branch_, '1007','01', kasz.SX_NBS,'01', '1002','01' );
    end if;

  else
     KASZ.NLS1 ( gl.baseval, Branch_, '9899','17', '9819','32', '9819','32' );
  end if;
  --------
  If inserting THEN
     insert into  KAS_Z(idz, DAT1,SOS, BRANCH, VID, KODV, DAT2, idu, KOL, kv)
     select s_KAS_Z.nextval,sysdate,0, branch_,3, KODV_,
            DAT2_, GL.AuID, :new.kol,kv_  from dual;
     return;
  end if;

  update KAS_Z set BRANCH=branch_,DAT2=dat2_,kol= :new.kol,kodV=kodv_
    where idz = :old.idz;

end tbiud_KAS_Zv3;
/
ALTER TRIGGER BARS.TBIUD_KAS_ZV3 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_ZV3.sql =========*** End *
PROMPT ===================================================================================== 
