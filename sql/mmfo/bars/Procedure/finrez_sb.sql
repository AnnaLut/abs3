

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FINREZ_SB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FINREZ_SB ***

  CREATE OR REPLACE PROCEDURE BARS.FINREZ_SB (dat01_ DATE)
IS

/* Версия 06-10-2015  */

 r_old  NUMBER := 0; -- резерв попереднього періоду (ном)
 r_oldq NUMBER := 0; -- резерв попереднього періоду (екв)
 del    NUMBER := 0; -- доформув.резерву (ном)
 delq   NUMBER := 0; -- доформув.резерву (екв)
 blok_  number;
 dat31_ DATE;
 nms_   ACCOUNTS.nms%type;

BEGIN

   DELETE FROM test_finrez;
   dat31_ := Dat_last (dat01_-4,dat01_-1);  -- последний рабочий день месяца

   begin
      select 1 into blok_ from rez_protocol where dat=dat31_ and crc='1' and rownum=1;
   EXCEPTION WHEN NO_DATA_FOUND THEN blok_:=0;
   end;

   if blok_=0 THEN
      rezerv_23(dat01_);
      p_2400_23(dat01_);
   end if;

   FOR k IN (select rtrim(substr(branch||'/',1,instr(branch||'/','/',1,3)-1),'/')||'/' branch, kat s080,
                    sum(rez) r_t, sum(rezq) r_tq, sum(rezn) r_tn, sum(reznq) r_tnq, sum(rez_30) r30, sum(rezq_30) rq30,
                    kv, acc_rez , acc_rezn, acc_rez_30, ob22_rez, ob22_rezn, ob22_rez_30,nls_rez   ,nls_rezn,nls_rez_30
             from   nbu23_rez where fdat=dat01_
             group  by rtrim(substr(branch||'/',1,instr(branch||'/','/',1,3)-1),'/')||'/' ,kat,kv,acc_rez,acc_rezn,
                       nls_rez,nls_rezn,ob22_rez,ob22_rezn,acc_rez_30,ob22_rez_30,nls_rez_30 )

   LOOP

      nms_:=null;

      BEGIN
         if k.r_t <>0 and (k.r_t<>k.r_tn or k.r_t<>k.r30)   THEN
            if k.nls_rez is not null THEN
               begin
                  select ost_korr(acc,dat31_,null, nbs),nms INTO r_old,nms_
                  from accounts where acc=k.acc_rez;
               EXCEPTION WHEN NO_DATA_FOUND THEN
               r_old:=0;
               end;

               r_oldq := p_icurval(k.kv,r_old,dat31_);
               if k.r30<>0 THEN
                   del :=k.r_t -k.r30 - r_old/100;
                   delq:=k.r_tq-k.rq30 - r_oldq/100;
               else
                  del :=k.r_t -k.r_tn -r_old/100;
                  delq:=k.r_tq-k.r_tnq-r_oldq/100;
               end if;

               update test_finrez
                  set s_oldf2  = s_oldf2 + decode(k.r30,0,(k.r_t -k.r_tn) ,(k.r_t -k.r30)) , --Розрахунковий резерв ном.
                      sq_oldf2 = sq_oldf2+ decode(k.r30,0,(k.r_tq-k.r_tnq),(k.r_t -k.rq30)), --Розрахунковий резерв екв.
                      s_del    = s_del   + decode(k.r30,0,(k.r_t -k.r_tn) ,(k.r_t -k.r30)) , -- разница (розр.-факт.) ном.
                      sq_del   = sq_del  + decode(k.r30,0,(k.r_tq-k.r_tnq),(k.r_t -k.rq30))  -- разница (розр.-факт.) екв.
               where   nls = k.nls_rez and kv = k.kv and ob22 = k.ob22_rez;

               IF SQL%ROWCOUNT=0 then

                  INSERT INTO test_finrez ( nls   ,nbs,branch,s080,kv,ob22,nls_r,acc,nms,s_oldf1,sq_oldf1,s_oldf2,sq_oldf2,s_del,
                                            sq_del,txt)
                                  VALUES  ( k.nls_rez,substr(k.nls_rez,1,4),k.branch  ,k.s080,k.kv,k.ob22_rez,k.nls_rez,k.acc_rez,
                                            nms_     ,r_old/100            ,r_oldq/100,decode(k.r30,0,k.r_t -k.r_tn ,k.r_t -k.r30 ),
                                            decode(k.r30,0,k.r_tq-k.r_tnq,k.r_t -k.rq30),
                                            decode(k.r30,0,k.r_t -k.r_tn ,k.r_t -k.r30 ) -r_old/100 ,
                                            decode(k.r30,0,k.r_tq-k.r_tnq,k.r_t -k.rq30) -r_oldq/100,'вкл в налоговий' );
               END iF;

            else
               r_old  := 0;
               r_oldq := 0;
               del    := k.r_t-r_old;
               delq   := k.r_tq-r_oldq;
            end if;
         end if;
         if k.r_tn <> 0 and k.r30<>0 and substr(k.nls_rezn,1,4) in
                            ('2400','3599','3190','2401','1590','1592','1490','1491','3599') THEN
            if k.nls_rezn is not null THEN
               begin
                  select ost_korr (acc,dat31_,null, nbs),nms INTO r_old,nms_ from accounts
                  where acc=k.acc_rezn;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  r_old:=0;
               end;

               r_oldq := p_icurval(k.kv,r_old,dat31_);
               del    := k.r_tn-r_old/100;
               delq   := k.r_tnq-r_oldq/100;
               update test_finrez set s_oldf2  = s_oldf2 + k.r_tn, sq_oldf2 = sq_oldf2+ k.r_tnq,s_del = s_oldf2 + k.r_tn - r_old/100,
                                      sq_del   = sq_oldf2+ k.r_tnq- r_oldq/100
               where nls = k.nls_rezn and kv = k.kv and ob22 = k.ob22_rezn;

               IF SQL%ROWCOUNT=0 then

                  INSERT INTO test_finrez (nls   ,nbs,branch,s080,kv,ob22,nls_r,acc,nms,s_oldf1,sq_oldf1,s_oldf2,sq_oldf2, s_del,
                                           sq_del,txt)
                                   VALUES (k.nls_rezn,substr(k.nls_rezn,1,4),k.branch ,k.s080    , k.kv ,k.ob22_rezn,k.nls_rezn,
                                           k.acc_rezn,nms_                  ,r_old/100,r_oldq/100,k.r_tn,k.r_tnq    ,del       ,
                                           delq,'не вкл.в налоговий');
               END IF;

            else
               r_old  := 0;
               r_oldq := 0;
               del    := k.r_t-r_old;
               delq   := k.r_tq-r_oldq;
            end if;
         end if;
         if k.r_tn <> 0 and k.r30=0 THEN
            if k.nls_rezn is not null THEN
               begin
                  select ost_korr (acc,dat31_,null, nbs),nms INTO r_old,nms_ from accounts
                  where acc=k.acc_rezn;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  r_old:=0;
               end;

               r_oldq := p_icurval(k.kv,r_old,dat31_);
               del    := k.r_tn-r_old/100;
               delq   := k.r_tnq-r_oldq/100;
               update test_finrez set s_oldf2  = s_oldf2 + k.r_tn ,sq_oldf2 = sq_oldf2+ k.r_tnq,s_del=s_oldf2 + k.r_tn - r_old/100,
                                      sq_del   = sq_oldf2+ k.r_tnq- r_oldq/100
               where nls = k.nls_rezn and kv = k.kv and ob22 = k.ob22_rezn;

               IF SQL%ROWCOUNT=0 then

                  INSERT INTO test_finrez  (nls   ,nbs,branch,s080,kv,ob22,nls_r,acc,nms,s_oldf1,sq_oldf1, s_oldf2,sq_oldf2, s_del,
                                            sq_del,txt)
                 VALUES (k.nls_rezn,substr(k.nls_rezn,1,4),k.branch,k.s080 ,k.kv,k.ob22_rezn,k.nls_rezn,k.acc_rezn,nms_,
                         r_old/100 ,r_oldq/100            ,k.r_tn  ,k.r_tnq,del ,delq       ,'не вкл.в налоговий');
               END IF;

            else
               r_old  := 0;
               r_oldq := 0;
               del    := k.r_t-r_old;
               delq   := k.r_tq-r_oldq;
            end if;
         end if;
         if k.r30 <> 0 THEN
            if k.nls_rez_30 is not null THEN
               begin
                  select ost_korr (acc,dat31_,null, nbs),nms INTO r_old,nms_ from accounts
                  where acc=k.acc_rez_30;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  r_old:=0;
               end;

               r_oldq := p_icurval(k.kv,r_old,dat31_);
               del    := k.r30-r_old/100;
               delq   := k.rq30-r_oldq/100;
               update test_finrez set s_oldf2  = s_oldf2 + k.r30 ,sq_oldf2 = sq_oldf2+ k.rq30,s_del = s_oldf2 + k.r30 - r_old/100,
                                      sq_del   = sq_oldf2+ k.rq30- r_oldq/100
               where nls = k.nls_rez_30 and kv = k.kv and ob22 = k.ob22_rez_30;

               IF SQL%ROWCOUNT=0 then

                  INSERT INTO test_finrez (nls,nbs,branch,s080,kv,ob22,nls_r,acc,nms,s_oldf1,sq_oldf1,s_oldf2,sq_oldf2, s_del,
                                           sq_del,txt)
                                   VALUES (k.nls_rez_30,substr(k.nls_rez_30,1,4),k.branch,k.s080, k.kv,k.ob22_rez_30,
                                           k.nls_rez_30,k.acc_rez_30,nms_,r_old/100,  r_oldq/100, k.r30, k.rq30, del,
                                           delq,'не вкл.в налоговий');
               END IF;

            else
               r_old  := 0;
               r_oldq := 0;
               del    := k.r_t-r_old;
               delq   := k.r_tq-r_oldq;
            end if;
         end if;

      END;
   END LOOP;

   INSERT INTO test_finrez (nbs,branch, s080,kv,  ob22,nls_r,  acc,fondid,s_oldf1,sq_oldf1,s_oldf2,sq_oldf2, s_del,  sq_del,txt)
         (select substr(a.nls,1,4),rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,a.s080, a.kv,a.ob22,
                 a.nls,a.acc,null,ost_korr(a.acc,dat31_,null,a.nbs)/100,
                 gl.p_icurval (a.kv, ost_korr(a.acc,dat31_,null,a.nbs), dat31_)/100,0,0,-ost_korr(a.acc,dat31_,null,a.nbs)/100,
                -gl.p_icurval (a.kv, ost_korr(a.acc,dat31_,null,a.nbs), dat31_)/100,'був резерв і немає'
          from v_gls080 a
          where a.nbs in ('1490','1492','3190','3191', -- ЦП в портфелi на продаж
                          '1491','1493','3290','3291', -- ЦП в портфелi до погашення
                          '1590','1592',               -- Операцiї на мiжбанкiвському ринку
                          '1890','2890','3590','3599', -- Дебiторська заборгованнiсть
                          '2400','2401','3690')
                and a.dazs is null and ost_korr(a.acc,dat31_,null,a.nbs) <> 0 and
                not exists (select 1 from test_finrez t where a.acc=t.acc )
          group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
                   a.s080,a.nls, a.kv);
   COMMIT;

END finrez_SB;
/
show err;

PROMPT *** Create  grants  FINREZ_SB ***
grant EXECUTE                                                                on FINREZ_SB       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FINREZ_SB       to RCC_DEAL;
grant EXECUTE                                                                on FINREZ_SB       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FINREZ_SB.sql =========*** End ***
PROMPT ===================================================================================== 
