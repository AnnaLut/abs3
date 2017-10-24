

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_SS_DEB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_SS_DEB ***

  CREATE OR REPLACE TRIGGER BARS.TU_SS_DEB 
-- триггер - ловушка траншей
before UPDATE OF ostc ON accounts
FOR EACH ROW
 WHEN (
old.tip in ('SS ', 'SP ')
       AND NEW.ostc < OLD.ostc
       AND NEW.pap = 1
       and regexp_like (old.nls,'^[2][0].[2,3,7]')
      ) DECLARE
 l_pr int ;    -- Признак наличия сторнирования (больше единицы)
BEGIN
  select count(sos) into l_pr from opldok where ref=gl.aref and tt='BAK';
  if l_pr=0 then
    CCT.tranSh1  (p_nbs   =>   :old.NBS                ,
                  p_acc   =>   :old.ACC                ,
                  P_S     => - :new.ostc + :old.ostc   ,
                  P_FDAT  => gl.bdate    ,
                  P_ref   => gl.aRef     ,
                  P_ost   => - :new.ostc ,
                  P_tip   =>   :old.TIP  ,
                  p_mdate =>   :old.mdate,
                  p_accc  =>   :old.accc ) ;
    end if;
END tu_SS_DEB;
/
ALTER TRIGGER BARS.TU_SS_DEB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_SS_DEB.sql =========*** End *** =
PROMPT ===================================================================================== 
