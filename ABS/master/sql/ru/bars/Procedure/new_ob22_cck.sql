

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NEW_OB22_CCK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NEW_OB22_CCK ***

  CREATE OR REPLACE PROCEDURE BARS.NEW_OB22_CCK (p_nd number) is

  oo test_cck_ob22%rowtype;  nn cck_ob22%rowtype;
  ostc_ number ;  sERR_ varchar2(1000);
  ob22_ char(2);  nls_  varchar2(15);  acrb_ number;
  prod_ varchar2(30);

 -----------------------
 procedure OB  (PROD_ varchar2, nd_ number, acc_ number, TIP_ varchar2, NBS_ varchar2) is
    OB22_    specparam_int.OB22%type;
 begin
   If   tip_ ='SS ' then OB22_:= substr(PROD_,5,2);
   else
      select decode(tip_,
            'SPI',SPI,'SDI',SDI,'SN ',SN ,'SPN',SPN  ,'SLN',SLN,'CR9',CR9 ,'SK0',SK0,'SK9',SK9,
            'SP ',SP ,'ISG',ISG,'S9N',substr(S9N,1,2),'SL ',substr(SL,1,2),'SG ',SG ,  null)
            into OB22_
      from CCK_OB22 where NBS||OB22 =PROD_;
   end if;
   ----------------
   If OB22_ is not null then
      update specparam_int set ob22 = OB22_ where acc = ACC_;
      if SQL%rowcount = 0 then
         insert into specparam_int (acc,ob22) values (ACC_,OB22_);
      end if;
   end if;
 end OB;
------------------
begin
  tuda;
for k in (select * from cc_deal d  where sos>=10 and sos<14 and substr(prod,1,6) in (select nbs||ob22_old from test_cck_ob22 )
           and p_nd in (0, d.nd)
         )
loop
  select * into oo from test_cck_ob22 where substr(k.prod,1,6) = nbs||ob22_old;

  select nvl(sum(a.ostc),0) into ostc_ from nd_acc n, accounts a where n.nd=k.nd and n.acc=a.acc and a.rnk=k.rnk and a.ostc < 0;

  if ostc_ =0 then   -- Закрыть КД (по возможности)
     sERR_ := null;  cck.cc_close (ND_ =>k.nd, sERR_ => sERR_  ) ;
     If sERR_ is null then  goto Next_KD;  end if;
  end if;

  If oo.ob22_new is  null then

     --выбрать новый продукт из доп.рекв
     begin
        select trim(txt) into oo.ob22_new from nd_txt where nd=k.ND and tag ='NEWOB'
           and trim(txt) in
              (select ob22 from cck_ob22 where nbs=oo.nbs minus select ob22_old from test_cck_ob22 where nbs=oo.nbs)   ;
     EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20100, 'Недопуст/вiдсут новий код ОВ22 для КД реф='||k.ND );
     end;

  end if;

  -- перенести на новый продукт
  select * into nn from cck_ob22 where nbs = oo.nbs and ob22 = oo.ob22_new;

  --поменять об22 на счетах
  for p in (select a.* from nd_acc n, accounts a where n.nd=k.nd and n.acc=a.acc and a.rnk=k.rnk and a.dazs is null)
  loop
     OB (oo.NBS||oo.ob22_new, k.ND, p.acc, p.TIP, p.NBS);
     --поменять счета дох/расх
     for i in (select x.acrb, x.id, b.nbs, b.ob22, substr(b.branch,1,15) branch from int_accn x, accounts b where x.acc = p.acc and x.acrb= b.acc and b.nbs like '6%')
     loop
        ob22_ := null;
        If    i.id = - 2 and p.tip ='LIM'  then  -- амортизация
           If p.kv = 980 then ob22_ := nn.SD_M;  -- COMMENT ON COLUMN BARS.CCK_OB22.SD_M IS 'ob22~А от н~6***';
           else               ob22_ := nn.SD_J;  -- COMMENT ON COLUMN BARS.CCK_OB22.SD_J IS 'ob22~А от i~6***';
           end if;
        Elsif i.id =   0 and p.tip ='CR9'  then  -- комиссия за 9129 (проценты)
           ob22_:= nn.SD_9129;                   -- COMMENT ON COLUMN BARS.CCK_OB22.SD_9129 IS 'OB22~ рах. доходiв ~ для комiсiї~ на 9129';

        Elsif i.id =   0 and p.tip in ('SS ','SP ') then  -- проценты
           if p.kv = 980 then ob22_ := nn.SD_N;  -- COMMENT ON COLUMN BARS.CCK_OB22.SD_N IS 'ob22~% от н~6***';
           else               ob22_ := nn.SD_I;  -- COMMENT ON COLUMN BARS.CCK_OB22.SD_I IS 'ob22~% от i~6***';
           end if;

        elsif i.id =   2 then                    -- комиссия
           ob22_ := nn.SD_SK0;                   --COMMENT ON COLUMN BARS.CCK_OB22.SD_SK0 IS 'OB22~ рах. доходiв ~ для щомiсячної ~комiсiї';
        end if;

        If ob22_ is not null and ob22_ <> i.ob22 then
           OP_BS_OB1 (PP_BRANCH =>i.branch, P_BBBOO => i.nbs || OB22_ );
           nls_ := nbs_ob22_null ( nbs_ => i.nbs, ob22_ => ob22_ ,  p_branch => i.branch ) ;
           select acc into acrb_ from accounts where kv =980 and nls = nls_;
           update int_accn set acrb = acrb_ where acc = p.acc and id = i.id;

           -- вывести старый SD
           delete from nd_acc where acc = i.acrb and nd = k.nd;
           delete from nd_acc where acc =  acrb_ and nd = k.nd;

           -- и ввести новый SD
           insert into nd_acc (nd, acc) values ( k.ND, acrb_);
        end if;
     end loop;  -- i
  end loop;      -- p по acc КД

  prod_ := oo.NBS||oo.ob22_new || substr(k.prod,7,30);

  update cc_deal set prod = prod_  where nd = k.nd ;
  INSERT INTO cc_sob (ND,FDAT,ISP,TXT,otm) VALUES  (k.ND,gl.bDATE,gl.aUid,'Cмена кода продукта с '||k.prod || ' на '|| prod_, 6);

  commit;

  <<Next_KD>> null;
end loop;  -- k по КД

end new_ob22_cck;
/
show err;

PROMPT *** Create  grants  NEW_OB22_CCK ***
grant EXECUTE                                                                on NEW_OB22_CCK    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NEW_OB22_CCK    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NEW_OB22_CCK.sql =========*** End 
PROMPT ===================================================================================== 
