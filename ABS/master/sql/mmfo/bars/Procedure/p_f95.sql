

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F95.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F95 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F95 (Dat_ DATE )  IS

acc_    Number;
nls_    varchar2(15);
nbs_    Varchar2(4);
data_   Date;
daos_   Date;
kv_     SMALLINT;
dat1_   date;
Oste_   number;
na_     number;
Cntr_   Number;
sum_k_  Number;
pna_    char(3);
nmk_    varchar2(70);
adr_    varchar2(70);
kod_    varchar2(14);
kodp_    varchar2(10);
znap_    varchar2(70);
userid_ Number;

--Остатки
CURSOR Saldo IS
  SELECT a.acc, a.nls, a.fdat, a.daos, a.ostf-a.dos+a.kos,
         LTRIM(RTRIM(c.nmk)), c.adr, c.okpo, 2-MOD(c.codcagent,2)
  FROM (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, s.daos, aa.ostf,
         aa.dos, aa.kos
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,
        cust_acc ca, customer c
  WHERE a.acc=ca.acc                AND
        ca.rnk=c.rnk                AND
---        c.prinsider in (13,21)      AND
        a.nbs='5000'                AND
        a.ostf-a.dos+a.kos <>0
  ORDER BY a.ostf-a.dos+a.kos DESC ;

CURSOR BaseL IS
    SELECT nls, kodp, znap
    FROM rnbu_trace
    WHERE userid=userid_
---    GROUP BY kodp
    ORDER BY nls, substr(kodp,3,2) ;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
na_:=1 ;

--- определение суммы уставного капитала
SELECT SUM(aa.ostf-aa.dos+aa.kos) into sum_k_
FROM saldoa aa, accounts s
WHERE aa.acc=s.acc     AND
      (s.acc,aa.fdat) =
      (select c.acc,max(c.fdat)
       from saldoa c
       where s.acc=c.acc and c.fdat <= Dat_ group by c.acc) AND
       substr(s.nbs,1,3)='500'
GROUP BY substr(s.nbs,1,3) ;

OPEN Saldo;
LOOP
    FETCH Saldo INTO acc_, nls_, data_, daos_, Oste_, nmk_, adr_, kod_, cntr_ ;
    EXIT WHEN Saldo%NOTFOUND;
    IF ABS(Oste_) >= ABS(sum_k_)*0.1 THEN
       pna_:= SUBSTR((1000+na_) || '',2,3) ;

       INSERT INTO rnbu_trace      -- Наименование клиента
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '01' || pna_, nmk_);

       INSERT INTO rnbu_trace      -- Адрес клиента
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '02' || pna_, adr_);

       INSERT INTO rnbu_trace      -- Код ЕДРПОУ чи ДРФО
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '03' || pna_, kod_);

       INSERT INTO rnbu_trace      -- Код резидентности
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '04' || pna_, to_char(Cntr_));

       INSERT INTO rnbu_trace      -- Дата набуття статусу
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '05' || pna_, to_char(daos_,'DDMMYYYY'));

       INSERT INTO rnbu_trace      -- Вiдношення до банку
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '06' || pna_, '2');

       INSERT INTO rnbu_trace      -- Розмiр статутного капiталу
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '07' || pna_, to_char(ABS(Oste_)));

--- вiдсоток прямоi участi
       znap_:=to_char((ABS(Oste_)/ABS(sum_k_))*100,'990D0000');

       INSERT INTO rnbu_trace      -- Вiдсоток прямоi участi
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '08' || pna_, znap_);

       INSERT INTO rnbu_trace      -- Вiдсоток опосередкованоi iстотноi участi на дату набуття
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '09' || pna_, ' ');

       INSERT INTO rnbu_trace      -- Вiдсоток прямоi iстотноi участi на звiтну дату
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '10' || pna_, znap_);

       INSERT INTO rnbu_trace      -- Вiдсоток опосередкованоi iстотноi участi на звiтну дату
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '11' || pna_, ' ');

       na_:= na_+1 ;
    END IF;
END LOOP;
CLOSE Saldo;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='95' AND datf=Dat_ ;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  nls_, kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('95', Dat_, kodp_, LTRIM(RTRIM(znap_)));
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_f95;
 
/
show err;

PROMPT *** Create  grants  P_F95 ***
grant EXECUTE                                                                on P_F95           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F95.sql =========*** End *** ===
PROMPT ===================================================================================== 
