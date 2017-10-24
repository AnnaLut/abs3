

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILED5.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILED5 ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILED5 (kodf_ varchar2,dat_ date,userid_ number) is
-- 01.08.2011 изменил условие для обработки новой структуры показателей (для #D5 была
--            правильная обработка, а для #D6 нет)
-- 22.07.2011 в связи с изменением структуры показателей файлов #D5, #D6
-- добавлен код "L" - 1-сумма,2-%%ставка, добавил условие для проверки
-- по KOD_D5, KOD_D6 проверяем только остатки и не проверяем %% ставки
-- 01.04.2010 применяем функцию TRIM для полей таблицы KOD_D5(KOD_D6)
-- 04.09.2007 (20.02.07) новый файл аналогичный #14 только изменена структура
-- в файле #14 вместо параметра K071 формируется параметр K072
-- для #D5 выполняем проверку по классификатору KOD_D5,
-- а для #D6 по кл-ру KOD_D6.
-- c 31.08.2007 вместо кода K081 будет формироваться код '9' и поэтому
-- в контроле исключаем данный параметр

 c_      number;
 kol_d5  number := 0;
 pr_d5   number := 0;
 kol_    number;
 kol1_   number;
 nbs_    Varchar2(4);
 k071_   Varchar2(1);
 pr_k081 number;
 pr_izm  number;


begin

  pr_izm :=0;

  if dat_ >= to_date('01072011','ddmmyyyy') then
     pr_izm := 1;
  end if;

  if dat_ < to_date('31082007','ddmmyyyy') then
     pr_k081 := 1;
  else
     pr_k081 := 0;
  end if;

delete from otcn_log
where userid = userid_ AND kodf = kodf_;

insert into otcn_log (kodf,userid,txt) VALUES
                     (kodf_,userid_,'Перевiрка файлу #'||kodf_||
                      ' по KL_R011 и KOD_'||kodf_);
insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'');



for k in
( select kodp,
         znap,
	 decode(pr_izm,0,substr(kodp,2,4),substr(kodp,3,4))  r020,
	 decode(pr_izm,0,substr(kodp,2,3),substr(kodp,3,3))  gr,
	 decode(pr_izm,0,substr(kodp,2,2),substr(kodp,3,2))  razd,
	 decode(pr_izm,0,substr(kodp,6,1),substr(kodp,7,1))  r011,
	 decode(pr_izm,0,substr(kodp,9,1),substr(kodp,10,1))  k072,
	 decode(pr_izm,0,substr(kodp,10,1),substr(kodp,11,1)) k081,
	 decode(pr_izm,0,substr(kodp,11,1),substr(kodp,12,1)) s181,
	 decode(pr_izm,0,substr(kodp,13,2),substr(kodp,14,2)) k051,
	 decode(pr_izm,0,substr(kodp,7,2),substr(kodp,8,2))  k111,
	 decode(pr_izm,0,substr(kodp,12,1),substr(kodp,13,1)) k030
  from tmp_nbu
  where kodf=kodf_ and datf=dat_
  order by 3)
loop

if ((dat_ >= to_date('01072011','ddmmyyyy') and substr(k.kodp,1,2) in ('11','12')
     and k.r020 not in ('1590','2400','2401')) or
    (dat_ < to_date('01072011','ddmmyyyy') and substr(k.kodp,1,1) in ('1','2')))
then

 begin

    select count(*) INTO kol_ from SP_NEW_R011
    where r020=k.r020 ;

    if kol_>0 THEN
--       select count(*) into kol1_    ---r020 into nbs_
--       from sp_new_r011   --kl_r011
--       where r020=k.r020 and r011=k.r011; --and prem='КБ ' and d_close is null;
--       if kol1_=0 then
--          insert into otcn_log (kodf,userid,txt)
--          select kodf_,userid_,
--          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
--         'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||
--          ' Помилковий R011='||k.r011
--          from rnbu_trace r, customer c
--          where r.userid = userid_
--            and r.kodp   = k.kodp
--            and r.rnk    = c.rnk;
--       end if;

       BEGIN
          select r020 into nbs_
          from sp_new_r011   --kl_r011
          where r020=k.r020 and r011=k.r011 and rownum=1; --and prem='КБ ' and d_close is null;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          insert into otcn_log (kodf,userid,txt)
          select kodf_,userid_,
          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
          'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||' '||r.tobo ||
          ' Помилковий R011='||k.r011
          from rnbu_trace r, customer c
          where r.userid = userid_
            and r.kodp   = k.kodp
            and r.rnk    = c.rnk;

