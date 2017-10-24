
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_expire_days.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_EXPIRE_DAYS (dat_ in date, --дата
                                                  acc_ in number, --счет
                                                  p_nd_ in varchar2,  --реф. договора (необязательный)
                                                  acc_exp_ in number:= null, --счет просрочки (необязательный)
                                                  is_osn_ number := null,-- null - по основной задолженности, not null - по %
                                                  mfo_ varchar2 default f_ourmfo
                                                  ) return number --кол-во дней просрочки
   -- version 28/08/2014 (15/11/2013)
   --
   -- 15.11.2013 для банка Надра добавлен блок для вывода номера док-та и
   --            основного счета если нет ND в CC_KOL_SP
   -- 07.06.2013 до окончательного решения вопроса вычисления кол-ва дней просрочки
   --            отключили функцию GETDOLGSTARTDATE
   -- 05.06.2013 для банка Надра дополнительно изпользуем функцию GETDOLGSTARTDATE
   -- 04.06.2013 добавлена функция cck_app.Get_ND_TXT(ND_, DATSP(DASPN) )
   -- DATSP - дата просрочки основного долга
   -- DASPN - дата просрочки процентов
is
    wdate_  date;
    mdate_  date;
    rez_    number;
    acc_p   number;
    ost_p   number;
    dos_    number;
    nls_    accounts.nls%type;
    kv_     accounts.kv%type;
    acc1_   number;
    wdate1_ date;
    wdate2_ date;
    nd_     varchar2(100) := p_nd_;
    datv_   date;

    procedure p_dbms(put_ in varchar2) is
begin
    if 1<>1 then
       --dbms_output.put_line(put_);
       null;
    end if;
