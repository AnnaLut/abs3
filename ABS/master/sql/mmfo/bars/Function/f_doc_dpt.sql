
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_doc_dpt.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DOC_DPT (dpt_id dpt_deposit.deposit_id%type , PR_ NUMBER, NUM_ NUMBER DEFAULT NULL ) RETURN VARCHAR2
IS
STR_    VARCHAR2(250);
l_sum_max   number(24);
l_sum_min   number(24);
l_sum1      number(24);
l_tar1      number(20,4);
l_sum2      number(24);
l_tar2      number(24);
l_cnt_max   number(24);
l_cnt_min   number(24);
l_lcv       tabval$global.lcv%type;

---Функція для визначення змінних договорів(Депозити ФЛ)
BEGIN
STR_:='__';
--PR_=1 - Процентна ставка за Депозитом "Прогрессивный" за період NUM_(ЧИСЛО)(NUM_- номер періода)
--PR_=2 - Процентна ставка за Депозитом "Прогрессивный" за період NUM_(прописом)(NUM_- номер періода)
--PR_=3 - Период действия договора, вычисляется как разница dpt_deposit.dat_end-dpt_deposit.dat_begin.(NUM_=1- число,NUM_=2- прописью)
--PR_=4 - Период действия договора в месяцах, вычисляется как разница dpt_deposit.dat_end-dpt_deposit.dat_begin.(NUM_=1- число,NUM_=2- прописью)
--PR_=5 - Процентна ставка за Депозитом "Накопительный" (ЧИСЛО)
--PR_=6 - Процентна ставка за Депозитом "Накопительный" (прописом)
--PR_=7 - Значения тарифа 70 (NUM_- номер граничной суммы)

 IF PR_= 1 THEN
   BEGIN  ---Деп:  Процентна ставка за Депозитом "Прогрессивный" за період NUM_(ЧИСЛО)(NUM_- номер періода)
    SELECT trim(to_char(rate))
      INTO STR_
      FROM (SELECT i.acc, i.bdat, nvl(i.ir,0) rate,
                   row_number() over (partition by i.acc order by i.bdat) CNT
              FROM int_ratn i, dpt_deposit d
             WHERE i.acc = d.acc  AND d.deposit_id = dpt_id)
     WHERE CNT=NUM_;
     EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
   END;
 ELSIF PR_= 2 THEN
  BEGIN ---Деп:  Процентна ставка за Депозитом "Прогрессивный" за період NUM_(прописом)(NUM_- номер періода)
    SELECT SUBSTR(f_sumpr(rate,null,'F'),1,25)
      INTO STR_
      FROM (SELECT i.acc, i.bdat, nvl(i.ir,0) rate,
                   row_number() over (partition by i.acc order by i.bdat) CNT
              FROM int_ratn i, dpt_deposit d
             WHERE i.acc = d.acc  AND d.deposit_id = dpt_id)
     WHERE CNT=NUM_;
     EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;
  -- PR_ = 3 Период действия договора, вычисляется как разница dpt_deposit.dat_end-dpt_deposit.dat_begin.(NUM_=1- число,NUM_=2- прописью)
 ELSIF PR_ = 3  AND NUM_ = 1 THEN
  BEGIN
    SELECT decode(nvl(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0), 0,'',
                  to_char(trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy'))
                  ,0))||' міс. '
                 )||
           decode(nvl( greatest(to_date(dat_end,'dd.mm.yyyy')-dpt.f_duration(to_date(dat_begin,'dd.mm.yyyy'),trunc(months_between (to_date(dat_end,'dd.mm.yyyy'),to_date(dat_begin, 'dd.mm.yyyy'))),0),0)
                  ,0),0,'',
                  to_char(greatest(to_date(dat_end,'dd.mm.yyyy')-dpt.f_duration(to_date(dat_begin,'dd.mm.yyyy'),trunc(months_between (to_date(dat_end,'dd.mm.yyyy'),to_date(dat_begin, 'dd.mm.yyyy'))),0),0)
                 ||' дн. '))
     INTO STR_
     FROM dpt_deposit
    WHERE deposit_id=dpt_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;
 ELSIF PR_ = 3  AND NUM_ = 2 THEN
  BEGIN

     SELECT decode(nvl(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0), 0,'',
                   f_sumpr(to_char(trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')))), null,'M')
                   ||' міс. '
                  )||
            decode(nvl( greatest(to_date(dat_end,'dd.mm.yyyy')-dpt.f_duration(to_date(dat_begin,'dd.mm.yyyy'),trunc(months_between (to_date(dat_end,'dd.mm.yyyy'),to_date(dat_begin, 'dd.mm.yyyy'))),0),0)
                   ,0),0,'',
                   f_sumpr(to_char(greatest(to_date(dat_end,'dd.mm.yyyy')-dpt.f_duration(to_date(dat_begin,'dd.mm.yyyy'),trunc(months_between (to_date(dat_end,'dd.mm.yyyy'),to_date(dat_begin, 'dd.mm.yyyy'))),0),0)
                                   ), null,'M')||' дн. '
                   )
     INTO STR_
     FROM dpt_deposit
    WHERE deposit_id=dpt_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;


 -- PR_ = 4 Период действия договора в месяцах, вычисляется как разница dpt_deposit.dat_end-dpt_deposit.dat_begin.(NUM_=1- число,NUM_=2- прописью)
 ELSIF PR_ = 4  AND NUM_ = 1 THEN
  BEGIN
    SELECT decode(nvl(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0), 0,'',
                  to_char(trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy'))
                  ,0))||' міс. '
                 )
     INTO STR_
     FROM dpt_deposit
    WHERE deposit_id=dpt_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;
 ELSIF PR_ = 4  AND NUM_ = 2 THEN
  BEGIN

     SELECT decode(nvl(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')),0), 0,'',
                   f_sumpr(to_char(trunc(months_between (to_date(dat_end, 'dd.mm.yyyy'), to_date(dat_begin, 'dd.mm.yyyy')))), null,'M')
                   ||' міс. '
                  )
     INTO STR_
     FROM dpt_deposit
    WHERE deposit_id=dpt_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;

  --PR_=5 - Процентна ставка за Депозитом "Накопительный"(ЧИСЛО)
  ELSIF PR_= 5 THEN
   BEGIN
    SELECT trim(to_char(rate))
      INTO STR_
      FROM (SELECT getbrat(BANKDATE,i.br,d.kv, min(b.s)) RATE
              FROM dpt_deposit d, int_ratn i, br_tier b
             WHERE d.deposit_id =  dpt_id
               AND i.acc   = d.acc and i.id = 1
               AND i.bdat  = (SELECT max(bdat)
                                FROM int_ratn
                               WHERE acc = d.acc
                                 AND id = 1 AND bdat <=BANKDATE )
               AND b.br_id = i.br
               AND b.kv    = d.kv
             GROUP BY i.br, d.kv) ;
     EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
   END;

   --PR_=6 - Процентна ставка за Депозитом "Накопительный" (прописом)
 ELSIF PR_= 6 THEN
  BEGIN
    SELECT SUBSTR(f_sumpr(rate,null,'F'),1,25)
      INTO STR_
      FROM (SELECT getbrat(BANKDATE,i.br,d.kv, min(b.s))RATE
              FROM dpt_deposit d, int_ratn i, br_tier b
             WHERE d.deposit_id =  dpt_id
               AND i.acc   = d.acc and i.id = 1
               AND i.bdat  = (SELECT max(bdat)
                                FROM int_ratn
                               WHERE acc = d.acc
                                 AND id = 1 AND bdat <=BANKDATE )
               AND b.br_id = i.br
               AND b.kv    = d.kv
             GROUP BY i.br, d.kv);
     EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;

 ELSIF PR_= 7 THEN
  BEGIN

        select lcv, t.smin/100
          into l_lcv, l_sum_min
          from tabval$global v, tarif t
         where t.kod = 70 and t.kv= v.kv;

         bars_audit.trace('f_doc_dpt 1 '||'l_lcv  = %s l_sum_min = %s',
                            to_char(l_lcv ), to_char(l_sum_min));

        select max(cnt), min(cnt)
          into l_cnt_max, l_cnt_min
          from (select rownum cnt
                  from tarif_scale
                 where kod = 70
                 order by sum_limit);


        bars_audit.trace('f_doc_dpt 2 '||'l_cnt_max  = %s l_cnt_min  = %s',
                            to_char(l_cnt_max), to_char(l_cnt_min ));

        select nvl(max(s),0),nvl(max(tar),0)
          into l_sum1, l_tar1
          from (select rownum cnt,
                       decode(s.pr, null,
                                    s.sum_tarif/100,
                                    s.pr) tar,
                       s.sum_limit/100 s
                  from tarif_scale s
                 where s.kod =70
                 order by s.sum_limit)
         where cnt = num_;


         bars_audit.trace('f_doc_dpt 3 '||'l_sum1  = %s l_tar1  = %s',
                            to_char(l_sum1,'9999999990D00'), to_char(l_tar1 ));

         select nvl(max(s),0)
           into l_sum2
           from (select rownum cnt,
                        decode(s.pr, null,
                                    s.sum_tarif/100,
                                    s.pr) tar,
                       s.sum_limit/100 s
                  from tarif_scale s
                 where s.kod =70
                 order by s.sum_limit)
         where cnt =num_-1;


         bars_audit.trace('f_doc_dpt 5 '||'l_sum2  = %s ',
                            to_char(l_sum2));


        if    num_ = l_cnt_min
              then
                   STR_:= trim(to_char(l_tar1,'99990D00'))||' від суми до '||
                          trim(to_char(l_sum1,'99999999990D00'))||' але не менше '||
                          trim(to_char(l_sum_min, '9999990D00'));
        elsif num_ = l_cnt_max
              then
                   STR_:= trim(to_char(l_tar1,'99990D00'))||' від суми від '||
                          trim(to_char(l_sum2+0.01,'99999999990D00'));
        elsif num_ > l_cnt_max  or  num_ < l_cnt_min
              then
                   STR_:= ' ';
        else
                   STR_:= trim(to_char(l_tar1,'99990D00'))||' від суми від '||
                          trim(to_char(l_sum2+0.01,'99999999990D00'))||' до '||
                          trim(to_char(l_sum1,'99999999990D00'));
        end if;

         bars_audit.trace('f_doc_dpt 6 '||'STR_ = %s ',
                            STR_);

     EXCEPTION WHEN NO_DATA_FOUND THEN STR_:='__';
  END;
  END IF;

  RETURN  STR_;
END;
/
 show err;
 
PROMPT *** Create  grants  F_DOC_DPT ***
grant EXECUTE                                                                on F_DOC_DPT       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DOC_DPT       to START1;
grant EXECUTE                                                                on F_DOC_DPT       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_doc_dpt.sql =========*** End *** 
 PROMPT ===================================================================================== 
 