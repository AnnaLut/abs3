CREATE OR REPLACE PROCEDURE BARS.p_f3b_NN (Dat_ DATE, sheme_ varchar2 default 'G', pr_op_ Number default 1) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #3B для
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     : 28.05.2019 (27.05.2019, 24.05.2019)
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
28.05.2019 змінено формування показників
           10PMK02280ZZZZZZZZZZ, 10PMK02285ZZZZZZZZZZ, 10PMK02290ZZZZZZZZZZ,
           10PMK02295ZZZZZZZZZZ 
27.05.2019 добавлено розрахунок кодів DDDDD in (2090, 2095, 2190, 2195)
24.05.2019 змінено формування значення показника для LL='08'
22.05.2019 для відбору клієнтів із таблиці OKPOF659  змінено умову для 
           звітної дати з 01.01.2017  на  01.01.2019
04.02.2019 Заявка COBUMMFO-10759
	   змінено формування показника 06 (дані беруться з кредитного ризику)
           точність показника 09 до 3 знаків (було 2)
           до формування показника 09 додали умову: and r.TIPA not in (15,17,30) (виключили некредити)
           змінено формування показника 11. Розраховується по NBU23_REZ.TIPA (було по NBU23_REZ.DDD)
24.05.2018 добавлено удаление показателя 10PMKDDDDDZZZZZZZZZZ с нулевым
           значением
23.05.2018 не включаем контрагентов у которых сумма кредитов равна нулю
           (BVQ из NBU23_REZ)
