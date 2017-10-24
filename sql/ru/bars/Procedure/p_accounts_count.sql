

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ACCOUNTS_COUNT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ACCOUNTS_COUNT ***

  CREATE OR REPLACE PROCEDURE BARS.P_ACCOUNTS_COUNT (fdat_ in date) IS
  ID10_  number; C10_  number; D10_  number; E10_  number; F10_  number; G10_  number; H10_  number; I10_  number;  J10_  number; K10_  number;
  ID11_  number; C11_  number; D11_  number; E11_  number;
  ID12_  number; C12_  number; D12_  number; E12_  number; F12_  number; G12_  number; H12_  number; I12_  number;  J12_  number; K12_  number;
  ID13_  number; C13_  number; D13_  number; E13_  number; F13_  number; G13_  number; H13_  number; I13_  number;  J13_  number; K13_  number;
  ID14_  number; C14_  number; E14_  number; F14_  number; H14_  number; I14_  number; K14_  number;
  ID15_  number; C15_  number; D15_  number; E15_  number; F15_  number; G15_  number; H15_  number; I15_  number;  J15_  number; K15_  number;
  ID16_  number; C16_  number; D16_  number; E16_  number; F16_  number; G16_  number; H16_  number; I16_  number;  J16_  number; K16_  number;
  ID17_  number; C17_  number; E17_  number; F17_  number; H17_  number; I17_  number; K17_  number;
     -------------------------------
