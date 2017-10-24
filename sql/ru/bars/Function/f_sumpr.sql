
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_sumpr.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SUMPR (
   nSum_          IN NUMBER,
   nCcyCode_      IN VARCHAR2,
   strGender_     IN VARCHAR2,
   nDefDig        IN NUMBER DEFAULT NULL,
   nul_p          in NUMBER DEFAULT NULL )
RETURN VARCHAR2
IS
   strSum      VARCHAR2(2000);
   nSum2       NUMBER;
   strRes      VARCHAR2(4000);
   strAdd1     VARCHAR2(100);
   strAdd2     VARCHAR2(100);
   strAdd3     VARCHAR2(100);
   strMod      VARCHAR2(100);
   nDig        NUMBER;
   nRmnd       NUMBER;
   strCcyName  VARCHAR2(30);
   strCntName  VARCHAR2(30);
   strCnt      VARCHAR2(30);
   strCnt1     VARCHAR2(100);
   nI          NUMBER;
   strTriad    VARCHAR2(3);
   nExp        NUMBER;
   nTriad_1    NUMBER;
   nTriad_2    NUMBER;
   nTriad_3    NUMBER;
   nTriad_12   NUMBER;
   strMGender  VARCHAR2(1);
   nPrv        NUMBER;
   strCntPr    VARCHAR2(30);
   strDot      char(1);

BEGIN
   IF nCcyCode_ IS NULL THEN
      IF nDefDig IS NULL THEN
         nDig   := 2;
      ELSE
         nDig   := nDefDig;
      END IF;
   ELSE
      IF nCcyCode_ = '980' THEN
         nDig       := 2;
         strCcyName := 'грн.';
         strCntName := 'коп.';
      ELSE
         BEGIN
            SELECT lcv, unit, dig, prv INTO strCcyName, strCntName, nDig, nPrv
            FROM tabval WHERE kv=nCcyCode_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            IF nDefDig IS NULL THEN
               nDig   := 2;
            ELSE
               nDig   := nDefDig;
            END IF;
            strCcyName := '';
            strCntName := '';
         END;
      END IF;
   END IF;

   IF nCcyCode_ IS NULL THEN
      nSum2 := nSum_;
   ELSE
      nSum2 := nSum_ / POWER(10, nDig);
   END IF;
   strSum := TO_CHAR( TRUNC( nSum2 ));
   strCnt := SUBSTR( LTRIM( TO_CHAR( nSum2 - TRUNC( nSum2 ), RPAD( '0.', nDig+2, '0' ))), 3 );

   IF nCcyCode_ IS NULL    THEN

   if  nul_p is  null then
      WHILE SUBSTR( strCnt, -1) = '0' LOOP
         strCnt := SUBSTR( strCnt, 1, LENGTH(strCnt)-1 );
      END LOOP;

      strCnt1:=strCnt;

      WHILE strCnt1=strCnt LOOP
         SELECT ltrim(rtrim(f_sumpr(to_number(strCnt),NULL,'F',nDig))) INTO strCnt1 FROM dual;
      END LOOP;

    else

   SELECT ltrim(rtrim(f_sumpr(to_number(strCnt),NULL,'F',nDig))) INTO strCnt1 FROM dual;
   END IF;

  END IF;



   nRmnd  := LENGTH( strSum )/3 - TRUNC( LENGTH( strSum )/3 );
   IF nRmnd <> 0 THEN
      nRmnd := 1;
   END IF;

   strSum := LPAD( strSum, (TRUNC( LENGTH( strSum )/3 ) + nRmnd)*3, '0');

   IF nCcyCode_ IS NULL or nPrv=1 THEN
     IF strCnt IS NOT NULL THEN
         strCcyName := 'ц≥л';
         IF SUBSTR( strSum, -1) = '1' AND SUBSTR( strSum, -2) <> '11' THEN
            strCcyName := strCcyName || 'а';
         ELSE
            strCcyName := strCcyName || 'их';
         END IF;
      END IF;
      strDot := substr(trim(to_char(1/10,'0D0')),2,1);


     if nul_p is not null then

         IF    LENGTH( strCnt) = 1 THEN
         strCntPr := 'дес€т';
          ELSIF LENGTH( strCnt ) = 2 THEN
         strCntPr := 'сот';
          ELSIF LENGTH( strCnt) = 3 THEN
         strCntPr := 'тис€чн';
          ELSIF LENGTH( strCnt) = 4 THEN
         strCntPr := 'дес€титис€чн';
          ELSE
         strCntPr := '¬и мабуть знущаЇтесь...';
          END IF;
     else
           IF    LENGTH( to_char(to_number('0'||strDot||strCnt)) )-1 = 1 THEN
         strCntPr := 'дес€т';
      ELSIF LENGTH( to_char(to_number('0'||strDot||strCnt)) )-1 = 2 THEN
         strCntPr := 'сот';
      ELSIF LENGTH( to_char(to_number('0'||strDot||strCnt)) )-1 = 3 THEN
         strCntPr := 'тис€чн';
      ELSIF LENGTH( to_char(to_number('0'||strDot||strCnt)) )-1 = 4 THEN
         strCntPr := 'дес€титис€чн';
      ELSE
         strCntPr := '¬и мабуть знущаЇтесь...';
      END IF;

     END IF;

      IF  SUBSTR( to_char(to_number('0'||strDot||strCnt)), -1) = '1' AND
         (SUBSTR( to_char(to_number('0'||strDot||strCnt)), -2) <> '11'
       OR SUBSTR( to_char(to_number('0'||strDot||strCnt)), -2) IS NULL) THEN
         strCntPr := strCntPr || 'а';
      ELSE
         strCntPr := strCntPr || 'их';
      END IF;

     if to_number(strCnt) = 0 and  nul_p is null then strCntPr := ''; end if;

      if nPrv = 1 then
         strCntName := iif_s(to_number(strCnt),0,'','',strCntPr || ' ') || strCntName;
      else
         strCntName := strCntPr;
      end if;
   END IF;

   nI := 0;
   strRes := '';

   WHILE strSum IS NOT NULL  LOOP
      nExp := nI * 3;

      strTriad := SUBSTR( strSum, -3 );
      strSum   := SUBSTR( strSum, 1, LENGTH( strSum )-3 );

      nTriad_1  := TO_NUMBER( SUBSTR( strTriad, -1 ));
      nTriad_2  := TO_NUMBER( SUBSTR( strTriad, 2, 1 ));
      nTriad_3  := TO_NUMBER( SUBSTR( strTriad, 1, 1 ));
      nTriad_12 := TO_NUMBER( SUBSTR( strTriad, -2 ));

      SELECT DECODE( nI, 0, strGender_, 1, 'F', 'M') INTO strMGender FROM DUAL;
      strAdd1 := '';
      strAdd2 := '';
      strAdd3 := '';
      strMod  := '';

