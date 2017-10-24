

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_CCMANY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_CCMANY ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_CCMANY 
before insert or update on CC_MANY for each row
begin

/*
13.01.2010 Sta
   В потоки вводим новые колонки "План" погашения тела и проц.
   Для сохранения разных приложений по начальному построению потоков
   и одновременного заполнения новых колонок "План" и вводится этот триггер
*/

  if :new.FDAT>gl.BDATE  Then
     :new.P_SS := Nvl ( :new.P_SS, :new.SS2);
     :new.P_SN := Nvl ( :new.P_SN, :new.SN2);
  else
     :new.P_SS := Nvl ( :new.P_SS, 0);
     :new.P_SN := Nvl ( :new.P_SN, 0);
  end if;

end tbiu_CCMANY;
/
ALTER TRIGGER BARS.TBIU_CCMANY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_CCMANY.sql =========*** End ***
PROMPT ===================================================================================== 
