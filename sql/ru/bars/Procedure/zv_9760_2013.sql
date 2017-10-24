

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ZV_9760_2013.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ZV_9760_2013 ***

  CREATE OR REPLACE PROCEDURE BARS.ZV_9760_2013 (
                dat1 date,
                dat2 date,
                par number default 1
                )
     IS

  fdat_ date ;
  vdat_ date;
  kod_ char(4);
  acc_a_ integer;
  nbs_a_ char(4);
  ob22_a_ char(2);
  nls_a_ varchar2(14);
  acc_b_ integer;
  nbs_b_ char(4);
  ob22_b_ char(2);
  nls_b_ varchar2(14);
  nazn_ varchar2(170);
  branch_ varchar2(30);
  branch_a_ varchar2(30);
  branch_b_ varchar2(30);
  mfo_a_ integer;
  mfo_b_ integer;
  i_ number := 0;
  n_ number:=0;
  err_ number :=0;
  rec_ number :=0;

begin

if par = 1 then goto exit1;
end if;


           dbms_application_info.set_client_info('Start '||Sysdate);
for k in (
select distinct ref, s, fdat, tt, sos , stmT
from opldok o
where exists (select 1 from fdat where o.fdat = fdat and ( fdat between dat1 and dat2+20))
and exists (select acc from accounts where nbs = '9760' and ob22 in ('01','23') and acc = o.acc)
and not exists (select 1 from TMP_9760_2013 where ref = o.ref and stmt = o.stmt)

union all
select distinct ref, s, fdat, tt, sos, stmT
from opldok o
where exists (select 1 from fdat where o.fdat = fdat and ( fdat between dat1 and dat2+20))
and  exists (select acc from accounts where nbs = '2906' and ob22 not in ('15') and acc = o.acc
)
and not exists (select 1 from TMP_9760_2013 where ref = o.ref and stmt = o.stmt)
--and sos = 5
            )
            LOOP

            select    SUM (DECODE (dk, 0, acc, 0)) accd,       SUM (DECODE (dk, 1, acc, 0)) acck--, s
               into acc_a_, acc_b_--, s_
              from opldok
            where ref = k.ref and fdat = k.fdat and stmt = k.stmt
            group by stmt;

            select nazn, vdat, mfoa, mfob
              into nazn_, vdat_, mfo_a_, mfo_b_
              from oper
              where ref = k.ref;

              begin
            select nls, nbs, ob22, branch
               into nls_a_, nbs_a_, ob22_a_, branch_a_
              from accounts
              where acc = acc_a_;
              exception when NO_DATA_FOUND THEN  nls_a_ := null; nbs_a_ := null; ob22_a_ := null; branch_a_ := null;
              end;

              begin
            select nls, nbs, ob22, branch
               into nls_b_, nbs_b_, ob22_b_, branch_b_
              from accounts
              where acc = acc_b_;
              exception when NO_DATA_FOUND THEN  nls_b_ := null;  nbs_b_ := null;  ob22_b_:= null; branch_b_ := null;
              end;




                    if nbs_a_ = '9760'       then branch_ := branch_a_;
                    elsif nbs_b_ = '9760' then branch_ := branch_b_;
                    elsif nbs_b_ = '2906' and mfo_b_ = f_ourmfo then branch_ := branch_b_;
                    elsif nbs_a_ = '2906' and mfo_a_ = f_ourmfo then branch_ := branch_a_;
                    elsif nbs_a_ = '2924' and mfo_a_ = f_ourmfo then branch_ := branch_a_;
					elsif nbs_b_ = '2924' and mfo_a_ = f_ourmfo then branch_ := branch_b_;
                    else branch_ := '/';
                    end if;


           if nbs_a_ = '9760' and
              nbs_b_ = '9910' and ob22_b_ = '01'                  then kod_ := 'ZARH' ;  -- зарахування  (компенсація, зміна пр. спадщина)
        elsif  nbs_a_ = '9910' and ob22_a_ = '01' and
              nbs_b_ = '9760'                                               then kod_ := 'SPIS';   -- списання (компенсація, зміна пр. спадщина)

        elsif nbs_a_ = '9760' and
              nbs_b_ = '9910' and ob22_b_ = '07'                  then kod_ := 'ZVNP';   -- зарахування  (переказ внутрірегіональний)
        elsif  nbs_a_ = '9910' and ob22_a_ = '07' and
              nbs_b_ = '9760'                                               then kod_ := 'SVNP' ;  -- списання (переказ внутрірегіональний)

        elsif nbs_a_ = '9760' and
              nbs_b_ = '9910' and ob22_b_ = '06'                  then kod_ := 'ZZVP' ;  -- зарахування  (переказ зовнішній)
        elsif  nbs_a_ = '9910' and ob22_a_ = '06' and
              nbs_b_ = '9760'                                               then kod_ := 'SZVP' ;  -- списання (Переказ зовнішній)

       elsif nbs_a_ = '2906' and ob22_a_ ='09' and NBS_b_ = '3739' and mfo_b_ != f_ourmfo           then kod_ := 'KKS9'; -- 2906 spisaniy 09
       elsif nbs_a_ = '3739'    and NBS_b_ = '2906' and ob22_b_ ='09' and mfo_a_ != f_ourmfo           then kod_ := 'KKZ9'; -- 2906 zarahuvanny 09
       elsif nbs_a_ = '2906' and ob22_a_ ='16' and NBS_b_ = '3739' and mfo_b_ != f_ourmfo           then kod_ := 'KKS6'; -- 2906 spisaniy  16
       elsif nbs_a_ = '3739'    and NBS_b_ = '2906' and ob22_b_ ='16' and mfo_a_ != f_ourmfo           then kod_ := 'KKZ6'; -- 2906 zarahuvanny 16

       elsif  nbs_a_ = '2906'   and NBS_b_ = '2924' and mfo_a_ = f_ourmfo and mfo_b_ = f_ourmfo then kod_ := 'z294';  -- зарахування на БПК
       elsif  nbs_a_ = '2906'   and NBS_b_ in ( '2620', '2630', '2638', '2635') and mfo_a_ = f_ourmfo and mfo_b_ = f_ourmfo then kod_ := 'z262';  -- зарахування на 2620
       elsif  nbs_a_ = '2924' and NBS_b_ = '2906'   then kod_ := 'a294';  -- повернуто з БПК
       elsif  nbs_a_ in ( '2620', '2630', '2638', '2635') and NBS_b_ = '2906'   then kod_ := 'a262';  -- повернуто з 2620

       elsif  nbs_a_ = '2906'  and NBS_b_ = '2906'   then kod_ := '6__6';  -- перекидка з 2906-2906
       elsif  nbs_a_ = '9760' and NBS_b_ = '9760'  then kod_ := '9__9';  -- перекидка з 9760-9760

       elsif ( nbs_a_ = '2906' or NBS_b_ = '2906') and mfo_a_ = f_ourmfo and mfo_b_ = f_ourmfo then kod_ := '!!29';  -- НЕ ВИЯСНЕНІ ПО  2906
       else kod_ := '!!!!';
       end if;




       n_ := n_ +1;


            if   k.sos <4  then null;
            else
           begin
           insert into tmp_9760_2013 ( ref , stmt,  fdat ,    vdat ,    tt ,    kod ,    acc_a,      nbs_a,           ob22_a ,   nls_a   ,        acc_b,         nbs_b,     ob22_b,  nls_b ,     s,     nazn,              sos ,    branch)
           values (k.ref , k.stmt,  k.fdat ,    vdat_ ,    k.tt ,    kod_,    acc_a_,      nbs_a_,          ob22_a_ ,   nls_a_   ,        acc_b_,         nbs_b_,     ob22_b_,  nls_b_ ,     k.s,     nazn_,              k.sos ,    branch_);
           exception  when others then
           insert into tmp_9760_2013 ( ref , stmt,   fdat ,    vdat ,    tt ,    kod ,    acc_a,      nbs_a,           ob22_a ,   nls_a   ,        acc_b,         nbs_b,     ob22_b,  nls_b ,     s,     nazn,              sos ,    branch)
           values (-k.ref , k.stmt,  k.fdat ,    vdat_ ,    k.tt ,    kod_,    acc_a_,      nbs_a_,          ob22_a_ ,   nls_a_   ,        acc_b_,         nbs_b_,     ob22_b_,  nls_b_ ,     k.s,     nazn_,              k.sos ,    branch_);
           err_ := err_ + 1 ;
           end;
           i_ := i_ +1;
           dbms_application_info.set_client_info('Count - '||n_||' Insert - '||i_||' Err_ '||err_ );

       --    commit;
           end if;

           commit;

           END LOOP;

           begin
           select min(stmt) into rec_ from tmp_9760_2013;
           exception when NO_DATA_FOUND THEN  rec_ :=0;
              end;

           dbms_application_info.set_client_info('Start2 '||Sysdate);

           delete from tmp_9760_2013 where kod = 'INFO';
           commit;

           for k in (
                      select
                        b.nls,  sum(a.s) as s, b.branch, a.datp ,  b.acc, b.ob22, a.nazn
                         from arc_rrp a, accounts b
                        where exists (select 1 from tzapros where rec = a.rec and STMP >= dat1  and STMP <= dat2 )
                        and a.dk=3 and a.nlsb like '2906_90___12' and a.kv = 980 and a.mfoa ='300465'
                         and a.nlsa =  '290642012'
                         and a.nlsb=b.nls
                         and a.kv=b.kv
                         group by b.nls, b.branch, a.datp ,  b.acc, b.ob22, a.nazn
                     )
         loop
         rec_ := rec_ + 1;
          insert into tmp_9760_2013 ( ref , stmt,  fdat ,    vdat ,    tt ,    kod ,    acc_a,      nbs_a,           ob22_a ,   nls_a   ,        acc_b,         nbs_b,     ob22_b,  nls_b ,     s,     nazn,              sos ,    branch)
           values (rec_ , -rec_,  k.datp ,    k.datp ,    'INF' ,    'INFO',    0,      0,         null ,   '2906',        k.acc,         '2906',     k.ob22,  k.nls ,     k.s,     k.nazn,              5 ,    k.branch);
           n_ := n_ +1;
           i_ := i_ +1;
                      dbms_application_info.set_client_info('Count2 - '||n_||' Insert - '||i_||' Err_ '||err_ );
        --     commit;
         end loop;

         commit;

           <<exit1>> null;

           END zv_9760_2013;
/
show err;

PROMPT *** Create  grants  ZV_9760_2013 ***
grant EXECUTE                                                                on ZV_9760_2013    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ZV_9760_2013    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ZV_9760_2013.sql =========*** End 
PROMPT ===================================================================================== 