17.05.2018 добавлено формирование показателя 11LLPMKDDDDDZZZZZZZZZZ
           изменено формирование показателей 04 и 06
           (будут формироваться как в файле #3V)
06.12.2017 Ограниченние набора показателей DDDDD для формы 3
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
    ost_     number;
    ost_96_  number;
    s190_    varchar2(1);
    dtb_     date;
    dte_     date;
    znap_    number;
    p06_     varchar2(1);
    p04_     varchar2(1);
    fmt_     varchar2 (10)  := '9990D000';
    gr_yo    varchar2(1);
    p08_     varchar2(1);
    s2090_   number;
    sr2090_  number;
    s2190_   number;
    sr2190_  number; 

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
                and zvitdate = to_date('01012019','ddmmyyyy')
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
                and zvitdate = to_date('01012019','ddmmyyyy')
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
                                      and zvitdate = to_date('01012019','ddmmyyyy')
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
                             a.pmax, a.pato, b.psk, a.plink, pinvest,
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
                              and zvitdate = to_date('01012019','ddmmyyyy')
                              and (mfo_ = 300465 or k is null)
                            order by nnnnn
                           ) a
                           left join (select okpo, '00' k160, max(nvl(k,0)) k,
                                             max(nvl(pd,0)) koef_k,
                                             max(nvl(kol_351,1)) s190,
                                             substr(max(nvl(kol24, '000')), 1, 70) psk
                                      from (select n.okpo, n.k, n.kat, n.kol_351, r.pd, r.kol24
                                            from bars.nbu23_rez n, rez_cr r
                                            where n.fdat = dte_
                                              and n.TIPA in (3,10,4,23) --ddd like '12%'
                                              and r.TIPA not in (15,17,30)
                                              and r.fdat = n.fdat
                                              and r.acc = n.acc
                                              and r.rnk = n.rnk
                                            --  union all
                                            --select edrpou okpo, k, kat, obs
                                            --from bars.okpof659
                                            --where zvitdate = to_date('01012019','ddmmyyyy')
                                           )
                                      group by okpo
                                     ) b
                              on a.okpo = b.okpo
                           left join (select c.okpo, c.rnk, kl.k111
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
          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '01'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.nmk, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '02'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.ll, 'OKPO='||k.OKPO, k.rnk);

          if k.s190 = 0
          then
             s190_ := '0';
          elsif k.s190 > 0 and k.s190 < 8
          then
             s190_ := 'A';
          elsif k.s190 < 31
          then
             s190_ := 'B';
          elsif k.s190 < 61
          then
             s190_ := 'C';
          elsif k.s190 < 91
          then
             s190_ := 'D';
          elsif k.s190 < 181
          then
             s190_ := 'E';
          elsif k.s190 < 361
          then
             s190_ := 'F';
          else
             s190_ := 'G';
          end if;

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '03'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), s190_, 'OKPO='||k.OKPO, k.rnk);

          p04_ := '0';
          if k.p <> k.pp
          then
             p04_ := '1';
          end if;

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '04'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), p04_, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '05'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.pato, 'OKPO='||k.OKPO, k.rnk);

          p06_ := '0';
          if k.psk = '100'
          then
             p06_ := '1';
          end if;

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '06'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), p06_, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '07'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), k.plink, 'OKPO='||k.OKPO, k.rnk);

          p08_ := k.pinvest;

          if dat_ >= to_date('29122018','ddmmyyyy') 
          then
             BEGIN
                SELECT NVL (trim(u.value), '0')
                   into p08_
                FROM CUSTOMERW_UPDATE U
                WHERE U.RNK = k.rnk 
                  AND U.TAG like 'ISSPE%' 
                  AND U.IDUPD = (SELECT MAX (IDUPD)
                                 FROM CUSTOMERW_UPDATE
                                 WHERE RNK = U.RNK 
                                   AND EFFECTDATE <= dat_
                                   AND TAG like 'ISSPE%');
             EXCEPTION WHEN NO_DATA_FOUND THEN
                p08_ := '0';
             END;

             if p08_ <> '1' 
             then       
                p08_ := '0';
             end if; 

          end if;

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '08'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'), p08_, 'OKPO='||k.OKPO, k.rnk);

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '09'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'),
                         LTRIM (to_char (ROUND (k.koef_k, 3), fmt_)), 'OKPO='||k.OKPO, k.rnk);
          -- код 11
          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             -- KODP = LL+P+1+M+DDDDD+ZZZZZZZZZZ
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '11'||k.P||'1'||'0'||'00000'||LPAD(k.okpo, 10,'0'),
                         '0', 'OKPO='||k.OKPO, k.rnk);
       end loop;
    --------------------------------------------------------
    -- блок для формування показників LL = '10'
    for t in (select *
              from ( (select a.nnnnn, a.okpo, c.rnk, a.nmk, e.p, e.ddddd,
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
                              and zvitdate = to_date('01012019','ddmmyyyy')
                              and (mfo_ = 300465 or k is null)
                            order by nnnnn
                           ) a
                           left join (select okpo, '00' k160, max(nvl(k,0)) k,
                                             max(nvl(kat,0)) s080,
                                             max(nvl(obs,0)) s190
                                      from (select n.okpo, n.k, n.kat, n.obs
                                            from bars.nbu23_rez n, bars.rez_cr r
                                            where n.fdat = dte_
					      and n.TIPA in (3,10,4,23) --ddd like '12%'
                                              and r.TIPA not in (15,17,30)
                                              and r.fdat = n.fdat
                                              and r.acc = n.acc
                                              and r.rnk = n.rnk
                                            --  union all
                                            --select edrpou okpo, k, kat, obs
                                            --from bars.okpof659
                                            --where zvitdate = to_date('01012019','ddmmyyyy')
                                           )
                                      group by okpo
                                     ) b
                              on a.okpo = b.okpo
                           left join (select c.okpo, c.rnk, kl.k111
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

          INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm, rnk)
             VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                     '10'||t.P||t.M||'0'||t.DDDDD||LPAD(t.okpo,10,'0'), TO_CHAR(znap_), 'OKPO='||t.OKPO, t.rnk);

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
                                 and zvitdate = to_date('01012019','ddmmyyyy')
                                 and (mfo_ = 300465 or k is null)
                               order by nnnnn
                             ) a
                           left join (select okpo, '00' k160, max(nvl(k,0)) k,
                                             max(nvl(kat,0)) s080,
                                             max(nvl(obs,0)) s190
                                      from (select n.okpo, n.k, n.kat, n.obs
                                            from bars.nbu23_rez n, bars.rez_cr r
                                            where n.fdat = dte_
			                      and n.TIPA in (3,10,4,23) --ddd like '12%'
                                              and r.TIPA not in (15,17,30)
                                              and r.fdat = n.fdat
                                              and r.acc = n.acc
                                              and r.rnk = n.rnk
                                            --  union all
                                            --select edrpou okpo, k, kat, obs
                                            --from bars.okpof659
                                            --where zvitdate = to_date('01012019','ddmmyyyy')
                                           )
                                      group by okpo
                                     ) b
                              on a.okpo = b.okpo
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

          if t.ddddd in ( '33000','33005','33006','33010','33095','33100','33105',
                          '33110','33115','33190','33195','33200','33205','33215',
                          '33220','33225','33250','33255','33260','33270','33290',
                          '33295','33300','33305','33340','33345','33350','33355',
                          '33360','33390','33395','33400','33405','33410','33415',
                          '43500','43505','43510','43515','43520','43550','43560',
                          '43570','43580','43195','43200','43205','43215','43220',
                          '43225','43250','43255','43260','43270','43290','43295',
                          '43300','43305','43340','43345','43350','43355','43360',
                          '43390','43395','43400','43405','43410','43415' )
          then

             if t.idf =3  then

                znap_ := t.COLUM3;            --смена знака для списка показателей
                if     sign(znap_) =1
                   and t.ddddd in ( '33100','33105','33110','33115','33190','33255',
                                    '33260','33270','33290','33345','33355','33390')
                then

                   znap_ := (-1)* znap_;
                end if;

                INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                   VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                           '10'||t.P||t.M||'0'||t.DDDDD||LPAD(t.okpo,10,'0'), TO_CHAR(znap_), 'OKPO='||t.OKPO);

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

          end if;

       end loop;

       -- 27.05.2019
       -- удаление кодов 02350, 02355 
       -- (удалаяем если для данного кода нулевое значение и есть другой код с ненулевим значением)
       delete from rnbu_trace 
       where znap = '0'  
         and kodp like '10%'  
         and substr(kodp,6,5) not in ('02350','11300','21900');

       delete from rnbu_trace r1 
       where r1.znap='0'  
         and r1.kodp like '10%'  
         and substr(r1.kodp,6,5) in ('02350')
         and exists ( select 1 from rnbu_trace
                      where kodp like '10%'
                        and substr(kodp,6,5) in ('02355')
                        and substr(kodp,3,3) = substr(r1.kodp,3,3) 
                        and substr(kodp,11,10) = substr(r1.kodp,11,10)
                        and znap >= '0'
                    ); 

       delete from rnbu_trace r1 
       where r1.znap = '0'  
         and r1.kodp like '10%'  
         and substr(r1.kodp,6,5) in ('02355')
         and exists ( select 1 from rnbu_trace
                      where kodp like '10%' 
                        and substr(kodp,6,5) in ('02350')
                        and substr(kodp,3,3) = substr(r1.kodp,3,3) 
                        and substr(kodp,11,10) = substr(r1.kodp,11,10)
                        and znap <> '0'
                    ); 

       -- LL=01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11
       -- формируем только если остатки по кредитам ненулевые
       for k in ( select *
                  from rnbu_trace
                  where kodp like '11%'
                )
          loop

             select NVL(sum(bvq*100), 0)
                into ost_
             from nbu23_rez
             where fdat = dte_
               and nls like '2%'
               and rnk = k.rnk
               and ddd like '12%';

             if ost_ = 0
             then
                delete from rnbu_trace r
                where substr(r.kodp,11,10) = substr(k.kodp,11,10)
                  and substr(r.kodp,1,2) in ('01','02','03','04','05','06','07','08','09','10','11');
             end if;

       end loop;

       for k in ( select *
                  from rnbu_trace r
                  where kodp like '10%'
                    and not exists ( select 1 
                                     from rnbu_trace r1
                                     where r1.kodp like '11%' 
                                       and substr(r1.kodp,3,18) = substr(r.kodp,3,18)
                                   ) 
             
                )
          loop

             select NVL(sum(bvq*100), 0)
                into ost_
             from nbu23_rez
             where fdat = dte_
               and nls like '2%'
               and rnk = k.rnk
               and ddd like '12%';

             if ost_ = 0
             then
                delete from rnbu_trace r
                where substr(r.kodp,11,10) = substr(k.kodp,11,10)
                  and substr(r.kodp,1,2) in ('01','02','03','04','05','06','07','08','09','10','11');
             end if;

       end loop;

       delete from rnbu_trace r
       where not exists (select 1
                         from rnbu_trace r1
                         where substr(r1.kodp, 11, 10) = substr(r.kodp, 11, 10)
                           and r1.kodp like '10_1______' || substr(r.kodp, 11, 10) || '%'
                       );

    --------------------------------------------------------
       -- 22.05.2019 
       -- блок для зміни значення показника 10PMKDDDDDZZZZZZZZZZ 
       update rnbu_trace set znap = to_char(round (to_number(znap), 0) ) 
       where kodp like '101%' OR kodp like '103%'; 

       -- 27.05.2019 
       -- розрахунки показників 2090, 2095, 2190, 2195
       -- коди 2090, 2095
       for t in ( select distinct substr(kodp,3,1) P, substr(kodp,4,1) M, '0' K, substr(kodp,11,10) OKPO
                  from rnbu_trace 
                  where (kodp like '101%' OR kodp like '103%')
                    and substr(kodp, 6,5) not in ('02090', '02095')  
                )
        loop

          select NVL( sum(znap), 0) 
             into s2090_
          from rnbu_trace 
          where (kodp like '101%' OR kodp like '103%')
            and substr(kodp, 6,5) in ('02090', '02095')
            and substr(kodp,3,1) = t.P
            and substr(kodp,4,1) = t.M 
            and substr(kodp,5,1) in ('0','1','2')  
            and substr(kodp,11,10) = t.OKPO;  

          if s2090_ = 0 then
             select NVL( sum(znap), 0) 
                into sr2090_
             from rnbu_trace 
             where (kodp like '101%' OR kodp like '103%')
               and substr(kodp, 6,5) in ('02000', '02010', '02050', '02070')
               and substr(kodp,3,1) = t.P
               and substr(kodp,4,1) = t.M 
               and substr(kodp,5,1) in ('0','1','2')
               and substr(kodp,11,10) = t.OKPO;  

             if sr2090_ >= 0 then
                INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                   VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                           '10'||t.P||t.M||t.K||'02090'||LPAD(t.okpo,10,'0'), TO_CHAR(sr2090_), 'OKPO='||t.OKPO);
             else
                INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                   VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                           '10'||t.P||t.M||t.K||'02095'||LPAD(t.okpo,10,'0'), TO_CHAR(sr2090_), 'OKPO='||t.OKPO);
             end if;
          end if;

       end loop;

       -- коди 2190, 2195
       for t in ( select distinct substr(kodp,3,1) P, substr(kodp,4,1) M, '0' K, substr(kodp,11,10) OKPO
                  from rnbu_trace 
                  where (kodp like '101%' OR kodp like '103%')
                    and substr(kodp, 6,5) not in ('02190', '02195')  
                )
        loop

          select NVL( sum(znap), 0) 
             into s2190_
          from rnbu_trace 
          where (kodp like '101%' OR kodp like '103%')
            and substr(kodp, 6,5) in ('02190', '02195')
            and substr(kodp,3,1) = t.P
            and substr(kodp,4,1) = t.M 
            and substr(kodp,5,1) in ('0','1','2')
            and substr(kodp,11,10) = t.OKPO;  
  
          if s2190_ = 0 then
             select NVL( sum(znap), 0) 
                into sr2190_
             from rnbu_trace 
             where (kodp like '101%' OR kodp like '103%')
               and substr(kodp, 6,5) in ('02000', '02010', '02050', '02070', '02105', '02110', '02120', '02130', '02150', '02180')
               and substr(kodp,3,1) = t.P
               and substr(kodp,4,1) = t.M 
               and substr(kodp,5,1) in ('0','1','2')
               and substr(kodp,11,10) = t.OKPO;  

             if sr2190_ >= 0 then
                INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                   VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                           '10'||t.P||t.M||t.K||'02190'||LPAD(t.okpo,10,'0'), TO_CHAR(sr2190_), 'OKPO='||t.OKPO);
             else
                INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                   VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                           '10'||t.P||t.M||t.K||'02195'||LPAD(t.okpo,10,'0'), TO_CHAR(sr2190_), 'OKPO='||t.OKPO);
             end if;
          end if;

       end loop;

       -- коди 2280, 2285
       for t in ( select distinct substr(r1.kodp,3,1) P, substr(r1.kodp,4,1) M, '0' K, substr(r1.kodp,11,10) OKPO
                  from rnbu_trace r1
                  where r1.kodp like '102%' 
                    and substr(r1.kodp, 6,5) not in ('02280') 
                    and not exists ( select 1 from rnbu_trace
                                     where kodp like '102%' 
                                       and substr(kodp,6,5) in ('02280')
                                       and substr(kodp,3,2) = substr(r1.kodp,3,2) 
                                       and substr(kodp,11,10) = substr(r1.kodp,11,10)
                               ) 
                )
        loop

             select NVL( sum(znap), 0) 
                into sr2090_
             from rnbu_trace 
             where kodp like '102%' 
               and substr(kodp, 6,5) in ('02000', '02120', '02240', '02160')
               and substr(kodp,3,1) = t.P
               and substr(kodp,4,1) = t.M 
               and substr(kodp,5,1) in ('0','1','2')
               and substr(kodp,11,10) = t.OKPO;  

             if ABS(sr2090_) >= 0 then
                INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                   VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                           '10'||t.P||t.M||t.K||'02280'||LPAD(t.okpo,10,'0'), TO_CHAR(sr2090_), 'OKPO='||t.OKPO);
             end if;

       end loop;

       for t in ( select distinct substr(r1.kodp,3,1) P, substr(r1.kodp,4,1) M, '0' K, substr(r1.kodp,11,10) OKPO
                  from rnbu_trace r1
                  where r1.kodp like '102%' 
                    and substr(r1.kodp, 6,5) not in ('02285') 
                    and not exists ( select 1 from rnbu_trace
                                     where kodp like '102%' 
                                       and substr(kodp,6,5) in ('02285')
                                       and substr(kodp,3,2) = substr(r1.kodp,3,2) 
                                       and substr(kodp,11,10) = substr(r1.kodp,11,10)
                               ) 
                )
        loop

             select NVL( sum(znap), 0) 
                into sr2090_
             from rnbu_trace 
             where kodp like '102%' 
               and substr(kodp, 6,5) in ('02050', '02180', '02270', '02165') 
               and substr(kodp,3,1) = t.P
               and substr(kodp,4,1) = t.M 
               and substr(kodp,5,1) in ('0','1','2')
               and substr(kodp,11,10) = t.OKPO;  

             if ABS(sr2090_) >= 0 then
                INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                   VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                           '10'||t.P||t.M||t.K||'02285'||LPAD(t.okpo,10,'0'), TO_CHAR(sr2090_), 'OKPO='||t.OKPO);
             end if;

       end loop;

       -- коди 2290, 2295
       for t in ( select distinct substr(kodp,3,1) P, substr(kodp,4,1) M, '0' K, substr(kodp,11,10) OKPO
                  from rnbu_trace 
                  where (kodp like '101%' OR kodp like '103%')
                    and substr(kodp, 6,5) not in ('02290', '02295')  
                )
        loop

          select NVL( sum(znap), 0) 
             into s2190_
          from rnbu_trace 
          where (kodp like '101%' OR kodp like '103%')
            and substr(kodp, 6,5) in ('02290', '02295')
            and substr(kodp,3,1) = t.P
            and substr(kodp,4,1) = t.M 
            and substr(kodp,5,1) in ('0','1','2')
            and substr(kodp,11,10) = t.OKPO;  
  
          if s2190_ = 0 then
             select NVL( sum(znap), 0) 
                into sr2190_
             from rnbu_trace 
             where (kodp like '101%' OR kodp like '103%')
               and substr(kodp, 6,5) in ('02190', '02195', '02200', '02220', '02240', '02160', '02250', '02255', '02270', '02165', '02275')
               and substr(kodp,3,1) = t.P
               and substr(kodp,4,1) = t.M 
               and substr(kodp,5,1) in ('0','1','2')
               and substr(kodp,11,10) = t.OKPO;  

             if sr2190_ >= 0 then
                INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                   VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                           '10'||t.P||t.M||t.K||'02290'||LPAD(t.okpo,10,'0'), TO_CHAR(sr2190_), 'OKPO='||t.OKPO);
             else
                INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
                   VALUES (s_rnbu_record.NEXTVAL, userid_, dat_,
                           '10'||t.P||t.M||t.K||'02295'||LPAD(t.okpo,10,'0'), TO_CHAR(sr2190_), 'OKPO='||t.OKPO);
             end if;
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

    ---------------------------------------------------
    delete from tmp_nbu where kodf=kodf_ and datf= dat_;
    ---------------------------------------------------
    --- формирование файла в табл. TMP_NBU
    insert into tmp_nbu(kodf, datf, kodp, znap)
    select kodf_, dat_, kodp, znap
    from rnbu_trace
    where substr(kodp,1,2) in ('01','02','03','04','05','06','07','08','09','11');

    insert into tmp_nbu(kodf, datf, kodp, znap)
    select kodf_, dat_, kodp, sum(znap) znap
    from rnbu_trace
    where substr(kodp,1,2) = '10'
    group by kodp;
------------------------------------------------------------------
END p_f3b_NN;
/