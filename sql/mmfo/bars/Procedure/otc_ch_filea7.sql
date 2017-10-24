

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTC_CH_FILEA7.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTC_CH_FILEA7 ***

  CREATE OR REPLACE PROCEDURE BARS.OTC_CH_FILEA7 (p_kodf  VARCHAR2, p_datf  DATE)
   --  AUTHOR:  Virko
   -- VERSION: 02/01/2012 (03/05/2012)
IS
   kol1_      NUMBER := 0;

   pr1_       number := 0;
   pr2_       number := 0;
   pr3_       number := 0;
   pr4_       number := 0;
   pr5_       number := 0;
   pr6_       number := 0;
   pr7_       number := 0;

   txt1_      varchar2(100) := 'Недопустиме значення параметру S240 ';
   txt2_      varchar2(100) := 'Неможливе сполучення: s181 та s240 ';
   txt3_      varchar2(100);
   txt4_      varchar2(100) := 'Не заповнено код s240';
   txt5_      varchar2(100) := 'Не заповнено код s181';
   txt6_      varchar2(100) := 'Недопустиме значення параметру R013';
   txt7_      varchar2(100) := 'Помилково вказано строк погашення S240 (не відповідає R013)';

   err_mes_   varchar2(1000);
   sql_       varchar2(1000);
   umova_     varchar2(1000);

   p_datzv    date := add_months(trunc(p_datf, 'mm'),1);
BEGIN
    FOR t
     IN (select kodp,  znap,
             substr(kodp,1,1)  t020,
             substr(kodp,2,4)  r020,
             substr(kodp,2,3)  gr,
             substr(kodp,2,2)  razd,
             substr(kodp,6,1)  r013,
             substr(kodp,7,1)  s181,
             substr(kodp,8,1)  s240,
             substr(kodp,9,1)  k030,
             substr(kodp,10,1) R012,
             substr(kodp,11,3) R030,
             ERR_MSG
          from tmp_nbu
          where kodf=p_kodf and datf=p_datf --and kodp = '1223802111'
          order by kodp )
    LOOP
        pr1_  := 0;
        pr2_  := 0;
        pr3_  := 0;
        pr4_  := 0;
        pr5_  := 0;
        pr6_  := 0;
        pr7_  := 0;

        if t.s240 = '0' then
            pr4_  := 1;
        else
            begin
                select 1
                into kol1_
                from kl_S240 k
                where s240 = t.s240 and
                      (k.DATA_O<=p_datzv and (k.DATA_C is null or k.DATA_C >= p_datzv)) ;
            exception
            when no_data_found then
                pr1_ := 1;
            end;
        end if;

        if t.s181 not in ('1', '2')  then
            pr5_  := 1;
        end if;

        begin
             select  ns_repl_fox(upper(k.UMOVA))  umova, k.txt
             into umova_, txt3_
             from kod_a7_1 k
             where trim(k.prem) = 'КБ' and
                       t020 = t.t020 and
                       r020 = t.r020 and
                       (k.data_c is null or k.data_c >= p_datzv) ;

             if instr(umova_, 'S181') > 0 and t.s181 <> '0' then
                  sql_ := 'select (case when '|| replace(umova_,'PS181',':s181_') || ' ' ||
                              'then 1 else 0 end) aa from dual';

                  execute immediate sql_ into pr3_ using t.s181;
             elsif  instr(umova_, 'S240') > 0 and t.s240 <> '0' then
                  sql_ := 'select (case when '|| replace(umova_,'PS240',':s240_') || ' ' ||
                              'then 1 else 0 end) aa from dual';

                  execute immediate sql_ into pr3_ using t.s240;
             end if;

             txt3_ := txt3_ || ' ('||REPLACE(umova_, 'PS', 'S')||')';
        exception
        when no_data_found then
            pr3_  := 0;
        end;

         if pr3_ = 0 then
             declare
                s181r_ varchar2(1);
             begin
                select s181
                into s181r_
                from kl_r020
                where trim(pr) is null and
                    r020 = t.r020 and
                    d_open<=p_datzv and
                    (d_close is null or d_close >= p_datzv) and
                    r020 in (select r020
                             from kod_r020
                             where a010 = 'A7' and
                                d_open<=p_datzv and
                                (d_close is null or d_close >= p_datzv)) and
                    nvl(trim(s181),'0') in ('1','2') and
                    r020 not in (select r020 from kod_a7_1);

                 if s181r_ <> t.s181 then
                    pr3_  := 1;
                    txt3_ := 'Строковість не відповідає плану рахунків';
                 end if;
             exception
                when no_data_found then
                    pr3_  := 0;
             end;
         end if;

        if pr1_ = 0 and pr3_ = 0 and pr4_ = 0 and pr5_ = 0 then
            if t.s181 = '1' and t.s240 > 'B'
            then
                pr2_  := 1;
            end if;
        end if;

        begin
             select count(*)
             into kol1_
             from kl_r013 k
             where trim(k.prem) = 'КБ' and
                       r020 = t.r020 and
                       (k.d_open<=p_datzv and (d_close is null or k.d_close >= p_datzv)) ;

             if kol1_ > 0 then
                 begin
                     select 1
                     into kol1_
                     from kl_r013 k
                     where trim(k.prem) = 'КБ' and
                               r020 = t.r020 and
                               r013 = t.r013 and
                               (k.d_open<=p_datzv and (d_close is null or k.d_close >= p_datzv)) ;
                 exception
                    when no_data_found then
                        pr6_ := 1;
                 end;
             else
                if t.r013 <> '0' then
                   pr6_ := 1;
                end if;
             end if;
        end;

        -- перевірка по KOD_A7C5.DBF
        if t.t020 = '2' and t.r020 = '2601' and pr6_ = 0 and pr4_ = 0 and pr1_ = 0 then
           if t.r013 in ('1', '2', '3') and t.s240 <> '1' or
              t.r013 in ('4') and t.s240 = '1'
           then
              pr7_ := 1;
           end if;
        end if;

        if pr1_ + pr2_ + pr3_  + pr4_ + pr5_ + pr6_> 0 then
            err_mes_ := trim((case when  pr1_ = 1 then txt1_ || ' ' else ' ' end)
                        || (case when  pr2_ = 1 then txt2_ || ' ' else ' ' end)
                        || (case when  pr3_ = 1 then txt3_ || ' ' else ' ' end)
                        || (case when  pr4_ = 1 then txt4_ || ' ' else ' ' end)
                        || (case when  pr5_ = 1 then txt5_ || ' ' else ' ' end)
                        || (case when  pr6_ = 1 then txt6_ || ' ' else ' ' end)
                        || (case when  pr7_ = 1 then txt7_ || ' ' else ' ' end)
                        );
        else
            err_mes_ := '';
        end if;

        if err_mes_ is not null or t.err_msg is not null and err_mes_ is null then
            update tmp_nbu
            set err_msg = err_mes_
            where kodf = p_kodf and
               datf = p_datf and
               kodp = t.kodp;
        end if;
    END LOOP;
END;
/
show err;

PROMPT *** Create  grants  OTC_CH_FILEA7 ***
grant EXECUTE                                                                on OTC_CH_FILEA7   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OTC_CH_FILEA7   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTC_CH_FILEA7.sql =========*** End
PROMPT ===================================================================================== 
