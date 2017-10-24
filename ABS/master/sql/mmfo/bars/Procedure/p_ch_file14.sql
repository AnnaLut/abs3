

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE14.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILE14 ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILE14 (kodf_ varchar2,dat_ date,userid_ number) is
 c_ number;
 kol_ number;
 nbs_ Varchar2(4);

begin

delete from otcn_log
where userid = userid_ AND kodf = kodf_;

insert into otcn_log (kodf,userid,txt) VALUES
                     (kodf_,userid_,'Перевiрка файлу #14 по KL_R011 и KOD_14');
insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'');

for k in
( select kodp,
         znap,
	 substr(kodp,2,4)  r020,
	 substr(kodp,2,3)  gr,
	 substr(kodp,2,2)  razd,
	 substr(kodp,6,1)  r011,
	 substr(kodp,9,1)  k071,
	 substr(kodp,10,1) k081,
	 substr(kodp,11,1) s181,
	 substr(kodp,13,2) k051,
	 substr(kodp,7,2)  k111,
	 substr(kodp,12,1) k030
  from tmp_nbu
  where kodf=kodf_ and datf=dat_
  order by 3)
loop

 begin

    select count(*) INTO kol_ from KL_R011
    where r020=k.r020 and prem='КБ ' and d_close is null;

    if kol_>0 THEN
       BEGIN
          select r020 into nbs_ from kl_r011
          where r020=k.r020 and prem='КБ ' and r011=k.r011 and d_close is null;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          insert into otcn_log (kodf,userid,txt)
          select kodf_,userid_,
          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
          'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||
          ' Помилковий R011='||k.r011
          from rnbu_trace r, customer c
          where r.userid = userid_
            and r.kodp   = k.kodp
            and r.rnk    = c.rnk;

          BEGIN
             select r020 into nbs_ from kl_r011
             where r020=k.r020 and prem='КБ ' and
                   r011=k.r011 and s181=k.s181 and d_close is null;
          EXCEPTION WHEN NO_DATA_FOUND THEN null;
             insert into otcn_log (kodf,userid,txt)
             select kodf_,userid_,
             'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
             'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||
             ' Помилка R011='||k.r011||' S181=' || k.s181
             from rnbu_trace r, customer c
             where r.userid = userid_
               and r.kodp   = k.kodp
               and r.rnk    = c.rnk;
          END;
       END;

    end if;

    if k.k071<>'0' THEN
       BEGIN
          select distinct k071 into nbs_ from kl_k070
          where k071=k.k071;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          insert into otcn_log (kodf,userid,txt)
          select kodf_,userid_,
          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
          'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||
          ' Помилковий K071='||k.k071
          from rnbu_trace r, customer c
          where r.userid = userid_
            and r.kodp   = k.kodp
            and r.rnk    = c.rnk;
       END;
    end if;

    if k.k081<>'0' THEN
       BEGIN
          select distinct k081 into nbs_ from kl_k080
          where k081=k.k081 and d_close is null;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          insert into otcn_log (kodf,userid,txt)
          select kodf_,userid_,
          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
          'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||
          ' Помилковий K081='||k.k081
          from rnbu_trace r, customer c
          where r.userid = userid_
            and r.kodp   = k.kodp
            and r.rnk    = c.rnk;
       END;
    end if;

    if k.k051<>'00' THEN
       BEGIN
          select distinct k051 into nbs_ from kl_k051
          where k051=k.k051 and d_close is null;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          insert into otcn_log (kodf,userid,txt)
          select kodf_,userid_,
          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
          'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||
          ' Помилковий K051='||k.k051
          from rnbu_trace r, customer c
          where r.userid = userid_
            and r.kodp   = k.kodp
            and r.rnk    = c.rnk;
       END;
    end if;

    if k.k111<>'00' THEN
       BEGIN
          select distinct k111 into nbs_ from kl_k110
          where k111=k.k111;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
          insert into otcn_log (kodf,userid,txt)
          select kodf_,userid_,
          'вик.='||to_char(r.isp)||' '||r.nls||' ('||r.kv||') '||
          'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,38)||
          ' Помилковий K111='||k.k111
          from rnbu_trace r, customer c
          where r.userid = userid_
            and r.kodp   = k.kodp
            and r.rnk    = c.rnk;
       END;
    end if;

    c_:=0;

    select count(*) into c_
    from kod_14 kd
    where kd.r020 = k.r020
      and decode(kd.r011,null,k.r011,kd.r011) = k.r011
      and kd.k071 = k.k071
      and decode(kd.k081,null,k.k081,kd.k081) = k.k081
      and decode(kd.k051,null,k.k051,kd.k051) = k.k051
      and decode(kd.k111,null,k.k111,kd.k111) = k.k111
      and kd.k030=k.k030 and kd.D_OPEN <= dat_
      and nvl(kd.D_CLOSE,dat_) >= dat_ ;

    if c_ =0 then
       select count(*) into c_
       from kod_14 kd
       where kd.gr   = k.gr
         and kd.r020 is null
         and decode(kd.r011,null,k.r011,kd.r011) = k.r011
         and kd.k071 = k.k071
         and decode(kd.k081,null,k.k081,kd.k081) = k.k081
         and decode(kd.k051,null,k.k051,kd.k051) = k.k051
         and decode(kd.k111,null,k.k111,kd.k111) = k.k111
         and kd.k030=k.k030 and kd.D_OPEN <= dat_
         and nvl(kd.D_CLOSE,dat_) >= dat_ ;

       if c_ = 0 then
          select count(*) into c_
          from kod_14 kd
          where kd.razd = k.razd
            and kd.r020 is null
            and kd.gr   is null
            and decode(kd.r011,null,k.r011,kd.r011) = k.r011
            and kd.k071 = k.k071
            and decode(kd.k081,null,k.k081,kd.k081) = k.k081
            and decode(kd.k051,null,k.k051,kd.k051) = k.k051
            and decode(kd.k111,null,k.k111,kd.k111) = k.k111
            and kd.k030=k.k030 and kd.D_OPEN <= dat_
            and nvl(kd.D_CLOSE,dat_) >= dat_ ;
       end if;
    end if;

    if c_ = 0 then
       insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'');
       insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'Помилка -  вiдсутнє сполучення в kod_14');
       insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'');
       insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'Код показника/Значення показника');
       insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'<'||k.kodp||'> = <'||k.znap||'>');
       insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,' K030(рез.)='||k.k030||' --> Неможливе сполучення');
       insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'R020='||k.r020||' R011='||k.r011||
       ' K071='||k.k071||' K081='||k.k081||' K051='||k.k051||' K111='||k.k111) ;
       insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'');
       insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'Перелiк рахункiв/контрагентiв якi включенi в показник');
       insert into otcn_log (kodf,userid,txt)
       select kodf_,userid_,''||'вик.='||r.isp||' '||r.nls||'  ('||r.kv||') '||
       'rnk='||to_char(r.rnk)||' '||substr(c.nmk,1,50)
       from rnbu_trace r, customer c
       where r.userid = userid_
         and r.kodp   = k.kodp
         and r.rnk    = c.rnk  ;

--  	insert into otcn_log (kodf,userid,txt)
--  	select kodf_,userid_,''||r.nls||'  ('||r.kv||') '
--  	from rnbu_trace r
--  	where r.userid = userid_
--  	  and r.kodp   = k.kodp;

    end if;
 end;

end loop;

end p_ch_file14;
/
show err;

PROMPT *** Create  grants  P_CH_FILE14 ***
grant EXECUTE                                                                on P_CH_FILE14     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE14.sql =========*** End *
PROMPT ===================================================================================== 
