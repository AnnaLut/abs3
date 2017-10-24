

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTC_CH_FILED5.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTC_CH_FILED5 ***

  CREATE OR REPLACE PROCEDURE BARS.OTC_CH_FILED5 (p_kodf varchar2,p_datf date)
   --  AUTHOR:  Virko
   -- VERSION: 07/02/2013 (23/01/2013)
is
   kol_       NUMBER := 0;
   kol1_      NUMBER := 0;

   pr1_       number := 0;
   pr2_       number := 0;
   pr3_       number := 0;
   pr4_       number := 0;
   pr5_       number := 0;
   pr6_       number := 0;
   pr7_       number := 0;
   pr8_       number := 0;
   pr9_       number := 0;

   txt1_      varchar2(100);
   txt2_      varchar2(100) := 'Помилковий K072';
   txt3_      varchar2(100) := 'Не заповнено код s183';
   txt4_      varchar2(100) := 'Помилковий K051';
   txt5_      varchar2(100) := 'Помилковий K111';
   txt6_      varchar2(100) := 'Помилковий S260';
   txt7_      varchar2(100) := 'Помилковий S032';
   txt8_      varchar2(100);
   txt9_      varchar2(100) := 'Процентна ставка за цим рахунком не надається';

   err_mes_   varchar2(1000);
   sql_       varchar2(1000);
   umova_     varchar2(1000);

   p_pall     number;
   p_aa       varchar2(1000);

   p_add      integer := (case when p_datf >= to_date('01072011','ddmmyyyy') then 1 else 0 end);

   p_datzv    date := add_months(trunc(p_datf, 'mm'),1);
   k071_      varchar2(1);