--          BEGIN
--             select r020 into nbs_
--             from kl_r011
--             where r020=k.r020 and prem='КБ ' and
--                   r011=k.r011 and s181=k.s181 and d_close is null;
--          EXCEPTION WHEN NO_DATA_FOUND THEN null;
--             insert into otcn_log (kodf,userid,txt)
--             select kodf_,userid_,
--             'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
--             'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||
--             ' Помилка R011='||k.r011||' S181=' || k.s181
--            from rnbu_trace r, customer c
--             where r.userid = userid_
--               and r.kodp   = k.kodp
--               and r.rnk    = c.rnk;
--          END;
       END;

    end if;

    if k.k072<>'0' THEN
       BEGIN
          select distinct k072 into nbs_
          from kl_k070
          where k072=k.k072;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          insert into otcn_log (kodf,userid,txt)
          select kodf_,userid_,
          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
          'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||' '||r.tobo||
          ' Помилковий K072='||k.k072
          from rnbu_trace r, customer c
          where r.userid = userid_
            and r.kodp   = k.kodp
            and r.rnk    = c.rnk;
       END;
    end if;

    if dat_ < to_date('31082007','ddmmyyyy') then
       if k.k081<>'0' THEN
          BEGIN
             select distinct k081 into nbs_
             from kl_k080
             where k081=k.k081 and d_close is null;
          EXCEPTION WHEN NO_DATA_FOUND THEN null;
             insert into otcn_log (kodf,userid,txt)
             select kodf_,userid_,
             'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
             'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||' '||r.tobo||
             ' Помилковий K081='||k.k081
             from rnbu_trace r, customer c
             where r.userid = userid_
               and r.kodp   = k.kodp
               and r.rnk    = c.rnk;
          END;
       end if;
    end if;

    if k.k051<>'00' THEN
       BEGIN
          select distinct k051 into nbs_
          from kl_k051
          where k051=k.k051 and d_close is null;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          insert into otcn_log (kodf,userid,txt)
          select kodf_,userid_,
          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
          'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||' '||r.tobo||
          ' Помилковий K051='||k.k051
          from rnbu_trace r, customer c
          where r.userid = userid_
            and r.kodp   = k.kodp
            and r.rnk    = c.rnk;
       END;
    end if;

    if k.k111<>'00' THEN
       BEGIN
          select distinct k111 into nbs_
          from kl_k110
          where k111=k.k111;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          insert into otcn_log (kodf,userid,txt)
          select kodf_,userid_,
          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
          'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||' '||r.tobo||
          ' Помилковий K111='||k.k111
          from rnbu_trace r, customer c
          where r.userid = userid_
            and r.kodp   = k.kodp
            and r.rnk    = c.rnk;
       END;
    end if;

    c_:=0;

 if kodf_='D5' THEN
    --if pr_d5 = 0 then
    --   insert into otcn_log (kodf,userid,txt)
    --   values(kodf_,userid_,'');
    --   insert into otcn_log (kodf,userid,txt)
    --   values(kodf_,userid_,'Перевiрка на допустимiсть сполучень по кл-ру kod_d5');
    --   insert into otcn_log (kodf,userid,txt)
    --   values(kodf_,userid_,'');
       --insert into otcn_log (kodf,userid,txt)
       --values(kodf_,userid_, ' !!! Неможливе сполучення !!!');
    --   pr_d5 := pr_d5 + 1;
    --end if;

       BEGIN
          select distinct razd into nbs_
          from kod_d5 kd
          where trim(kd.r020) = k.r020
            and decode(trim(kd.r011),null,k.r011,trim(kd.r011)) like '%'||k.r011||'%'
            and trim(kd.k072) like '%'||k.k072||'%'
            --and trim(kd.k081) like '%'||k.k081||'%'
            and trim(kd.k081) like '%'||decode(pr_k081,1,k.k081,trim(kd.k081))||'%'
            and trim(kd.k051) like '%'||k.k051||'%'
            and trim(kd.k111) like '%'||k.k111||'%'
            and trim(kd.k030)=k.k030 and nvl(kd.D_CLOSE,dat_) >= dat_ ;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          BEGIN
             select distinct razd into nbs_
             from kod_d5 kd
             where trim(kd.gr)   = k.gr
               and trim(kd.r020) is null
               and decode(trim(kd.r011),null,k.r011,trim(kd.r011)) like '%'||k.r011||'%'
               and trim(kd.k072) like '%'||k.k072||'%'
               --and trim(kd.k081) like '%'||k.k081||'%'
               and trim(kd.k081) like '%'||decode(pr_k081,1,k.k081,trim(kd.k081))||'%'
               and trim(kd.k051) like '%'||k.k051||'%'
               and trim(kd.k111) like '%'||k.k111||'%'
               and trim(kd.k030)=k.k030 and nvl(kd.D_CLOSE,dat_) >= dat_ ;
          EXCEPTION WHEN NO_DATA_FOUND THEN null;
             BEGIN
                select distinct razd into nbs_
                from kod_d5 kd
                where trim(kd.razd) = k.razd
                  and trim(kd.r020) is null
                  and trim(kd.gr)   is null
                  and decode(trim(kd.r011),null,k.r011,trim(kd.r011)) like '%'||k.r011||'%'
                  and trim(kd.k072) like '%'||k.k072||'%'
                  --and trim(kd.k081) like '%'||k.k081||'%'
                  and trim(kd.k081) like '%'||decode(pr_k081,1,k.k081,trim(kd.k081))||'%'
                  and trim(kd.k051) like '%'||k.k051||'%'
                  and trim(kd.k111) like '%'||k.k111||'%'
                  and trim(kd.k030)=k.k030 and nvl(kd.D_CLOSE,dat_) >= dat_ ;
             EXCEPTION WHEN NO_DATA_FOUND THEN null;
                if pr_d5 = 0 then
                   insert into otcn_log (kodf,userid,txt)
                   values(kodf_,userid_,'');
                   insert into otcn_log (kodf,userid,txt)
                   values(kodf_,userid_,'Помилка -  вiдсутнє сполучення в kod_d5 !!!');
                   pr_d5 := pr_d5 + 1;
                end if;

                insert into otcn_log (kodf,userid,txt)
                values(kodf_,userid_,'');
                insert into otcn_log (kodf,userid,txt)
                values(kodf_,userid_,'Код показника/Значення показника');
                insert into otcn_log (kodf,userid,txt)
                values(kodf_,userid_,'<'||k.kodp||'> = <'||k.znap||'>');
                --insert into otcn_log (kodf,userid,txt)
                --values(kodf_,userid_, ' !!! Неможливе сполучення !!!');
                kol_d5 := kol_d5 + 1;

                insert into otcn_log (kodf,userid,txt)
                values(kodf_,userid_,'R020='||k.r020||' R011='||k.r011||
                ' K072='||k.k072||' K081='||k.k081||' K051='||k.k051||' K111='||k.k111||
                ' K030(рез.)='||k.k030) ;
                insert into otcn_log (kodf,userid,txt)
                values(kodf_,userid_,'');
                insert into otcn_log (kodf,userid,txt)
                values(kodf_,userid_,'Перелiк рахункiв/контрагентiв якi включенi в показник');
                insert into otcn_log (kodf,userid,txt)
                select kodf_,userid_,''||'вик.='||r.isp||' '||r.nls||'  ('||r.kv||') '||
                'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,50)||' '||r.tobo
                from rnbu_trace r, customer c
                where r.userid = userid_
                  and r.kodp   = k.kodp
                  and r.rnk    = c.rnk  ;
                insert into otcn_log (kodf,userid,txt)
                values(kodf_,userid_,'');
             END;
          END;
       END;

 end if;

 if kodf_='D6' THEN
    BEGIN
       select distinct razd into nbs_
       from kod_d6 kd
       where trim(kd.r020) = k.r020
         and decode(trim(kd.r011),null,k.r011,trim(kd.r011)) like '%'||k.r011||'%'
         and trim(kd.k072) like '%'||k.k072||'%'
         --and trim(kd.k081) like '%'||k.k081||'%'
         and trim(kd.k081) like '%'||decode(pr_k081,1,k.k081,trim(kd.k081))||'%'
         and trim(kd.k051) like '%'||k.k051||'%'
         and trim(kd.k111) like '%'||k.k111||'%'
         and trim(kd.k030)=k.k030 and nvl(kd.D_CLOSE,dat_) >= dat_ ;
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
       BEGIN
          select distinct razd into nbs_
          from kod_d6 kd
          where trim(kd.gr)   = k.gr
            and trim(kd.r020) is null
            and decode(trim(kd.r011),null,k.r011,trim(kd.r011)) like '%'||k.r011||'%'
            and trim(kd.k072) like '%'||k.k072||'%'
            --and trim(kd.k081) like '%'||k.k081||'%'
            and trim(kd.k081) like '%'||decode(pr_k081,1,k.k081,trim(kd.k081))||'%'
            and trim(kd.k051) like '%'||k.k051||'%'
            and trim(kd.k111) like '%'||k.k111||'%'
            and trim(kd.k030)=k.k030 and nvl(kd.D_CLOSE,dat_) >= dat_ ;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          BEGIN
             select distinct razd into nbs_
             from kod_d6 kd
             where trim(kd.razd) = k.razd
               and trim(kd.r020) is null
               and trim(kd.gr)   is null
               and decode(trim(kd.r011),null,k.r011,trim(kd.r011)) like '%'||k.r011||'%'
               and trim(kd.k072) like '%'||k.k072||'%'
               --and trim(kd.k081) like '%'||k.k081||'%'
               and trim(kd.k081) like '%'||decode(pr_k081,1,k.k081,trim(kd.k081))||'%'
               and trim(kd.k051) like '%'||k.k051||'%'
               and trim(kd.k111) like '%'||k.k111||'%'
               and trim(kd.k030)=k.k030 and nvl(kd.D_CLOSE,dat_) >= dat_ ;
          EXCEPTION WHEN NO_DATA_FOUND THEN null;
             if pr_d5 = 0 then
                insert into otcn_log (kodf,userid,txt)
                values(kodf_,userid_,'');
                insert into otcn_log (kodf,userid,txt)
                values(kodf_,userid_,'Помилка -  вiдсутнє сполучення в kod_d6 !!!');
                pr_d5 := pr_d5 + 1;
             end if;

             insert into otcn_log (kodf,userid,txt)
             values(kodf_,userid_,'');
             insert into otcn_log (kodf,userid,txt)
             values(kodf_,userid_,'Код показника/Значення показника');
             insert into otcn_log (kodf,userid,txt)
             values(kodf_,userid_,'<'||k.kodp||'> = <'||k.znap||'>');
             --insert into otcn_log (kodf,userid,txt)
             --values(kodf_,userid_, ' !!! Неможливе сполучення !!!');
             kol_d5 := kol_d5 + 1;

             insert into otcn_log (kodf,userid,txt)
             values(kodf_,userid_,'R020='||k.r020||' R011='||k.r011||
             ' K072='||k.k072||' K081='||k.k081||' K051='||k.k051||' K111='||k.k111||
             ' K030(рез.)='||k.k030) ;
             insert into otcn_log (kodf,userid,txt)
             values(kodf_,userid_,'');
             insert into otcn_log (kodf,userid,txt)
             values(kodf_,userid_,'Перелiк рахункiв/контрагентiв якi включенi в показник');
             insert into otcn_log (kodf,userid,txt)
             select kodf_,userid_,''||'вик.='||r.isp||' '||r.nls||'  ('||r.kv||') '||
             'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,50)||' '||r.tobo
             from rnbu_trace r, customer c
             where r.userid = userid_
               and r.kodp   = k.kodp
               and r.rnk    = c.rnk  ;
             insert into otcn_log (kodf,userid,txt)
             values(kodf_,userid_,'');
          END;
       END;
    END;

 end if;

 end;

end if;

end loop;

if kol_d5 = 0 then
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'');
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,' !!! Неможливi сполучення вiдсутнi !!!');
   insert into otcn_log (kodf,userid,txt)
   values(kodf_,userid_,'');
end if;

end p_ch_filed5;
/
show err;

PROMPT *** Create  grants  P_CH_FILED5 ***
grant EXECUTE                                                                on P_CH_FILED5     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILED5.sql =========*** End *
PROMPT ===================================================================================== 
