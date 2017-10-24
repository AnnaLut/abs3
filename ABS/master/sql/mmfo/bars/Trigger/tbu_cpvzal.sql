

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CPVZAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CPVZAL ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CPVZAL 
  INSTEAD OF UPDATE ON BARS.CP_V_ZAL
  REFERENCING FOR EACH ROW
declare
l_datz date;
l_spid int:=85;
BEGIN  null;

  l_datz:=to_date(:new.DAT_ZAL, 'DD-MON-YY' , 'nls_date_language =American');
  begin
   select spid
     into l_spid
     from sparam_list
    where tag = 'CP_ZAL';
  exception when no_data_found then  l_spid:=85;
  end;

  -- таблиця CPZAL т_льки для сум_сност_ в_д попередньої верс_ї вьюшки
   update cp_zal set kolz = :new.KOL_ZAL,
                    datz = :new.DAT_ZAL
              where ref = :old.ref;
   if SQL%rowcount = 0 then
      insert into cp_zal (ref, id, kolz,datz)
      values (:old.ref,:old.id, :new.KOL_ZAL, :new.DAT_ZAL);
   end if;

  -- Збереження актуальних значень обтяження в пар-р_ рах-ку CP_ZAL (spid=l_spid)
  if :new.DAT_ZAL = :old.DAT_ZAL then
     update accountspv set val=nvl(:new.kol_zal,'0')
     where acc=:old.acc and parid=l_spid and dat1=
     (select max(dat1) from accountspv where acc=:old.acc
             and parid=l_spid and dat1<=:new.dat_zal)
       and dat2<=l_datz;
/*
  elsif :new.DAT_ZAL is not null and :old.DAT_ZAL is null then
     begin
     insert into accountspv (acc, dat1, dat2, parid, val)
     values (:old.acc, :old.vdat, gl.bd, l_spid, nvl(:new.kol_zal,'0'));
     exception when dup_val_on_index then raise;
     end;

     begin
     insert into accountspv (acc, dat1, dat2, parid, val)
     values (:old.acc, decode(:new.dat_zal,null,to_date('31012099','ddmmyyyy'),l_datz+1), NULL, l_spid, '0');
     exception when dup_val_on_index then raise;
               when others then raise;
     end;
*/
  else
     begin
     insert into accountspv (acc, dat1, dat2, parid, val)
     values (:old.acc, decode(:new.dat_zal,null,to_date('31012099','ddmmyyyy'),l_datz+1), NULL, l_spid, '0');
     exception when others then raise;
     end;
     update accountspv set val=nvl(:new.kol_zal,'0')
     where acc=:old.acc and parid=l_spid and dat1=
     (select max(dat1) from accountspv where acc=:old.acc
             and parid=l_spid and dat1<=:new.dat_zal);
  end if;
END TBU_CPVZAL;


/
ALTER TRIGGER BARS.TBU_CPVZAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CPVZAL.sql =========*** End *** 
PROMPT ===================================================================================== 
