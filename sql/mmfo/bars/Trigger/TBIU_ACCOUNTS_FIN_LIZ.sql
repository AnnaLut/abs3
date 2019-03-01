CREATE OR REPLACE TRIGGER TBIU_ACCOUNTS_FIN_LIZ
  before update of ostc ON ACCOUNTS
  for each row
   WHEN
     -- проставление доп. параметрам на договорах по счетах финансового лизинга
     (new.nbs in ('2044','2071'))
declare
    l_nd       cc_deal.nd%type;
    l_txt      nd_txt.txt%type;
    l_asum     nd_txt.tag%type:='LIZASUM';
    l_sum      nd_txt.tag%type:='LIZSUM';
begin
    select n.nd, t.txt
    into l_nd, l_txt
    from nd_acc n,
         cc_deal c,
         nd_txt t
    where n.acc = :new.acc
      and c.nd = n.nd
      and c.sos <15
      and t.nd(+) = n.nd
      and t.tag(+) = l_asum;

     if l_txt is null   then
       insert into nd_txt (nd, tag, txt) values (l_nd, l_asum, 'Taк');
       insert into nd_txt (nd, tag, txt) values (l_nd, l_sum, nvl(:new.ostc/100,0)*(-1));
     elsif l_txt = 'Taк' then
       update  nd_txt set txt=nvl(:new.ostc/100,0)*(-1) where nd=l_nd and tag=l_sum;
     end if;

end TBIU_ACCOUNTS_FIN_LIZ;
/
