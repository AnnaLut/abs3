

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ISTVAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ISTVAL ***

  CREATE OR REPLACE PROCEDURE BARS.P_ISTVAL (Dat01_ DATE) IS

s1_   varchar2(15);
s2_   varchar2(1000);
s3_   number;
nn_   number;
n_    number;
name_ tabval.name%type;
lcv_  tabval.lcv%type;

begin
   delete from tmp_istval;
   begin
      select sum(rezq) into s3_ from nbu23_rez
      where  fdat=dat01_ and id like 'CCK2%' and kv<>980; -- 1
   EXCEPTION WHEN NO_DATA_FOUND THEN
   RETURN;
   end;
   insert into tmp_istval ( NN,s1,s2,s3,s4)
                   values ( 1,'1','Кредитні операції в іноземній валюті,крім операцій на міжбанківському ринку, із них:',
                            s3_,s3_);
   begin
      select sum(rezq) into s3_ from nbu23_rez
      where  fdat=dat01_ and id like 'CCK2%' and kv<>980 and istval=0;  --  1.1
   EXCEPTION WHEN NO_DATA_FOUND THEN
   RETURN;
   end;
   insert into tmp_istval ( NN,s1,s2,s3,s4)
                   values ( 2,'1.1','кредитні операції в іноземній валюті з позичальниками, у яких немає документально підтверджених очікуваних надходжень валютної виручки, із них:',
                            s3_,s3_);
   begin
      select sum(rezq) into s3_ from nbu23_rez
      where  fdat=dat01_ and id like 'CCK2%' and kv<>980 and istval=0 and sdate > to_date('28-12-2008','dd-mm-yyyy'); --1.1.1
   EXCEPTION WHEN NO_DATA_FOUND THEN
   RETURN;
   end;
   insert into tmp_istval ( NN,s1,s2,s3,s4)
                   values ( 3,'1.1.1','за кредитами, наданими з 28 грудня 2008 року, із них:',
                            s3_,s3_);
   NN_ := 4;
   n_  := 1;
   for k in (select kv,sum(rez) rez,sum(rezq) rezq from nbu23_rez
             where     fdat=dat01_
                   and id like 'CCK2%'
                   and kv<>980
                   and rez<>0
                   and istval=0
                   and sdate > to_date('28-12-2008','dd-mm-yyyy')
             group by kv ) --1.1.1.1
   LOOP
      begin
         select name,lcv into name_,lcv_ from tabval
         where kv=k.kv;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         name_ :='';
         lcv_  :='';
      end;
      s1_:='1.1.1.'||to_char(n_);
      s2_:=name_||'('||LCV_||')';
      insert into tmp_istval ( NN,s1,s2,s3,s4)
                      values ( NN_,s1_,s2_,k.rez,k.rez);
      s1_:=s1_||'.1';
      s2_:='гривневий еквівалент';
      insert into tmp_istval ( NN,s1,s2,s3,s4)
                      values ( NN_,s1_,s2_,k.rezq,k.rezq);
      N_:=N_+1;

   END LOOP;

 commit;
end;
/
show err;

PROMPT *** Create  grants  P_ISTVAL ***
grant EXECUTE                                                                on P_ISTVAL        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ISTVAL        to RCC_DEAL;
grant EXECUTE                                                                on P_ISTVAL        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ISTVAL.sql =========*** End *** 
PROMPT ===================================================================================== 
