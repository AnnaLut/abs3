

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_SWIMTILIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_SWIMTILIST ***

  CREATE OR REPLACE TRIGGER BARS.TAI_SWIMTILIST after insert ON BARS.SWI_MTI_LIST for each row
-- триггер для открытия в грн 6110, 2909, 2809 в грн при появлении новой системы
   -- 980 всегда отрываем
declare
begin
   FOR  M IN ( SELECT * FROM MV_KF)
   LOOP BC.GO (M.kf) ;
       for k in (select DISTINCT substr(p.BRANCH,1,15) BRANCH from BRANCH_PARAMETERS p inner join BRANCH b on b.BRANCH = p.BRANCH where p.tag ='SWI' and p.val='1' and b.DATE_CLOSED is null)
       loop    MONEX_RU.op_NLSM ( p_nbs =>'6110',  p_ob22 => :new.OB22_KOM ,  p_branch => k.branch, p_kv => gl.baseval );   end loop;

       for k in (select p.branch from BRANCH_PARAMETERS p inner join BRANCH b on b.BRANCH = p.BRANCH where p.tag ='SWI' and p.val='1' and b.DATE_CLOSED is null)
       loop     --grishkovmv@oschadbank.ua (Mastercard Moneysend не предусмотрено открытие ОБ22 для 2809)
          if :new.OB22_2809 is not null then    MONEX_RU.op_NLSM ( p_nbs =>'2809',  p_ob22 => :new.OB22_2809,  p_branch => k.branch, p_kv => gl.baseval );  end if;
          MONEX_RU.op_NLSM ( p_nbs =>'2909',  p_ob22 => :new.OB22_2909,  p_branch => k.branch, p_kv => gl.baseval );
       end loop ; -- K
   END LOOP ; --- M

end TAI_SWIMTILIST ;
/
ALTER TRIGGER BARS.TAI_SWIMTILIST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_SWIMTILIST.sql =========*** End 
PROMPT ===================================================================================== 
