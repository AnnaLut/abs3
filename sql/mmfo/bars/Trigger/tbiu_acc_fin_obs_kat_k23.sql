

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACC_FIN_OBS_KAT_K23.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_ACC_FIN_OBS_KAT_K23 ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_ACC_FIN_OBS_KAT_K23 
  before update or insert of FIN, OBS  ON BARS.ACC_FIN_OBS_KAT for each row
   WHEN (
new.FIN >0 and new.OBS >0
      ) declare
 err_ int;
 err_text_ varchar2(2000);
 l_cus   int;
 l_fin23 int;
 l_obs23 int;
 p_kat23 int;
 p_k23   number;
 l_acc   number;
 rnk_    number;


 l_VNCRR varchar2(4); l_KHIST int; l_NEINF int;
 l_VN2 varchar2(2);

begin

  select custtype, c.rnk  into l_cus, rnk_
  from customer c,accounts a
  where a.acc=:new.acc and a.rnk=c.rnk;

  if l_cus=1 THEN l_cus:=5; End if;

  k23_def(:new.FIN,:new.OBS,l_cus,:new.acc,rnk_,p_kat23,p_k23);

  :new.KAT := p_kat23;
  :new.k   := p_k23  ;

--    HE  Установлен ВЕБ-модуь "Фин-Стан"

end ACC_FIN_OBS_KAT_K23;


/
ALTER TRIGGER BARS.TBIU_ACC_FIN_OBS_KAT_K23 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACC_FIN_OBS_KAT_K23.sql =======
PROMPT ===================================================================================== 
