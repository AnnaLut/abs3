

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_BANKMETALSLOCAL.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_BANKMETALSLOCAL ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_BANKMETALSLOCAL 
after insert or update or delete ON bank_metals$local for each row
declare
  l_bankdate date       := gl.bdate;
  l_userid   number(38) := gl.auid;
  l_actionid number(1)  := 0;
  l_idupd    number(38);
begin

  if deleting  then

     l_actionid:= 2;

     select s_bank_metals$local_upd.nextval into l_idupd from dual;

     insert into bank_metals$local_upd
                 (BRANCH,      KOD,        CENA,      CENA_K,      ACC_3800,
                  isp,         bdate,      sdate,     idupd,       action_id)
          values (:old.BRANCH, :old.KOD,   :old.CENA, :old.CENA_K, :old.ACC_3800,
                  l_userid,    l_bankdate, sysdate,   l_idupd,     l_actionid);

  elsif inserting then

     l_actionid:= 0;

     select s_bank_metals$local_upd.nextval into l_idupd from dual;

     insert into bank_metals$local_upd
                 (BRANCH,      KOD,        CENA,      CENA_K,      ACC_3800,
                  isp,         bdate,      sdate,     idupd,       action_id)
          values (:new.BRANCH, :new.KOD,   :new.CENA, :new.CENA_K, :new.ACC_3800,
                  l_userid,    l_bankdate, sysdate,   l_idupd,     l_actionid);
  else
     l_actionid:= 1;

     if   nvl(:old.branch,   '_______') != nvl(:new.branch,  '________')
       or nvl(:old.kod,      -31011900) != nvl(:new.kod,      -31011900)
       or nvl(:old.cena,     -31011900) != nvl(:new.cena,     -31011900)
       or nvl(:old.cena_k,   -31011900) != nvl(:new.cena_k,   -31011900)
       or nvl(:old.acc_3800, -31011900) != nvl(:new.acc_3800, -31011900)

      then
         select s_bank_metals$local_upd.nextval into l_idupd from dual;

         insert into bank_metals$local_upd
                     (BRANCH,      KOD,        CENA,      CENA_K,      ACC_3800,
                     isp,         bdate,      sdate,      idupd,       action_id)
              values (:new.BRANCH, :new.KOD,   :new.CENA, :new.CENA_K, :new.ACC_3800,
                      l_userid,    l_bankdate, sysdate,   l_idupd,     l_actionid);
      else

         return; -- ничего не менялось, выходим

     end if;
  end if;
end tbiu_bankmetalslocal;



/
ALTER TRIGGER BARS.TBIU_BANKMETALSLOCAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_BANKMETALSLOCAL.sql =========**
PROMPT ===================================================================================== 
