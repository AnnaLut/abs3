
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s370.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S370 (dat_ in date,
                                           s370_ in varchar2,
                                           acc_ in number,
                                           p_nd_ in varchar2,
                                           p_mfou_ in number default null)
return varchar2
   -------------------------------------------------------------------------------
   -- version 06/02/2012 (02/02/2012)
   -------------------------------------------------------------------------------
   -- s370_ - значення параметру S370 з картки рахунку (тобто з SPECPARAM)
   -------------------------------------------------------------------------------
   -- розраховуємо на основі історії дебет. оборотів по рахунку простроч. відсотків
   -- чи на основі параметру R013, а потім порівнюємо його зі значенням s370_:
   -- якщо s370_ більше, ніж розраховане, то повертаємо s370_. Інакше - розраховане
   -------------------------------------------------------------------------------
   -- 03.02.2011 ОАВ вместо RNK из SAL будем брать RNK из ACCOUNTS
   -------------------------------------------------------------------------------
is
    wdate_  date;
    mdate_  date;
    s370_r  varchar2(2);
    acc_p   number;
    ost_p   number;
    r013_p  varchar2(1);
    dos_    number;
    nls_    accounts.nls%type;
    kv_     accounts.kv%type;
    acc1_   number;
    wdate1_ date;
    rnk_    number;
    nd_     number := p_nd_;
    s370_m  varchar2(2);
    rizn_   number;
    nkd_    varchar2(200);
    mfo_    number;
    mfou_   number := p_mfou_;

    procedure p_dbms(put_ in varchar2) is
    begin
        if 1=1 then --acc_ in (41773, 116414, 131266, 169468, 152250, 162612) then
           dbms_output.put_line(put_);
        end if;
    end;

    procedure p_get_s370(pacc_ in number, postp_ in number, pr013_ in varchar2) is
    begin
       -- если r013 заполнен 3, то остатток не разбиваем, а соответственно и S370 ставим по-умолчанию
        if pr013_ = '3' then
          s370_r := 'J';
        else
           if postp_ <> 0 then
              dos_ := 0;
              s370_r := null;

              for k in (select s.acc, s.fdat, s.dos - nvl(sel.s,0) dos
                        from saldoa s,
                             ( --находим сторнированные (r.ref) и сторнирующие (r.ref_bak) проводки
                             select o.acc, sum(o.s) s, o.fdat
                              from ref_back r, opldok o
                              where o.ref in (r.ref )  and
                                    r.dt between Dat_ - 60 and Dat_ and
                                    o.dk = 0 and
                                    o.acc = acc_p
                              group by  o.acc, o.fdat
                             ) sel
                        where s.acc=pacc_
                          and s.fdat between Dat_ - 60 and Dat_
                          and s.dos<>0
                          and s.acc = sel.acc(+)
                          and s.fdat = sel.fdat(+)
                        order by fdat DESC)

              loop
                 dos_ := dos_ + k.dos;
                 wdate_ := k.fdat;

                 if pr013_ = '2' then
                    -- якщо не було рухів до 31 дня, то далі розбиваємо залишок
                    if wdate1_ is null and dat_ - wdate_ + 1 > 31 then
                       wdate1_ := wdate_;
                    else -- інакше беремо як є
                       s370_r := 'I';
                       exit;
                    end if;
                 end if;

                 if dos_ >= postp_ then
                    exit;
                 end if;
              end loop;

              if s370_r is null then
                  if (wdate_ is not null) and (dos_ >= postp_) then
                     rizn_ := dat_ - wdate_ + 1;

                     if rizn_ <= 0 then
                        s370_r := '0';
                     elsif rizn_ <= 60 then
                        s370_r := 'I';
                     elsif rizn_ > 60 then
                        s370_r := 'J';
                     else
                        null;
                     end if;
                  else
                    s370_r := 'J';
                  end if;
              end if;
           else
              s370_r := '0';
           end if;
        end if;
    end;
