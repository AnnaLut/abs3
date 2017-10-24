

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DOC_MAKET.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DOC_MAKET ***

  CREATE OR REPLACE PROCEDURE BARS.P_DOC_MAKET (Dat01_ DATE) IS

dat31_ date;

begin
   dat31_ := Dat_last_work (dat01_ -1 );
   delete from ver_doc_maket;
   insert into ver_doc_maket (nbs,NLS_REZ,ob22,KV,acc_rez,s1,sq1,nlsa,ost,delta)
   select y.nbs,x.NLS_REZ,y.ob22,y.KV,x.acc_rez,nvl(x.s1,0),nvl(x.sq1,0),y.nlsa,nvl(y.ost,0) ost,nvl(x.s1,0)-nvl(y.ost,0) delta
   from  (select nls_rez,kv,acc_rez,nvl(sum(rez_0),0) s1,nvl(sum(rezq_0),0) sq1 from nbu23_rez
          where  fdat=dat01_ and acc_rez <>0 and rez_0 <>0 group by nls_rez,kv,acc_rez
          union  all
          select nls_rezn,kv,acc_rezn,nvl(sum(rezn),0),nvl(sum(reznq),0) from nbu23_rez
          where  fdat=dat01_ and acc_rezn<> 0 and rezn <>0 group by nls_rezn,kv,acc_rezn
          union  all
          select nls_rez_30,kv,acc_rez_30,nvl(sum(rez_30),0),nvl(sum(rezq_30),0) from nbu23_rez
          where  fdat=dat01_ and acc_rez_30<> 0 and rez_30 <>0 group by nls_rez_30,kv,acc_rez_30
          union  all
          select nls_rez,kv,nvl(acc_rez,0),nvl(sum(rez_0),0),nvl(sum(rezq_0),0) from nbu23_rez
          where  fdat=dat01_ and acc_rez is null and rez_0 <>0 group by nls_rez,kv,nvl(acc_rez,0)
          union  all
          select nls_rezn,kv,nvl(acc_rezn,0),nvl(sum(Rezn),0),nvl(sum(Reznq),0) from nbu23_rez
          where  fdat=dat01_ and acc_rezn is null and rezn <>0 group by nls_rezn,kv,nvl(acc_rezn,0)
          union  all
          select nls_rez_30,kv,nvl(acc_rez_30,0),nvl(sum(rez_30),0),nvl(sum(rezq_30),0) from nbu23_rez
          where  fdat=dat01_ and acc_rez_30 is null and rez_30 <>0 group by nls_rez_30,kv,nvl(acc_rez_30,0)) x,
         (select l.nlsa,l.kv,l.ob22,l.nbs,l.acc,decode(dk,1,l.ost+l.s,-1,l.ost,l.ost-l.s)/100 ost
          from  (select d.nlsa,d.kv,a.acc,a.ob22,a.nbs,ost_korr(a.acc,dat31_,null,a.nbs) ost, d.s, d.dk
                 from rez_doc_maket d,accounts a
                 where d.nlsa=a.nls and d.kv=a.kv ) l
         )  y
    where  x.acc_rez =y.acc (+) ;
end;
/
show err;

PROMPT *** Create  grants  P_DOC_MAKET ***
grant EXECUTE                                                                on P_DOC_MAKET     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_DOC_MAKET     to RCC_DEAL;
grant EXECUTE                                                                on P_DOC_MAKET     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DOC_MAKET.sql =========*** End *
PROMPT ===================================================================================== 