BEGIN
    DELETE FROM TMP_ACCOUNTS_COUNT;
    -------------------------------
    SELECT   '10', C10.CNT, D10.cnt, E10.cnt, F10.cnt, G10.cnt, H10.cnt, I10.cnt, J10.cnt, K10.cnt
      INTO  ID10_,    C10_,    D10_,    E10_,    F10_,    G10_,    H10_,    I10_,    J10_,    K10_
      FROM  (SELECT COUNT(*) CNT
               FROM ACCOUNTS
	      WHERE ( NBS in ( '2601','2602','2603','2604','2606','2640','2641','2642','2643')
	         OR ( NBS in ( '2600','2605') AND FOSTQ_S(acc, fdat_)>=0 ) )
                AND KV = 980
		AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) C10,
            (SELECT COUNT(*) CNT
	       FROM ACCOUNTS
	      WHERE ( NBS in ( '2601','2602','2603','2604','2606','2640','2641','2642','2643')
	         OR ( NBS in ( '2600','2605') and FOSTQ_S(acc, fdat_)>=0 ) )
	        AND KV <> 980
		AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) D10,
            (SELECT COUNT(*) CNT
               FROM ACCOUNTS
	      WHERE ( NBS in ( '2601','2602','2603','2604','2606','2640','2641','2642','2643')
	         OR ( NBS in ( '2600','2605') AND FOSTQ_S(acc, fdat_)>=0 ) )
                AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_
		AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0) ) E10,
            (SELECT COUNT(*) CNT
	       FROM ACCOUNTS
	      WHERE NBS in ( '2650','2655')
                AND KV=980
		AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) F10,
            (SELECT COUNT(*) CNT
	       FROM ACCOUNTS
	      WHERE NBS in ( '2650','2655')
                AND KV<>980
		AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) G10,
            (SELECT COUNT(*) CNT
	       FROM ACCOUNTS
	      WHERE NBS in ( '2650','2655')
                AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_
		AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0) ) H10,
            (SELECT COUNT(*) CNT
	       FROM ACCOUNTS
	      WHERE substr(NBS,1,2)='25'
	        AND NBS not like '25_8'
		AND (nbs not in ('2546','2625') OR (nbs='2625' and FOSTQ_S(acc, fdat_)>=0))
		AND KV=980
		AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_ ) I10,
            (SELECT COUNT(*) CNT
	       FROM ACCOUNTS
	      WHERE substr(NBS,1,2)='25'
	        AND NBS not like '25_8'
		AND (nbs not in ('2546','2625') OR (nbs='2625' and FOSTQ_S(acc, fdat_)>=0))
		AND KV<>980
		AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_ ) J10,
            (SELECT COUNT(*) CNT
	       FROM ACCOUNTS
	      WHERE substr(NBS,1,2)='25'
	        AND NBS not like '25_8'
		AND (nbs not in ('2546','2625') OR (nbs='2625' and FOSTQ_S(acc, fdat_)>=0))
		AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_
		AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0) ) K10;

      INSERT INTO TMP_ACCOUNTS_COUNT (    ID,    C,    D,    E,    F,    G,    H,    I,    J,    K )
                              VALUES ( ID10_, C10_, D10_, E10_, F10_, G10_, H10_, I10_, J10_, K10_ );
    -------------------------------
      SELECT  '11', C11.cnt, D11.cnt, E11.cnt
        INTO ID11_,    C11_,    D11_,    E11_
        FROM (SELECT COUNT(*) CNT
	        FROM ACCOUNTS
	       WHERE NBS ='2606'
	         AND KV=980
		 AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) C11,
             (SELECT COUNT(*) CNT
	        FROM ACCOUNTS
	       WHERE NBS ='2606'
	         AND KV<>980
		 AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) D11,
	     (SELECT COUNT(*) CNT
	        FROM ACCOUNTS
	       WHERE NBS ='2606'
		 AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_
		 AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0) ) E11;

      INSERT INTO TMP_ACCOUNTS_COUNT (    ID,    C,    D,    E,    F,    G,    H,    I,    J,    K )
                              VALUES ( ID11_, C11_, D11_, E11_, NULL, NULL, NULL, NULL, NULL, NULL );
    -------------------------------
       SELECT  '12', C12.CNT, D12.cnt, E12.cnt, F12.cnt, G12.cnt, H12.cnt, I12.cnt, J12.cnt, K12.cnt
         INTO  ID12_,    C12_,    D12_,    E12_,    F12_,    G12_,    H12_,    I12_,    J12_,    K12_
         FROM (SELECT COUNT(*) CNT
	         FROM ACCOUNTS
		WHERE NBS in ('2610','2615')
                  AND KV=980
		  AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) C12,
              (SELECT COUNT(*) CNT
	         FROM ACCOUNTS
		WHERE NBS in ('2610','2615')
                  AND KV<>980
		  AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_ ) D12,
              (SELECT COUNT(*) CNT
	         FROM ACCOUNTS
		WHERE NBS in ('2610','2615')
                  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_ ) E12,
              (SELECT COUNT(*) CNT
	         FROM ACCOUNTS
		WHERE NBS in ('2651','2652')
                  AND KV=980
		  AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) F12,
              (SELECT COUNT(*) CNT
	         FROM ACCOUNTS
		WHERE NBS in ('2651','2652')
                  AND KV<>980
		  AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) G12,
              (SELECT COUNT(*) CNT
	         FROM ACCOUNTS
		WHERE NBS in ('2651','2652')
                  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) H12,
	      (SELECT COUNT(*) CNT
	         FROM ACCOUNTS
		WHERE ( NBS ='2546' or (NBS='2525' and FOSTQ_S(acc, fdat_)>=0))
                  AND KV=980
		  AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) I12,
              (SELECT COUNT(*) CNT
	         FROM ACCOUNTS
		WHERE ( NBS ='2546' or (NBS='2525' and FOSTQ_S(acc, fdat_)>=0))
                  AND KV<>980
		  AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) J12,
              (SELECT COUNT(*) CNT
	         FROM ACCOUNTS
		WHERE ( NBS ='2546' or (NBS='2525' and FOSTQ_S(acc, fdat_)>=0))
                  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (DAZS IS NULL or dazs>fdat_) AND DAOS<=fdat_) K12;

      INSERT INTO TMP_ACCOUNTS_COUNT (    ID,    C,    D,    E,    F,    G,    H,    I,    J,    K )
                              VALUES ( ID12_, C12_, D12_, E12_, F12_, G12_, H12_, I12_, J12_, K12_ );
     -------------------------------
       SELECT   '13', C13.CNT, D13.cnt, E13.cnt, F13.cnt, G13.cnt, H13.cnt, I13.cnt, J13.cnt, K13.cnt
         INTO  ID13_,    C13_,    D13_,    E13_,    F13_,    G13_,    H13_,    I13_,    J13_,    K13_
         FROM (SELECT COUNT(a.acc) CNT
                 FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610' and s.ob22 in ( '02','03') ) or (a.NBS ='2615'   and s.ob22 in ( '02','03') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)    AND DAOS<=fdat_) C13,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610' and s.ob22 in ( '02','03') ) or  (a.NBS ='2615'   and s.ob22 in ( '02','03') ) )
		  AND a.KV<>980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) D13,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610' and s.ob22 in ( '02','03') ) or  (a.NBS ='2615'   and s.ob22 in ( '02','03') ) )
		  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) E13,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651' and s.ob22 in ( '02') ) or (a.NBS ='2652'   and s.ob22 in ( '02') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)    AND DAOS<=fdat_) F13,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651' and s.ob22 in ( '02') ) or (a.NBS ='2652'   and s.ob22 in ( '02') ) )
		  AND a.KV<>980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) G13,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651' and s.ob22 in ( '02') ) or (a.NBS ='2652'   and s.ob22 in ( '02') ) )
		  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) H13,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND a.NBS ='2546' and s.ob22 in ( '09','10')
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) I13,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND a.NBS ='2546' and s.ob22 in ( '09','10')
		  AND a.KV<>980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) J13,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND a.NBS ='2546' and s.ob22 in ( '09','10')
		  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) K13;

      INSERT INTO TMP_ACCOUNTS_COUNT (    ID,    C,    D,    E,    F,    G,    H,    I,    J,    K )
                              VALUES ( ID13_, C13_, D13_, E13_, F13_, G13_, H13_, I13_, J13_, K13_ );
      -------------------------------
      SELECT   '14', C14.CNT,  E14.cnt, F14.cnt, H14.cnt, I14.cnt, K14.cnt
        INTO  ID14_,    C14_,     E14_,    F14_,    H14_,    I14_,    K14_
        FROM  (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610' and s.ob22 in ( '04') ) or (a.NBS ='2615'   and s.ob22 in ( '07') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) C14,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610' and s.ob22 in ( '04') ) or (a.NBS ='2615'   and s.ob22 in ( '07') ) )
		  AND a.KV=980  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) E14,
	      (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651' and s.ob22 in ( '03') ) or (a.NBS ='2652'   and s.ob22 in ( '03') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)   AND DAOS<=fdat_) F14,
	      (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651' and s.ob22 in ( '03') ) or (a.NBS ='2652'   and s.ob22 in ( '03') ) )
		  AND a.KV=980 AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)   AND DAOS<=fdat_) H14,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE  s.acc=a.acc
		  AND  a.NBS ='2546'   and s.ob22 in ( '02','03')
		  AND  a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) I14,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE  s.acc=a.acc
		  AND  a.NBS ='2546'   and s.ob22 in ( '02','03')
		  AND  a.KV=980 AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) K14;

      INSERT INTO TMP_ACCOUNTS_COUNT (    ID,    C,    D,    E,    F,    G,    H,    I,    J,    K )
                              VALUES ( ID14_, C14_, NULL, E14_, F14_, NULL, H14_, I14_, NULL, K14_ );
    -------------------------------
       SELECT   '15', C15.CNT, D15.cnt, E15.cnt, F15.cnt, G15.cnt, H15.cnt, I15.cnt, J15.cnt, K15.cnt
         INTO  ID15_,    C15_,    D15_,    E15_,    F15_,    G15_,    H15_,    I15_,    J15_,    K15_
         FROM (SELECT COUNT(a.acc) CNT
                 FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610' and s.ob22 in ( '07') ) or (a.NBS ='2615'   and s.ob22 in ( '08') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) C15,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610' and s.ob22 in ( '07') ) or (a.NBS ='2615'   and s.ob22 in ( '08') ) )
		  AND a.KV<>980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) D15 ,
               (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610' and s.ob22 in ( '07') ) or (a.NBS ='2615'   and s.ob22 in ( '08') ) )
		  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) E15 ,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651'  and s.ob22 in ( '05') ) or (a.NBS ='2652'   and s.ob22 in ( '04') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) F15,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651' and s.ob22 in ( '05') ) or (a.NBS ='2652'   and s.ob22 in ( '04') ) )
		  AND a.KV<>980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) G15 ,
             (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651' and s.ob22 in ( '05') ) or (a.NBS ='2652'   and s.ob22 in ( '04') ) )
		  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) H15 ,
	      (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND a.NBS ='2546'  and s.ob22 in ( '05','06')
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) I15,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND a.NBS ='2546'   and s.ob22 in ( '05','06')
		  AND a.KV<>980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) J15,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND a.NBS ='2546'   and s.ob22 in ( '05','06')
		  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) K15;

      INSERT INTO TMP_ACCOUNTS_COUNT (    ID,    C,    D,    E,    F,    G,    H,    I,    J,    K )
                              VALUES ( ID15_, C15_, D15_, E15_, F15_, G15_, H15_, I15_, J15_, K15_ );
      -------------------------------
       SELECT   '16', C16.CNT, D16.cnt, E16.cnt, F16.cnt, G16.cnt, H16.cnt, I16.cnt, J16.cnt, K16.cnt
         INTO  ID16_,    C16_,    D16_,    E16_,    F16_,    G16_,    H16_,    I16_,    J16_,    K16_
         FROM (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610' and s.ob22 in ( '08') ) or (a.NBS ='2615'   and s.ob22 in ( '09') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) C16,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610'   and s.ob22 in ( '08') ) or (a.NBS ='2615'   and s.ob22 in ( '09') ) )
		  AND a.KV<>980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) D16 ,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610'   and s.ob22 in ( '08') ) or (a.NBS ='2615'   and s.ob22 in ( '09') ) )
		  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) E16 ,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651'   and s.ob22 in ( '06') ) or (a.NBS ='2652'   and s.ob22 in ( '05') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)   AND DAOS<=fdat_) F16,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651'   and s.ob22 in ( '06') ) or (a.NBS ='2652'   and s.ob22 in ( '05') ) )
		  AND a.KV<>980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) G16 ,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651'   and s.ob22 in ( '06') ) or (a.NBS ='2652'   and s.ob22 in ( '05') ) )
		  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) H16 ,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND a.NBS ='2546'   and s.ob22 in ( '07','08')
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) I16,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND a.NBS ='2546'   and s.ob22 in ( '07','08')
		  AND a.KV<>980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)    AND DAOS<=fdat_)  J16,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND a.NBS ='2546'   and s.ob22 in ( '07','08')
		  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)    AND DAOS<=fdat_)  K16;

     INSERT INTO TMP_ACCOUNTS_COUNT (     ID,    C,    D,    E,    F,    G,    H,    I,    J,    K )
                              VALUES ( ID16_, C16_, D16_, E16_, F16_, G16_, H16_, I16_, J16_, K16_ );
    -------------------------------
       SELECT   '17', C17.CNT, E17.cnt, F17.cnt, H17.cnt, I17.cnt,  K17.cnt
         INTO  ID17_,    C17_,    E17_,    F17_,    H17_,    I17_,     K17_
         FROM (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610'   and s.ob22 in ( '09') ) or    (a.NBS ='2615'   and s.ob22 in ( '10') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) C17,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
                WHERE s.acc=a.acc
		  AND ( (a.NBS ='2610'   and s.ob22 in ( '09') ) or    (a.NBS ='2615'   and s.ob22 in ( '10') ) )
		  AND a.KV=980 AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) E17,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
		WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651'   and s.ob22 in ( '07') ) or     (a.NBS ='2652'   and s.ob22 in ( '06') ) )
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)    AND DAOS<=fdat_) F17,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
		WHERE s.acc=a.acc
		  AND ( (a.NBS ='2651'   and s.ob22 in ( '07') ) or     (a.NBS ='2652'   and s.ob22 in ( '06') ) )
		  AND a.KV=980  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)    AND DAOS<=fdat_) H17,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
		WHERE s.acc=a.acc
		  AND a.NBS ='2546' and s.ob22 in ( '11','12')
		  AND a.KV=980
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) I17,
              (SELECT COUNT(a.acc) CNT
	         FROM ACCOUNTS a, specparam_int s
		WHERE s.acc=a.acc
		  AND a.NBS ='2546' and s.ob22 in ( '11','12')
		  AND a.KV=980  AND (NVL(blkk,0)<>0 OR NVL(blkd,0)<>0)
		  AND (a.DAZS IS NULL or a.dazs>fdat_)  AND DAOS<=fdat_) K17;

     INSERT INTO TMP_ACCOUNTS_COUNT (     ID,    C,    D,    E,    F,    G,    H,    I,    J,    K )
                              VALUES ( ID17_, C17_, NULL, E17_, F17_, NULL, H17_, I17_, NULL, K17_ );

     COMMIT;

end p_accounts_count;
/
show err;

PROMPT *** Create  grants  P_ACCOUNTS_COUNT ***
grant EXECUTE                                                                on P_ACCOUNTS_COUNT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ACCOUNTS_COUNT to START1;
grant EXECUTE                                                                on P_ACCOUNTS_COUNT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ACCOUNTS_COUNT.sql =========*** 
PROMPT ===================================================================================== 
