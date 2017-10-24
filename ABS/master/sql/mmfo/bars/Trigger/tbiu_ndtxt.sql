

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_NDTXT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_NDTXT ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_NDTXT before insert or update
  ON BARS.ND_TXT for each row
DECLARE
  l_BRANCH cc_deal.BRANCH%type;
  l_RNK    cc_deal.RNK%type;
  L_       int ;
begin

  if :NEW.TAG = 'INIC' then
     L_:= instr (:new.TXT, ' ');

     If l_ =  0 then    l_:= length(:new.txt) + 1;   end if;
     If L_ < 31 then
        l_BRANCH := substr(:new.TXT, 1, L_-1 );
        begin
          select 1   into l_    from tobo    where tobo=l_branch ;
          Select rnk into l_RNK from cc_deal where nd  =:new.ND;
          update cc_deal
             set branch=l_BRANCH where nd=:new.ND and branch <>l_BRANCH
          returning count(nd) into L_;
          if L_>0 and :OLD.TXT is not null then
            Insert into BARS.CC_SOB (ND, FDAT, ID, ISP, TXT, OTM, FREQ)
                 Values (:new.ND, sysdate, null, null, 'Изменен инициатор КД с '||:OLD.TXT ||' на '||l_BRANCH, 6, 2);
             -- высокая вероятность того что счет доходов теперь не правильный
             delete from nd_acc
              where nd=:new.ND and
                    acc in (select a.acc
                             from accounts a,nd_acc n
                            where n.nd=:new.ND and n.acc=a.acc and a.tip='SD '
                          );
          end if;
          for k in (select a.acc from nd_acc n, accounts a
                    where n.nd=:NEW.ND and n.acc=a.acc and a.rnk=l_RNK and a.TIP  not in ('DEP','DEN','NL8')
                      and a.tobo<>l_BRANCH
                    union ALL
                    select acc from cc_accp p
                    where  p.accs in
                           ( select a.acc from nd_acc n, accounts a
                              where n.nd=:NEW.ND and n.acc=a.acc and a.rnk=l_RNK
                           )
                       and (pr_12 is null or pr_12=1 or pr_12=3)
                       )
          loop
             update accounts set tobo=l_BRANCH where acc=k.ACC and dazs is null;
          end loop;
        EXCEPTION  WHEN no_data_found THEN null;
        end;
     end if;

  end if;

end tbiu_NDTXT;


/
ALTER TRIGGER BARS.TBIU_NDTXT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_NDTXT.sql =========*** End *** 
PROMPT ===================================================================================== 
