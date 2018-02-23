--====================================================================
-- Module : OTC (для НБУ)
-- Author : OAB
-- Date   : 23.02.2018
--============ <Comments> ============================================
--    Изменения: 
--================================================
Prompt CREATE FILE #3V;
--- Действия необходимые для формирования файла #3V
--====================================================================
-- Module : Отчетность КБ 
-- Author : Овчарук
-- Date   : 23.02.2018
--====================================================================
-- Новый отчетный файл 3V - процедуры и структура показателя
--====================================================================
exec bc.home;

declare
   id_     number;
   kol_    number;
   kodf_   varchar2(2):='3V';
   kodf1_  varchar2(2):='3B';
   branch_ varchar2(30);
   uuu_    varchar2(3); 
   path_o_ varchar2(35);
   zzz_    varchar2(20);
   a017_   varchar2(1); 

begin
---  #3V файл

    delete from kl_f00$LOCAL where kodf=kodf_;    
    delete from kl_f00$GLOBAL where kodf=kodf_;

    select count(*) 
     into kol_ 
    from kl_f00$GLOBAL 
    where kodf='3B' and a017 in ('C','G');

    if kol_ = 0 then
       kodf1_ := '02';
       select count(*) 
          into kol_ 
       from kl_f00$GLOBAL 
       where kodf=kodf1_ and a017 in ('C','G');
    end if;

    if kol_ <> 0 then
       for k in
       (select aa, a017, pr_tobo from kl_f00$GLOBAL 
        where kodf=kodf1_ and a017 in ('C','G'))

          loop

          begin
             select procc
              into id_
             from rep_proc
             where name = 'P_F'||kodf_||'_n'||lower(k.a017); 
          exception when no_data_found then
             select max(to_number(PROCC)) + 1 
             into id_ 
             from rep_proc;

             insert into rep_proc
             values (to_char(id_),'P_F'||kodf_||'_n'||lower(k.a017), 
                     'Данi про боржникiв банку');
          end;

        Insert into KL_F00$GLOBAL (KODF, AA, A017, NN, PERIOD, 
                                       PROCC, R, SEMANTIC, KODF_EXT, F_PREF, PR_TOBO)
        Values
                                   ('3V', k.aa, k.a017, '04', 'Y', 
                                    to_char(id_), '1', 'Дані про боржників банку - великих, середніх і малих підприємств', NULL, NULL, 0);

       end loop;
    end if;

    bc.home;

    for z in ( select kf from mv_kf )
    loop

       BEGIN
          select branch, uuu, path_o, zzz, a017 
             into branch_, uuu_, path_o_, zzz_, a017_  
          from kl_f00$local
          where kodf=kodf1_ 
            and a017 in ('C','G') 
            and policy_group='FILIAL'
            and branch = '/' || to_char(z.kf) || '/';

          Insert into KL_F00$LOCAL (POLICY_GROUP, BRANCH, KODF, A017, UUU, 
                                    ZZZ, PATH_O, DATF, NOM)
          Values
                                   ('FILIAL', branch_, kodf_, a017_, uuu_, 
                                    zzz_, path_o_, TO_DATE('28/02/2018','DD/MM/YYYY'), '1');

          Insert into KL_F00$LOCAL (POLICY_GROUP, BRANCH, KODF, A017, UUU, 
                                    ZZZ, PATH_O, DATF, NOM)
          Values
                                   ('WHOLE', '/', kodf_, a017_, uuu_, 
                                    zzz_, path_o_, TO_DATE('28/02/2018', 'DD/MM/YYYY'), '1');

       EXCEPTION WHEN NO_DATA_FOUND THEN 
          null;
       END;

    end loop;

    bc.home;

-- добавляем описание показателя
DELETE FROM FORM_STRU WHERE KODF='3V' ;

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3V', 1, 'Код~LL', 'substr(kodp,1,2)', '1', 3, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3V', 2, '1-велике,среднє~2-мале під-во', 'substr(kodp,3,1)', '1', 2, 'G'); 

INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3V', 3, 'Ідентифікаційний~номер ЮО', 'substr(kodp,4,10)', '1', 1, 'G');
 
INSERT INTO FORM_STRU ( KODF, NATR, NAME, VAL, ISCODE, CODE_SORT,
A017 ) VALUES ( 
'3V', 4, 'Значення~показника', 'znap', '0', NULL, 'G'); 

commit;
 
end;
/

prompt 'Procedure P_F3V_nn';
CREATE OR REPLACE PROCEDURE BARS.p_f3V_NN (Dat_ DATE, sheme_ varchar2 default 'G', pr_op_ Number default 1) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #3V для
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 21.02.2018 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
21.02.2018 новый файл отчетности
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    kodf_    varchar2(2) := '3V';
    userid_  number;
    mfo_     number;
    mfou_    number;
    ost_     number;
    ost_96_  number;
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
                                             max(nvl(pd,0)) koef_k,
                                             max(nvl(kol_351,1)) s190
                                      from (select n.okpo, n.k, n.kat, n.kol_351, r.pd
                                            from bars.nbu23_rez n, rez_cr r
                                            where n.fdat = dte_
                                              and n.ddd like '12%'
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
                         LTRIM (to_char (ROUND (k.koef_k, 2), fmt_)), 'OKPO='||k.OKPO, k.rnk);

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
            and ddd like '12%'
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

begin
    execute immediate 'DROP PUBLIC SYNONYM p_f3V_nn';
exception
    when others then null;
end;
/    

create public synonym p_f3V_nn for bars.p_f3V_nn;
grant execute on p_f3V_nn to rpbn002;
/
show err;

prompt 'Procedure P_F3V_nc';
CREATE OR REPLACE procedure p_f3V_nc(Dat_ DATE, pr_op_ Number default 1)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #3V для схема "C" 
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 16.02.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f3V_NN (Dat_,'C',1);
end;
/

begin
    execute immediate 'DROP PUBLIC SYNONYM p_f3V_nc';
exception
    when others then null;
end;
/    

create public synonym p_f3V_nc for bars.p_f3V_nc;
grant execute on p_f3V_nc to rpbn002;
/

show err;

prompt 'Procedure P_F3V_ng';
CREATE OR REPLACE procedure p_f3V_ng(Dat_ DATE, pr_op_ Number default 1)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #3V для схема "G" 
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 16.02.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f3V_NN (Dat_,'G',1);
end;
/

begin
    execute immediate 'DROP PUBLIC SYNONYM p_f3V_ng';
exception
    when others then null;
end;
/    

create public synonym p_f3V_ng for bars.p_f3V_ng;
grant execute on p_f3B_ng to rpbn002;
/

show err;

commit work;

