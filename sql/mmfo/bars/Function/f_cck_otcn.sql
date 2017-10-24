
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cck_otcn.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CCK_OTCN (FDAT_ DATE, ACC_ INT, MDATE_ DATE,
             VST_ number, FAKT_ varchar2 default '000', PDAT_ date default null,
             typen_ number default 1, 
             fdatb_ in date default null, 
             fdate_ in date default null,
             pnd_ in number default null) RETURN tbl_240 pipelined
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Вспомогательная функция для формирования #A7
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     : v.16.003    03/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 параметры: FDAT_ - отчетная дата
            ACC_ - ид. счета основного долга
            MDATE_ -  дата окончательного погашения остатка
            VST_ - остаток на отчетную дату
            FAKT_ - признак наличия дополнительных модулей:
                    0 - ничего нет
                    1 - есть только модуль факторинга
                    2 - есть только график погашения субординир. долга
                    3 - 1 + 2
            PDAT_ - фактическая дата конца декады (м.б. = FDAT_)
            TYPEN_ - спосіб врегулювання платежів по графіку
            = 1 - враховуємо 9129 при розрахунку суми заборгованості по кредиту
            = 2 - не враховуємо 9129 (зауваження Ощадбанку)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

26.08.2016 - txt_sql7: (счета SNO) добавлен ограничительный интервал на дату погашения 
19.08.2016 - обработка графиков для счетов SNO (скрипт txt_sql7)
30/07/2012 - будем обрабатывать бал.счет 1418 из табл. OTCN_LIM_SB (ПКБ)
27/07/2012 - потеряла изменение от 01/12/2011 для Демарка (счет 2618)
02/04/2012 - в расчет текущей суммы по договору не включался счет 9129 (CR9) и
             для CC_TRANS не было ограничения на FDAT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

  N0_  NUMBER := 0;    N1_  NUMBER := 0;
  N2_  NUMBER := 0;    N3_  NUMBER := 0; 
  N4_  NUMBER := 0;    N5_  NUMBER := 0;
  N6_  NUMBER := 0;    N7_  NUMBER := 0;     
  N8_  NUMBER := 0;    N9_  NUMBER := 0;
  N10_ NUMBER := 0;    N11_ NUMBER := 0;     
  N12_ NUMBER := 0;    N13_ NUMBER := 0;
  N14_ NUMBER := 0;    N15_ NUMBER := 0;

  i     tp_240 := tp_240(NULL, NULL, NULL, NULL, NULL, NULL); -- структура для хранения параметров s240, s242 и остатка

  ND_                INT;
  vidd_         cc_deal.vidd%type;
  OST_             NUMBER;
  L_             NUMBER;
  nls_a7_       Varchar2(15);
  kv1_            NUMBER;
  kv2_             NUMBER;
  dost_         NUMBER;
  pr_             NUMBER;
  rizn_         NUMBER;
  mdate_acc_       DATE;
  zm_date_         DATE:=TO_DATE('01072006', 'ddmmyyyy'); -- дата изменения классификатора
  zm_date2_     DATE:=TO_DATE('30092013', 'ddmmyyyy'); -- дата изменения классификатора
  cnt_               number:=0;
  nbs_                varchar2(4);
  rnkd_           INT;

  txt_sql         varchar2(1000) := 'SELECT   j.ni, j.sava, j.dava + k.srok mdate, sum(p.sa) pava, p.fdat dpava
                                       FROM fak_kontr k, fak_invoice j, fak_pog p
                                       WHERE k.nd = :nd_
                                         AND k.rnkd = :rnkd_
                                         AND k.nk = j.nk
                                         AND j.ni = p.ni
                                         AND p.fdat <= :fdat_
                                       GROUP BY j.ni, j.sava, j.dava + k.srok, p.fdat
                                       ORDER BY j.ni';

  txt_sql2         varchar2(1000) := 'select FDAT, LIM
                                       from OTCN_LIM_SB
                                       where acc=:acc_
                                         and fdat >= :fdat_
                                       ORDER BY 1 desc';

  txt_sql3         varchar2(1000) := 'select d_plan, sv - nvl(sz, ''0'')
                                       from OTC_ARC_CC_TRANS
                                       where dat_otc = :dat_ 
                                         and acc=:acc_
                                         and (d_fakt is null or sv<>sz)
                                         and fdat <= :dat_
                                       ORDER BY 1 desc'; 

  txt_sql4         varchar2(1000) := 'select c.dok, c.nom
                                     from cp_deal d, cp_dat c, accounts a
                                      where d.acc = :acc_ and
                                            d.id = c.id and
                                            c.nom <> 0 and
                                            c.dok >= :dat_ and
                                            d.acc = a.acc
                                    ORDER BY 1';


  txt_sql5         varchar2(1000) := 'SELECT o.fdat, o.s sump, n.nd 
                                        FROM nd_acc n, cc_add ad, opldok o
                                        WHERE n.acc = :acc_ and
                                            n.nd = ad.nd and 
                                            o.fdat > :dat_ and
                                            o.acc = n.acc and
                                            o.tt = ''GPP'' AND 
                                            o.sos = 3 and
                                            ad.refp = o.REF AND 
                                            o.dk = 1'; --

  txt_sql7         varchar2(2000) :=
             'SELECT NVL( (SELECT MIN (fdat)
                             FROM cc_lim
                            WHERE nd = x.nd and fdat >= x.dat31
                              and fdat between x.fdat-3 and x.fdat+3
                              and NVL (NOT_SN, 0) <> 1),
                           a.mdate)  fdat,
                     x.sump1 S, x.nd
                FROM accounts a,
                     sno_gpp x
               WHERE x.acc = a.acc
                 and x.acc = :acc_ 
                 and x.fdat > :dat_ ' ;

  TYPE ref_type_curs IS REF CURSOR;

  fakt_curs     ref_type_curs;
  sb_curs       ref_type_curs;
  trans_curs    ref_type_curs;
  restr_curs    ref_type_curs;
  
  i_sava    number;
  i_pava    number;
  i_dpava   date;
  i_mdate   date;
  i_ni      number;
  odat_     date:=nvl(pdat_, fdat_);
  pog_      number;

  zn_       number;
  pr_trans_ number:=0;
  comm_     varchar2(255);
  i_lim     number;
  i_limp    number;
