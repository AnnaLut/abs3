

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BANKMONUPD.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_BANKMONUPD ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_BANKMONUPD 
after insert or update or delete ON bank_mon for each row
declare
  l_bankdate date       := gl.bdate;
  l_userid   number(38) := gl.auid;
  l_actionid number(1)  := 0;
  l_idupd    number(38);
begin

  if deleting  then

     l_actionid:= 2;

     select s_bank_mon_upd.nextval into l_idupd from dual;

   insert into bank_mon_upd
          (name_mon,     nom_mon,          cena_nbu,     kod,        type,
           case,         cena_nbu_otp,     razr,         branch,
           isp,          bdate,            sdate,        idupd,      action_id)
   values (:old.name_mon, :old.nom_mon,      :old.cena_nbu, :old.kod,   :old.type,
           :old.case,     :old.cena_nbu_otp, :old.razr,     :old.branch,
           l_userid,     l_bankdate,        sysdate,     l_idupd,    l_actionid);

  elsif inserting then

     l_actionid:= 0;

     select s_bank_mon_upd.nextval into l_idupd from dual;

   insert into bank_mon_upd
          (name_mon,     nom_mon,          cena_nbu,     kod,        type,
           case,         cena_nbu_otp,     razr,         branch,
           isp,          bdate,            sdate,        idupd,      action_id)
   values (:new.name_mon,:new.nom_mon,     :new.cena_nbu,:new.kod,   :new.type,
           :new.case,    :new.cena_nbu_otp,:new.razr,    :new.branch,
           l_userid,     l_bankdate,        sysdate,     l_idupd,    l_actionid);

  else
     l_actionid:= 1;

     if
          nvl(:old.name_mon,      '_______') != nvl(:new.name_mon,    '________')
       or nvl(:old.branch,        '_______') != nvl(:new.branch,      '________')
       or nvl(:old.nom_mon,       -31011900) != nvl(:new.nom_mon,      -31011900)
       or nvl(:old.cena_nbu,      -31011900) != nvl(:new.cena_nbu,     -31011900)
       or nvl(:old.kod  ,         -31011900) != nvl(:new.kod,          -31011900)
       or nvl(:old.type ,         -31011900) != nvl(:new.type,         -31011900)
       or nvl(:old.case ,         -31011900) != nvl(:new.case,         -31011900)
       or nvl(:old.cena_nbu_otp , -31011900) != nvl(:new.cena_nbu_otp, -31011900)
       or nvl(:old.razr ,         -31011900) != nvl(:new.razr,         -31011900)
      then
         select s_bank_mon_upd.nextval into l_idupd from dual;

         insert into bank_mon_upd
                (name_mon,     nom_mon,          cena_nbu,     kod,        type,
                 case,         cena_nbu_otp,     razr,         branch,
                 isp,          bdate,            sdate,        idupd,      action_id)
         values (:new.name_mon,:new.nom_mon,     :new.cena_nbu,:new.kod,   :new.type,
                 :new.case,    :new.cena_nbu_otp,:new.razr,    :new.branch,
                 l_userid,     l_bankdate,        sysdate,     l_idupd,    l_actionid);
      else

         return; -- ничего не менялось, выходим

     end if;
  end if;
end tbiud_bankmonupd;
/
ALTER TRIGGER BARS.TBIUD_BANKMONUPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_BANKMONUPD.sql =========*** En
PROMPT ===================================================================================== 
