

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZVIT2625.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZVIT2625 ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZVIT2625 ( Mode_ VARCHAR2,
                                             Dat1_ VARCHAR2,
                                             Dat2_ VARCHAR2,
                                             Insider_ VARCHAR2,
                                             UserID_  VARCHAR2 ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования печатных отчетов по служебной 
%               записке ГОУ от 20/01/2011 № 16/3-79    
% COPYRIGHT   : Макаренко И.В. 2011-
% VERSION     : 25.01.2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Mode_ - режим 
           Dat1_ - начало отчетного периода
           Dat2_ - конец отчетного периода
           Insider_ - признак инсайдера (0-Да;1-Нет)
           UserID_ - код пользователя
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  UserFIO     VARCHAR2(70);
  Period_     VARCHAR2(35);
  rnk_        customer.rnk%type;
  nmk_        customer.nmk%type;
  prinsider_  NUMBER;
  nlsd_       VARCHAR2(14);
  nlsk_       VARCHAR2(14);
  kv_         NUMBER;
  summa_      NUMBER;
  sq_         NUMBER;
  nazn_         provodki.nazn%type;
  nd_         VARCHAR2(20);
  isp_        NUMBER;
  debs_         NUMBER;
  debsq_        NUMBER;
  kres_         NUMBER;
  kresq_        NUMBER;
--=============================================================--
CURSOR Incomings IS
  -- выборка проводок по доходам (проценты, комиссионные)  
  -- Дт 2208402     - Кт 6040
  --    22086000037 - Кт 6042
  --   -"-          - Кт 6110
  --   -"-          - Кт 6119 
  -- Дт 2625 - Кт 2208402
  --   -"-   - Кт 22086000037
  --   -"-   - Кт 6040
  --   -"-   - Кт 6042
  --   -"-   - Кт 6110
  --   -"-   - Кт 6119 
  SELECT c1.rnk,
         c1.nmk,
         c1.prinsider,
         s.nkd, 
         p.nlsd, 
         p.nlsk, 
         p.kv, 
         p.s,
         p.sq,
         a.isp
    FROM provodki p, 
         accounts a, 
         customer c1,
         specparam s
   WHERE p.fdat BETWEEN TO_DATE(Dat1_,'DD/MM/YYYY')
                    AND TO_DATE(Dat2_,'DD/MM/YYYY')
     AND ( 
           ( SUBSTR(p.nlsd,1,4) in ('2625','3570')
--             AND (p.nlsk IN ('2208402', '22086000037') 
--             AND (p.nlsk LIKE '2208%' 
--                  or SUBSTR(p.nlsk,1,4) IN ('6040','6042','6110','6119') )
             AND SUBSTR(p.nlsk,1,2) = '61' )  
--          OR
--           ( p.nlsd IN ('2208402', '22086000037')
--           ( p.nlsd LIKE '2208%'
--             AND SUBSTR(p.nlsk,1,4) IN ('6040','6042','6110','6119')
--           )
         )        
     AND p.nlsd = a.nls
     AND p.kv   = a.kv
     AND a.rnk  = c1.rnk
     AND a.acc  = s.acc 
     AND c1.custtype = 3;
--=============================================================--
CURSOR Outgoings IS
  -- выборка проводок по затратам (проценты)  
  -- Дт (7040,7041) - Кт (2625,2628)
  SELECT c1.rnk,
         c1.nmk,
         c1.prinsider,
         s.nkd, 
         p.nlsd, 
         p.nlsk, 
         p.kv, 
         p.s,
         p.nazn,
         p.sq,
         a.isp
    FROM provodki p, 
         accounts a, 
         customer c1,
         specparam s
   WHERE p.fdat BETWEEN TO_DATE(Dat1_,'DD/MM/YYYY')
                    AND TO_DATE(Dat2_,'DD/MM/YYYY')
     AND SUBSTR(p.nlsd,1,4) in ('7040','7041')
     AND SUBSTR(p.nlsk,1,4) in ('2625','2628')
     AND p.nlsk = a.nls
     AND p.kv   = a.kv
     AND a.rnk  = c1.rnk
     AND a.acc  = s.acc 
     AND c1.custtype = 3;
--=============================================================--
CURSOR TurnOver IS
  -- выборка оборотов Дт/Кт по балансовым счетам 2202,2203,2638,9129 
  SELECT c1.rnk,
         c1.nmk,
         c1.prinsider,
         s.nkd,
         a.nls,
         a.kv,
/*         
         nvl(fdos (a.acc,TO_DATE(Dat1_,'DD/MM/YYYY'),
                         TO_DATE(Dat2_,'DD/MM/YYYY')),0) DebObVal,
         nvl(fdosq(a.acc,TO_DATE(Dat1_,'DD/MM/YYYY'),
                         TO_DATE(Dat2_,'DD/MM/YYYY')),0) DebObUAH,
         nvl(fkos (a.acc,TO_DATE(Dat1_,'DD/MM/YYYY'),
                         TO_DATE(Dat2_,'DD/MM/YYYY')),0) KreObVal,         
         nvl(fkosq(a.acc,TO_DATE(Dat1_,'DD/MM/YYYY'),
                         TO_DATE(Dat2_,'DD/MM/YYYY')),0) KreObUAH,         
*/         
         s2.dos                             DebObVal,
         gl.p_icurval(s2.kv,s2.dos,s2.fdat) DebObUAH,
         s2.kos                             KreObVal,
         gl.p_icurval(s2.kv,s2.kos,s2.fdat) KreObUAH,
         a.isp
    FROM accounts a, 
         customer c1,
         specparam s,
         sal s2
   WHERE substr(a.nls,1,4) IN ('2202','2203','2638','9129')
     AND a.rnk = c1.rnk
     AND a.acc = s.acc
     AND a.acc = s2.acc
     AND a.kv  = s2.kv
     AND c1.custtype = 3
     AND s2.fdat BETWEEN TO_DATE(Dat1_,'DD/MM/YYYY')
                     AND TO_DATE(Dat2_,'DD/MM/YYYY');               
--=============================================================--
  
-----------------------------------------------------------------
--                                                             --
--                    Начало тела процедуры                    --  
--                                                             --
-----------------------------------------------------------------
BEGIN

  ---------------------------------------------------------
  DELETE FROM tmp_zvit2625;
  ---------------------------------------------------------

  Period_ := 'з ' || Dat1_ || ' р. по ' || Dat2_ || ' р.';

  IF to_number(Insider_) NOT IN (0,1) OR Insider_ IS NULL THEN
    nmk_ := 'Не вказано ознаку інсайдера !!!';
    INSERT INTO tmp_zvit2625(nmk) VALUES (nmk_);
    COMMIT;
    RETURN;
  END IF;
  
  IF UserID_ IS NULL OR (UserID_<>'*' AND to_number(UserID_)<0) THEN
    nmk_ := 'Не вказано ознаку виконавця !!!';
    INSERT INTO tmp_zvit2625(nmk) VALUES (nmk_);
    COMMIT;
    RETURN;
  END IF;

  -- отчет по доходам --
  
  IF Mode_ = 1 THEN
    OPEN Incomings;
    LOOP
      FETCH Incomings INTO rnk_, nmk_, prinsider_, nd_, nlsd_, nlsk_, kv_, summa_, sq_, isp_;
      EXIT WHEN Incomings%NOTFOUND;
      IF Insider_ = 1 THEN          
        -- выбираем информацию по инсайдерам --
        IF prinsider_ IN (1,2,3,4,5) THEN
          IF UserID_ = '*' THEN       
            -- выбираем информацию по всем исполнителям --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=isp_;
            INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                       RNK, NMK, INSIDER, ND, NLSD, NLSK, KV,                               
                                       VAL_SUMMA1, UAH_SUMMA1 )
                              VALUES ( Period_, isp_, UserFIO,
                                       rnk_, nmk_, 1, nd_, nlsd_, nlsk_, kv_,
                                       summa_, sq_ );
            ELSE
            -- выбираем информацию по указанному исполнителю --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=UserID_;
            IF isp_ = UserID_ THEN
              INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                         RNK, NMK, INSIDER, ND, NLSD, NLSK, KV,                                   
                                         VAL_SUMMA1, UAH_SUMMA1 )
                                VALUES ( Period_, UserID_, UserFIO,
                                         rnk_, nmk_, 1, nd_, nlsd_, nlsk_, kv_,
                                         summa_, sq_ );
            END IF;
          END IF;
        END IF;  
      ELSE  
        -- выбираем информацию по НЕинсайдерам --
        IF prinsider_ NOT IN (1,2,3,4,5) THEN
          IF UserID_ = '*' THEN       
            -- выбираем информацию по всем исполнителям --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=isp_;
            INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                       RNK, NMK, INSIDER, ND, NLSD, NLSK, KV,                                   
                                       VAL_SUMMA1, UAH_SUMMA1 )
                              VALUES ( Period_, isp_, UserFIO,
                                       rnk_, nmk_, 0, nd_, nlsd_, nlsk_, kv_,
                                       summa_, sq_ );
          ELSE
            -- выбираем информацию по указанному исполнителю --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=to_number(UserID_);
            IF isp_ = UserID_ THEN
              INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                         RNK, NMK, INSIDER, ND, NLSD, NLSK, KV,                                   
                                         VAL_SUMMA1, UAH_SUMMA1 )
                                VALUES ( Period_, UserID_, UserFIO,
                                         rnk_, nmk_, 0, nd_, nlsd_, nlsk_, kv_,
                                         summa_, sq_ );
            END IF;
          END IF;  
        END IF;
      END IF;    
    END LOOP;
    CLOSE Incomings;
  END IF;

  -- отчет по затратам --
  
  IF Mode_ = 2 THEN
    OPEN Outgoings;
    LOOP
      FETCH Outgoings INTO rnk_, nmk_, prinsider_, nd_, nlsd_, nlsk_, kv_, summa_, nazn_, sq_, isp_;
      EXIT WHEN Outgoings%NOTFOUND;
      IF Insider_ = 1 THEN          
        -- выбираем информацию по инсайдерам --
        IF prinsider_ IN (1,2,3,4,5) THEN
          IF UserID_ = '*' THEN       
            -- выбираем информацию по всем исполнителям --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=isp_;
            INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                       RNK, NMK, INSIDER, ND, NLSD, NLSK, KV, NAZN,                                   
                                       VAL_SUMMA1, UAH_SUMMA1 )
                              VALUES ( Period_, isp_, UserFIO,
                                       rnk_, nmk_, 1, nd_, nlsd_, nlsk_, kv_, nazn_,
                                       summa_, sq_ );
            ELSE
            -- выбираем информацию по указанному исполнителю --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=UserID_;
            IF isp_ = UserID_ THEN
              INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                         RNK, NMK, INSIDER, ND, NLSD, NLSK, KV, NAZN,                                   
                                         VAL_SUMMA1, UAH_SUMMA1 )
                                VALUES ( Period_, UserID_, UserFIO,
                                         rnk_, nmk_, 1, nd_, nlsd_, nlsk_, kv_, nazn_,
                                         summa_, sq_ );
            END IF;
          END IF;
        END IF;  
      ELSE  
        -- выбираем информацию по НЕинсайдерам --
        IF prinsider_ NOT IN (1,2,3,4,5) THEN
          IF UserID_ = '*' THEN       
            -- выбираем информацию по всем исполнителям --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=isp_;
            INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                       RNK, NMK, INSIDER, ND, NLSD, NLSK, KV, NAZN,                                  
                                       VAL_SUMMA1, UAH_SUMMA1 )
                              VALUES ( Period_, isp_, UserFIO,
                                       rnk_, nmk_, 0, nd_, nlsd_, nlsk_, kv_, nazn_,
                                       summa_, sq_ );
          ELSE
            -- выбираем информацию по указанному исполнителю --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=to_number(UserID_);
            IF isp_ = UserID_ THEN
              INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                         RNK, NMK, INSIDER, ND, NLSD, NLSK, KV, NAZN,                                   
                                         VAL_SUMMA1, UAH_SUMMA1 )
                                VALUES ( Period_, UserID_, UserFIO,
                                         rnk_, nmk_, 0, nd_, nlsd_, nlsk_, kv_, nazn_,
                                         summa_, sq_ );
            END IF;
          END IF;  
        END IF;
      END IF;    
    END LOOP;
    CLOSE Outgoings;
  END IF;
  
  -- отчет по оборотам --
  
  IF Mode_ = 3 THEN
    OPEN TurnOver;
    LOOP
      FETCH TurnOver INTO rnk_, nmk_, prinsider_, nd_, nlsd_, kv_, 
                          debs_, debsq_, kres_, kresq_, isp_;
      EXIT WHEN TurnOver%NOTFOUND;
      IF Insider_ = 1 THEN          
        -- выбираем информацию по инсайдерам --
        IF prinsider_ IN (1,2,3,4,5) THEN
          IF UserID_ = '*' THEN       
            -- выбираем информацию по всем исполнителям --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=isp_;
            INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                       RNK, NMK, INSIDER, ND, NLSD, KV,                                   
                                       VAL_SUMMA1, UAH_SUMMA1, VAL_SUMMA2, UAH_SUMMA2 )
                              VALUES ( Period_, isp_, UserFIO,
                                       rnk_, nmk_, 1, nd_, nlsd_, kv_,
                                       debs_, debsq_, kres_, kresq_ );
            ELSE
            -- выбираем информацию по указанному исполнителю --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=UserID_;
            IF isp_ = UserID_ THEN
              INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                         RNK, NMK, INSIDER, ND, NLSD, KV,                                   
                                         VAL_SUMMA1, UAH_SUMMA1, VAL_SUMMA2, UAH_SUMMA2 )
                                VALUES ( Period_, UserID_, UserFIO,
                                         rnk_, nmk_, 1, nd_, nlsd_, kv_,
                                         debs_, debsq_, kres_, kresq_ );
            END IF;
          END IF;
        END IF;  
      ELSE  
        -- выбираем информацию по НЕинсайдерам --
        IF prinsider_ NOT IN (1,2,3,4,5) THEN
          IF UserID_ = '*' THEN       
            -- выбираем информацию по всем исполнителям --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=isp_;
            INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                       RNK, NMK, INSIDER, ND, NLSD, KV,                                   
                                       VAL_SUMMA1, UAH_SUMMA1, VAL_SUMMA2, UAH_SUMMA2 )
                              VALUES ( Period_, isp_, UserFIO,
                                       rnk_, nmk_, 0, nd_, nlsd_, kv_,
                                       debs_, debsq_, kres_, kresq_ );
          ELSE
            -- выбираем информацию по указанному исполнителю --
            -- получим ФИО исполнителя --
            SELECT fio INTO UserFIO FROM staff WHERE id=to_number(UserID_);
            IF isp_ = UserID_ THEN
              INSERT INTO tmp_zvit2625 ( ZVIT_PERIOD, USER_ID, USER_FIO,
                                         RNK, NMK, INSIDER, ND, NLSD, KV,                                   
                                         VAL_SUMMA1, UAH_SUMMA1, VAL_SUMMA2, UAH_SUMMA2 )
                                VALUES ( Period_, UserID_, UserFIO,
                                         rnk_, nmk_, 0, nd_, nlsd_, kv_,
                                         debs_, debsq_, kres_, kresq_ );
            END IF;
          END IF;  
        END IF;
      END IF;    
    END LOOP;
    CLOSE TurnOver;
  END IF;

END;
/
show err;

PROMPT *** Create  grants  P_ZVIT2625 ***
grant EXECUTE                                                                on P_ZVIT2625      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZVIT2625      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZVIT2625.sql =========*** End **
PROMPT ===================================================================================== 
