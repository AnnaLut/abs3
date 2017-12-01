

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F3B_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F3B_NN ***

  CREATE OR REPLACE PROCEDURE BARS.p_f3b_NN (Dat_ DATE, sheme_ varchar2 default 'G', pr_op_ Number default 1) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #3B для
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     : 23.11.2017 (21.08.2017,16.08.2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_    - отчетная дата
               sheme_  - код схемы

   Структура показателя     LL P M K DDDDD ZZZZZZZZZZ

  1    LL           значения по списку         (01,02,..,10)
  3    P            тип предприятия            (1/2/3)
  4    M            код отчетного периода      (1/2)
  5    K            тип статьи фин.отчетности  (0/1/2)
  6    DDDDD        код статьи фин.отчетности
 11    ZZZZZZZZZZ   ОКПО предприятия

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
23.11.2017 Сегмент LL=10 -oбработка данных формы 3 для клиентов
21.08.2017 Изменено формирование показателя 05 (признак АТО)
           (0 - находится в АТО, 1 - нет) 
16.08.2017 Изменение знака по показателю 02300 (ОБ)
25.07.2017 на 01.01.2017 новая структура показателя и новые показатели
07.10.2014 Доработки по BRSMAIN-2937
23.10.2014 Изменение знака по показателю 02300 (ОБ)
07.08.2015 Доработки по COBUSUPABS-3548
14.07.2016 Доработки по COBUSUPABS-4577
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    kodf_    varchar2(2) := '3B';
    userid_  number;
    mfo_     number;
    mfou_    number;
    dtb_     date;
    dte_     date;
    znap_    number;
    p04_     varchar2(1);
    fmt_     varchar2 (10)  := '9990D00';
BEGIN
    userid_ := user_id;
    mfo_:=F_OURMFO();

    begin
       select nvl(trim(mfou), mfo_) 
          into mfou_ 
       from banks where mfo = mfo_;
    exception
       when no_data_found
       then
          mfou_ := mfo_;
    end;

    -------------------------------------------------------------------
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
    DELETE FROM OTCN_LOG
             WHERE userid = userid_ AND kodf = kodf_;
    -------------------------------------------------------------------

    select trunc(dat_,'yyyy'), add_months(trunc(dat_,'yyyy'),12) 
       into dtb_, dte_ 
    from dual;

    INSERT INTO OTCN_LOG (kodf, userid, txt) VALUES(kodf_,userid_,to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' Протокол формирования файла #3B за '||to_char(dat_,'dd.mm.yyyy'));
    INSERT INTO OTCN_LOG (kodf, userid, txt) VALUES(kodf_,userid_,'Дата начала отчетного периода - '||to_char(dtb_,'dd.mm.yyyy'));
    INSERT INTO OTCN_LOG (kodf, userid, txt) VALUES(kodf_,userid_,'Дата окончания отчетного периода - '||to_char(dte_,'dd.mm.yyyy'));
    INSERT INTO OTCN_LOG (kodf, userid, txt) VALUES(kodf_,userid_,'--------------------------------------------------');
    --------------------------------------------------------
    for t in (select edrpou okpo 
              from okpof659 
              where edrpou in (select lpad(okpo,10,'0') 
                               from customer c 
                               where okpo in (select edrpou 
                                              from okpof659 
                                              where exists (select 1 
                                                            from fin_rnk 
                                                            where okpo = edrpou 
                                                              and idf in (1, 2, 3) 
                                                              and fdat in (dtb_, dte_)
                                                              and branch like '/'||mfo_||'/' 
                                                            )
                                             )
                                 and (date_off is null or date_off > dte_) 
                               group by lpad(c.okpo,10,'0') 
                               having count(*) > 1
                              )
                and zvitdate = to_date('01012017','ddmmyyyy')
             )
    loop
       INSERT INTO OTCN_LOG (kodf, userid, txt) VALUES(kodf_,userid_,'ОКПО '||to_char(t.okpo)||' имеет более одного RNK');
    end loop;

    for t in (select edrpou 
              from okpof659 
              where not exists (select 1 
                                from nbu23_rez 
                                where fdat = dte_ and okpo = edrpou) 
                                  and exists (select 1 
                                              from customer 
                                              where is_number(okpo) = 1 
                                                and okpo = edrpou 
                                                and (date_off is null or date_off > dte_)
                                             ) 
                                  and exists (select 1 
                                              from fin_rnk 
                                              where okpo = edrpou 
                                                and idf in (1, 2, 3) 
                                                and fdat in (dtb_, dte_)
                                                and branch like '/'||mfo_||'/' 
                                             )
                and zvitdate = to_date('01012017','ddmmyyyy')
             )

       loop
          INSERT INTO OTCN_LOG (kodf, userid, txt) VALUES(kodf_,userid_,'ОКПО '||to_char(t.edrpou)||' отсутствует в NBU23_REZ за '||to_char(dte_,'dd.mm.yyyy'));
       end loop;

      for t in (select * from
              (select okpo, sum(fmb) fmb,sum(fme) fme 
               from (select okpo,
                            decode(fdat,dte_,null,decode(nvl(fm,'0'),'M',2,'R',2,1)) fmb,
                            decode(fdat,dte_,decode(nvl(fm,'0'),'M',2,'R',2,1),null) fme 
                     from fin_fm 
                     where fdat in (dtb_, dte_) 
                       and okpo in (select edrpou 
                                    from okpof659 
                                    where exists (select 1 
                                                  from customer 
                                                  where is_number(okpo) = 1 
                                                    and okpo = edrpou 
                                                    and (date_off is null or date_off>dte_)
                                                 ) 
                                      and exists (select 1 
                                                  from fin_rnk 
                                                  where okpo = edrpou 
                                                    and idf in (1, 2, 3) 
                                                    and fdat in (dtb_, dte_)
                                                    and branch like '/'||mfo_||'/' 
                                                 )
                                      and zvitdate = to_date('01012017','ddmmyyyy')
                                   )
                    )
               group by okpo
              )
              where fmb<>fme
             )
       loop

          INSERT INTO OTCN_LOG (kodf, userid, txt) VALUES(kodf_,userid_,'ОКПО '||to_char(t.okpo)||' исключается из отчета т.к. изменилась форма, на начало периода "'||decode(t.fmb,1,'большие и средние','малые')||' предприятия", на конец периода "'||decode(t.fme,1,'большие и средние','малые')||' предприятия".');

       end loop;

    --------------------------------------------------------
    -- блок для формування показників LL = '01','02','03','04','05','06','07','08','09'
    for k in (select distinct nnnnn, okpo, nmk, p, pp, ll, koef_k, s190, pato, 
                              psk, plink, pinvest 
              from (
               select * 
               from ((select a.nnnnn, a.okpo, a.nmk, 
                             to_char(decode(nvl(d.fm,'R'),'N',1,'R',2,2)) p, 
                             to_char(decode(nvl(f.fm,'R'),'N',1,'R',2,2)) pp,
                             '00000' ddddd, d.m, 
                             trim(to_char(nvl(b.k160,0),'00')) II, 
                             trim(to_char(nvl(b.koef_k,0))) KOEF_K, 
                             nvl(c.k111,'00') LL, 
                             trim(to_char(nvl(b.s190,0))) s190, 
                             a.pmax, a.pato, a.psk, a.plink, pinvest,  
                             round((fin_nbu.zn_rep(e.kod,e.idf, decode(d.m,2,dtb_,1,dte_),a.okpo)),1) znap 
                      from (select nnnnn, edrpou okpo, txt nmk, 
                                   decode(coalesce(par_max,0),1,0,1) pmax, 
                                   --decode(coalesce(par_ato,0),1,0,1) pato, 
                                   NVL(par_ato, 1) pato, 
                                   nvl(par_sk, '0') psk,
                                   nvl(par_link, '0') plink,
                                   nvl(par_invest, '0') pinvest
                            from okpof659
                            where exists (select 1 
                                          from customer 
                                          where is_number(okpo) = 1 
                                            and okpo = edrpou 
                                            and (date_off is null or date_off > dte_)
                                         )
                              and exists (select 1 
                                          from fin_rnk 
                                          where okpo = edrpou 
                                            and fdat in (dtb_, dte_)
                                            and branch like '/'||mfo_||'/' 
                                          )
                              and zvitdate = to_date('01012017','ddmmyyyy')
                              and (mfo_ = 300465 or k is null)
                            order by nnnnn
                           ) a
                           left join (select okpo, '00' k160, max(nvl(k,0)) k, 
                                             max(nvl(k,0)) koef_k, 
                                             max(nvl(obs,0)) s190 
                                      from (select okpo, k, kat, obs 
                                            from bars.nbu23_rez 
                                            where fdat = dte_
                                              and ddd like '12%'
                                            --  union all
                                            --select edrpou okpo, k, kat, obs 
                                            --from bars.okpof659
                                            --where zvitdate = to_date('01012017','ddmmyyyy')   
                                           )
                                      group by okpo
                                     ) b
                              on a.okpo = b.okpo
                           left join (select okpo, k111 
                                      from customer c, kl_k110 kl 
                                      where (kl.d_open <= dte_ 
                                        and (kl.d_close is null or kl.d_close >= dte_)) 
                                        and c.rnk in (select max(rnk) 
                                                      from customer 
                                                      where (date_off is null or date_off > dte_)
                                                      group by lpad(okpo,10,'0')
                                                     ) 
                                        and c.ved = kl.k110
                                     ) c
                              on a.okpo = c.okpo
                           left join (select f1.okpo, 
                                             nvl(f1.fm,'R') fm, 
                                             decode(f1.fdat,dte_,1,2) m 
                                      from bars.fin_fm f1
                                      where f1.fdat = dte_
                                     ) d
                              on a.okpo = d.okpo
                           left join (select f2.okpo, 
                                             nvl(f2.fm,'R') fm 
                                      from bars.fin_fm f2
                                      where f2.fdat = dtb_
                                     ) f
                              on a.okpo = f.okpo 
                           left join (select p, ddddd, kod, idf 
                                      from kl_f659
                                     ) e
                              on e.p = decode(nvl(d.fm,'R'),'N',1,'R',2,2)
                     )
                   )
              order by P, nnnnn, substr(DDDDD,2), M)
             order by 3, 1
             )
       loop
          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '01'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.nmk, 'OKPO='||k.OKPO);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '02'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.ll, 'OKPO='||k.OKPO);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '03'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.s190, 'OKPO='||k.OKPO);

          p04_ := '0';
          if k.p <> k.pp
          then
             p04_ := '1';
          end if;

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '04'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), p04_, 'OKPO='||k.OKPO);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '05'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.pato, 'OKPO='||k.OKPO);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '06'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.psk, 'OKPO='||k.OKPO);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '07'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.plink, 'OKPO='||k.OKPO);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '08'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.pinvest, 'OKPO='||k.OKPO);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '09'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), 
                         LTRIM (to_char (ROUND (k.koef_k, 2), fmt_)), 'OKPO='||k.OKPO);

       end loop;
    --------------------------------------------------------
    -- блок для формування показників LL = '10'
    for t in (select * 
              from ( (select a.nnnnn, a.okpo, a.nmk, e.p, e.ddddd, 
                             d.m, trim(to_char(nvl(b.k160,0),'00')) II, 
                             trim(to_char(nvl(b.s080,0))) T, 
                             nvl(c.k111,'00') LL, 
                             trim(to_char(nvl(b.s190,0))) s190, 
                             a.pmax, a.pato, 
                             round((fin_nbu.zn_rep(e.kod,e.idf, decode(d.m,2,dtb_,1,dte_),a.okpo)),1) znap 
                      from (select nnnnn, edrpou okpo, txt nmk, 
                                   decode(coalesce(par_max,0),1,0,1) pmax, 
                                   --decode(coalesce(par_ato,0),1,0,1) pato 
                                   NVL(par_ato, 1) pato 
                            from okpof659
                            where exists (select 1 
                                          from customer 
                                          where is_number(okpo) = 1 
                                            and okpo=edrpou 
                                            and (date_off is null or date_off > dte_)
                                         )
                              and exists (select 1 
                                          from fin_rnk 
                                          where okpo = edrpou 
                                            and fdat in (dtb_, dte_)
                                            and branch like '/'||mfo_||'/' 
                                          )
                              and zvitdate = to_date('01012017','ddmmyyyy')  
                              and (mfo_ = 300465 or k is null)
                            order by nnnnn
                           ) a
                           left join (select okpo, '00' k160, max(nvl(k,0)) k, 
                                             max(nvl(kat,0)) s080, 
                                             max(nvl(obs,0)) s190 
                                      from (select okpo, k, kat, obs 
                                            from bars.nbu23_rez 
                                            where fdat = dte_
                                              and ddd like '12%'
                                            --  union all
                                            --select edrpou okpo, k, kat, obs 
                                            --from bars.okpof659
                                            --where zvitdate = to_date('01012017','ddmmyyyy')
                                           )
                                      group by okpo
                                     ) b
                              on a.okpo = b.okpo
                           left join (select okpo, k111 
                                      from customer c, kl_k110 kl 
                                      where (kl.d_open <= dte_ 
                                        and (kl.d_close is null or kl.d_close >= dte_)) 
                                        and c.rnk in (select max(rnk) 
                                                      from customer 
                                                      where (date_off is null or date_off > dte_)
                                                      group by lpad(okpo,10,'0')
                                                     ) 
                                        and c.ved = kl.k110
                                     ) c           
                              on a.okpo = c.okpo
                           left join (select f1.okpo, 
                                             min(decode(nvl(f2.fm,'0'),'M',2,'R',2,1)) fm, 
                                             decode(f1.fdat,dte_,1,2) m
                                      from bars.fin_fm f1
                                      inner join bars.fin_fm f2 
                                         on f1.okpo = f2.okpo and f2.fdat = dte_
                                      where f1.fdat in (dtb_, dte_)
                                      group by f1.okpo,f1.fdat
                                     ) d
                              on a.okpo = d.okpo
                           left join (select p, ddddd, kod, idf 
                                      from kl_f659
                                     ) e
                              on e.p = nvl(d.fm,'1')
                     )
                   )
              order by P, nnnnn, substr(DDDDD,2), M)

       loop
        
          if (t.ddddd in ('02050', '02070', '02130', '02150', '02180', '02250', 
                          '02255', '02270', '21425', '21430', '23360', '04020', 
                          '04080', '04090', '04100', '04140', '02095', --'02300',
                          '02195','02295','02355') or 
                         (t.ddddd in('02285') and t.P='2')) and sign(t.znap)=1 then
             znap_ := -t.znap;
          else
             znap_ := t.znap;
          end if;

          if t.ddddd  = '02300' 
          then
             znap_ := - t.znap;
          end if;

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                     '10'||t.P||t.M||'0'||t.DDDDD||LPAD(t.okpo,10,'0'), TO_CHAR(znap_), 'OKPO='||t.OKPO);

       end loop;

    --------------------------------------------------------
    -- блок для формування показників LL = '10' по формi 3
    for t in (select * 
                from ( select a.nnnnn, a.okpo, a.nmk, d.fm P,
                              a.pmax, a.pato,
                              decode(r.fdat, dte_, '1','2') M,
                              r.fdat, r.idf, r.ddddd, r.colum3, r.colum4
                        from (select nnnnn, edrpou okpo, txt nmk, 
                                     decode(coalesce(par_max,0),1,0,1) pmax, 
                                     NVL(par_ato, 1) pato 
                                from okpof659
                               where exists (select 1 
                                          from customer 
                                          where is_number(okpo) = 1 
                                            and okpo=edrpou 
                                            and branch like '/'||mfo_||'/%'  
                                            and (date_off is null or date_off > dte_)
                                         )
                                 and exists (select 1 
                                               from fin_forma3_dm 
                                              where okpo = edrpou 
                                                and fdat in (dtb_, dte_)
                                             )
                                 and zvitdate = to_date('01012017','ddmmyyyy')  
                                 and (mfo_ = 300465 or k is null)
                               order by nnnnn
                             ) a
                           left join (select okpo,
                                             decode(nvl(fm,'0'),'M',2,'R',2,1) fm
                                        from bars.fin_fm
                                       where fdat = dte_
                                     ) d
                              on a.okpo = d.okpo
                           left join ( select d.fdat, d.okpo, d.colum3, d.colum4, u.idf,
                                              to_char(u.idf)||trim(to_char(u.kod,'0000')) ddddd
                                         from fin_forma3_dm d, fin_forma3_ref u
                                        where d.id = u.id
                                          and d.fdat in ( dtb_, dte_ )
                                          and trim(u.kod) is not null
                                     ) r
                              on a.okpo = r.okpo
                     )
                 order by P, nnnnn, substr(DDDDD,2), M 
       ) loop
        
          if t.idf =3  then

             INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                        '10'||t.P||t.M||'0'||t.DDDDD||LPAD(t.okpo,10,'0'), TO_CHAR(t.COLUM3), 'OKPO='||t.OKPO);

          end if;

          if t.idf =4 and t.COLUM4 >0 then

             INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                        '10'||t.P||t.M||'1'||t.DDDDD||LPAD(t.okpo,10,'0'), TO_CHAR(t.COLUM4), 'OKPO='||t.OKPO);

          end if;

          if t.idf =4 and t.COLUM3 >0 then

             INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, 
                        '10'||t.P||t.M||'2'||t.DDDDD||LPAD(t.okpo,10,'0'), TO_CHAR(t.COLUM3), 'OKPO='||t.OKPO);
          end if;

       end loop;

--    if mfo_ = 300465 then
       delete from rnbu_trace where znap='0' and kodp like '10%';

       delete from rnbu_trace r
       where not exists (select 1 
                         from rnbu_trace r1
                         where substr(r1.kodp, 11, 10) = substr(r.kodp, 11, 10)
                           and r1.kodp like '10_1______' || substr(r.kodp, 11, 10) || '%'
                       );  
--    end if;
    
    ---------------------------------------------------
    delete from tmp_nbu where kodf=kodf_ and datf= dat_;
    ---------------------------------------------------
    --- формирование файла в табл. TMP_NBU
    insert into tmp_nbu(kodf, datf, kodp, znap)
    select kodf_, dat_, kodp, znap
    from rnbu_trace
    where substr(kodp,1,2) in ('01','02','03','04','05','06','07','08','09');

    insert into tmp_nbu(kodf, datf, kodp, znap)
    select kodf_, dat_, kodp, sum(znap) znap
    from rnbu_trace
    where substr(kodp,1,2) = '10'
    group by kodp;
------------------------------------------------------------------
END p_f3b_NN;
/
show err;

PROMPT *** Create  grants  P_F3B_NN ***
grant EXECUTE                                                                on P_F3B_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F3B_NN        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F3B_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
