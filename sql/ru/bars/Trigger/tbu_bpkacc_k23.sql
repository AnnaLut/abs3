

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_BPKACC_K23.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_BPKACC_K23 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_BPKACC_K23 
  before update of FIN23, OBS23  ON BARS.BPK_ACC  for each row
 WHEN ( new.FIN23>0 OR   new.OBS23>0 ) declare
  l_cus int; l_fin23 int; l_obs23 int; l_nd number; l_rnk number; l_kat23 int; l_k23 number;
begin
  l_fin23 := nvl(:new.FIN23,0);  l_obs23 := nvl(:new.OBS23,0);
  if l_fin23 = 0 or  l_obs23 =0  then return; end if;

  l_nd    := :old.nd;
  ----------------------------------------------

  --ïî óìîë÷àòåëüíîé ìåòîäèêå ÏÅÒÐÎÊÎÌ(ÞË) + îíà æå ÎÙÀÄÁÀÍÊ (ÔË)
  begin
    select c.rnk, c.custtype into l_rnk, l_cus  from customer c, accounts a
    where a.acc= :old.acc_pk and a.rnk = c.rnk;
  exception when no_data_found then return;
  end;

  k23_def( p_fin23 => l_fin23,
           p_obs23 => l_obs23,
           p_cus   => l_cus  ,
           p_nd    => l_nd   ,
           p_rnk   => l_rnk  ,
           -------------------
           p_KAT23 => l_kat23, -- OUT int,
           p_k23   => l_k23  -- OUT number
         );
  :new.KAT23 := l_kat23;
  :new.k23   := l_k23  ;
end tbu_BPKACC_K23;
/
ALTER TRIGGER BARS.TBU_BPKACC_K23 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_BPKACC_K23.sql =========*** End 
PROMPT ===================================================================================== 
