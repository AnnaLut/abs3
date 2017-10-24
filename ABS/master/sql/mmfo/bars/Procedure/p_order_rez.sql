

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ORDER_REZ.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ORDER_REZ ***

  CREATE OR REPLACE PROCEDURE BARS.P_ORDER_REZ (Dat01_ DATE) IS

/* Версия 29-07-2016 15-04-2015

1) 29-07-2016 LUDA Dat_last --> Dat_last_work
*/

l_dat31 date;

l_cnt   number;
l_maket number;

l_sos   oper.sos%type;
l_nlsa  oper.nlsa%type;
l_s     oper.s%type;


begin

   delete from order_REZ;

   l_dat31 := Dat_last_work(dat01_-1);
   l_maket := 1;

   begin
      select nlsa, s into l_nlsa,l_s from rez_doc_maket where dk<>-1 and rownum=1 and ref is not null order by nlsa ;
   EXCEPTION  WHEN NO_DATA_FOUND  THEN
      l_maket := 0;
   end;

   begin
      select sos into l_sos from oper 
      where TT IN ('ARE','AR*') and nlsa=l_nlsa and s=l_s AND VDAT = l_dat31 and sos<>-1 and pdat BETWEEN dat01_ and  add_months (dat01_,1) and rownum=1;
      l_maket := 0;
   EXCEPTION  WHEN NO_DATA_FOUND  THEN
      l_maket := 1;
   end;

   -- все строки
   insert into order_rez (DK,kV,NLSA,NLSB,S,GRP)
   select *
   from ( select decode(o.dk,1,0,1) DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB,sum(decode(o.dk,1,o.s2,-o.s2))/100 S,nvl(gn.grp,10) GRP
          from   rez_doc_maket o,accounts a,grp_rez g,grp_rez_nbs gn
          where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                 a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and dk<>-1 and l_maket=1 and ref is null
          group  by decode(o.dk,1,0,1),o.kv,o.nlsa,o.nlsb,gn.grp,g.name
          union  all
          select o.dk DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB,sum(decode(o.dk,1,-o.s2,o.s2))/100 S,nvl(gn.grp,10) GRP
          from   oper o,accounts a,grp_rez g,grp_rez_nbs gn
          where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                 a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and sos <> -1 and  pdat BETWEEN dat01_ and  add_months (dat01_,1)
          group  by o.dk,o.kv,o.nlsa,o.nlsb,gn.grp,g.name   )
   order by  grp,kv,nlsa;

   -- Итог по группе
   insert into order_rez (NAME,GRP,S)
   select g.name,nvl(x.grp,10),sum(x.S)
   from (select o.dk DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB,sum(decode(o.dk,1,-o.s2,o.s2))/100 S,gn.grp GRP,g.name NAME
         from   oper o,accounts a,grp_rez g,grp_rez_nbs gn
         where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and sos <>-1 and pdat BETWEEN dat01_ and  add_months (dat01_,1)
         group  by o.dk,o.kv,o.nlsa,o.nlsb,gn.grp,g.name
         union  all
         select decode(o.dk,1,0,1) DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB,sum(decode(o.dk,1,o.s2,-o.s2))/100 S,gn.grp GRP,g.name NAME
         from   REZ_doc_maket o,accounts a,grp_rez g,grp_rez_nbs gn
         where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and dk<>-1 and  l_maket=1 and ref is null
         group  by decode(o.dk,1,0,1),o.kv,o.nlsa,o.nlsb,gn.grp,g.name
         ) x, grp_rez g
   where x.grp=g.grp (+)
   group by  g.name,x.grp;

   -- по зменьшення/збільшення
   insert into order_rez (GRP,NAME,S)
   select dk+20 grp,decode(dk,1,'Зменшення резерву','Збільшення резерву') NAME,sum(s)
   from (select o.dk DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB,sum(decode(o.dk,1,-o.s2,o.s2))/100 S,gn.grp GRP,g.name NAME
         from   oper o,accounts a,grp_rez g,grp_rez_nbs gn
         where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and sos<>-1 and  pdat BETWEEN dat01_ and  add_months (dat01_,1)
         group  by o.dk,o.kv,o.nlsa,o.nlsb,gn.grp,g.name
         union  all
         select decode(o.dk,1,0,1) DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB,sum(decode(o.dk,1,o.s2,-o.s2))/100 S,gn.grp GRP,g.name NAME
         from   rez_doc_maket o,accounts a,grp_rez g,grp_rez_nbs gn
         where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and dk<>-1 and l_maket=1 and ref is null
         group  by decode(o.dk,1,0,1),o.kv,o.nlsa,o.nlsb,gn.grp,g.name
        ) x
   group by dk;

   SELECT COUNT(*) into l_cnt from order_rez;

   if l_cnt <> 0 THEN

      -- Всього
      insert into order_rez (GRP,NAME,S)
      select 30 grp,'Всього' NAME,sum(s)
      from (select o.dk DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB,sum(decode(o.dk,1,-o.s2,o.s2))/100 S,gn.grp GRP,g.name NAME
            from   oper o,accounts a,grp_rez g,grp_rez_nbs gn
            where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                   a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and sos <>-1 and pdat BETWEEN dat01_ and  add_months (dat01_,1)
            group  by o.dk,o.kv,o.nlsa,o.nlsb,gn.grp,g.name
            union  all
            select decode(o.dk,1,0,1) DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB,sum(decode(o.dk,1,o.s2,-o.s2))/100 S,gn.grp GRP,g.name NAME
            from   rez_doc_maket o,accounts a,grp_rez g,grp_rez_nbs gn
            where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                   a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and dk<>-1  and L_maket=1 and ref is null
            group by decode(o.dk,1,0,1),o.kv,o.nlsa,o.nlsb,gn.grp,g.name
            ) x;

      insert into order_rez (GRP,NAME)
      select 31 grp,' у тому числі:' NAME from dual;
   end if;

   -- итоги по группам
   insert into order_rez (NAME,GRP,S)
   select name,grp+40,sum(S)
   from (select g.name,nvl(x.grp,10) grp,sum(x.S) S
         from (select o.dk DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB,sum(decode(o.dk,1,-o.s2,o.s2))/100 S,gn.grp GRP,g.name NAME
               from   oper o,accounts a,grp_rez g,grp_rez_nbs gn
               where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                      a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and sos <>-1 and  pdat BETWEEN dat01_ and  add_months (dat01_,1)
               group by o.dk,o.kv,o.nlsa,o.nlsb,gn.grp,g.name)x, grp_rez g
         where x.grp=g.grp (+)
         group by  g.name,x.grp
         union all
         select g.name,nvl(x.grp,10) grp,sum(x.S) S
         from (select decode(o.dk,1,0,1) DK,o.kv kV,o.nlsa NLSA,o.nlsb NLSB, sum(decode(o.dk,1,o.s2,-o.s2))/100 S,
                      gn.grp GRP,g.name NAME
               from   rez_doc_maket o,accounts a,grp_rez g,grp_rez_nbs gn
               where  tt in ('ARE','AR*') and vdat=l_dat31 and o.nlsa=a.nls and o.kv=a.kv and a.nbs=gn.nbs (+) and
                      a.ob22=gn.ob22 (+) and gn.grp=g.grp (+) and dk <> -1 and L_maket=1 and ref is null
               group by decode(o.dk,1,0,1),o.kv,o.nlsa,o.nlsb,gn.grp,g.name)x, grp_rez g
         where x.grp=g.grp (+)
         group by  g.name,x.grp
        )
   group by name,grp+40;

end;
/
show err;

PROMPT *** Create  grants  P_ORDER_REZ ***
grant EXECUTE                                                                on P_ORDER_REZ     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ORDER_REZ     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ORDER_REZ.sql =========*** End *
PROMPT ===================================================================================== 
