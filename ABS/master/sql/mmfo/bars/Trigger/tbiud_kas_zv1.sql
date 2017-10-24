

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_ZV1.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_KAS_ZV1 ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_KAS_ZV1 
   INSTEAD OF UPDATE OR INSERT OR DELETE
   ON BARS.KAS_ZV1 REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
declare
  branch_ branch.BRANCH%type;    dat2_   date;   KV_     int; s_ number;
begin
  If deleting then
     If :old.sos>0 then
        raise_application_error(-20100,'Заявка уже в роботi, вилучення НЕможливе!');
     end if;
     delete from KAS_Z where idz =:old.IDZ;
     return;
  end if;

  branch_ := nvl (:new.branch,sys_context('bars_context','user_branch') );
  S_      := NVL(:NEW.S,0);
  KV_     := nvl(:new.kv, gl.baseval);

  KASZ.PDAT2   (1,:new.dat2, S_, dat2_);
--  dat2_   := nvl ( to_date(:new.dat2,'dd/mm/yyyy'), gl.bdate + 1);
  KASZ.CEL_MON ( kv_, S_*100 );


  iF S_ <=0 THEN
      raise_application_error(-20100,'Не указано суму !');
  END IF;

  -- Проверка на открытость счетов
  If branch_ like '%/000000/' or  branch_ like '%/000000/060000/'   then
     KASZ.NLS1 ( kv_, Branch_, '1007','01', kasz.SX_NBS,'01', '1001','01' );
  else
     KASZ.NLS1 ( kv_, Branch_, '1007','01', kasz.SX_NBS,'01', '1002','01' );
  end if;

  If inserting THEN
     insert into  KAS_Z(idz, DAT1,SOS, BRANCH,VID,KV,DAT2,idu, S)
     select s_KAS_Z.nextval,sysdate,0,branch_,1, kv_,DAT2_,GL.AuID,s_ from dual;
     return;
  end if;

  update KAS_Z set BRANCH=branch_,KV=kv_,DAT2=dat2_,S=S_  where idz= :old.idz;

end tbiud_KAS_Zv1;



/
ALTER TRIGGER BARS.TBIUD_KAS_ZV1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_ZV1.sql =========*** End *
PROMPT ===================================================================================== 