-------
   PROCEDURE DEL(N_ IN NUMBER, DAT_ IN DATE, i OUT tp_240 ) IS
     GOD_   INT := MOD(TO_NUMBER(TO_CHAR(DAT_,'YYYY')),4) ;
     delta_ INT := DAT_- ODAT_;
     NN_    NUMBER;
     god1_    NUMBER;
     god2_    NUMBER;
     year_    NUMBER;
     add_ NUMBER := 0;

     BEGIN
        i := tp_240(NULL, NULL, NULL, NULL, NULL, NULL);
        
        NN_ := nvl(N_, 0);

        IF odat_ < zm_date_ THEN
           god1_ := TO_NUMBER(TO_CHAR(odat_, 'yyyy'));
           god2_ := TO_NUMBER(TO_CHAR(dat_, 'yyyy'));

           IF Delta_ IS NULL  THEN
              N0_:=N0_+ NN_;
              i.S240 := 0;
              i.s242 := 0;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_<=  0     THEN
              N1_:=N1_+ NN_;
              i.S240 := 1;
              i.s242 := 5;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ =  1     THEN
              N2_:=N2_+ NN_;
              i.S240 := 2;
              i.s242 := 5;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ <  8     THEN
              N3_:=N3_+ NN_;
              i.S240 := 3;
              i.s242 := 5;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ < 22     THEN
              N4_:=N4_+ NN_;
              i.S240 := 4;
              i.s242 := 5;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ < 32     THEN
              N5_:=N5_+ NN_;
              i.S240 := 5;
              i.s242 := 5;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ < 93     THEN
              N6_:=N6_+ NN_;
              i.S240 := 6;
              i.s242 := 6;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ <184     THEN
              N7_:=N7_+ NN_;
              i.S240 := 7;
              i.s242 := 8;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  (delta_ <366 AND GOD1_<>0 AND GOD2_<>0) OR
                  (delta_<=366 AND (GOD1_= 0 OR GOD2_=0)) THEN
              N8_:=N8_+ NN_;
              i.S240 := 8;
              i.s242 := 8;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSE
              N9_:=N9_+ NN_;
              i.S240 := 9;
              i.s242 := 9;
              i.ost := NN_;
              i.ldate := DAT_;
           END IF;
        ELSE
           year_ := MONTHS_BETWEEN(dat_, odat_)/12;

           IF year_ >= 1 THEN -- может быть 1 и больше высокосных годов
              god1_ := TO_NUMBER(TO_CHAR(odat_, 'yyyy'));
              god2_ := TO_NUMBER(TO_CHAR(dat_, 'yyyy'));

              FOR i IN god1_..god2_ LOOP
                  god_ := MOD(i, 4);

                 IF (god_ = 0 and i <> god1_ and i <> god2_) OR
                     (god_ = 0 AND (
                    (i = god1_ AND odat_ < TO_DATE('2902'||TO_CHAR(i), 'ddmmyyyy')) OR
                    (i = god2_ AND dat_ >= TO_DATE('2902'||TO_CHAR(i), 'ddmmyyyy')))) THEN
                    add_ := add_ + 1;
                 END IF;
              END LOOP;
           END IF;
           
           IF Delta_ IS NULL  THEN
              N0_:=N0_+ NN_;
              i.S240 := 0;
              i.s242 := 0;
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_<=  0     THEN
              N1_:=N1_+ NN_;
              
              IF odat_ < zm_date2_ THEN
                  i.S240 := '1';
                  i.s242 := '5';
              else
                  if delta_ < 0 then
                     if fdatb_ is not null and fdate_ is not null and
                        mdate_ between fdatb_ and fdate_ or
                        dat_ = fdat_ 
                     then 
                         i.S240 := '1'; 
                         i.s242 := '5';
                     else
                         i.S240 := 'Z'; 
                         i.S242 := 'Z'; 
                     end if;
                  else
                     i.S240 := '1'; 
                     i.s242 := '5';
                  end if;
              end if;
              
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ =  1     THEN
              N2_:=N2_+ NN_;
              i.S240 := '2';
              i.s242 := '5';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ <  8     THEN
              N3_:=N3_+ NN_;
              i.S240 := '3';
              i.s242 := '5';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ < 22     THEN
              N4_:=N4_+ NN_;
              i.S240 := '4';
              i.s242 := '5';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ < 32     THEN
              N5_:=N5_+ NN_;
              i.S240 := '5';
              i.s242 := '5';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ < 93     THEN
              N6_:=N6_+ NN_;
              i.S240 := '6';
              i.s242 := '6';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ <184     THEN
              N7_:=N7_+ NN_;
              i.S240 := '7';
              i.s242 := '8';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ <275     THEN
              N8_:=N8_+ NN_;
              i.S240 := 'A';
              i.s242 := '8';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ <366 + add_ THEN
              N9_:=N9_+ NN_;
              i.S240 := 'B';
              i.s242 := '8';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF  delta_ <=548 + add_ THEN
              N10_:=N10_+ NN_;
              i.S240 := 'C';
              i.s242 := '8';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF year_ <= 2 THEN
              N11_:=N11_+ NN_;
              i.S240 := 'D';
              i.s242 := '9';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF year_ <= 3 THEN
              N12_:=N12_+ NN_;
              i.S240 := 'E';
              i.s242 := '9';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF year_ <= 5 THEN
              N13_:=N13_+ NN_;
              i.S240 := 'F';
              i.s242 := '9';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSIF year_ <= 10 THEN
              N14_:=N14_+ NN_;
              i.S240 := 'G';
              i.s242 := '9';
              i.ost := NN_;
              i.ldate := DAT_;
           ELSE
              N15_:=N15_+ NN_;
              i.S240 := 'H';
              i.s242 := '9';
              i.ost := NN_;
              i.ldate := DAT_;
           END IF;

        END IF;

     i.nd := nd_;
     i.comm := comm_;
