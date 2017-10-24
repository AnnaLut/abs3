

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23CCKBN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_NBU23CCKBN ***

  CREATE OR REPLACE TRIGGER BARS.TAU_NBU23CCKBN INSTEAD OF UPDATE
  ON BARS.NBU23_CCK_BN REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
declare
  l_ccdeal   cc_deal%rowtype;
  l_comm     varchar2(254);
BEGIN
   If    nvl(:new.fin23,0)   <> nvl(:old.fin23,0)   OR nvl(:new.obs23,0)    <> nvl(:old.obs23,0)
      OR nvl(:new.fin_351,0) <> nvl(:old.fin_351,0) or nvl(:new.pd,0)       <> nvl(:old.pd,0)
      OR nvl(:new.NEINF,0)   <> nvl(:old.NEINF,0)   and nvl(:new.NEINF,0)   <> 0
      OR nvl(:new.VNCRR,'*') <> nvl(:old.VNCRR,'*') and nvl(:new.VNCRR,'*') <> '*'
      OR nvl(:new.KHIST,0)   <> nvl(:old.KHIST,0)   and nvl(:new.KHIST,0)   <> 0 THEN

      --NEINF=Негативнa iнформацiя CCK_NEINF
      If trim (:new.NEINF) is not null then
         cck_app.Set_ND_TXT( p_ND  =>:old.ND, p_TAG =>'NEINF',  p_TXT => trim (:new.NEINF) );
      end if;

      --VNCRR=Внутр.кред.рейтинг позич-ка по КД,  CCK_RATING
      If trim (:new.VNCRR) is not null then
         cck_app.Set_ND_TXT( p_ND  =>:old.ND, p_TAG =>'VNCRR',  p_TXT => trim (:new.VNCRR) );
      end if;

      --KHIST=Кредитна iсторiя CCK_HISTORY
      If trim (:new.KHIST) is not null then
         cck_app.Set_ND_TXT( p_ND  =>:old.ND, p_TAG =>'KHIST',  p_TXT => trim (:new.KHIST) );
      end if;

      if :new.fin_351 not in (1,2,3,4,5) THEN
         raise_application_error(-(20001),'/' ||'     Вказано не існуючий клас боржника - '|| :new.fin_351, TRUE);
      End if;
      if :new.pd < 0 or :new.pd > 1  THEN
         raise_application_error(-(20001),'/' ||'     Вказано не можливе значення PD (0-1) - '|| :new.pd, TRUE);
      End if;
      update cc_deal set fin23 = :new.fin23, fin_351 = :new.fin_351, pd = :new.pd, OBS23 = :new.obs23 where nd = :old.ND;

  end if;

end TAU_NBU23CCKBN;
/
ALTER TRIGGER BARS.TAU_NBU23CCKBN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23CCKBN.sql =========*** End 
PROMPT ===================================================================================== 