-- –азбираем ненулевую триаду
      IF TO_NUMBER( strTriad ) <> 0 THEN

         IF nTriad_3 > 0 THEN
            BEGIN
               SELECT des INTO strAdd3 FROM sumpr WHERE i=nTriad_3 AND e=2 AND rod=strMGender;
            EXCEPTION WHEN NO_DATA_FOUND THEN strAdd3 := '';
            END;
         END IF;
-- ƒл€ чисел от 1 до 19 особые числители
         IF nTriad_12 <= 19 AND nTriad_12 > 0 THEN
            BEGIN
               SELECT des INTO strAdd2 FROM sumpr WHERE i=nTriad_12 AND e=0 AND rod=strMGender;
            EXCEPTION WHEN NO_DATA_FOUND THEN strAdd2 := '';
            END;
         ELSE
-- обычный разбор дес€тков и едениц
            IF nTriad_2 > 0 THEN
               BEGIN
                  SELECT des INTO strAdd2 FROM sumpr WHERE i=nTriad_2 AND e=1 AND rod=strMGender;
               EXCEPTION WHEN NO_DATA_FOUND THEN strAdd2 := '';
               END;
            END IF;
            IF nTriad_1 > 0 THEN
               BEGIN
                  SELECT des INTO strAdd1 FROM sumpr WHERE i=nTriad_1 AND e=0 AND rod=strMGender;
               EXCEPTION WHEN NO_DATA_FOUND THEN strAdd1 := '';
               END;
            END IF;
         END IF;
-- добавл€ем модификатор "тыс€чи","ћиллионы" и т.л.
         IF nExp > 0 THEN
            BEGIN
               SELECT DECODE ( nTriad_2, 1, des, DECODE( nTriad_1, 1, des2, 2, des3, 3, des3, 4, des3, des ))
               INTO strMod FROM sumpr WHERE i=1 AND e=nExp AND rod=strMGender;
            EXCEPTION WHEN NO_DATA_FOUND THEN  strMod := '???';
            END;
         END IF;
      ELSE
-- ќбработка полного нул€
         IF strSum IS NULL THEN
            BEGIN
               SELECT des INTO strAdd1 FROM sumpr WHERE i=0 AND e=0 AND rod=strMGender;
            EXCEPTION WHEN NO_DATA_FOUND THEN  strAdd1 := 'ноль';
            END;
         END IF;
      END IF;

      IF strMod IS NOT NULL THEN
         strRes := strMod || ' ' || strRes;
      END IF;
      IF strAdd1 IS NOT NULL THEN
         strRes := strAdd1 || ' ' || strRes;
      END IF;
      IF strAdd2 IS NOT NULL THEN
         strRes := strAdd2 || ' ' || strRes;
      END IF;
      IF strAdd3 IS NOT NULL THEN
         strRes := strAdd3 || ' ' || strRes;
      END IF;

      nI := nI + 1;
   END LOOP;

   strRes := UPPER(substr(strRes,1,1))||substr(strRes,2,length(strRes)-1);
   strRes := RTRIM(strRes) || ' ' || strCcyName;

   if strCnt is not null and nPrv = 1 then
     SELECT ltrim(rtrim(f_sumpr(
              to_number(substr(to_char(to_number('0.'||strCnt)),2)),
              NULL,'F',nDig)))
     INTO strCnt1 FROM dual;
   end if;

   IF nCcyCode_ IS NOT NULL OR strCnt IS NOT NULL THEN
      IF strCnt <> strCnt1 THEN
         strRes := strRes || ' ' || lower(strCnt1) || ' ' || strCntName;
      ELSE
         strRes := strRes || ' ' || strCnt || ' ' || strCntName;
      END IF;
   END IF;

   RETURN strRes;

END f_sumpr;
/
 show err;
 
PROMPT *** Create  grants  F_SUMPR ***
grant EXECUTE                                                                on F_SUMPR         to ABS_ADMIN;
grant EXECUTE                                                                on F_SUMPR         to BARSAQ with grant option;
grant EXECUTE                                                                on F_SUMPR         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SUMPR         to CC_DOC;
grant EXECUTE                                                                on F_SUMPR         to DPT;
grant EXECUTE                                                                on F_SUMPR         to RPBN001;
grant EXECUTE                                                                on F_SUMPR         to START1;
grant EXECUTE                                                                on F_SUMPR         to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_SUMPR         to WR_CREDIT;
grant EXECUTE                                                                on F_SUMPR         to WR_DOCVIEW;
grant EXECUTE                                                                on F_SUMPR         to WR_DOC_INPUT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_sumpr.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 