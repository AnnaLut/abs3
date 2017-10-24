

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_CURRATEKOMUPD.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_CURRATEKOMUPD ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_CURRATEKOMUPD 
before insert or update ON cur_rates$base for each row
declare
  l_comm cur_rate_kom_upd.comments%type;
  l_kol  number;
begin

  l_kol:=0;
  l_comm := 'Изменен/добавлен курс ';

  If    :new.rate_b != :old.rate_b
                    then l_comm := l_comm||'покупки, ';
                         l_kol:=l_kol +1;
  end if;

  if :new.rate_s != :old.rate_s
                    then l_comm := l_comm||'продажи, ';
                         l_kol:=l_kol +1;
  end if;

  if :new.rate_o != :old.rate_o
                    then l_comm := l_comm||'официальный, ';
                         l_kol:=l_kol +1;
  end if;

  if l_kol> 0 then
                  insert into CUR_RATE_KOM_UPD (KV,VDATE,BSUM,RATE_B,RATE_S,BRANCH,ISP,SYSTIME,recid, rate_o, comments)
                                         select :new.KV, :new.VDATE, :new.BSUM, :new.RATE_B, :new.RATE_S,
                                                :new.BRANCH,gl.aUid,sysdate,S_CURRATEKOMUPD.nextval, :new.rate_o, l_comm
                                           from dual;
  end if;

end tbiu_CURRATEKOMUPD;
/
ALTER TRIGGER BARS.TBIU_CURRATEKOMUPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_CURRATEKOMUPD.sql =========*** 
PROMPT ===================================================================================== 
