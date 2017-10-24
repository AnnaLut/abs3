

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILEA7.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILEA7 ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILEA7 (kodf_      VARCHAR2,
                                              dat_       DATE,
                                              userid_    NUMBER)
IS
   kol_       NUMBER := 0;
   kol1_      NUMBER := 0;

   pr1_       number := 0;
   pr2_       number := 0;
   pr3_       number := 0;
   pr4_       number := 0;
   pr5_       number := 0;
   pr6_       number := 0;

   txt1_      varchar2(100) := 'Закриті коди S240 ''8'' та ''9'' ';
   txt2_      varchar2(100) := 'Неможливе сполучення: s181 = ''1'', а s240 > ''B'' ';
   txt3_      varchar2(100);
   txt4_      varchar2(100) := 'Не заповнено код s240';
   txt5_      varchar2(100) := 'Не заповнено код s181';
   txt6_      varchar2(100) := 'Недопустиме значення параметру R013';

   sql_       varchar2(1000);
   umova_     varchar2(1000);
   err_mes_   varchar2(1000);
BEGIN
   DELETE FROM otcn_log
         WHERE userid = userid_ AND kodf = kodf_;

   INSERT INTO otcn_log (kodf, userid, txt)
        VALUES (kodf_, userid_, 'Перевiрка файлу  #' || kodf_);

   INSERT INTO otcn_log (kodf, userid, txt)
        VALUES (kodf_, userid_, ' ');

   SELECT COUNT (*)
     INTO kol_
     FROM v_banks_report
    WHERE kodf = kodf_ AND datf = dat_;

   IF kol_ >= 0
   THEN
      INSERT INTO otcn_log (kodf, userid, txt)
           VALUES (kodf_, userid_, '   *** Звiт банку ***');

      INSERT INTO otcn_log (kodf, userid, txt)
           VALUES (kodf_, userid_, ' ');

      INSERT INTO otcn_log (kodf, userid, txt)
           VALUES (
                     kodf_,
                     userid_,
                     'Контроль строків до погашення S240 та сполучень S181, S240');

      INSERT INTO otcn_log (kodf, userid, txt)
           VALUES (kodf_, userid_, ' ');

     FOR t
         IN (select kodp,  znap,
                 substr(kodp,1,1)  t020,
                 substr(kodp,2,4)  r020,
                 substr(kodp,2,3)  gr,
                 substr(kodp,2,2)  razd,
                 substr(kodp,6,1)  r013,
                 substr(kodp,7,1)  s181,
                 substr(kodp,8,1)  s240,
                 substr(kodp,9,1) r031,
                 substr(kodp,10,1) k030,
                 ERR_MSG
              from tmp_nbu
              where kodf='A7' and datf=dat_
              order by kodp )
      LOOP
         pr1_  := 0;
         pr2_  := 0;
         pr3_  := 0;
         pr4_  := 0;
         pr5_  := 0;
         pr6_  := 0;

         if t.s240 in ('8', '9') then
            pr1_  := 1;
          end if;

         if t.s181 = '1' and t.s240 > 'B' then
            pr2_  := 1;
         end if;

         if t.s240 = '0' then
            pr4_  := 1;
         end if;

         if t.s181 = '0'  then
            pr5_  := 1;
         end if;

         begin
             select  ns_repl_fox(upper(k.UMOVA))  umova, k.txt
             into umova_, txt3_
             from kod_a7_1 k
             where trim(k.prem) = 'КБ' and
                       t020 = t.t020 and
                       r020 = t.r020 and
                       (k.data_c is null or k.data_c >= dat_) ;

             pr3_  := 0;

             if instr(umova_, 'S181') > 0 and t.s181 <> '0' then
                  sql_ := 'select (case when '|| replace(umova_,'PS181',':s181_') || ' ' ||
                              'then 1 else 0 end) aa from dual';

                  execute immediate sql_ into pr3_ using t.s181;
             elsif  instr(umova_, 'S240') > 0 and t.s240 <> '0' then
                  sql_ := 'select (case when '|| replace(umova_,'PS240',':s240_') || ' ' ||
                              'then 1 else 0 end) aa from dual';

                  execute immediate sql_ into pr3_ using t.s240;
             end if;
         exception
            when no_data_found then
                pr3_  := 0;
         end;

         begin
             select count(*)
             into kol1_
             from kl_r013 k
             where trim(k.prem) = 'КБ' and
                       r020 = t.r020 and
                       (k.d_open>=dat_ and (d_close is null or k.d_close >= dat_)) ;

             if kol1_ > 0 then
                 if t.r013 = '0' then
                    pr6_ := 0;
                 else
                     begin
                         select 1
                         into kol1_
                         from kl_r013 k
                         where trim(k.prem) = 'КБ' and
                                   r020 = t.r020 and
                                   r013 = t.r013 and
                                   (k.d_open>=dat_ and (d_close is null or k.d_close >= dat_)) ;
                     exception
                        when no_data_found then
                            pr6_ := 0;
                     end;
                 end if;
             end if;
         end;

         if pr1_ + pr2_ + pr3_  + pr4_ + pr5_ + pr6_> 0 then
            err_mes_ := '   Показник = '  || t.kodp || ' '
                            || (case when  pr1_ = 1 then txt1_ || ' ' else ' ' end)
                            || (case when  pr2_ = 1 then txt2_ || ' ' else ' ' end)
                            || (case when  pr3_ = 1 then txt3_ || ' ' else ' ' end)
                            || (case when  pr4_ = 1 then txt4_ || ' ' else ' ' end)
                            || (case when  pr5_ = 1 then txt5_ || ' ' else ' ' end)
                            || (case when  pr6_ = 1 then txt6_ || ' ' else ' ' end);

            INSERT INTO otcn_log (kodf, userid, txt)
             VALUES (kodf_,  userid_, err_mes_);

             INSERT INTO otcn_log (kodf, userid, txt)
                   VALUES (kodf_, userid_, ' ');

             INSERT INTO otcn_log (kodf, userid, txt)
             select kodf_, userid_,
                            'Рахунок = ' || r.nls || ' ' ||
                            ' валюта = ' || r.kv  || ' ' ||
                            ' РНК = ' || a.rnk || ' ' ||
                            a.nms || ' '
              from rnbu_trace r, accounts a
              where r.kodp = t.kodp and
                        r.acc = a.acc
              order by r.nls, r.kv;

              INSERT INTO otcn_log (kodf, userid, txt)
                   VALUES (kodf_, userid_, ' ');
         end if;

      END LOOP;
   END IF;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILEA7.sql =========*** End *
PROMPT ===================================================================================== 
