CREATE OR REPLACE PROCEDURE p_f3V_NN (Dat_ DATE, sheme_ varchar2 default 'G', pr_op_ Number default 1) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  Процедура формирования #3V для
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 05.02.2019 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
21.02.2018 новый файл отчетности
31.01.2019 Заявка COBUMMFO-10759
           значення S190 згідно довідника kl_s190 (було дні)
           точність показника 09 до 3 знаків (було 2)
           змінено формування показника 06 (дані беруться з кредитного ризику)
           змінено формування показника 11. Розраховується по NBU23_REZ.TIPA (було по NBU23_REZ.DDD)
01.02.2019 Заявка COBUMMFO-10759
           до формування показника 09 додали умову: and r.TIPA not in (15,17,30) (виключили некредити)
04.02.2019 Заявка COBUMMFO-10759
           показник P вираховується зі заначення за найбільшу дату в періоді звітності (таблиця fin_fm)
           (раніше вираховувалось   зі заначення за  останню дати періоду)
05.02.2019 Заявка COBUMMFO-10759
	   додано дату dtbp_ (беремо до уваги звітність клієнта за дату, що на 1 рік ментша за початкову)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    kodf_    varchar2(2) := '3V';
    userid_  number;
    mfo_     number;
    mfou_    number;
    ost_     number;
    ost_96_  number;
    dtb_     date;
    dtbp_    date; -- дата на 1 рік менша за dtb_
    dte_     date;
    znap_    number;
    p04_     varchar2(1);
    fmt_     varchar2 (10)  := '9990D000';
    gr_yo    varchar2(1);

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

    select trunc(dat_,'yyyy'), add_months(trunc(dat_,'yyyy'),12), add_months(trunc(dat_,'yyyy'),-12)
       into dtb_, dte_, dtbp_
    from dual;

    INSERT INTO OTCN_LOG (kodf, userid, txt) VALUES(kodf_,userid_,to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')||' Протокол формирования файла #3V за '||to_char(dat_,'dd.mm.yyyy'));
    --INSERT INTO OTCN_LOG (kodf, userid, txt) VALUES(kodf_,userid_,'Дата начала отчетного периода - '||to_char(dtb_,'dd.mm.yyyy'));
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
                                                              and fdat = dte_  --in (dtb_, dte_)
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
                                                and fdat in (dtb_, dte_, dtbp_)
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
                                                    and fdat in (dtb_, dte_, dtbp_)
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
    for k in (select distinct nnnnn, rnk, okpo, nmk, p, pp, ll, koef_k, s190, pato,
                              psk, plink, pinvest
              from (
               select *
               from ((select a.nnnnn, c.rnk, a.okpo, a.nmk,
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
                              and ( exists (select 1
                                              from fin_rnk
                                             where okpo = edrpou
                                               and fdat in (dtb_, dte_, dtbp_)
                                               and branch like '/'||mfo_||'/'
                                            )
                                    or
			            exists (select 1
                                              from fin_forma3_dm
                                             where okpo = edrpou
                                               and fdat in (dtb_, dte_, dtbp_)
                                            )
                                   )
                              and zvitdate = to_date('01012017','ddmmyyyy')
                              and (mfo_ = 300465 or k is null)
                            order by nnnnn
                           ) a
                           left join (select okpo, '00' k160, max(nvl(k,0)) k,
                                             max(nvl(pd,0)) koef_k,
                                             max(f_nbur_get_s190(dte_,kol_351)) s190
                                      from (select n.okpo, n.k, n.kat, n.kol_351, r.pd
                                            from bars.nbu23_rez n, rez_cr r
                                            where n.fdat = dte_
                                              and n.TIPA in (3,10,4,23) --ddd like '12%'
                                              and r.TIPA not in (15,17,30)
                                              and r.fdat = n.fdat
                                              and r.rnk = n.rnk
                                            --  union all
                                            --select edrpou okpo, k, kat, obs
                                            --from bars.okpof659
                                            --where zvitdate = to_date('01012017','ddmmyyyy')
                                           )
                                      group by okpo
                                     ) b
                              on a.okpo = b.okpo
                           left join (select rnk, okpo, k111
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
                           left join (select distinct f1.okpo,
                                             --nvl(f1.fm,'R') fm,
                                             nvl(FIRST_VALUE (f1.fm) over (partition by f1.okpo order by f1.fdat desc),'R') fm,
                                             decode(f1.fdat,dte_,1,2) m
                                      from bars.fin_fm f1
                                      where f1.fdat <= dte_ -- f1.fdat = dte_
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
          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk )
             -- KODP = LL+P+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '01'||k.P||LPAD(k.okpo, 10,'0'), k.nmk, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '02'||k.P||LPAD(k.okpo, 10,'0'), k.ll, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '03'||k.P||LPAD(k.okpo, 10,'0'), k.s190, 'OKPO='||k.OKPO, k.rnk);

          p04_ := '0';
          if k.p <> k.pp
          then
             p04_ := '1';
          end if;

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+PZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '04'||k.P||LPAD(k.okpo, 10,'0'), p04_, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '05'||k.P||LPAD(k.okpo, 10,'0'), k.pato, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '06'||k.P||LPAD(k.okpo, 10,'0'), k.psk, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '07'||k.P||LPAD(k.okpo, 10,'0'), k.plink, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '08'||k.P||LPAD(k.okpo, 10,'0'), k.pinvest, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '09'||k.P||LPAD(k.okpo, 10,'0'),
                         LTRIM (to_char (ROUND (k.koef_k, 3), fmt_)), 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '11'||k.P||LPAD(k.okpo, 10,'0'),
                         '0', 'OKPO='||k.OKPO, k.rnk);

       end loop;
    --------------------------------------------------------
    -- блок для зміни значення показника 11PZZZZZZZZZZ
    for k in ( select *
               from rnbu_trace
               where kodp like '11%'
             )
       loop

          select NVL(sum(bvq*100), 0)
             into ost_
          from nbu23_rez
          where fdat = dte_
            and TIPA in (3,10,4,23) --ddd like '12%'
            and rnk = k.rnk;

          if ost_ = 0
          then
             select NVL(sum(ost), 0)
                into ost_96_
             from sal
             where fdat = dat_
               and nls like '96%'
               and rnk = k.rnk;
          end if;

          if ost_ = 0 and ost_96_ = 0
          then
             update rnbu_trace  set znap = '1'
             where kodp like '11%' and rnk = k.rnk;
          end if;

          if ost_ = 0 and ost_96_ <> 0
          then
             update rnbu_trace  set znap = '3'
             where kodp like '11%' and rnk = k.rnk;
          end if;

    end loop;

    --------------------------------------------------------
    -- блок для зміни значення показника 06PZZZZZZZZZZ -- Заявка COBUMMFO-10759
      for k in ( select *
               from rnbu_trace
               where kodp like '06%'
             )
       loop
           select DECODE(max(distinct kol24), '100', 1, '0')  into gr_yo
             from REZ_CR rc
            where rc.fdat = dte_
              and rc.rnk = k.rnk
              and rc.TIPA not in (15,17,30);

             update rnbu_trace  set znap = gr_yo
             where kodp like '06%' and rnk = k.rnk;
       end loop;


    -- LL=02, 03, 04, 05, 06, 07, 08, 09
    -- формируем только если LL=11 - принимает значение "0".
    for k in ( select *
               from rnbu_trace
               where kodp like '11%'
                 and znap <> '0'
             )

       loop

          delete from rnbu_trace r
          where substr(r.kodp,3,11) = substr(k.kodp,3,11)
            and substr(r.kodp,1,2) in ('02','03','04','05','06','07','08','09');

    end loop;
    ---------------------------------------------------
    delete from tmp_nbu where kodf=kodf_ and datf= dat_;
    ---------------------------------------------------
    --- формирование файла в табл. TMP_NBU
    insert into tmp_nbu(kodf, datf, kodp, znap)
    select kodf_, dat_, kodp, znap
    from rnbu_trace
    where substr(kodp,1,2) in ('01','02','03','04','05','06','07','08','09','11');
------------------------------------------------------------------
END p_f3V_NN;
/