end;
begin
   --  10/07/2013 для банку Надра будемо брати з таблицы, де вже є розрахована кількість дныв прострочки по договору
    if mfo_ = '380764' and p_nd_ is not null then
        begin
            select nvl(decode(is_osn_, null, sp, spn),0)
            into rez_
            from CC_KOL_SP
            where fdat= dat_ and
                nd = p_nd_;

            return greatest(nvl(rez_, 0),0);
        exception
            when no_data_found then
                null; -- якщо там немає запису, то рахуємо по-старому
               when others
                 then raise_application_error(-20000,'nd=>'||p_nd_||', is_osn_=>'||is_osn_);

        end;
    end if;

    rez_ := 0;
    p_dbms('---------------------------------------------------');

    --указан счет просрочки
    if acc_exp_ is not null then
       -- якщо знайшли, то розрахуємо залишок
       BEGIN
          acc1_ := acc_exp_;

          select acc, nls, fost(acc, dat_)
             INTO acc_p, nls_, ost_p
          from accounts
          where acc=acc1_;

          p_dbms('fl0: accp='||to_char(acc_p)||' ost_p='||to_char(ost_p));

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

          -- якщо по кредиту є прострочка, то рахуємо коли вона виникла???
          if ost_p <> 0 then
             dos_ := 0;

             if nls_ like '___7%' then
                wdate_ := to_date(cck_app.Get_ND_TXT(nd_, 'DATSP'),'dd/mm/yyyy');
             end if;

             if nls_ like '___9%' then
                wdate_ := to_date(cck_app.Get_ND_TXT(nd_, 'DASPN'),'dd/mm/yyyy');
             end if;

             if wdate_ is null then
                for k in (select acc, fdat, dos
                          from saldoa
                          where acc=acc_p
                            and fdat<=Dat_
                            and dos<>0
                          order by fdat DESC  )

                loop
                   dos_ := dos_+k.dos;
                   wdate_ := k.fdat;

                   if dos_ >= ost_p then
                      exit;
                   end if;
                end loop;
             end if;

             p_dbms('fl0: wdate_='||wdate_||' dos='||dos_);

             if wdate_ is not null  then  --and dos_ >= ost_p then
                rez_ := dat_ - wdate_;
             else
               rez_ := 200;
             end if;
          else -- по кредиту немає прстрочки
             rez_ := 0;
          end if;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          rez_ := 0;
       END;

    --счет просрочки не задан - нужно его найти
    else
        select nls, kv, mdate
        into nls_, kv_, mdate_
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
               --по счетам осн долга
               if is_osn_ is null then
                   select acc, nls,  fost(acc, dat_)
                      INTO acc_p, nls_, ost_p
                   from accounts
                   where nbs like substr(nls_,1,3) || '%'
                     and nls like substr(nls_,1,3)||'7_'||substr(nls_,6,9)||'%'
                     and kv = kv_ ;
               --по счетам процентов
               else
                   select acc, nls, ABS(ost)
                      INTO acc_p, nls_, ost_p
                   from sal
                   where fdat=Dat_
                     and ost < 0
                     and nbs like substr(nls_,1,3) || '%'
                     and nls like substr(nls_,1,3)||'9_'||substr(nls_,6,9)||'%'
                     and kv = kv_ ;
               end if;

               p_dbms('fl1: accp='||to_char(acc_p)||' ost_p='||to_char(ost_p));

               if ost_p <> 0 then
                  dos_ := 0;

                  if nls_ like '___7%' then
                     wdate_ := to_date(cck_app.Get_ND_TXT(nd_, 'DATSP'),'dd/mm/yyyy');
                  end if;

                  if nls_ like '___9%' then
                     wdate_ := to_date(cck_app.Get_ND_TXT(nd_, 'DASPN'),'dd/mm/yyyy');
                  end if;

                  if wdate_ is null then
                     for k in (select acc, fdat, dos
                               from saldoa
                               where acc=acc_p
                                and fdat<=Dat_
                                 and dos<>0
                               order by fdat DESC  )

                     loop
                        dos_ := dos_+k.dos;
                        wdate_ := k.fdat;

                        if dos_ >= ost_p then
                           exit;
                        end if;

                     end loop;
                  end if;

                  p_dbms('fl0: wdate_='||wdate_||' dos='||dos_);

                  if wdate_ is not null  then  --and dos_ >= ost_p then
                     rez_ := dat_ - wdate_;
                  else
                    rez_ := 200;
                  end if;
               else
                  rez_ := 0;
               end if;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                -- взагалі нічого не знайшли
               rez_ := 0;
            END;
        else
            BEGIN
               --по счетам осн долга
               if is_osn_ is null then
                 begin
                   select s.acc, c.wdate, c.nd
                      into acc1_, wdate1_, nd_
                   from nd_acc a, cc_deal c, accounts s
                   where a.nd=nd_
                     and a.nd=c.nd
                     and a.acc=s.acc
                     and s.nls LIKE substr(nls_,1,3)||'7_'||substr(nls_,6,9)||'%'
                     and nvl(s.dazs, to_date('01014999','ddmmyyyy')) > Dat_
                     and (s.kv=kv_  or nls_ LIKE '3578%' OR nls_ LIKE '3579%' )
                     and exists (select 1
                                 from sal
                                 where fdat = dat_ and
                                       acc = a.acc and
                                       ost<0)
                     and rownum = 1;
                 exception
                    when no_data_found then
                       select s.acc, c.wdate, c.nd
                          into acc1_, wdate1_, nd_
                       from nd_acc a, cc_deal c, accounts s
                       where a.nd=nd_
                         and a.nd=c.nd
                         and a.acc=s.acc
                         and s.nls LIKE substr(nls_,1,3)||'7_'||'%'
                         and nvl(s.dazs, to_date('01014999','ddmmyyyy')) > Dat_
                         and (s.kv=kv_  or nls_ LIKE '3578%' OR nls_ LIKE'3579%' )
                         and exists (select 1
                                 from sal
                                 where fdat = dat_ and
                                       acc = a.acc and
                                       ost<0)
                         and rownum = 1;
                 end;
               --по счетам процентов
               else
                 begin
                   select s.acc, c.wdate, c.nd
                      into acc1_, wdate1_, nd_
                   from nd_acc a, cc_deal c, accounts s
                   where a.nd=nd_
                     and a.nd=c.nd
                     and s.nls LIKE substr(nls_,1,3)||'9_'||substr(nls_,6,9)||'%'
                     and a.acc=s.acc
                     and nvl(s.dazs, to_date('01014999','ddmmyyyy')) > Dat_
                     and exists (select 1
                                 from sal
                                 where fdat = dat_ and
                                       acc = a.acc and
                                       ost<0)
                     and rownum = 1;
                 exception
                    when no_data_found then
                       select s.acc, c.wdate, c.nd
                          into acc1_, wdate1_, nd_
                       from nd_acc a, cc_deal c, accounts s
                       where a.nd=nd_
                         and a.nd=c.nd
                         and s.nls LIKE substr(nls_,1,3)||'9_'||'%'
                         and a.acc=s.acc
                         and nvl(s.dazs, to_date('01014999','ddmmyyyy')) > Dat_
                         and exists (select 1
                                     from sal
                                     where fdat = dat_ and
                                           acc = a.acc and
                                           ost<0)
                         and rownum = 1;
                 end;
               end if;

               p_dbms('acc1='||to_char(acc1_));

               if nls_='22095100015737' then
                  logger.info ('REZZ acc1='||acc1_);
               end if;


               -- якщо знайшли, то розрахуємо залишок
               BEGIN
                  select acc, nls, ABS(ost)
                     INTO acc_p, nls_, ost_p
                  from sal
                  where fdat=Dat_
                    and acc=acc1_;

                  p_dbms('fl2: accp='||to_char(acc_p)||' ost_p='||to_char(ost_p));

                  if nls_='22095100015737' then
                     logger.info ('REZZ fl2: accp='||acc_p||' ost_p='||ost_p);
                  end if;

                  -- якщо по кредиту є прострочка, то рахуємо коли вона виникла???
                  if ost_p <> 0 then
                     dos_ := 0;

                     if nls_ like '___7%' then
                        wdate_ := to_date(cck_app.Get_ND_TXT(nd_, 'DATSP'),'dd/mm/yyyy');
                     end if;

                     if nls_ like '___9%' then
                        wdate_ := to_date(cck_app.Get_ND_TXT(nd_, 'DASPN'),'dd/mm/yyyy');
                     end if;

                     if wdate_ is null then
                        for k in (select acc, fdat, dos
                                  from saldoa
                                  where acc=acc_p
                                    and fdat<=Dat_
                                    and dos<>0
                                  order by fdat DESC  )

                        loop
                           dos_ := dos_+k.dos;
                           wdate_ := k.fdat;

                           if dos_ >= ost_p then
                              exit;
                           end if;
                        end loop;
                     end if;

                     p_dbms('fl0_l: wdate_='||wdate_||'gl.bd='||gl.bd||' dos='||dos_);

                     if nls_='22095100015737' then
                        logger.info ('REZZ fl0_l: wdate_='||wdate_||'gl.bd='||gl.bd||' dos='||dos_);
                     end if;

                     if wdate_ is not null  and dos_ >= ost_p then
                        rez_ := dat_ - wdate_;
                     else
                        rez_ := 200;
                     end if;
                  else -- по кредиту немає прстрочки
                     rez_ := 0;
                  end if;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  rez_ := 0;
               END;
            EXCEPTION
