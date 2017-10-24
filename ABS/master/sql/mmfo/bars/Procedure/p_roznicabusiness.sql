

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ROZNICABUSINESS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ROZNICABUSINESS ***

  CREATE OR REPLACE PROCEDURE BARS.P_ROZNICABUSINESS ( id_ VARCHAR2 DEFAULT '*', date_ DATE, mode_ VARCHAR2)
is
    mfo_    NUMBER;
    nls_    VARCHAR2(14);
    kol_    NUMBER;
    sum_    NUMBER;
    kol_s_  NUMBER;
    sum_s_  NUMBER;
    period_ VARCHAR2(70);
    dd_     VARCHAR2(2);
    mm_     VARCHAR2(2);
    yyyy_   VARCHAR2(4);
    name_   VARCHAR2(110);
    nd_     VARCHAR2(30);
BEGIN

  --------------------------------
  EXECUTE IMMEDIATE 'TRUNCATE TABLE tmp_roznicabusiness';
  --------------------------------
  SELECT to_char(date_,'dd'),
         to_char(date_,'mm'),
         to_char(date_,'yyyy')
    INTO dd_, mm_, yyyy_ FROM dual;

  -- выберем отчетный период
  SELECT 'з 01 '||name_from||' '||yyyy_||' р. по '||dd_||' '||name_from||' '||yyyy_||' р.'
   INTO period_ FROM meta_month WHERE n = to_number(mm_);

  IF id_ = '*' THEN     -- выберем информацию по ВСЕМ организациям --

    IF mode_ = 'SHORT' THEN
      FOR i IN ( SELECT r1.ID, r1.ND, r1.NAME, r1.OKPO, s1.MFOB, s1.NLSB, nvl(SUM(s1.KOL),0) as "KOL", nvl(SUM(s1.SUMMA),0) as "SUMMA"
                   FROM ROZNICABUSINESS r1,
                        ( SELECT r.ID, r.ND, r.NAME, r.OKPO, a.MFOB, a.NLSB, COUNT(*) KOL, SUM(S) SUMMA
                            FROM ARC_RRP a, ROZNICABUSINESS r
                           WHERE a.DAT_A BETWEEN TO_DATE('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY')
                                             AND TO_DATE(dd_||'/'||mm_||'/'||yyyy_,'DD/MM/YYYY')
                             AND a.ID_B = r.OKPO
                             AND SUBSTR(a.NLSA,1,4) = '2902'
                             AND a.DK = 1
                             AND SUBSTR(a.FN_A,1,2) <> '$B'
                             AND a.nlsb LIKE decode(trim(r.nls),null,'%','%'||trim(r.nls)||'%')
                             AND a.MFOA IN (SELECT UNIQUE B1.MFO
                                              FROM BANKS B1, BANKS_RU B2
                                             WHERE ( (   B1.MFO IN (SELECT MFO FROM BANKS_RU)
                                                      OR B1.MFOP IN (SELECT MFO FROM BANKS_RU)))
                                               AND (B2.MFO = B1.MFO OR B2.MFO = B1.MFOP))
                          GROUP BY grouping sets ( (r.id),
                                                   (r.id,r.nd),
                                                   (r.id,r.nd,r.name),
                                                   (r.id,r.nd,r.name,r.okpo),
                                                   (r.id,r.nd,r.name,r.okpo,a.mfob),
                                                   (r.id,r.nd,r.name,r.okpo,a.mfob,a.nlsb) )
                          ORDER BY 1,2,3,4,5,6 ) s1
                  WHERE r1.OKPO = s1.OKPO(+)
                    AND r1.nd    is not null
                    AND r1.name  is not null
                    AND r1.okpo  is not null
                    AND s1.mfob  is null
                    AND s1.nlsb  is null
                  GROUP BY r1.ID, r1.ND, r1.NAME, r1.OKPO, s1.MFOB, s1.NLSB )
      LOOP
        INSERT INTO tmp_roznicabusiness (period,    id,   okpo,   name,   nd,   kol, summa)
                                 VALUES (period_, i.id, i.okpo, i.name, i.nd, i.kol, i.summa);
      END LOOP;
    END IF;

    IF mode_ = 'WIDE' THEN
      FOR i IN ( SELECT id, nd, name, mfob, nlsb, okpo, kol, summa
                   FROM ( SELECT r.ID, r.ND, r.NAME, r.OKPO, a.MFOB, a.NLSB, COUNT(*) KOL, SUM(S) SUMMA
                            FROM ARC_RRP a, ROZNICABUSINESS r
                           WHERE a.DAT_A BETWEEN TO_DATE('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY')
                                             AND TO_DATE(dd_||'/'||mm_||'/'||yyyy_,'DD/MM/YYYY')
                             AND a.ID_B = r.OKPO
                             AND SUBSTR(a.NLSA,1,4) = '2902'
                             AND a.DK = 1
                             AND SUBSTR(a.FN_A,1,2) <> '$B'
                             AND a.nlsb LIKE decode(trim(r.nls),null,'%','%'||trim(r.nls)||'%')
                             AND a.MFOA IN (SELECT UNIQUE B1.MFO
                                              FROM BANKS B1, BANKS_RU B2
                                             WHERE ( (   B1.MFO IN (SELECT MFO FROM BANKS_RU)
                                                      OR B1.MFOP IN (SELECT MFO FROM BANKS_RU)))
                                               AND (B2.MFO = B1.MFO OR B2.MFO = B1.MFOP))
                        GROUP BY grouping sets ( (r.id),
                                                 (r.id,r.nd),
                                                 (r.id,r.nd,r.name),
                                                 (r.id,r.nd,r.name,r.okpo),
                                                 (r.id,r.nd,r.name,r.okpo,a.mfob),
                                                 (r.id,r.nd,r.name,r.okpo,a.mfob,a.nlsb) )
                        ORDER BY 1,2,3,4,5,6 )
                  WHERE nd    is not null
                    AND name  is not null
                    AND kol   is not null
                    AND summa is not null
                    AND okpo  is not null
                    AND mfob  is not null
                    AND nlsb  is not null )
      LOOP
        INSERT INTO tmp_roznicabusiness (period,    id,   okpo,   name,   nd,    mfo,    nls,   kol, summa)
                                 VALUES (period_, i.id, i.okpo, i.name, i.nd, i.mfob, i.nlsb, i.kol, i.summa);
      END LOOP;
    END IF;

  ELSE

    -- здесь выборка по указанному коду контрагента

    SELECT name, nd INTO name_, nd_
      FROM roznicabusiness
     WHERE id = to_number(id_,'999') AND rownum=1;

    FOR i IN ( SELECT okpo, name, nd, nls FROM roznicabusiness WHERE id=to_number(id_,'999') )
    LOOP

      kol_s_ := 0;
      sum_s_ := 0;

      FOR k IN ( SELECT mfob,
                        nlsb,
                        count(*) KOL,
                        sum(s) SUMMA
                   FROM arc_rrp
                  WHERE dat_a BETWEEN TO_DATE('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY')
                                  AND TO_DATE(dd_||'/'||mm_||'/'||yyyy_,'DD/MM/YYYY')
--                                  AND LAST_DAY(TO_DATE('01/'||mm_||'/'||yyyy_,'DD/MM/YYYY'))
                    AND id_b = i.okpo
                    AND substr(nlsa,1,4) = '2902'
                    AND nlsb LIKE decode(trim(i.nls),null,'%','%'||trim(i.nls)||'%')
                    AND dk   = 1
                    AND substr(fn_a,1,2) <> '$B'
                    AND mfoa IN (select unique b1.mfo
                                   from banks b1, banks_ru b2
                                  where ( (
                                            b1.mfo in (select mfo from banks_ru)
                                            or
                                            b1.mfop in (select mfo from banks_ru)
                                          )
                                        )
                                    and ( b2.mfo = b1.mfo
                                          or
                                          b2.mfo = b1.mfop
                                        )
                                )
               GROUP BY mfob, nlsb )
      LOOP

        mfo_ := k.mfob;
        nls_ := k.nlsb;
        kol_ := k.kol;
        sum_ := k.summa;

        IF mode_ = 'WIDE' THEN
          INSERT INTO tmp_roznicabusiness
                 (period,  id,    okpo,  name,  nd,  mfo,  nls,  kol, summa)
          VALUES (period_, to_number(id_,'999'), i.okpo, name_, nd_, mfo_, nls_, kol_, sum_ );
        END IF;

        IF mode_ = 'SHORT' THEN
          kol_s_ := kol_s_ + kol_;
          sum_s_ := sum_s_ + sum_;
        END IF;

      END LOOP;

      IF mode_ = 'SHORT' THEN
          INSERT INTO tmp_roznicabusiness
                 (period,  id,     okpo,  name,  nd,    kol,  summa)
           VALUES (period_, to_number(id_,'999'), i.okpo, name_, nd_, kol_s_, sum_s_);
      END IF;

    END LOOP;

  END IF;

  COMMIT;

END;
/
show err;

PROMPT *** Create  grants  P_ROZNICABUSINESS ***
grant EXECUTE                                                                on P_ROZNICABUSINESS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ROZNICABUSINESS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ROZNICABUSINESS.sql =========***
PROMPT ===================================================================================== 
