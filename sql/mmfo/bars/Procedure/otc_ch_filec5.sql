

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTC_CH_FILEC5.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTC_CH_FILEC5 ***

  CREATE OR REPLACE PROCEDURE BARS.OTC_CH_FILEC5 (p_kodf varchar2,p_datf date)
   --  AUTHOR:  Virko
   -- VERSION: 17.04.2011
is
   kol_       NUMBER := 0;
   kol1_      NUMBER := 0;

   pr1_       number := 0;

   txt1_      varchar2(100) := 'Помилковий R013';

   err_mes_   varchar2(1000);
   sql_       varchar2(1000);
   umova_     varchar2(1000);

--   p_pall     number;
--   p_aa       varchar2(1000);
BEGIN
    FOR t
     IN (select kodp,  znap,
             substr(kodp,2,4)  r020,
             substr(kodp,2,3)  gr,
             substr(kodp,2,2)  razd,
             substr(kodp,6,1)  r013,
             ERR_MSG
          from tmp_nbu
          where kodf=p_kodf and datf=p_datf --and kodp='12062051L9E1124978804208'
          order by kodp )
    LOOP
        pr1_  := 0;
        kol_ := 0;
        kol1_ := 0;

        err_mes_  := null;

        -- перевірка параметра R013
        select count(*) INTO kol_ from KL_R013 k
        where trim(k.prem) = 'КБ' and
              r020 = t.r020 and
              (k.d_close is null or k.d_close >= p_datf);

        if kol_ > 0 then
            if t.r013 = '0' then
               pr1_  := 1;
            else
               select count(*)
               into kol1_
               from kl_r013 k
               where trim(k.prem) = 'КБ' and
                       r020 = t.r020 and
                       r013 = t.r013 and
                       (k.d_close is null or k.d_close >= p_datf);

               if kol1_ = 0 then
                  pr1_ := 1;
               end if;
            end if;
        else
            if t.r013 <> '0' then
               pr1_ := 1;
            end if;
        end if;

        if pr1_ > 0 then
            err_mes_ := trim((case when  pr1_ = 1 then txt1_ || ' ' else ' ' end));
        end if;

        if err_mes_ is not null or t.err_msg is not null and err_mes_ is null then
            update tmp_nbu
            set err_msg = err_mes_
            where kodf = p_kodf and
               datf = p_datf and
               kodp = t.kodp;
        end if;
    END LOOP;
end;
/
show err;

PROMPT *** Create  grants  OTC_CH_FILEC5 ***
grant EXECUTE                                                                on OTC_CH_FILEC5   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OTC_CH_FILEC5   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTC_CH_FILEC5.sql =========*** End
PROMPT ===================================================================================== 