BEGIN
    FOR t
     IN (select kodp,  znap,
             substr(kodp,0 + p_add,1)  pr_ost,
             substr(kodp,1 + p_add,1)  t020,
             substr(kodp,2 + p_add,4)  r020,
             substr(kodp,2 + p_add,3)  gr,
             substr(kodp,2 + p_add,2)  razd,
             substr(kodp,6 + p_add,1)  r011,
             substr(kodp,7 + p_add,2)  k111,
             substr(kodp,9 + p_add,1)  k072,
             --substr(kodp,10,1) k081, -- закритий сегмент
             substr(kodp,11 + p_add,1) s183,
             substr(kodp,12 + p_add,1) k030,
             substr(kodp,13 + p_add,2) k051,
             substr(kodp,15 + p_add,1) S032,
             substr(kodp,16 + p_add,3) R030,
             substr(kodp,19 + p_add,3) k040,
             substr(kodp,22 + p_add,1) s080,
             substr(kodp,23 + p_add,2) s260,
             ERR_MSG
          from tmp_nbu
          where kodf=p_kodf and datf=p_datf --and kodp='11262590009120098403761080'
          order by kodp )
    LOOP
        pr1_  := 0;
        pr2_  := 0;
        pr3_  := 0;
        pr4_  := 0;
        pr5_  := 0;
        pr6_  := 0;
        pr7_  := 0;
        pr8_  := 0;
        pr9_  := 0;
        p_pall := null;
        kol_ := 0;
        kol1_ := 0;

        txt1_ := 'Hеправильно вказано розрiз R011 для рахунку R020=' || t.r020;
        txt8_ := 'Помилковий S080='||t.s080 ||' для рахунку R020=' || t.r020;
        err_mes_  := null;

        -- перевірка параметра R011
        select count(*) INTO kol_ from KL_R011 k
        where trim(k.prem) = 'КБ' and
             k. r020 = t.r020 and
             (k.d_open <= p_datzv) and
             (k.d_close is null or k.d_close > p_datzv);

        if kol_ > 0 then
            if t.r011 = '0' then
               pr1_  := 1;
            else
               select count(*)
               into kol1_
               from kl_r011 k
               where trim(k.prem) = 'КБ' and
                       k.r020 = t.r020 and
                       k.r011 = t.r011 and
                      (k.d_open <= p_datzv) and
                      (k.d_close is null or k.d_close > p_datzv);

               if kol1_ = 0 then
                  pr1_ := 1;
               end if;
            end if;
        else
            if t.r011 <> '0' then
               pr1_ := 1;
            end if;
        end if;

        if t.k072<>'0' THEN
            if t.k030 = '2' then
              pr2_ := 1;
            else
               select count(*)
               into kol1_
               from kl_k070 k
               where k.k072 = t.k072 and
                     (k.d_open <= p_datzv) and
                     (k.d_close is null or k.d_close > p_datzv);

               if kol1_ = 0 then
                  pr2_ := 1;
               else
                  select max(k071)
                   into k071_
                   from kl_k070 k
                   where k.k072 = t.k072 and
                         (k.d_open <= p_datzv) and
                         (k.d_close is null or k.d_close > p_datzv);
               end if;
            end if;
        else
            k071_ := '0';

            if t.k030 = '2' then
               pr2_ := 0;
            else
               pr2_ := 1;
            end if;
        end if;

        if t.s183 = '0'  then
            pr3_  := 1;
        end if;

        if t.k051<>'00' THEN
            if t.k030 = '2' then
              pr4_ := 1;
            else
               select count(*)
               into kol1_
               from kl_k051 k
               where k.k051=t.k051 and
                         (k.d_open <= p_datzv) and
                         (k.d_close is null or k.d_close > p_datzv);

               if kol1_ = 0 then
                  pr4_ := 1;
               end if;
            end if;
        else
            select count(*)
            into kol_
            from kod_d5 kd
            where ((trim(kd.r020) is null or kd.r020 = t.r020) and
                   (trim(kd.gr) is null or kd.gr = t.gr) and
                    kd.razd = t.razd)
              and instr(trim(kd.k051), '00')>0
              and kd.k030=t.k030
              and  (kd.d_open <= p_datzv)
              and  (kd.d_close is null or kd.d_close > p_datzv);

            if kol_ = 0 then
               pr4_ := 1;
            else
               pr4_ := 0;
            end if;
        end if;

        if t.k111<>'00' THEN
            if t.k030 = '2' then
              pr5_ := 1;
            else
               select count(*)
               into kol1_
               from kl_k110 k
               where k.k111=t.k111 and
                         (k.d_open <= p_datzv) and
                         (k.d_close is null or k.d_close > p_datzv);

               if kol1_ = 0 then
                  pr5_ := 1;
               end if;
            end if;
        else
            select count(*)
            into kol_
            from kod_d5 kd
            where ((trim(kd.r020) is null or kd.r020 = t.r020) and
                   (trim(kd.gr) is null or kd.gr = t.gr) and
                    kd.razd = t.razd)
              and instr(trim(kd.k111), '00')>0
              and kd.k030=t.k030
              and  (kd.d_open <= p_datzv)
              and  (kd.d_close is null or kd.d_close > p_datzv);

            if kol_ = 0 then
               pr5_ := 1;
            else
               pr5_ := 0;
            end if;
        end if;

        if t.s260<>'00' THEN
           select count(*)
           into kol1_
           from kl_s260 k
           where k.s260=t.s260 and
                 (k.d_open <= p_datzv) and
                 (k.d_close is null or k.d_close > p_datzv);

           if kol1_ = 0 then
              pr6_ := 1;
           end if;
        else
           pr6_ := 1;
        end if;

        if t.s032 = '0'  then
            pr7_  := 1;
        end if;

        if p_datf < to_date('29122012', 'ddmmyyyy') then
            if t.s080 = '0' or
               t.r020 = '2401' and t.s080 <> '1' or
               t.r020 = '2400' and t.s080 not in ('1', '2', '3', '4', '5')
            then
                pr8_  := 1;
            end if;
        else
            if t.s080 = '0' or
               t.r020 in ('2400', '2401') and t.s080 not in ('1', '2', '3', '4', '5')
            then
                pr8_  := 1;
            end if;
        end if;

        if p_datf >= to_date('01072011','ddmmyyyy') and t.pr_ost = '2' then
          select count(*)
             into kol_
          from kod_d5_1 k
          where r020 = t.r020 and
                t020 = t.t020 and
                 (k.d_open <= p_datzv) and
                 (k.d_close is null or k.d_close > p_datzv);

           if kol_ = 0 then
              pr9_ := 1;
           else
              pr9_ := 0;
           end if;
        end if;

        if pr1_ + pr2_ + pr3_  + pr4_ + pr5_ + pr6_ + pr7_ + pr8_ + pr9_ > 0 then
            err_mes_ := trim((case when  pr1_ = 1 then txt1_ || ' ' else ' ' end)
                        || (case when  pr2_ = 1 then txt2_ || ' ' else ' ' end)
                        || (case when  pr3_ = 1 then txt3_ || ' ' else ' ' end)
                        || (case when  pr4_ = 1 then txt4_ || ' ' else ' ' end)
                        || (case when  pr5_ = 1 then txt5_ || ' ' else ' ' end)
                        || (case when  pr6_ = 1 then txt6_ || ' ' else ' ' end)
                        || (case when  pr7_ = 1 then txt7_ || ' ' else ' ' end)
                        || (case when  pr8_ = 1 then txt8_ || ' ' else ' ' end)
                        || (case when  pr9_ = 1 then txt9_ || ' ' else ' ' end));
        else
            select count(*)
            into kol_
            from kod_d5 kd
            where kd.r020 = t.r020 and kd.t020 = t.t020
              and (trim(kd.r011) is null or trim(kd.r011) like '%'||t.r011||',%')
              and kd.k072 like '%'||t.k072||',%'
              and kd.k051 like '%'||t.k051||',%'
              and kd.k111 like '%'||t.k111||',%'
              and kd.k030=t.k030
              and (trim(kd.s183) is null or trim(kd.s183) like '%'||t.s183||',%')
              and (trim(kd.s260) is null or trim(kd.s260) like '%'||t.s260||',%')
              and  (kd.d_open <= p_datzv)
              and  (kd.d_close is null or kd.d_close > p_datzv);

            if kol_ = 0 then
                err_mes_ := 'Неможливе сполучення ';

                for z in (select b.*, (case least(z1,z2,z3,z4,z5,z6)
                                        when z1 then 'R011'
                                        when z2 then 'K111'
                                        when z3 then 'K072'
                                        when z4 then 'S183'
                                        when z5 then 'K051'
                                        else 'S260'
                                     end) aa
                        from (
                            select a.*, p1+p2+p3+p4+p5+p6 pall,
                                sum(p1) over (partition by r020) z1,
                                sum(p2) over (partition by r020) z2,
                                sum(p3) over (partition by r020) z3,
                                sum(p4) over (partition by r020) z4,
                                sum(p5) over (partition by r020) z5,
                                sum(p6) over (partition by r020) z6
                            from (
                                select kd.*,
                                    (case when instr(trim(kd.r011), t.r011||',')>0 or trim(kd.r011) is null then 1 else 0 end) p1,
                                    (case when instr(kd.k111, t.k111||',')>0 then 1 else 0 end) p2,
                                    (case when instr(kd.k072, t.k072||',')>0 then 1 else 0 end) p3,
                                    (case when instr(trim(kd.s183), t.s183||',')>0 or trim(kd.s183) is null then 1 else 0 end) p4,
                                    (case when instr(kd.k051, t.k051||',')>0 then 1 else 0 end) p5,
                                    (case when instr(kd.s260, t.s260||',')>0  or trim(kd.s260) is null then 1 else 0 end) p6
                                from kod_d5 kd
                                where kd.r020 = t.r020 and kd.t020 = t.t020
                                  and kd.k030=t.k030
                                  and kd.k071 = k071_
                                  and  (kd.d_open <= p_datzv)
                                  and  (kd.d_close is null or kd.d_close > p_datzv)
                                  ) a
                            ) b
                            order by pall desc)
                 loop
                    if p_pall is null or p_pall = z.pall then
                       if p_pall is null then
                          err_mes_ := err_mes_|| '(перевірте '||z.aa;

                          if z.p1=0 and z.aa <> 'R011' then
                             err_mes_ := err_mes_|| ', '||'R011';
                          end if;

                          if z.p2=0 and z.aa <> 'K111' then
                             err_mes_ := err_mes_|| ', '||'K111';
                          end if;

                          if z.p3=0 and z.aa <> 'K072' then
                             err_mes_ := err_mes_|| ', '||'K072';
                          end if;

                          if z.p4=0 and z.aa <> 'S183' then
                             err_mes_ := err_mes_|| ', '||'S183';
                          end if;

                          if z.p5=0 and z.aa <> 'K051' then
                             err_mes_ := err_mes_|| ', '||'K051';
                          end if;

                          if z.p6=0 and z.aa <> 'S260' then
                             err_mes_ := err_mes_|| ', '||'S260';
                          end if;
                       elsif p_aa <> z.aa and instr(err_mes_,z.aa)=0 then
                          err_mes_ := err_mes_|| ', '||z.aa;
                       end if;
                    else
                       exit;
                    end if;

                    p_pall := z.pall;
                    p_aa := z.aa;
                 end loop;

                 if p_pall is null then
                    err_mes_ := null;
                 else
                    err_mes_ := err_mes_||')';
                 end if;
            else
                err_mes_ := null;
            end if;

            if kol_ = 0 and err_mes_ is null then
                select count(*)
                into kol_
                from kod_d5 kd
                where trim(kd.gr) = t.gr and trim(kd.r020) is null
                  and (trim(kd.r011) is null or trim(kd.r011) like '%'||t.r011||',%')
                  and kd.k072 like '%'||t.k072||',%'
                  and kd.k051 like '%'||t.k051||',%'
                  and kd.k111 like '%'||t.k111||',%'
                  and kd.k030=t.k030
                  and (trim(kd.s183) is null or trim(kd.s183) like '%'||t.s183||',%')
                  and (trim(kd.s260) is null or trim(kd.s260) like '%'||t.s260||',%')
                  and  (kd.d_open <= p_datzv)
                  and  (kd.d_close is null or kd.d_close > p_datzv);

                if kol_ = 0 then
                    err_mes_ := 'Неможливе сполучення ';

                    for z in (select b.*, (case least(z1,z2,z3,z4,z5,z6)
                                            when z1 then 'R011'
                                            when z2 then 'K111'
                                            when z3 then 'K072'
                                            when z4 then 'S183'
                                            when z5 then 'K051'
                                            else 'S260'
                                         end) aa
                            from (
                                select a.*, p1+p2+p3+p4+p5+p6 pall,
                                    sum(p1) over (partition by r020) z1,
                                    sum(p2) over (partition by r020) z2,
                                    sum(p3) over (partition by r020) z3,
                                    sum(p4) over (partition by r020) z4,
                                    sum(p5) over (partition by r020) z5,
                                    sum(p6) over (partition by r020) z6
                                from (
                                    select kd.*,
                                        (case when instr(trim(kd.r011), t.r011||',')>0 or trim(kd.r011) is null then 1 else 0 end) p1,
                                        (case when instr(kd.k111, t.k111||',')>0 then 1 else 0 end) p2,
                                        (case when instr(kd.k072, t.k072||',')>0 then 1 else 0 end) p3,
                                        (case when instr(trim(kd.s183), t.s183||',')>0 or trim(kd.s183) is null then 1 else 0 end) p4,
                                        (case when instr(kd.k051, t.k051||',')>0 then 1 else 0 end) p5,
                                        (case when instr(kd.s260, t.s260||',')>0  or trim(kd.s260) is null then 1 else 0 end) p6
                                    from kod_d5 kd
                                    where trim(kd.gr) = t.gr  and trim(kd.r020) is null
                                      and kd.k030=t.k030
                                      and kd.k071 = k071_
                                      and  (kd.d_open <= p_datzv)
                                      and  (kd.d_close is null or kd.d_close > p_datzv)
                                      ) a
                                ) b
                                order by pall desc)
                     loop
                        if p_pall is null or p_pall = z.pall then
                           if p_pall is null then
                              err_mes_ := err_mes_|| '(перевірте '||z.aa;

                              if z.p1=0 and z.aa <> 'R011' then
                                 err_mes_ := err_mes_|| ', '||'R011';
                              end if;

                              if z.p2=0 and z.aa <> 'K111' then
                                 err_mes_ := err_mes_|| ', '||'K111';
                              end if;

                              if z.p3=0 and z.aa <> 'K072' then
                                 err_mes_ := err_mes_|| ', '||'K072';
                              end if;

                              if z.p4=0 and z.aa <> 'S183' then
                                 err_mes_ := err_mes_|| ', '||'S183';
                              end if;

                              if z.p5=0 and z.aa <> 'K051' then
                                 err_mes_ := err_mes_|| ', '||'K051';
                              end if;

                              if z.p6=0 and z.aa <> 'S260' then
                                 err_mes_ := err_mes_|| ', '||'S260';
                              end if;
                           elsif p_aa <> z.aa and instr(err_mes_,z.aa)=0 then
                              err_mes_ := err_mes_|| ', '||z.aa;
                           end if;
                        else
                           exit;
                        end if;

                        p_pall := z.pall;
                        p_aa := z.aa;
                     end loop;

                     if p_pall is null then
                        err_mes_ := null;
                     else
                        err_mes_ := err_mes_||')';
                     end if;
                else
                    err_mes_ := null;
                end if;

                if kol_ = 0 and err_mes_ is null then
                    select count(*)
                    into kol_
                    from kod_d5 kd
                    where kd.RAZD = t.RAZD and trim(kd.gr) is null and trim(kd.r020) is null
                      and (trim(kd.r011) is null or trim(kd.r011) like '%'||t.r011||',%')
                      and kd.k072 like '%'||t.k072||',%'
                      and kd.k051 like '%'||t.k051||',%'
                      and kd.k111 like '%'||t.k111||',%'
                      and kd.k030=t.k030
                      and (trim(kd.s183) is null or trim(kd.s183) like '%'||t.s183||',%')
                      and (trim(kd.s260) is null or trim(kd.s260) like '%'||t.s260||',%')
                      and  (kd.d_open <= p_datzv)
                      and  (kd.d_close is null or kd.d_close > p_datzv);

                    if kol_ = 0 then
                        err_mes_ := 'Неможливе сполучення ';

                        for z in (select b.*, (case least(z1,z2,z3,z4,z5,z6)
                                                when z1 then 'R011'
                                                when z2 then 'K111'
                                                when z3 then 'K072'
                                                when z4 then 'S183'
                                                when z5 then 'K051'
                                                else 'S260'
                                             end) aa
                                from (
                                    select a.*, p1+p2+p3+p4+p5+p6 pall,
                                        sum(p1) over (partition by r020) z1,
                                        sum(p2) over (partition by r020) z2,
                                        sum(p3) over (partition by r020) z3,
                                        sum(p4) over (partition by r020) z4,
                                        sum(p5) over (partition by r020) z5,
                                        sum(p6) over (partition by r020) z6
                                    from (
                                        select kd.*,
                                            (case when instr(trim(kd.r011), t.r011||',')>0 or trim(kd.r011) is null then 1 else 0 end) p1,
                                            (case when instr(kd.k111, t.k111||',')>0 then 1 else 0 end) p2,
                                            (case when instr(kd.k072, t.k072||',')>0 then 1 else 0 end) p3,
                                            (case when instr(trim(kd.s183), t.s183||',')>0 or trim(kd.s183) is null then 1 else 0 end) p4,
                                            (case when instr(kd.k051, t.k051||',')>0 then 1 else 0 end) p5,
                                            (case when instr(kd.s260, t.s260||',')>0  or trim(kd.s260) is null then 1 else 0 end) p6
                                        from kod_d5 kd
                                        where trim(kd.RAZD) = t.RAZD and trim(kd.gr) is null and trim(kd.r020) is null
                                          and kd.k030=t.k030
                                          --and kd.k071 = k071_
                                          and  (kd.d_open <= p_datzv)
                                          and  (kd.d_close is null or kd.d_close > p_datzv)
                                          ) a
                                    ) b
                                    order by pall desc)
                         loop
                            if p_pall is null or p_pall = z.pall then
                               if p_pall is null then
                                  err_mes_ := err_mes_|| '(перевірте '||z.aa;

                                  if z.p1=0 and z.aa <> 'R011' then
                                     err_mes_ := err_mes_|| ', '||'R011';
                                  end if;

                                  if z.p2=0 and z.aa <> 'K111' then
                                     err_mes_ := err_mes_|| ', '||'K111';
                                  end if;

                                  if z.p3=0 and z.aa <> 'K072' then
                                     err_mes_ := err_mes_|| ', '||'K072';
                                  end if;

                                  if z.p4=0 and z.aa <> 'S183' then
                                     err_mes_ := err_mes_|| ', '||'S183';
                                  end if;

                                  if z.p5=0 and z.aa <> 'K051' then
                                     err_mes_ := err_mes_|| ', '||'K051';
                                  end if;

                                  if z.p6=0 and z.aa <> 'S260' then
                                     err_mes_ := err_mes_|| ', '||'S260';
                                  end if;
                               elsif p_aa <> z.aa and instr(err_mes_,z.aa)=0 then
                                  err_mes_ := err_mes_|| ', '||z.aa;
                               end if;
                            else
                               exit;
                            end if;

                            p_pall := z.pall;
                            p_aa := z.aa;
                         end loop;

                         if p_pall is null then
                            err_mes_ := null;
                         else
                            err_mes_ := err_mes_||')';
                         end if;
                    else
                        err_mes_ := null;
                    end if;
                end if;
            end if;
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

PROMPT *** Create  grants  OTC_CH_FILED5 ***
grant EXECUTE                                                                on OTC_CH_FILED5   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OTC_CH_FILED5   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTC_CH_FILED5.sql =========*** End
PROMPT ===================================================================================== 
