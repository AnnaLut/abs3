CREATE OR REPLACE FUNCTION BARS.f_get_s031(acc_ in number, dat_ in date, s031_ in varchar2,
            nd_ number default null) return varchar2
    ----------------------------------------------------------------------------
    -- version 17/12/2018 (12/12/2018)
    ----------------------------------------------------------------------------
    -- 05/11/2014 добавлены блоки
    --           ELSIF s1_25+s1_26+s1_31+s1_37+s1_50+s1_56 >=
    --                 s1_v-(s1_25+s1_26+s1_31+s1_37+s1_50+s1_56) THEN
    --                 pawn_:=43;
    --           ELSIF s1_25+s1_26+s1_31+s1_37+s1_50+s1_56 >=
    --                 s1_v-(s1_25+s1_26+s1_31+s1_37+s1_50+s1_56) THEN
    --                 pawn_:=43;
    --         т.к. всесто кода 43 формировался код 33
    -- 06/06/2014 доработан алгоритм формирования по замечаниям из Житомира
    -- 27/05/2014 при отсутствии данных в табл. TMP_REZ_ZALOG23 по договору или
    --            ACC счета за отчетную дату код вида залога (S031) и затем S032
    --            определялся по последнему значению S031 из CC_PAWN
    --            а не по формулах для нескольких видов обеспечения
    -- 10/02/2014 добавлен блок который был выполнен Вирко для банка Демарк
    --            30/05/2013 для Демарка формируем вид обеспечения по мах.сумме
    --                       ипотеки (анализ переменной s_mx)
    ----------------------------------------------------------------------------
is
    p080f_  varchar2(2);
    p080_   varchar2(2);
	p080_23 varchar2(2);
    kol_dz   number:=0;
    kol_dz23 number:=0;
	ndn_    number;
    s032_   varchar2(2);
    pnd_    number;
    s_v     number;
    s_25    number;
    s_26    number;
    s_29    number;
    s_31    number;
    s_37    number;
    s_50    number;
    s_56    number;
    s1_v    number := 0;
    s1_25   number := 0;
    s1_26   number := 0;
    s1_29   number := 0;
    s1_31   number := 0;
    s1_37   number := 0;
    s1_50   number := 0;
    s1_56   number := 0;
    s_mx    number := 0;
    pawn_   number;
    ostz_   number;
    dat23_  Date;

-- виды залогов для кредитного счета
CURSOR KREDIT IS
   select d.s031, d.nd, abs(sum(d.ost)) ostz
    from (SELECT b.s031, a.nd, a.acc accz, fostq(a.acc, dat_) ost
            FROM CC_ACCP a, CC_PAWN b, PAWN_ACC c
            WHERE a.nd=pnd_    AND
                  a.acc=c.acc    AND
                  NVL(c.pawn,'90')=b.pawn
            group by b.s031, a.nd, a.acc) d
    where d.ost<>0
    group by d.s031, d.nd;

CURSOR NOKREDIT IS
    select d.s031, d.nd, abs(sum(d.ost)) ostz
    from (SELECT b.s031, a.nd, a.acc accz, fostq(a.acc, dat_) ost
            FROM CC_ACCP a, CC_PAWN b, PAWN_ACC c
            WHERE a.accs=acc_    AND
                  a.acc=c.acc    AND
                  NVL(c.pawn,'90')=b.pawn
            group by b.s031, a.nd, a.acc) d
    where d.ost<>0
    group by d.s031, d.nd;
