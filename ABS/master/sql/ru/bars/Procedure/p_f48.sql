

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F48.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F48 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F48 (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    #D5 for KB
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    24/10/2012 (10/10/2012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
nls_     Varchar2(15);
data_    Date;
kv_      SMALLINT;
dat1_    Date;
Oste_    Number;
na_      Number;
pna_     Char(2);
country_ Varchar2(70);
nmk_     Varchar2(70);
adr_     Varchar2(70);
kod_     Varchar2(14);
kodp_    Varchar2(10);
znap_    Varchar2(70);
userid_  Number;

CURSOR Saldo IS
  SELECT a.nls, a.fdat, a.ostf-a.dos+a.kos, c.country, LTRIM(RTRIM(c.nmk)),
         c.adr, c.okpo
  FROM (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,
        cust_acc ca, customer c
  WHERE a.acc=ca.acc             AND
        c.rnk=ca.rnk             AND
        a.nbs='5000'             AND
        a.ostf-a.dos+a.kos <>0
  ORDER BY a.ostf-a.dos+a.kos DESC ;

CURSOR BaseL IS
    SELECT nls, kodp, znap
    FROM rnbu_trace
    WHERE userid=userid_
    ORDER BY nls, substr(kodp,3,2) ;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
na_:=1 ;

OPEN Saldo;
LOOP
    FETCH Saldo INTO nls_, data_, Oste_, country_, nmk_, adr_, kod_ ;
    EXIT WHEN Saldo%NOTFOUND;
    IF na_ < 21 AND Oste_ <> 0 THEN
       pna_:= SUBSTR((100+na_) || '',2,2) ;

       INSERT INTO rnbu_trace         -- Наименование клиента
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '10' || pna_, nmk_);

       INSERT INTO rnbu_trace         -- Код ЕДРПОУ чи ДРФО
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '15' || pna_, kod_);

       INSERT INTO rnbu_trace         -- Код страны участника
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '16' || pna_, country_);

       INSERT INTO rnbu_trace         -- Адрес клиента
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '20' || pna_, adr_);

       INSERT INTO rnbu_trace         -- Платежные реквизиты
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '30' || pna_, kod_);

       INSERT INTO rnbu_trace         -- Количество акций
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '40' || pna_, '0');

       INSERT INTO rnbu_trace         -- Заявленый размер или стоимость акций
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '51' || pna_, '0');

       if Dat_ < to_date('01092012','ddmmyyyy') then
           INSERT INTO rnbu_trace         -- Сплаченный размер или стоимость акций
                            (nls, kv, odate, kodp, znap) VALUES
                            (nls_, 980, data_, '52' || pna_, to_char(Oste_));
       end if;

       INSERT INTO rnbu_trace     -- %%% в Уставном капитале (прямое участие)
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '60' || pna_, '0');

       INSERT INTO rnbu_trace     -- %%% в Уставном капитале (непрямое участие)
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '70' || pna_, '0');

       INSERT INTO rnbu_trace         -- Общая часть в Уставном капитале
                        (nls, kv, odate, kodp, znap) VALUES
                        (nls_, 980, data_, '80' || pna_, '0');

       if Dat_ < to_date('01092012','ddmmyyyy') then
           INSERT INTO rnbu_trace         -- Кол-во акций по письмен. разрешению НБУ
                            (nls, kv, odate, kodp, znap) VALUES
                            (nls_, 980, data_, '91' || pna_, '0');

           INSERT INTO rnbu_trace         -- Стоимость акций по письмен. разрешению НБУ
                            (nls, kv, odate, kodp, znap) VALUES
                            (nls_, 980, data_, '92' || pna_, '0');

           INSERT INTO rnbu_trace         -- %% в Уставном капитале по письмен. разрешению НБУ
                            (nls, kv, odate, kodp, znap) VALUES
                            (nls_, 980, data_, '93' || pna_, '0');

           INSERT INTO rnbu_trace         -- Дата и N даного НБУ разрешения на увеличение
                            (nls, kv, odate, kodp, znap) VALUES
                            (nls_, 980, data_, '94' || pna_, '0');
       end if;

       na_:= na_+1 ;
    END IF;
END LOOP;
CLOSE Saldo;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='48' AND datf=Dat_ ;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  nls_, kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('48', Dat_, kodp_, LTRIM(RTRIM(znap_)));
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_f48;
/
show err;

PROMPT *** Create  grants  P_F48 ***
grant EXECUTE                                                                on P_F48           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F48.sql =========*** End *** ===
PROMPT ===================================================================================== 