begin
    s370_r := '0';
    s370_m := '0';
    wdate1_ := null;

    select a.nls, a.kv, a.mdate, a.rnk, trim(s.nkd),NVL(trim(s.r013),'0')
    into nls_, kv_, mdate_, rnk_, nkd_, r013_p
    from accounts a, specparam s
    where a.acc = acc_ and
        a.acc  = s.acc(+);

    if mfou_ is null then
       mfo_ := f_ourmfo;

       BEGIN
          SELECT mfou
            INTO mfou_
            FROM banks
           WHERE mfo = mfo_;
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
             mfou_ := mfo_;
       END;
    end if;

    p_dbms('acc='||to_char(acc_)||' mdate='||to_char(mdate_,'dd/mm/yyyy'));

    -- для банку Надра берем то, что на счете (т.к. нужно регулировать расчет резервов)
    if mfou_ = 380764 then
       begin
           if nd_ is null then
              if nkd_ is null then
                  select nvl(max(nvl(trim(p.s370), '0')), '0')
                  into s370_m
                  from sal s, specparam p, accounts a
                  where s.fdat=Dat_
                     and s.acc = a.acc
                     and a.rnk = rnk_
                     and s.ost <> 0
                     and (a.nbs like substr(nls_,1,3) || '%' and
                          a.nls like substr(nls_,1,3)||'9_'||substr(nls_,6,9)||'%' or
                          a.nls like '3579_'||substr(nls_,6,9)||'%')
                     and a.kv = kv_
                     and s.acc = p.acc(+)
                     and nvl(trim(p.s370), '0')<>'0';
              else
                  select nvl(max(nvl(trim(p.s370), '0')), '0')
                  into s370_m
                  from sal s, specparam p, accounts a
                  where s.fdat = Dat_
                     and s.acc = a.acc
                     and a.rnk = rnk_
                     and s.ost <> 0
                     and (a.nbs like substr(nls_,1,3) || '%' and
                          a.nls like substr(nls_,1,3)||'9%' or
                          a.nls like '3579%')
                     and a.kv = kv_
                     and s.acc = p.acc
                     and trim(p.nkd) = nkd_
                     and nvl(trim(p.s370), '0')<>'0';
              end if;
           else
              select nvl(max(nvl(trim(p.s370), '0')), '0')
              into s370_m
              from nd_acc a, cc_deal c, sal s, specparam p
              where a.nd=nd_
                 and a.nd=c.nd
                 and a.acc=s.acc
                 and s.fdat = dat_
                 and s.ost<>0
                 and (trim(s.tip) in ('SPN','SLN')
                   or s.nls LIKE substr(nls_,1,3)||'9%'
                   or s.nls like '3579%') and
                     a.acc = p.acc(+)
                 and nvl(trim(p.s370), '0')<>'0';
           end if;
       exception
         when no_data_found then
            s370_m := '0';
       end;

       if s370_m <> '0' then
          return s370_m;
       end if;
    end if;

    if nd_ is null then
       p_dbms('nkd='||to_char(nkd_));

       -- не знайшли, то шукаємо так рахунок просрочки
       if nkd_ is null then
          for pp in (select s.acc acc_p, ABS(s.ost) ost_p, nvl(p.r013, '0') r013_p
                       from sal s, specparam p, accounts a
                       where s.fdat=Dat_
                         and s.acc = a.acc
                         and a.rnk = rnk_
                         and s.ost <> 0
                         and (a.nbs like substr(nls_,1,3) || '%' and
                              a.nls like substr(nls_,1,3)||'9_'||substr(nls_,6,9)||'%' or
                              a.nls like '3579_'||substr(nls_,6,9)||'%')
                         and a.kv = kv_
                         and s.acc = p.acc(+))
           loop
               p_dbms('fl1: accp='||to_char(pp.acc_p)||' ost_p='||to_char(pp.ost_p)||' r013_p='||to_char(pp.r013_p));

               p_get_s370(pp.acc_p, pp.ost_p, pp.r013_p);

               if s370_r > s370_m then
                 s370_m := s370_r;
               end if;

               -- дальше смотреть бессмысленно
               if s370_m = 'J' then
                 exit;
               end if;

           end loop;

           s370_r := s370_m;
       else
          for pp in (select s.acc acc_p, ABS(s.ost) ost_p, nvl(p.r013, '0') r013_p
                       from sal s, specparam p, accounts a
                       where s.fdat = Dat_
                         and s.acc = a.acc
                         and a.rnk = rnk_
                         and s.ost <> 0
                         and (a.nbs like substr(nls_,1,3) || '%' and
                              a.nls like substr(nls_,1,3)||'9%' or
                              a.nls like '3579%')
                         and a.kv = kv_
                         and s.acc = p.acc
                         and trim(p.nkd) = nkd_
                         )
           loop
               p_dbms('fl2: accp='||to_char(pp.acc_p)||' ost_p='||to_char(pp.ost_p)||' r013_p='||to_char(pp.r013_p));

               r013_p := pp.r013_p;

               p_get_s370(pp.acc_p, pp.ost_p, pp.r013_p);

               if s370_r > s370_m then
                 s370_m := s370_r;
               end if;

               -- дальше смотреть бессмысленно
               if s370_m = 'J' then
                 exit;
               end if;

           end loop;

           s370_r := s370_m;

       end if;
    else
        p_dbms('nd='||to_char(nd_));

        for pp in (select s.acc acc_p, c.wdate, c.nd, ABS(ost) ost_p, nvl(p.r013, '0') r013_p
                           from nd_acc a, cc_deal c, sal s, specparam p
                           where a.nd=nd_
                             and a.nd=c.nd
                             and a.acc=s.acc
                             and s.fdat = dat_
                             and s.rnk = rnk_
                             and s.ost<>0
                             and (trim(s.tip) in ('SPN','SLN')
                               or s.nls LIKE substr(nls_,1,3)||'9%'
                               or s.nls like '3579%') and
                                 a.acc = p.acc(+)
                   )
        loop
           p_dbms('fl3: accp='||to_char(pp.acc_p)||' ost_p='||to_char(pp.ost_p)||' r013_p='||to_char(pp.r013_p));

           wdate1_ := null;
           s370_r := null;

           -- если r013 заполнен 3, то остатток не разбиваем, а соответственно и S370 ставим по-умолчанию
           if pp.r013_p = '3' then
              s370_r := 'J';
           else
             -- рахуємо коли виникла прострочка,???
             dos_ := 0;

             for k in (select s.acc, s.fdat, s.dos - nvl(sel.s,0) dos
                        from saldoa s,
                             ( --находим сторнированные (r.ref) и сторнирующие (r.ref_bak) проводки
                             select o.acc, sum(o.s) s, o.fdat
                              from ref_back r, opldok o
                              where o.ref in (r.ref )  and
                                    r.dt between Dat_ - 60 and Dat_ and
                                    o.dk = 0 and
                                    o.acc = pp.acc_p
                              group by  o.acc, o.fdat
                             ) sel
                        where s.acc=pp.acc_p
                          and s.fdat between Dat_ - 60 and Dat_
                          and s.dos<>0
                          and s.acc = sel.acc(+)
                          and s.fdat = sel.fdat(+)
                        order by fdat DESC)
              loop
                 dos_ := dos_ + k.dos;
                 wdate_ := k.fdat;

                 if pp.r013_p = '2' then
                    -- якщо не було рухів до 31 дня, то далі розбиваємо залишок
                    if wdate1_ is null and dat_ - wdate_ + 1 > 31 then
                       wdate1_ := wdate_;
                    else -- інакше беремо як є
                       s370_r := 'I';
                       exit;
                    end if;
                 end if;
                 if dos_ >= pp.ost_p then
                    exit;
                 end if;
              end loop;

              if s370_r is null then
                 -- розраховуємо різницю і визначаємо код s370
                  if (wdate_ is not null) and (dos_ >= pp.ost_p) then
                     rizn_ := dat_ - wdate_ + 1;

                     if rizn_ <= 0 then
                        s370_r := '0';
                     elsif rizn_ <= 60 then
                        s370_r := 'I';
                     elsif rizn_ > 60 then
                        s370_r := 'J';
                     else
                        null;
                     end if;
                  else
                     s370_r := 'J';
                  end if;
              end if;
           end if;

           if s370_r > s370_m then
             s370_m := s370_r;
           end if;

           -- дальше смотреть бессмысленно
           if s370_m = 'J' then
             exit;
           end if;

        end loop;

        s370_r := s370_m;
    end if;

   -- якщо s370_ більше, ніж розраховане, то повертаємо s370_. Інакше - розраховане
    if nvl(trim(s370_), '0') in ('0', 'I', 'J') and
       s370_r < nvl(trim(s370_), '0')
    then
       s370_r := nvl(trim(s370_), '0');
    end if;

    if r013_p = '1' and trim(s370_r)='0' then
       s370_r := 'I';
    end if;

    return nvl(s370_r, 'X');
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s370.sql =========*** End ***
 PROMPT ===================================================================================== 
 