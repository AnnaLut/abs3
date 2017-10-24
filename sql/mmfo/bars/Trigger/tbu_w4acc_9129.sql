

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_W4ACC_9129.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_W4ACC_9129 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_W4ACC_9129 
  before update of acc_9129  ON BARS.W4_ACC  for each row
   WHEN (
old.acc_9129 is null and new.acc_9129 is not null
      ) declare
  l_cus int;   l_rnk number; l_kat23 int; l_k23 number;
begin

  :new.fin23 := 1;

   begin
    select c.rnk, c.custtype into l_rnk, l_cus  from customer c, accounts a
    where a.acc= :old.acc_pk and a.rnk = c.rnk;
  exception when no_data_found then return;
  end;

  k23_def( p_fin23 => :new.fin23,
           p_obs23 => :new.obs23,
           p_cus   => l_cus  ,
           p_nd    => :new.nd   ,
           p_rnk   => l_rnk  ,
           -------------------
           p_KAT23 => l_kat23, -- OUT int,
           p_k23   => l_k23  -- OUT number
         );
  :new.KAT23 := l_kat23;
  :new.k23   := l_k23  ;

end TBU_W4ACC_9129;


/
ALTER TRIGGER BARS.TBU_W4ACC_9129 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_W4ACC_9129.sql =========*** End 
PROMPT ===================================================================================== 
