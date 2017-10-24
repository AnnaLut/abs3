

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F3B_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F3B_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F3B_NN (Dat_ DATE, sheme_ varchar2 default 'G', pr_op_ Number default 1) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования #3B для
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    22/12/2016 (14.07.2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
07.10.2014 Доработки по BRSMAIN-2937
23.10.2014 Изменение знака по показателю 02300 (ОБ)
07.08.2015 Доработки по COBUSUPABS-3548
14.07.2016 Доработки по COBUSUPABS-4577
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='3B';
userid_  number;
mfo_     number;
mfou_    number;
dtb_     date;
dte_     date;
znap_    number;

BEGIN
userid_ := user_id;
mfo_:=F_OURMFO();

begin
   select nvl(trim(mfou), mfo_) into mfou_ from banks where mfo = mfo_;
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

select trunc(dat_,'yyyy'), add_months(trunc(dat_,'yyyy'),12) into dtb_,dte_ from dual;

INSERT INTO OTCN_LOG (kodf, userid, txt)
        VALUES (kodf_, userid_,
                     TO_CHAR (SYSDATE, 'dd.mm.yyyy hh24:mi:ss')
                  || ' Протокол формирования файла #3B за '
                  || TO_CHAR (dat_, 'dd.mm.yyyy'));

INSERT INTO OTCN_LOG (kodf, userid, txt)
        VALUES (kodf_, userid_,
                     'Дата начала отчетного периода - '
                  || TO_CHAR (dtb_, 'dd.mm.yyyy'));

INSERT INTO OTCN_LOG (kodf, userid, txt)
        VALUES (kodf_, userid_,
                     'Дата окончания отчетного периода - '
                  || TO_CHAR (dte_, 'dd.mm.yyyy'));

INSERT INTO OTCN_LOG (kodf, userid, txt)
        VALUES (
                  kodf_,
                  userid_,
                  '--------------------------------------------------');
--------------------------------------------------------
FOR T IN
(SELECT edrpou okpo
   FROM okpof659
  WHERE edrpou IN (  SELECT LPAD (okpo, 10, '0')
                       FROM customer c
                      WHERE okpo IN (SELECT TO_CHAR (edrpou)
                                       FROM okpof659
                                      WHERE EXISTS
                                               (SELECT 1
                                                  FROM fin_rnk
                                                 WHERE     okpo = edrpou
                                                       AND idf IN (1, 2)
                                                       AND fdat IN (dtb_,
                                                                    dte_)))
                            AND (date_off IS NULL OR date_off > dte_)
                   GROUP BY LPAD (c.okpo, 10, '0')
                     HAVING COUNT (*) > 1))
loop
    INSERT INTO OTCN_LOG (kodf, userid, txt) 
    VALUES(kodf_,userid_,'ОКПО '||to_char(t.okpo)||' имеет более одного RNK');
END LOOP;

FOR T IN
(SELECT edrpou
   FROM okpof659
  WHERE     NOT EXISTS
               (SELECT 1
                  FROM nbu23_rez
                 WHERE fdat = dte_ AND okpo = to_char(edrpou))
        AND EXISTS
               (SELECT 1
                  FROM customer
                 WHERE     is_number (okpo) = 1
                       AND okpo = to_char(edrpou)
                       AND (date_off IS NULL OR date_off > dte_))
        AND EXISTS
               (SELECT 1
                  FROM fin_rnk
                 WHERE     okpo = edrpou
                       AND idf IN (1, 2)
                       AND fdat IN (dtb_, dte_)))
loop
    INSERT INTO OTCN_LOG (kodf, userid, txt) 
    VALUES(kodf_,userid_,'ОКПО '||to_char(t.edrpou)||' отсутствует в NBU23_REZ за '||to_char(dte_,'dd.mm.yyyy'));
END LOOP;

FOR T IN

(SELECT edrpou
   FROM okpof659 o JOIN customer c ON c.okpo = TO_CHAR (o.edrpou)
  WHERE     EXISTS
               (SELECT 1
                  FROM customer
                 WHERE     is_number (okpo) = 1
                       AND okpo = to_char(edrpou)
                       AND (date_off IS NULL OR date_off > dte_))
        AND EXISTS
               (SELECT 1
                  FROM fin_rnk
                 WHERE okpo = edrpou
                       AND idf IN (1, 2)
                       AND fdat IN (dtb_, dte_))
        AND EXISTS
               (SELECT 1
                  FROM nbu23_rez
                 WHERE fdat = dte_ AND rnk = c.rnk)
        AND (SELECT MIN (kat)
               FROM nbu23_rez
              WHERE fdat = dte_ AND rnk = c.rnk)
               IS NULL)
loop
    INSERT INTO OTCN_LOG (kodf, userid, txt) 
    VALUES(kodf_,userid_,'ОКПО '||to_char(t.edrpou)||' не заполнено S080 в NBU23_REZ за '||to_char(dte_,'dd.mm.yyyy'));
END LOOP;

FOR T IN

(SELECT *
   FROM (  SELECT okpo, SUM (fmb) fmb, SUM (fme) fme
             FROM (SELECT okpo,
                          DECODE (fdat,
                                  dte_, NULL,
                                  DECODE (NVL (fm, '0'),  'M', 2,  'R', 2,  1))
                             fmb,
                          DECODE (
                             fdat,
                             dte_, DECODE (NVL (fm, '0'),  'M', 2,  'R', 2,  1),
                             NULL)
                             fme
                     FROM fin_fm
                    WHERE     fdat IN (dtb_, dte_)
                          AND okpo IN (SELECT edrpou
                                         FROM okpof659
                                        WHERE     EXISTS
                                                     (SELECT 1
                                                        FROM customer
                                                       WHERE is_number(okpo) = 1
                                                             AND okpo = to_char(edrpou)
                                                             AND (   date_off
                                                                        IS NULL
                                                                  OR date_off >
                                                                        dte_))
                                              AND EXISTS
                                                     (SELECT 1
                                                        FROM fin_rnk
                                                       WHERE     okpo = edrpou
                                                             AND idf IN (1, 2)
                                                             AND fdat IN (dtb_,
                                                                          dte_))))
         GROUP BY okpo)
  WHERE fmb <> fme)
loop
    INSERT INTO OTCN_LOG (kodf, userid, txt) 
    VALUES(kodf_,userid_,'ОКПО '||to_char(t.okpo)||' исключается из отчета т.к. изменилась форма, на начало периода "'||decode(t.fmb,1,'большие и средние','малые')||' предприятия", на конец периода "'||decode(t.fme,1,'большие и средние','малые')||' предприятия".');
END LOOP;

--------------------------------------------------------
FOR T IN
(SELECT *
   FROM ( (SELECT a.nnnnn,
                  a.okpo,
                  e.p,
                  e.ddddd,
                  d.m,
                  TRIM (TO_CHAR (NVL (b.k160, 0), '00')) II,
                  TRIM (TO_CHAR (NVL (b.s080, 0))) T,
                  NVL (c.k111, '00') LL,
                  TRIM (TO_CHAR (NVL (b.s190, 0))) s190,
                  a.pmax,
                  a.pato,
                  ROUND ( (fin_nbu.zn_rep (e.kod,
                                           e.idf,
                                           DECODE (d.m,  2, dtb_,  1, dte_),
                                           a.okpo)),
                         1)
                     znap
             FROM (  SELECT nnnnn,
                            TO_CHAR (edrpou) okpo,
                            DECODE (COALESCE (par_max, 0), 1, 0, 1) pmax,
                            DECODE (COALESCE (par_ato, 0), 1, 0, 1) pato
                       FROM okpof659
                      WHERE     EXISTS
                                   (SELECT 1
                                      FROM customer
                                     WHERE     is_number (okpo) = 1
                                           AND okpo = to_char(edrpou)
                                           AND (   date_off IS NULL
                                                OR date_off > dte_))
                            AND EXISTS
                                   (SELECT 1
                                      FROM fin_rnk
                                     WHERE okpo = edrpou
                                           AND fdat IN (dtb_, dte_))
                            AND (mfo_ = 300465 OR k IS NULL)
                   ORDER BY nnnnn) a
                  LEFT JOIN (  SELECT okpo,   
                                      '00' k160,
                                      MAX (NVL (k, 0)) k,
                                      MAX (NVL (kat, 0)) s080,
                                      MAX (NVL (obs, 0)) s190
                                 FROM (SELECT okpo,
                                              k,
                                              kat,
                                              obs
                                         FROM bars.nbu23_rez
                                        WHERE fdat = dte_
                                       UNION ALL
                                       SELECT edrpou okpo,
                                              k,
                                              kat,
                                              obs
                                         FROM bars.okpof659)
                             GROUP BY okpo) b
                     ON a.okpo = b.okpo
                  LEFT JOIN
                  (SELECT okpo, k111
                     FROM customer, kl_k110
                    WHERE     (    kl_k110.d_open <= dte_
                               AND (   kl_k110.d_close IS NULL
                                    OR kl_k110.d_close >= dte_))
                          AND rnk IN (  SELECT MAX (rnk)
                                          FROM customer
                                         WHERE    date_off IS NULL
                                               OR date_off > dte_
                                      GROUP BY LPAD (okpo, 10, '0'))
                          AND customer.ved = kl_k110.k110) c
                     ON a.okpo = c.okpo
                  LEFT JOIN
                  (  SELECT f1.okpo,
                            MIN (
                               DECODE (NVL (f2.fm, '0'),  'M', 2,  'R', 2,  1))
                               fm,
                            DECODE (f1.fdat, dte_, 1, 2) m
                       FROM bars.fin_fm f1
                            INNER JOIN bars.fin_fm f2
                               ON f1.okpo = f2.okpo AND f2.fdat = dte_
                      WHERE f1.fdat IN (dtb_, dte_)
                   GROUP BY f1.okpo, f1.fdat) d
                     ON a.okpo = d.okpo
                  LEFT JOIN (SELECT p,
                                    ddddd,
                                    kod,
                                    idf
                               FROM kl_f659) e
                     ON e.p = NVL (d.fm, '1'))
         UNION ALL
         (SELECT a.nnnnn,
                 a.okpo,
                 NVL (TO_CHAR (d.fm), '1') p,
                 '77777' ddddd,
                 NVL (d.m, 1) m,
                 TRIM (TO_CHAR (NVL (b.k160, 0), '00')) II,
                 TRIM (TO_CHAR (NVL (b.s080, 0))) T,
                 NVL (c.k111, '00') LL,
                 TRIM (TO_CHAR (NVL (b.s190, 0))) s190,
                 a.pmax,
                 a.pato,
                 ROUND (NVL (b.k, 0), 2) znap
            FROM (  SELECT nnnnn,
                           TO_CHAR (edrpou) okpo,
                           DECODE (COALESCE (par_max, 0), 1, 0, 1) pmax,
                           DECODE (COALESCE (par_ato, 0), 1, 0, 1) pato
                      FROM okpof659
                     WHERE     EXISTS
                                  (SELECT 1
                                     FROM customer
                                    WHERE     is_number (okpo) = 1
                                          AND okpo = to_char(edrpou)
                                          AND (   date_off IS NULL
                                               OR date_off > dte_))
                           AND EXISTS
                                  (SELECT 1
                                     FROM fin_rnk
                                    WHERE okpo = edrpou
                                          AND fdat IN (dtb_, dte_))
                           AND (mfo_ = 300465 OR k IS NULL)
                  ORDER BY nnnnn) a
                 LEFT JOIN (  SELECT okpo,                 
                                     '00' k160,
                                     MAX (NVL (k, 0)) k,
                                     MAX (NVL (kat, 0)) s080,
                                     MAX (NVL (obs, 0)) s190
                                FROM (SELECT okpo,
                                             k,
                                             kat,
                                             obs
                                        FROM bars.nbu23_rez
                                       WHERE fdat = dte_
                                      UNION ALL
                                      SELECT edrpou okpo,
                                             k,
                                             kat,
                                             obs
                                        FROM bars.okpof659)
                            GROUP BY okpo) b
                    ON a.okpo = b.okpo
                 LEFT JOIN
                 (SELECT okpo, k111
                    FROM customer, kl_k110
                   WHERE     (    kl_k110.d_open <= dte_
                              AND (   kl_k110.d_close IS NULL
                                   OR kl_k110.d_close >= dte_))
                         AND rnk IN (  SELECT MAX (rnk)
                                         FROM customer
                                        WHERE    date_off IS NULL
                                              OR date_off > dte_
                                     GROUP BY LPAD (okpo, 10, '0'))
                         AND customer.ved = kl_k110.k110) c
                    ON a.okpo = c.okpo
                 LEFT JOIN
                 (  SELECT okpo,
                           MIN (DECODE (NVL (fm, '0'),  'M', 2,  'R', 2,  1))
                              fm,
                           DECODE (fdat, dte_, 1, 2) m
                      FROM fin_fm
                     WHERE fdat IN (dte_)
                  GROUP BY okpo, fdat) d
                    ON a.okpo = d.okpo))order by P,nnnnn,substr(DDDDD,2),M)
loop

if (t.ddddd in ('02050', '02070', '02130', '02150', '02180', '02250', '02255', 
                '02270', '21425', '21430','23360', '04020', '04080', '04090', 
                '04100', '04140','02300','02095','02195','02295','02355') or 
                (t.ddddd in('02285') and t.P='2')) and sign(t.znap)=1 
then
   znap_:=-t.znap;
ELSE
   znap_:=t.znap;
END IF;

INSERT INTO rnbu_trace (recid,
                        userid,
                        odate,
                        kodp,
                        znap,
                        comm)
        VALUES (
                  s_rnbu_record.NEXTVAL,
                  userid_,
                  dat_,
                     t.P
                  || t.DDDDD
                  || t.M
                  || t.II
                  || t.T
                  || t.LL
                  || TRIM (TO_CHAR (t.nnnnn, '00000'))
                  || t.s190
                  || t.pmax
                  || t.pato,
                  TO_CHAR (znap_),
                  'OKPO=' || t.OKPO);

END LOOP;

DELETE FROM rnbu_trace
      WHERE znap = 0 AND SUBSTR (kodp, 2, 5) NOT IN ('77777');

FOR T IN

(SELECT SUBSTR (a.kodp, 1, 1) || '02350' || SUBSTR (a.kodp, 7) kodp,
        0 znap,
        comm
   FROM rnbu_trace a
  WHERE     SUBSTR (kodp, 2, 6) = '219001'
        AND NOT EXISTS
               (SELECT 1
                  FROM rnbu_trace b
                 WHERE b.kodp LIKE '_0235_' || SUBSTR (a.kodp, 7)))
loop
    INSERT INTO rnbu_trace (recid, userid, odate, kodp, znap, comm)
    VALUES (s_rnbu_record.NEXTVAL, userid_, dat_, t.kodp, t.znap, t.comm);
END LOOP;
---------------------------------------------------
delete from tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
--- формирование файла в табл. TMP_NBU
insert into tmp_nbu(kodf, datf, kodp, znap)
select kodf_, dat_, kodp, sum(znap) znap
from rnbu_trace
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
