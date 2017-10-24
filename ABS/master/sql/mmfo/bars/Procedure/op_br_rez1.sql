

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BR_REZ1.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BR_REZ1 ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BR_REZ1 
 (p_kv     accounts.kv%type    ,
  p_branch accounts.branch%type,
  p_nbs    accounts.nbs%type   ,
  p_ob22   accounts.ob22%type  ,
  p_s080   specparam.s080%type
 ) IS

-- 06.07.2016 Sta specparam_int        ->      Accreg.setAccountSParam(aa.acc, 'OB22', aa.ob22) ;
-- 18.10.2011 Sta процедура дл€ открыти€ 1-го счета по учету рез

 l_val BRANCH_PARAMETERS.VAL%type;
 l_rnk  accounts.RNK%type  ;
 l_rnk1 accounts.RNK%type  ;
 l_acc  accounts.acc%type  ;
 l_dazs accounts.DAZS%type ;
 l_ISP  accounts.isp%type  ;
 l_bbbb char(4) ;
 I_     int     ;
 ii_    char(2) ;
 l_nls  accounts.nls%type  ; -- 2400_SBBBB000
 l_nms  accounts.nms%type  ;
 l_GRP  accounts.grp%type  := 21 ;
 p4_    int     ;
 ----------------------------

begin

 If length(p_branch) <>15 then
    raise_application_error(-20100,
    '     OP_BR_REZ1:Ѕранч '|| p_branch ||' не Ї бранчем другого рiвн€');
 end if;
 -----------------------------------------------
 begin
  select val into l_val from BRANCH_PARAMETERS
  where tag='RNK' and branch=p_branch;
  l_rnk := to_number(l_val);
 exception when others then
    raise_application_error(-20100,
    '     OP_BR_REZ1:Ѕранч '|| p_branch ||' не знайдено RNK');
 end;
 ----------------------------------------------------
 begin
   -- 1) счет есть ѕ–ј¬»Ћ№Ќџ… (открытый или закрытый)
   select acc, dazs, rnk
   into l_acc, l_dazs, l_rnk1
   from (select a.acc, a.dazs, a.rnk
         from accounts a, specparam s
         where a.kv     = p_kv
           and a.branch = p_branch
           and a.nbs    = p_nbs
           and a.ob22   = p_ob22
           and a.acc    = s.acc
           and s.s080   = p_s080
         order by decode (a.dazs, null,1,2)
         )
   where rownum = 1 ;

   If l_rnk <> l_rnk1 then
      update accounts set rnk = l_rnk where acc = l_acc ;
   end if;

   If l_dazs is NOT null then
       update accounts set dazs= null where acc = l_acc ;
   end if;

   RETURN;

 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end;
 ---------------------------------------
 begin
   -- счет есть , но S080 не заполнено (открытый или закрытый)
   select acc, dazs, rnk
   into l_acc, l_dazs, l_rnk1
   from (select a.acc, a.dazs,a.rnk
         from accounts a,
              (select acc from specparam
               where nvl(s080,' ')  not in ('1','2','3','4','5','9' )
               ) s
         where a.kv     = p_kv
           and a.branch = p_branch
           and a.nbs    = p_nbs
           and a.ob22   = p_ob22
           and a.acc    = s.acc (+)
         order by decode (a.dazs, null,1,2)
         )
   where rownum = 1 ;

   If l_rnk <> l_rnk1 then
      update accounts set rnk = l_rnk where acc = l_acc ;
   end if;

   If l_dazs is NOT null then
       update accounts set dazs= null where acc = l_acc ;
   end if;

   update specparam set s080 = p_s080 where acc = l_acc ;
   if SQL%rowcount = 0 then
      insert into specparam (acc, s080) values ( l_acc, p_s080 ) ;
   end if;

   RETURN;

 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end;
 -----------------------------------------

 ---------- ѕЋќ’ќ. надо открывать
 -- подберем исполнител€
 begin
    select isp into l_isp  from accounts
    where branch like p_branch||'%'
      and nbs like '240_' and dazs is null and rownum=1;
 EXCEPTION WHEN NO_DATA_FOUND THEN l_isp := 20094;
 end;

 l_bbbb  := substr(substr(p_branch,-5),1,4);
 I_      := -1;
 while TRUE
 loop
   -- сдедаем маску счета типа 2400_SIIBBBB00
   i_    := i_ + 1;
   ii_   := Substr('00'||i_, -2 ) ;
   l_nls := p_nbs || '0' || p_s080 || II_ || l_BBBB || p_ob22 ;
   l_nls := vkrzn( substr(gl.aMfo,1,5), l_NLS );

   begin
      select acc into p4_ from accounts where kv = p_kv and nls = l_nls ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      l_nms := '–‘ S080='||p_s080|| ',об22='||p_ob22 || ',бранч=' || p_branch;
      op_reg(99,0,0,l_GRP,p4_,l_RNK,l_nls,p_kv,l_nms,'ODB',l_isp, l_acc );
      update accounts set tobo = p_branch where acc= l_acc;
      Accreg.setAccountSParam(l_acc, 'OB22', p_ob22) ;
      insert into specparam     ( acc, s080 ) values ( l_acc, p_s080 ) ;

      RETURN ;

   end;
 end loop;

 RETURN;
end OP_BR_REZ1 ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BR_REZ1.sql =========*** End **
PROMPT ===================================================================================== 