--              when too_many_rows then
--                  raise_application_error(-20001, 'acc='||to_char(acc_)|| ' ' ||sqlerrm);
              WHEN NO_DATA_FOUND THEN
               rez_ := 0;
               p_dbms('NO acc1');

               -- шукаємо рахунок основного боргу і дату закінчення дії договору???
               BEGIN
                  --по счетам осн долга
                  if is_osn_ is null then
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
                        and (s.kv=kv_  or nls_ LIKE '3578%' OR nls_ LIKE'3579%' )
                        and nvl(s.dazs, to_date('01014999','ddmmyyyy')) > Dat_
                        and exists (select 1
                                 from sal
                                 where fdat = dat_ and
                                       acc = s.acc and
                                       ost<0)
                        )
                        where (nls LIKE '_____'||substr(nls_,6,9)||'%' or cnt = 1 or nls_ LIKE '3578%' OR nls_ LIKE'3579%')
                             and rownum=1
                        ;
                  --по счетам процентов
                  else
                      select acc,wdate,nd
                      into acc1_, wdate2_, nd_
                      from
                      (
                      select a.acc, c.wdate, c.nd, count(*) over() cnt,s.nls, s.kv
                      from cc_deal c, nd_acc a, accounts s
                      where c.nd=nd_
                        and a.nd=c.nd
                        and a.acc=s.acc
                        and trim(s.tip)='SN'
                        and (s.kv=kv_  or nls_ LIKE '3578%' OR nls_ LIKE'3579%' )
                        and nvl(s.dazs, to_date('01014999','ddmmyyyy')) > Dat_
                        and exists (select 1
                                 from sal
                                 where fdat = dat_ and
                                       acc = s.acc and
                                       ost<0)
                        )
                        where (nls LIKE '_____'||substr(nls_,6,9)||'%' or cnt = 1 or nls_ LIKE '3578%' OR nls_ LIKE'3579%')
                             and rownum=1
                        ;
                  end if;
                p_dbms('fl3: accp='||to_char(acc1_)||' wdate='||to_char(wdate2_,'dd/mm/yyyy'));

                   -- розраховуємо різницю і визначаємо код s270
                   rez_ := dat_ - wdate2_;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                   p_dbms('NO acc1 2');
               END;
            END;
        end if;

    end if;

    p_dbms('fl4: rez_='||rez_);

    if nvl(rez_, 0) <> 0 then
       rez_ := rez_ + 1;
    end if;

    return greatest(nvl(rez_, 0),0);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_expire_days.sql =========*** 
 PROMPT ===================================================================================== 
 