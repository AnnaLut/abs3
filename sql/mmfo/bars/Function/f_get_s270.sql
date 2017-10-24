
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s270.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S270 (dat_ in date, s270_ in varchar2, acc_ in number, nd_ in out varchar2) return varchar2
   -------------------------------------------------------------------------------
   -- version 30/10/2012 (30/05/2011)
   -------------------------------------------------------------------------------
   -- якщо параметр s270 має одне із значень 01,07 чи 08, то повертаємо це значення,
   -- інакше - розраховуємо на основі історії дебет. оборотів по рахунку прострочки
   -------------------------------------------------------------------------------
is
    wdate_  date;
    mdate_  date;
    s270_r  varchar2(2);
    acc_p   number;
    ost_p   number;
    dos_    number;
    nls_    accounts.nls%type;
    kv_     accounts.kv%type;
    acc1_   number;
    wdate1_ date;
    wdate2_ date;
    rnk_    number;
    rizn_   number;

    procedure p_dbms(put_ in varchar2) is
begin
    if 1=1 then --acc_ in (41773, 116414, 131266, 169468, 152250, 162612) then
       dbms_output.put_line(put_);
    end if;
end;
begin
    -- кщо параметр правильно заповнений, то повертаємо це значення
    if NVL(trim(s270_),'00') in ('01', '07', '08') then
       return NVL(trim(s270_),'00');
    end if;

    -- інакше - розраховуємо на основі історії дебет. оборотів по рахунку прострочки
    s270_r := '01';

    select nls, kv, mdate, rnk
    into nls_, kv_, mdate_, rnk_
    from accounts
    where acc=acc_;

    p_dbms('acc='||to_char(acc_)||' mdate='||to_char(mdate_,'dd/mm/yyyy'));

    if nd_ is null then
        begin
            SELECT MAX (p.nd)
            into nd_
            FROM nd_acc a, cc_deal p
            WHERE a.acc = acc_
              and a.nd = p.nd
              and p.sdate <= dat_;
        exception
            when no_data_found then
                nd_ := null;
        end;
    end if;

    p_dbms('nd='||to_char(nd_));

    if nd_ is null then
       -- не знайшли, то шукаємо так рахунок просрочки
        BEGIN
           select acc, ABS(ost)
              INTO acc_p, ost_p
           from sal
           where fdat=Dat_
             and rnk = rnk_
             and ost <> 0
             and nbs like substr(nls_,1,3) || '%'
             and nls like substr(nls_,1,3)||'7_'||substr(nls_,6,9)||'%'
             and nls not like '2607%'
             and nls not like '2627%'
             and nls not like '2657%'
             and kv = kv_ ;

            p_dbms('fl1: accp='||to_char(acc_p)||' ost_p='||to_char(ost_p));

           if ost_p <> 0 then
              dos_ := 0;
              for k in (select s.acc, s.fdat, s.dos - nvl(sel.s,0) dos
                        from saldoa s,
                             ( --находим сторнированные (r.ref) и сторнирующие (r.ref_bak) проводки
                             select o.acc, sum(o.s) s, o.fdat
                              from ref_back r, opldok o
                              where o.ref in (r.ref )  and
                                    r.dt between Dat_ - 180 and Dat_ and
                                    o.dk = 0 and
                                    o.acc = acc_p
                              group by  o.acc, o.fdat
                             ) sel
                        where s.acc=acc_p
                          and s.fdat between Dat_ - 180 and Dat_
                          and s.dos<>0
                          and s.acc = sel.acc(+)
                          and s.fdat = sel.fdat(+)
                        order by fdat DESC
                       )

              loop
                 dos_ := dos_+k.dos;
                 wdate_ := k.fdat;

                 if dos_ >= ost_p then
                    exit;
                 end if;

              end loop;

              if (wdate_ is not null) and (dos_ >= ost_p) then
                 rizn_ := dat_ - wdate_ + 1;

                 if rizn_ <= 0 then
                    s270_r := '01';
                 elsif rizn_ <= 180 then
                    s270_r := '07';
                 elsif rizn_ > 180 then
                    s270_r := '08';
                 else
                    null;
                 end if;
              else
                s270_r := '08';
              end if;
           else
              s270_r := '01';
           end if;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- взагалі нічого не знайшли
               if nls_ LIKE '3578%' OR nls_ LIKE '3579%' then
                  -- шукаємо рахунок основного боргу i дату закiнчення дiї договору???
                  BEGIN
                     select s.acc
                        into acc1_
                     from  accounts s
                     where s.nls LIKE '2_____'||substr(nls_,6,9)||'%'
                       and substr(s.nbs,1,2) in ('20','21','22')
                       and substr(s.nbs,4,1) not in ('5','6','7')
                       and s.acc<>acc_ -- на всякий случай
                       and (s.kv=kv_)
                       and rnk = rnk_
                       and rownum=1;

                     s270_r := '01';
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     s270_r := '00';
                  END;
               else
                  s270_r := '01';
               end if;
           when TOO_MANY_ROWS then
                raise_application_error(-20000, 'Для РНК= '||to_char(rnk_)||' nls='||nls_||' (acc='||acc_||') існує декілька рахунків прострочки.');
        END;
    else
        BEGIN
           select s.acc, c.wdate, c.nd
              into acc1_, wdate1_, nd_
           from nd_acc a, cc_deal c, accounts s, sal s1
           where a.nd=nd_
             and a.nd=c.nd
             and a.acc=s.acc
             and s.acc=s1.acc
             and s1.fdat= Dat_
             and s1.ost <> 0
             and (trim(s.tip) in ('SP','SL')
               or s.nls LIKE substr(nls_,1,3)||'7_'||substr(nls_,6,9)||'%')
             and (s.kv=kv_  or nls_ LIKE '3578%' OR nls_ LIKE'3579%' )
             and rownum=1;

          p_dbms('acc1='||to_char(acc1_));

           -- якщо знайшли, то розрахуємо залишок
           BEGIN
              select acc, ABS(ost)
                 INTO acc_p, ost_p
              from sal
              where fdat=Dat_
                and acc=acc1_;

              p_dbms('fl2: accp='||to_char(acc_p)||' ost_p='||to_char(ost_p));

              -- якщо по кредиту є прострочка, то рахуємо коли вона виникла???
              if ost_p <> 0 then
                 dos_ := 0;

                 for k in (select s.acc, s.fdat, s.dos - nvl(sel.s,0) dos
                        from saldoa s,
                             ( --находим сторнированные (r.ref) и сторнирующие (r.ref_bak) проводки
                             select o.acc, sum(o.s) s, o.fdat
                              from ref_back r, opldok o
                              where o.ref in (r.ref )  and
                                    r.dt between Dat_ - 180 and Dat_ and
                                    o.dk = 0 and
                                    o.acc = acc_p
                              group by  o.acc, o.fdat
                             ) sel
                        where s.acc=acc_p
                          and s.fdat between Dat_ - 180 and Dat_
                          and s.dos<>0
                          and s.acc = sel.acc(+)
                          and s.fdat = sel.fdat(+)
                        order by fdat DESC)

                 loop
                    dos_ := dos_+k.dos;
                    wdate_ := k.fdat;

                    if dos_ >= ost_p then
                       exit;
                    end if;
                 end loop;

                 -- розраховуємо різницю і визначаємо код s270
                 if (wdate_ is not null) and (dos_ >= ost_p) then
                     rizn_ := dat_ - wdate_ + 1;

                     if rizn_ <= 0 then
                        s270_r := '01';
                     elsif rizn_ <= 180 then
                        s270_r := '07';
                     elsif rizn_ > 180 then
                        s270_r := '08';
                     else
                        null;
                     end if;
                 else
                    s270_r := '08';
                 end if;
              else -- по кредиту немає прстрочки
                 s270_r := '01';
              end if;
           EXCEPTION WHEN NO_DATA_FOUND THEN
              s270_r := '01';
           END;
        EXCEPTION
          when too_many_rows then
              raise_application_error(-20001, 'Для РНК= '||to_char(rnk_)||' nls='||nls_||' (acc='||acc_||') існує декілька рахунків прострочки.');
          WHEN NO_DATA_FOUND THEN
           s270_r := '01';
           p_dbms('NO acc1');

           -- шукаємо рахунок основного боргу і дату закінчення дії договору???
           BEGIN
               select acc,wdate,nd
               into acc1_, wdate2_, nd_
              from
              (
              select a.acc, c.wdate, c.nd, count(*) over() cnt,s.nls, s.kv
              from cc_deal c, nd_acc a, accounts s
              where c.nd=nd_
                and a.nd=c.nd
                and a.acc=s.acc
                and trim(s.tip)='SS'
                and s.acc<>acc_ -- на всякий случай
                and (s.kv=kv_  or nls_ LIKE '3578%' OR nls_ LIKE'3579%' )
                )
                where (nls LIKE '_____'||substr(nls_,6,9)||'%' or cnt = 1 or nls_ LIKE '3578%' OR nls_ LIKE'3579%')
                     and rownum=1;

              p_dbms('fl3: accp='||to_char(acc1_)||' wdate='||to_char(wdate2_,'dd/mm/yyyy'));

               -- розраховуємо різницю і визначаємо код s270
               rizn_ := dat_ - wdate2_ + 1;

               if rizn_ <= 0 then
                  s270_r := '01';
               elsif rizn_ <= 180 then
                  s270_r := '07';
               elsif rizn_ > 180 then
                  s270_r := '08';
               else
                  null;
               end if;
           EXCEPTION WHEN NO_DATA_FOUND THEN
               if nls_ LIKE '3578%' OR nls_ LIKE'3579%' then
                  s270_r := '00';
               end if;
               p_dbms('NO acc1 2');
           END;
        END;
    end if;

    return nvl(s270_r, '00');
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_S270 ***
grant EXECUTE                                                                on F_GET_S270      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s270.sql =========*** End ***
 PROMPT ===================================================================================== 
 