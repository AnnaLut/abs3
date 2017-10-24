

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_ZV4.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_KAS_ZV4 ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_KAS_ZV4 
   INSTEAD OF UPDATE OR INSERT OR DELETE
   ON BARS.KAS_ZV4 REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
declare
  type_ int; kodv_ varchar2(14); branch_ branch.BRANCH%type;  dat2_ date;
  kv_ int := 980;
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

  kodv_ := :new.kodv;
  declare
     Nbs1_ accounts.nbs%type       := substr(kodv_,1,4);
     Ob1_  specparam_int.ob22%type := substr(kodv_,5,2);
     Nbs7_ accounts.nbs%type       ;
     Ob7_  specparam_int.ob22%type ;
  begin
     select decode(substr(ob22,1,4),'9821','9893','9820','9891','9899'),ob22_dor
     into Nbs7_, Ob7_
     from valuables
     where ob22 = KODV_ and ob22_dor is not null;

     KASZ.NLS1 ( gl.baseval, Branch_, Nbs7_,Ob7_, Nbs1_,Ob1_, Nbs1_,Ob1_ );

  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100,'ПОМИЛКА. Код цiнностi !');
  end;

  If inserting THEN
     insert into  KAS_Z(idz, DAT1,SOS, BRANCH, VID, KODV, DAT2, idu, KOL,kv)
     select s_KAS_Z.nextval,sysdate,0, branch_,4, KODV_,
            DAT2_, GL.AuID, :new.kol, kv_  from dual;
     return;
  end if;

  update KAS_Z set BRANCH=branch_, DAT2=dat2_, kol= :new.kol, kodV= kodv_
    where idz = :old.idz;

end tbiud_KAS_Zv4;
/
ALTER TRIGGER BARS.TBIUD_KAS_ZV4 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_ZV4.sql =========*** End *
PROMPT ===================================================================================== 
