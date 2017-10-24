

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23KORR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_NBU23KORR ***

  CREATE OR REPLACE TRIGGER BARS.TAU_NBU23KORR INSTEAD OF UPDATE
  ON NBU23_KORR REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
  If nvl(:new.fin23,0)<>nvl(:old.fin23,0)     OR nvl(:new.obs23,0)<>nvl(:old.obs23,0)
    OR nvl(:new.NEINF,0)<>nvl(:old.NEINF,0)   OR nvl(:new.VNCRR,'*')<>nvl(:old.VNCRR,'*')
    OR nvl(:new.KHIST,0)<>nvl(:old.KHIST,0)
  --OR nvl(:new.kat23,0)<>nvl(:old.kat23,0)
  --OR nvl(:new.k23  ,0)<>nvl(:old.k23  ,0)
  then

--NEINF=Негативнa iнформацiя CCK_NEINF
    If trim (:new.NEINF) is not null then
       Set_accountsw( p_acc  =>:old.ND, p_TAG =>'NEINF',  p_VALUE => trim (:new.NEINF) );
    end if;

--VNCRR=Внутр.кред.рейтинг позич-ка по КД,  CCK_RATING
    If trim (:new.VNCRR) is not null then
       Set_accountsw( p_acc  =>:old.ND, p_TAG =>'VNCRR',  p_value => trim (:new.VNCRR) );
    end if;

--KHIST=Кредитна iсторiя CCK_HISTORY
    If trim (:new.KHIST) is not null then
       Set_accountsw( p_acc  =>:old.ND, p_TAG =>'KHIST',  p_value => trim (:new.KHIST) );
    end if;

    update acc_fin_obs_kat set fin = :new.fin23, OBS = :new.obs23
  --KAT23 = :new.kat23,   k23   = :new.k23
    where acc = :old.ND;
    if SQL%rowcount = 0 then
       insert into acc_fin_obs_kat ( acc, fin, obs) 
                           values  (:old.ND,:new.fin23, :new.obs23 );
    end if;
    update customer set crisk = :new.fin23 where rnk=:old.rnk;

  end if;

end TAU_NBU23KORR;


/
ALTER TRIGGER BARS.TAU_NBU23KORR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23KORR.sql =========*** End *
PROMPT ===================================================================================== 