END DEL;
----
BEGIN
   IF VST_=0 THEN RETURN; END IF;

   BEGIN
      -- код валюты счета
      SELECT a.nls, a.kv, NVL(a.mdate, mdate_), nbs, rnk
      INTO nls_a7_, kv1_, mdate_acc_, nbs_, rnkd_
      FROM ACCOUNTS a
      WHERE a.acc=acc_;
   EXCEPTION WHEN NO_DATA_FOUND THEN  DEL(VST_,MDATE_, i); pipe ROW(i); RETURN;
   END;
   
   mdate_acc_ := nvl(f_mdate_hist(acc_, fdat_), mdate_); 

   IF kv1_ <> 980 THEN -- в эквиваленте
      ost_ := Gl.P_Icurval(kv1_, vst_, fdat_);
   ELSE
      ost_ := vst_;
   END IF;

   if nbs_ = '2030' and substr(fakt_,1,1) = '1' then -- смотрим модуль факторинга
       BEGIN
          ost_ := -1 * ost_;
          
          if pnd_ is not null then
             nd_ := pnd_;
          else
              SELECT n.nd
                INTO nd_
                FROM nd_acc n
               WHERE n.acc = acc_;
          end if;
          
          comm_ := 'з модулю факторинга';

          open fakt_curs
          for txt_sql using nd_, rnkd_, odat_;

          LOOP
               FETCH fakt_curs into i_ni, i_sava, i_mdate, i_pava, i_dpava;
             EXIT WHEN fakt_curs%NOTFOUND;

             IF ost_ > 0
             THEN
                IF i_dpava is not null and i_dpava <= odat_
                THEN
                   if i_sava >= i_pava then
                      l_ := i_sava - i_pava;
                   else
                      l_ := i_sava;
                   end if;
                ELSE
                   l_ := i_sava;
                END IF;

                l_ := LEAST (ost_, l_);
                ost_ := ost_ - l_;

                DEL(-1 * L_, i_mdate, i);
                pipe ROW(i);

             END IF;
          END LOOP;

          close fakt_curs;
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
               comm_ := 'без модулю';

               IF ost_ <> 0
               THEN
                    DEL(-1 * ost_, mdate_, i);
                    pipe ROW(i);
               END IF;
       END;
   elsif (nbs_ in ('2701', '3660', '3648') or
          substr(nls_a7_,1,4) in ('1410','1413','1414','3112','3113','3114')) and substr(fakt_,2,1) = '1' then
       open sb_curs
       for txt_sql2 using acc_, odat_;

       if substr(nls_a7_,1,4) in ('1410','1413','1414','1418','2068','3112','3113','3114') then
          zn_ := -1;
       else
          zn_ := 1;
       end if;

       ost_ := zn_ * ost_;

       comm_ := 'розбивка по OTCN_LIM_SB';

       LOOP
          FETCH sb_curs into i_mdate, pog_;
          EXIT WHEN sb_curs%NOTFOUND;

          L_ := least(Gl.P_Icurval(kv1_, pog_, fdat_), OST_);

          IF L_ > 0 AND (OST_ -L_)>=0 THEN
             DEL(zn_ * L_, i_mdate, i);
             pipe ROW(i);

             OST_:= OST_ - L_;
          END IF;
       END LOOP;

       close sb_curs;

       IF ost_ >0 THEN 
          if abs(ost_)<=100 then -- вирівнювання 
             DEL(zn_ * OST_, i_mdate, i);  
             pipe ROW(i); 
          else  
             DEL(zn_ * OST_, MDATE_, i);  
             pipe ROW(i); 
          END IF;
       end if;
   elsif substr(fakt_,4,1) = '1' then -- платіжний календар по ЦП
       open sb_curs
       for txt_sql4 using acc_, odat_;

       comm_ := 'розбивка по платіжному календарю ЦП';
       
       declare
          id_       number;
          nom_      number;
          ldok_      date;
       begin
          select p.id, c.cena, c.dok, nvl(d.nom,0) nom
          into id_, dost_, ldok_, nom_
          from cp_deal p, cp_kod c, cp_dat d
          where p.acc = acc_ and
                p.id = c.id and
                c.id = d.id and
                c.datp = D.DOK; 
          
          if nom_ = 0 then
             select nvl(sum(nom), 0)
             into rizn_
             from cp_dat
             where id = id_ and
                dok > ldok_;
             
             rizn_ := dost_ - rizn_;
          end if; 
       exception
          when no_data_found then
             select nvl(sum(c.nom), 0), 0 rizn
             into dost_, rizn_
             from cp_deal p, cp_dat c
             where p.acc = acc_ and
                p.id = c.id;
       end;
       
       zn_ := -1;
       ost_ := zn_ * ost_;
       
       if dost_ <> 0 then
           rizn_ := round(ost_ * (rizn_ / dost_), 0);

           LOOP
              FETCH sb_curs into i_mdate, pog_;
              EXIT WHEN sb_curs%NOTFOUND;
              
              pr_ := pog_ / dost_;
              
              L_ := round(ost_ * pr_, 0);

              IF L_ > 0  AND (OST_ -L_)>=0 THEN
                 DEL(zn_ * L_, i_mdate, i);
                 pipe ROW(i);
              END IF;
           END LOOP;
       end if;
       
       close sb_curs;
       
       ost_ := rizn_;

       IF ost_ >0 THEN 
          if abs(ost_)<=100 then -- вирівнювання 
             DEL(zn_ * OST_, i_mdate, i);  
             pipe ROW(i); 
          else  
             DEL(zn_ * OST_, MDATE_, i);  
             pipe ROW(i); 
          END IF;
       end if;
   elsif substr(fakt_,5,1) = '1' or substr(fakt_,7,1) = '1' then
       if substr(fakt_,5,1) = '1' then
           open restr_curs
           for txt_sql5 using acc_, odat_;
           
           comm_ := 'реструктуризація відсотків v1';
       else
           open restr_curs
           for txt_sql7 using acc_, odat_;
           
           comm_ := 'реструктуризація відсотків v2';
       end if;
       
       zn_ := -1;

       ost_ := zn_ * ost_;
       
       LOOP
          FETCH restr_curs into i_mdate, pog_, nd_;
          EXIT WHEN restr_curs%NOTFOUND;

          L_ := least(Gl.P_Icurval(kv1_, pog_, fdat_), OST_);

          IF L_ > 0 AND (OST_ -L_)>=0 THEN
             DEL(zn_ * L_, i_mdate, i);
             pipe ROW(i);

             OST_:= OST_ - L_;
          END IF;
       END LOOP;

       close restr_curs;

       IF ost_ >0 THEN DEL(zn_ * OST_, MDATE_, i);  pipe ROW(i); END IF;
   elsif substr(fakt_,6,1) = '1' then --міжбанківські кред/деп
       comm_ := 'міжбанківські кред/деп';
       
       nd_ := pnd_;
       
       zn_ := 1;

       ost_ := zn_ * ost_;

       BEGIN
          -- код валюты договора
          SELECT d.kv 
          INTO  kv2_
          FROM CC_ADD d
          WHERE d.nd=nd_ AND
                d.ADDS=0;
       EXCEPTION WHEN NO_DATA_FOUND THEN  DEL(OST_,MDATE_, i); pipe ROW(i); RETURN;
       END;

       FOR k IN (SELECT Gl.P_Icurval(kv2_, lim2, fdat_) lim2, 
                        Gl.P_Icurval(kv2_, sumg, fdat_) sumg,
                        FDAT
                 FROM OTC_ARC_CC_LIM
                 WHERE dat_otc = pdat_ and
                       nd=ND_ AND
                       FDAT BETWEEN FDAT_+1 AND mdate_acc_ 
                 ORDER BY FDAT)
       LOOP
