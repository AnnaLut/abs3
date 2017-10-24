

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FORMA520.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FORMA520 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FORMA520 ( DateStart VARCHAR2, DateEnd VARCHAR2, NLS_Mask VARCHAR2, tt_ VARCHAR2 )
-- *****************************************************************************************************
-- *
-- * Выборка данных для печатного отчета
-- * "Сальдівка в номіналі за перiод по ВАЛ рах.(форма 520)"
-- *
-- * Используемые параметры :
-- *    fDat1_      - дата начала периода
-- *    fDat2_      - дата конца периода
-- *    NLS_Mask    - маска счета
-- *    tt_         - операции ввода, которые нужно использовать для выборки данных
-- *
-- * Макаренко И.В. (февраль 2010 г.)
-- *
-- *****************************************************************************************************
IS
  nls_          VARCHAR2(14);
  kv_           NUMBER(3);
  In_Ostatok    NUMBER(24);
  Out_Ostatok   NUMBER(24);
  nms_          VARCHAR2(38);
  dos_          NUMBER(24);
  kos_          NUMBER(24);
  summa_        NUMBER(24);
  UserID_       NUMBER;
  nls_mask_     VARCHAR2(14);
  tt_mask_      VARCHAR2(100);
  fDat1_        DATE;
  fDat2_        DATE;

BEGIN
  -------------------------------------------------------------------
  SELECT id INTO UserID_ FROM staff WHERE upper(logname)=upper(USER);
  DELETE FROM TMP_FORMA520 WHERE userid = UserID_;
  -------------------------------------------------------------------

  fDat1_ := to_date(DateStart,'DD/MM/YYYY');
  fDat2_ := to_date(DateEnd,  'DD/MM/YYYY');

  IF NLS_Mask IS NULL THEN
    nls_mask_ := '%';
  ELSE
    nls_mask_ := trim(replace(NLS_Mask,'*','%'));
  END IF;

  -- выборка данных по маске счета без учета операций ввода
  IF tt_ IS NULL THEN
    FOR i IN ( SELECT acc, nls, kv, nms
                 FROM accounts
                WHERE (dazs is null OR dazs>=fDat1_)
                  AND kv <> 980
                  AND nls like nls_mask_ )
    LOOP
      SELECT nvl(fost(acc,fDat1_)+fdos(acc,fDat1_,fDat2_)-fkos(acc,fDat1_,fDat2_),0),
             nvl(fost(acc,fDat1_),0),
             nvl(fdos(acc,fDat1_,fDat2_),0),
             nvl(fkos(acc,fDat1_,fDat2_),0)
      INTO In_Ostatok, Out_Ostatok, dos_, kos_
      FROM accounts WHERE acc = i.acc;
      IF In_Ostatok <> 0 or Out_Ostatok <> 0 or dos_ <> 0 or kos_ <> 0 THEN
      INSERT INTO TMP_FORMA520 (userid,  date1, date2,   nls,   kv,   nms,
                                in_ost, dos, kos, out_ost)
                         VALUES(UserID_,fDat1_,fDat2_, i.nls, i.kv, substr(i.nms,1,38),
                                In_Ostatok, dos_, kos_, Out_Ostatok);
      END IF;
    END LOOP;
  END IF;

  -- выборка данных по маске счета c учетом операций ввода
  IF tt_ IS NOT NULL THEN
    tt_mask_ := trim(tt_);
    FOR i IN ( SELECT sel1.nls,
                      sel1.kv,
                      sum(sel1.sale) SALE_,
                      sum(sel1.buy) BUY_ ,
                      sel1.nms
                 FROM ( SELECT nls, kv, decode(dk,0, sum(s), 0) SALE,
                                        decode(dk,1, sum(s), 0) BUY,
                               nms
                          FROM opl
                         WHERE ref IN ( SELECT ref
                                          FROM oper
                                         WHERE sos = 5
                                           AND kv <> 980
                                           AND ( tt IN ( SUBSTR(tt_mask_,1,3), SUBSTR(tt_mask_,5,3) ) )
                                           AND datd BETWEEN fDat1_ AND fDat2_
                                       )
                           AND kv <> 980
                         GROUP BY nls, kv, dk, nms ) sel1
                GROUP BY sel1.nls, sel1.kv, sel1.nms
             )
    LOOP
      INSERT INTO TMP_FORMA520 (userid,  date1, date2,   nls,   kv,   nms,
                                in_ost, dos, kos, out_ost)
                         VALUES(UserID_,fDat1_,fDat2_, i.nls, i.kv, substr(i.nms,1,38),
                                In_Ostatok, i.SALE_, i.BUY_, Out_Ostatok);
    END LOOP;
  END IF;

END P_FORMA520;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FORMA520.sql =========*** End **
PROMPT ===================================================================================== 