begin
    Dat23_  := TRUNC(add_months(Dat_,1),'MM');

    if nd_ is null then
       begin
          select max(n.nd)
          into pnd_
          from  nd_acc n, cc_deal c
          where  n.acc = acc_
            and  n.nd=c.nd
            and  c.vidd in (1,2,3,11,12,13,9,19,29,39)
            and  c.sdate <= dat_;
       exception
          when no_data_found then
              pnd_ := null;
       end;
    else
       pnd_ := nd_;
    end if;

    if pnd_ <= 0 then
       pnd_ := null;
    end if;

    if pnd_ is not null then -- кредитный договор найден
        -- виды залогов
        OPEN kredit;

        LOOP
           FETCH kredit
            INTO p080f_, ndn_, ostz_;

           EXIT WHEN kredit%NOTFOUND;
           p080_ := NVL (p080f_, s031_);

           kol_dz := kol_dz + 1;

           if p080f_ = '25' then
              s1_25 :=  s1_25 + ostz_;
           elsif p080f_ = '26' then
              s1_26 :=  s1_26 + ostz_;
           elsif p080f_ = '31' then
              s1_31 :=  s1_31 + ostz_;
           elsif p080f_ = '37' then
              s1_37 :=  s1_37 + ostz_;
           elsif p080f_ = '50' then
              s1_50 :=  s1_50 + ostz_;
           elsif p080f_ = '56' then
              s1_56 :=  s1_56 + ostz_;
           else
               null;
           end if;

           s1_v := s1_v + ostz_;
        END LOOP;

        CLOSE kredit;
        
        -- немає запису в PAWN_ACC, тоді і немає забезпечення (Семенова В. 17/12/2018)
        if kol_dz = 0 then
           return '90';
        end if;
        
        if s1_25+s1_26+s1_31+s1_37+s1_50+s1_56+s1_v =  0
        then
           OPEN nokredit;

           LOOP
              FETCH nokredit
               INTO p080f_, ndn_, ostz_;

              EXIT WHEN nokredit%NOTFOUND;
              p080_ := NVL (p080f_, s031_);

              kol_dz := kol_dz + 1;

              if p080f_ = '25' then
                 s1_25 :=  s1_25 + ostz_;
              elsif p080f_ = '26' then
                 s1_26 :=  s1_26 + ostz_;
              elsif p080f_ = '31' then
                 s1_31 :=  s1_31 + ostz_;
              elsif p080f_ = '37' then
                 s1_37 :=  s1_37 + ostz_;
              elsif p080f_ = '50' then
                 s1_50 :=  s1_50 + ostz_;
              elsif p080f_ = '56' then
                 s1_56 :=  s1_56 + ostz_;
              else
                  null;
              end if;

              s1_v := s1_v + ostz_;
           END LOOP;

           CLOSE nokredit;
        end if;
    else -- кредитный договор не найден
        p080_ := s031_;
        
        -- виды залогов
        OPEN nokredit;

        LOOP
           FETCH nokredit
            INTO p080f_, ndn_, ostz_;

           EXIT WHEN nokredit%NOTFOUND;
           p080_ := NVL (p080f_, s031_);

           kol_dz := kol_dz + 1;

           if p080f_ = '25' then
              s1_25 :=  s1_25 + ostz_;
           elsif p080f_ = '26' then
              s1_26 :=  s1_26 + ostz_;
           elsif p080f_ = '31' then
              s1_31 :=  s1_31 + ostz_;
           elsif p080f_ = '37' then
              s1_37 :=  s1_37 + ostz_;
           elsif p080f_ = '50' then
              s1_50 :=  s1_50 + ostz_;
           elsif p080f_ = '56' then
              s1_56 :=  s1_56 + ostz_;
           else
               null;
           end if;

           s1_v := s1_v + ostz_;
        END LOOP;

        CLOSE nokredit;
    end if;
    
    -- немає запису в PAWN_ACC, тоді і немає забезпечення (Семенова В. 17/12/2018)
    if kol_dz = 0 then
       return '90';
    end if;

    if dat_ >= to_date('31012013', 'ddmmyyyy') then
        if pnd_ is not null then
            select count(distinct p.s031), max(p.s031)
               into kol_dz23, p080_23
             from tmp_rez_zalog23 t, cc_pawn p
             where t.accs in (select acc from nd_acc where nd = pnd_)
                   and t.dat = dat23_
                   and t.pawn = p.pawn;

            if kol_dz23 = 0 then
               select count(distinct p.s031), max(p.s031)
                  into kol_dz23, p080_23
               from tmp_rez_zalog23 t, cc_pawn p
               where t.accs in (select acc from acc_over where nd = pnd_
                                UNION ALL
                                select acc_9129 from acc_over where nd = pnd_)
                     and t.dat = dat23_
                     and t.pawn = p.pawn;
            end if;
        else
            select count(distinct p.s031), max(p.s031)
               into kol_dz23, p080_23
             from tmp_rez_zalog23 t, cc_pawn p
             where t.accs = acc_
               and t.dat = dat23_
               and t.pawn = p.pawn;
        end if;
    end if;

    --- если кол-во договоров залога больше 1, то вид залога p080_='40'
    IF kol_dz23 > 1
    THEN
       p080_ := '40';
       pawn_ := null;

       if pnd_ is not null then -- кредитный договор найден
           if dat_ <= to_date('30112012','ddmmyyyy') then
              begin
                 select nvl(sum (t.SALL),0),
                        nvl(sum(case when p.s031 = '25' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '26' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '29' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '31' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '37' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '50' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '56' then t.SALL else 0 end), 0)
                   into s_V, s_25 , s_26, s_29, s_31, s_37, s_50, s_56
                 from tmp_rez_risk2 t, rez_protocol r, cc_pawn p
                 where t.accs in (select acc from nd_acc where nd = pnd_)
                   and t.dat = dat_
                   and t.userid = r.userid
                   and r.dat = dat_
                   and t.pawn = p.pawn;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                   s_v:=0;
                   s_25:=0;
                   s_26:=0;
                   s_29:=0;
                   s_31:=0;
                   s_37:=0;
                   s_50:=0;
                   s_56:=0;
              end;
           end if;
           if dat_ >= to_date('29122012','ddmmyyyy') then
              begin
                 select nvl(sum (t.SALL),0),
                        nvl(sum(case when p.s031 = '25' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '26' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '31' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '37' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '50' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '56' then t.SALL else 0 end), 0)
                   into s_V, s_25 , s_26, s_31, s_37, s_50, s_56
                 from tmp_rez_zalog23 t, cc_pawn p
                 where t.accs in (select acc from nd_acc where nd = pnd_)
                   and t.dat = dat23_
                   and t.pawn = p.pawn;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                   s_v:=0;
                   s_25:=0;
                   s_26:=0;
                   s_31:=0;
                   s_37:=0;
                   s_50:=0;
                   s_56:=0;
              end;
           end if;
       else
           if dat_ <= to_date('30112012','ddmmyyyy') then
              begin
                 select nvl(sum (t.SALL),0),
                        nvl(sum(case when p.s031 = '25' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '26' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '31' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '37' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '50' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '56' then t.SALL else 0 end), 0)
                   into s_V, s_25 , s_26, s_31, s_37, s_50, s_56
                 from tmp_rez_risk2 t, rez_protocol r, cc_pawn p
                 where t.accs = acc_
                   and t.dat = dat_
                   and t.userid = r.userid
                   and r.dat = dat_
                   and t.pawn = p.pawn;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                   s_v:=0;
                   s_25:=0;
                   s_26:=0;
                   s_31:=0;
                   s_37:=0;
                   s_50:=0;
                   s_56:=0;
              end;
           end if;
           if dat_ >= to_date('29122012','ddmmyyyy') then
              s_mx := 0;
              begin
                 select nvl(sum (t.SALL),0),
                        nvl(sum(case when p.s031 = '25' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '26' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '31' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '37' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '50' then t.SALL else 0 end), 0),
                        nvl(sum(case when p.s031 = '56' then t.SALL else 0 end), 0)
                   into s_V, s_25 , s_26, s_31, s_37, s_50, s_56
                 from tmp_rez_zalog23 t, cc_pawn p  
                 where t.accs = acc_
                   and t.dat = dat23_
                   and t.pawn = p.pawn;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                   s_v:=0;
                   s_25:=0;
                   s_26:=0;
                   s_31:=0;
                   s_37:=0;
                   s_50:=0;
                   s_56:=0;
              end;
           end if;
       end if;
    END IF;

    if s_v > 0 and kol_dz23>1 then
       IF s_25+s_26+s_31+s_37+s_50+s_56 = 0 THEN
          pawn_:=40;
       ELSIF s_25 > s_v-s_25 THEN
          pawn_:=41;
       ELSIF s_26 > s_v-s_26 THEN
          pawn_:=42;
       ELSIF s_31+s_37+s_50 > s_v-s_31-s_37-s_50 THEN
          pawn_:=43;
       ELSIF s_56 > s_v-s_56 THEN
          pawn_:=44;
       ELSIF s_25+s_26+s_31+s_37+s_50+s_56 >= s_v-(s_25+s_26+s_31+s_37+s_50+s_56) THEN
          pawn_:=43;
       ELSIF s_25+s_26+s_31+s_37+s_50+s_56 < s_v-(s_25+s_26+s_31+s_37+s_50+s_56) THEN
          pawn_:=45;
       ELSIF f_ourmfo()=353575 and s_mx = 0 THEN
          s_mx := greatest(s_25,s_26,(s_31+s_37),s_56);
          if s_mx=s_25 then pawn_:=41; end if;
          if s_mx=s_26 then pawn_:=42; end if;
          if s_mx=s_31+s_37 then pawn_:=43; end if;
          if s_mx=s_56 then pawn_:=44; end if;
       ELSE
          pawn_:=33;
       END IF;

       if pawn_ is not null then
          p080_ := pawn_;
       end if;
    else
       if s1_v > 0 and kol_dz>1 then
          IF s1_25+s1_26+s1_31+s1_37+s1_50+s1_56 = 0 THEN
             pawn_:=40;
          ELSIF s1_25 > s1_v-s1_25 THEN
             pawn_:=41;
          ELSIF s1_26 > s1_v-s1_26 THEN
             pawn_:=42;
          ELSIF s1_31+s1_37+s1_50 > s1_v-s1_31-s1_37-s1_50 THEN
             pawn_:=43;
          ELSIF s1_56 > s1_v-s1_56 THEN
             pawn_:=44;
          ELSIF s1_25+s1_26+s1_31+s1_37+s1_50+s1_56 >= s1_v-(s1_25+s1_26+s1_31+s1_37+s1_50+s1_56) THEN
             pawn_:=43;
          ELSIF s1_25+s1_26+s1_31+s1_37+s1_50+s1_56 < s1_v-(s1_25+s1_26+s1_31+s1_37+s1_50+s1_56) THEN
             pawn_:=45;
          ELSE
             pawn_:=33;
          END IF;
       end if;

       if pawn_ is not null then
          p080_ := pawn_;
       end if;
    end if;

	if kol_dz23=1 then
	   p080_:=p080_23;
	end if;

    return nvl(p080_, '90');
end;
/