--          if k.lim2 - ost_ < 0 then 
          i_mdate := k.fdat;
          pog_ := k.sumg;
     
          L_ := Gl.P_Icurval(kv1_, pog_, fdat_);

          IF L_ > 0 and  OST_ - L_ >= 0 THEN
             DEL(zn_ * L_, i_mdate, i);
             pipe ROW(i);

             OST_:= OST_ - L_;
          END IF;
--          end if;
       END LOOP;

       IF ost_ >0 THEN 
          if abs(ost_)<=100 then -- вирівнювання 
             DEL(zn_ * OST_, i_mdate, i);  
             pipe ROW(i); 
          else  
             DEL(zn_ * OST_, MDATE_, i);  
             pipe ROW(i); 
          END IF;
       end if;
   else -- смотрим графики погашения
       BEGIN
          --есть ли в КП е есть ли ГПК  и какой вид договора
          SELECT n.nd, c.VIDD
          INTO ND_, vidd_
          FROM ND_ACC n, OTC_ARC_CC_LIM l, cc_deal c
          WHERE n.acc=ACC_ AND
                l.dat_otc = pdat_ and
                n.nd=l.nd AND
                (l.nd,l.FDAT)=(SELECT nd, MIN(FDAT)
                               FROM OTC_ARC_CC_LIM
                               WHERE dat_otc = pdat_ and
                                     nd=l.ND AND
                                     FDAT>=odat_
                               GROUP BY nd) and
                 n.nd = c.nd and
                 c.sos in (10, 13);
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
              begin
                  SELECT n.nd, c.VIDD
                  INTO ND_, vidd_
                  FROM ND_ACC n, OTC_ARC_CC_LIM l, cc_deal c
                  WHERE n.acc=ACC_ AND
                        l.dat_otc = pdat_ and
                        n.nd=l.nd AND
                        (l.nd,l.FDAT)=(SELECT nd, MIN(FDAT)
                                       FROM OTC_ARC_CC_LIM
                                       WHERE dat_otc = pdat_ and
                                             nd=l.ND AND
                                             FDAT>=odat_
                                       GROUP BY nd) and
                         n.nd = c.nd;
           EXCEPTION
              WHEN NO_DATA_FOUND THEN
                  begin
                      SELECT n.nd, c.VIDD
                      INTO ND_, vidd_
                      FROM ND_ACC n, OTC_ARC_CC_LIM l, cc_deal c
                      WHERE n.acc=ACC_ AND
                            l.dat_otc = pdat_ and
                            n.nd=l.nd AND
                            (l.nd,l.FDAT)=(SELECT nd, MAX(FDAT)
                                           FROM OTC_ARC_CC_LIM
                                           WHERE dat_otc = pdat_ and
                                                 nd=l.ND AND
                                                 FDAT<odat_
                                           GROUP BY nd) and
                             n.nd = c.nd;
                  EXCEPTION WHEN NO_DATA_FOUND THEN DEL(OST_,MDATE_, i); pipe ROW(i); RETURN;
                            WHEN too_many_rows then raise_application_error(-20001, 'Счет: '||nls_a7_||' вал. '||to_char(kv1_));
                  end;
              WHEN too_many_rows then raise_application_error(-20001, 'Счет: '||nls_a7_||' вал. '||to_char(kv1_));
              end;
          WHEN too_many_rows then raise_application_error(-20001, 'Счет: '||nls_a7_||' вал. '||to_char(kv1_));
       END;

       -- якщо кредитна лінія та є транші, то шукаємо чи можемо по них розбити щалишок
       if vidd_ in (2, 3, 12, 13) and substr(fakt_,3,1) = '1' then
          pr_trans_ := 1;
       else
          pr_trans_ := 0;
       end if;

       if pr_trans_ <> 0 then -- по таблиці траншів розбиваємо
           open trans_curs
           for txt_sql3 using pdat_, acc_, pdat_;

           comm_ := 'розбивка по траншах';

           zn_ := -1;

           ost_ := zn_ * ost_;

           LOOP
              FETCH trans_curs into i_mdate, pog_;
              EXIT WHEN trans_curs%NOTFOUND;

              L_ := least(Gl.P_Icurval(kv1_, pog_, fdat_), OST_);

              IF L_ > 0 AND (OST_ -L_)>=0 THEN
                 DEL(zn_ * L_, i_mdate, i);
                 pipe ROW(i);

                 OST_:= OST_ - L_;
              END IF;
           END LOOP;

           close trans_curs;

           IF ost_ >0 THEN 
              if abs(ost_)<=100 then -- вирівнювання 
                 DEL(zn_ * OST_, i_mdate, i);  
                 pipe ROW(i); 
              else  
                 DEL(zn_ * OST_, MDATE_, i);  
                 pipe ROW(i); 
              END IF;
           end if;
       else -- пробуємо по графіку розбити
           if nd_ is not null then
              comm_ := 'розбивка по графіку';
           else
              comm_ := 'не знайдено РЕФ КД';
           end if;
           
           if nd_ is not null then
               BEGIN
                  -- код валюты договора
                  SELECT d.kv 
                  INTO  kv2_
                  FROM CC_ADD d
                  WHERE d.nd=nd_ AND
                        d.ADDS=0;
               EXCEPTION WHEN NO_DATA_FOUND THEN  DEL(OST_,MDATE_, i); pipe ROW(i); RETURN;
               END;

               BEGIN
                  -- непогашенный остаток по договору (без учета просрочки)
                   if typen_ = 1 then
                      select /*+leading(n)*/
                          sum(b.ostq) ost
                      into dost_
                      FROM snap_balances b, tmp_kod_r020 t, accounts s, ND_ACC n
                      WHERE n.nd=nd_ and
                            n.acc = s.acc  AND
                            s.nbs = t.r020 and
                            trim(s.tip) in ('SS', 'CR9') and
                            s.acc = b.acc and
                            b.fdat = fdat_ ;      
                   else
                      select /*+leading(n)*/
                          sum(b.ostq) ost
                      into dost_
                      FROM snap_balances b, tmp_kod_r020 t, accounts s, ND_ACC n
                      WHERE n.nd=nd_ and
                            n.acc = s.acc  AND
                            s.nbs = t.r020 and
                            trim(s.tip) in ('SS') and
                            s.acc = b.acc and
                            b.fdat = fdat_ ;                             
                   end if;
               EXCEPTION WHEN NO_DATA_FOUND THEN  DEL(OST_,MDATE_, i); pipe ROW(i); RETURN;
               END;
           else
               DEL(OST_,MDATE_, i); pipe ROW(i); RETURN;
           end if;

           -- якщо рахунок активу не один (графік будується по кредиту в цілому,а не по кожному рахунку активу)
           IF dost_ <> ost_ AND dost_<> 0 THEN
             pr_ := ost_ / dost_;
           ELSE
             pr_ := 1;
           END IF;

           FOR k IN (SELECT nvl(Gl.P_Icurval(kv2_, lim2, fdat_), 0) lim2, FDAT
                     FROM OTC_ARC_CC_LIM
                     WHERE dat_otc = pdat_ and
                           nd=ND_ AND
                           FDAT BETWEEN FDAT_ AND mdate_acc_ 
                     ORDER BY FDAT)
           LOOP
              L_:= nvl(ROUND(LEAST(0, k.LIM2 + DOST_) * pr_ , 0),0);
              i_lim := k.LIM2;
              
              if (nvl(L_, 0) <> 0 or nvl(OST_ - L_, 0) <> 0) and 
                 (nvl(i_lim, 0) <> 0 or nvl(i_limp, 0) <> 0) 
              then
                 i_mdate := k.fdat;
              end if;
              
              IF L_ < 0 AND (OST_ - L_)<=0 THEN
                 DEL(L_,k.FDAT, i);
                 
                 pipe ROW(i);

                 OST_:= OST_ - L_;
                 DOST_:= (-1) * k.lim2;
              END IF;

              cnt_ := cnt_ + 1;
              i_limp := i_lim;
           END LOOP;
       end if;
   end if;

   IF fdat_ < zm_date_ THEN
      -- погрешность округления
      rizn_ := Gl.P_Icurval(kv1_, vst_, fdat_) -
              (N0_ + N1_ + N2_ + N3_ + N4_ +  N5_  + N6_ + N7_ + N8_ + N9_);
   ELSE
      -- погрешность округления
      rizn_ := Gl.P_Icurval(kv1_, vst_, fdat_) -
              (N0_+N1_+N2_+N3_+N4_+N5_+N6_+N7_+N8_+N9_+N10_+N11_+N12_+N13_+N14_+N15_);
   END IF;

   IF rizn_ <> 0 THEN
      i.ost := rizn_;
      i.ldate := nvl(i_mdate, MDATE_);
      pipe ROW(i);
   END IF;

   RETURN;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cck_otcn.sql =========*** End ***
 PROMPT ===================================================================================== 
 