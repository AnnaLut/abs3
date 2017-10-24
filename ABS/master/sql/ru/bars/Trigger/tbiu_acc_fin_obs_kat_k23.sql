

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACC_FIN_OBS_KAT_K23.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_ACC_FIN_OBS_KAT_K23 ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_ACC_FIN_OBS_KAT_K23 
  before update or insert of FIN, OBS  ON BARS.ACC_fin_obs_kat for each row
 WHEN ( new.FIN >0 and new.OBS >0) declare
 err_ int;
 err_text_ varchar2(2000);
 l_cus   int;
 l_fin23 int;
 l_obs23 int;
 p_kat23 int;
 p_k23   number;
 l_acc   number;


 l_VNCRR varchar2(4); l_KHIST int; l_NEINF int;
 l_VN2 varchar2(2);

begin


  k23_def(:new.FIN,:new.OBS,2,null,null,p_kat23,p_k23);

  :new.KAT := p_kat23;
  :new.k   := p_k23  ;

--    HE  Установлен ВЕБ-модуь "Фин-Стан"

end ACC_FIN_OBS_KAT_K23;
/
ALTER TRIGGER BARS.TBIU_ACC_FIN_OBS_KAT_K23 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACC_FIN_OBS_KAT_K23.sql =======
PROMPT ===================================================================================== 
