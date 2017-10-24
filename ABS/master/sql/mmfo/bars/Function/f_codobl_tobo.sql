
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_codobl_tobo.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CODOBL_TOBO (acc_ IN NUMBER, type_ IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
 -------------------------------------------------------------------
 -- ¬≈–—»я:  23.04.2013 (26.03.2013, 20.02.2013, 08.11.2011)
 -------------------------------------------------------------------
 -- 23.04.2013 добавил функцию TRIM дл€ параметра TAG (trim(tag)='B040')
 -- 26.03.2013 добавлены некоторые строки комментариев
 -- 19.03.2013 дл€ type_ = 8 (вместо кода ћ‘ќ=300465) и бал.счета 1004
 --            будем обрабатывать доп.параметр TAG='B040' и из данного
 --            кода формировать код области и код подразделени€
 -- дл€ —Ѕ дл€ кода файла #94 изменим PR_TOBO с 5 на 8
 -- дл€ ћ‘ќ=300465 и бал.счета 1004 будем обрабатывать доп.параметр
 -- TAG='B040' и из данного кода формировать код области и код
 -- подразделени€
 -- код области дл€ безбалансовых отделений или код подразделени€
 -- параметры:
 --    acc_ - код счета
 --    type_ - вид поиска кода области дл€ Ѕќ
 --          =1 - по-старому ++++++++++ (дл€ offline - подразделений) ++++++++++++++
 --
 --     	 =2 - по-новому, через вн. рег. коды подразделений (B040) ++++++++++ (исскуственна€ прив€зка через исполнителей) ++++++++++
 --     	 =3 - возвращает код области и код подразделени€ (по типу 2)
 --
 --     	 =4 - через таблицу ACCOUNTS поле TOBO ++++++++++ (дл€ online - подразделений) ++++++++++
 --     	 =5 - возвращает код области и код подразделени€ (по типу 4)
 --
 --     	 =6 - смешанный тип ++++++++++ (если есть и offline, и online - подразделени€) ++++++++++
 --     	 =7 - возвращает код области и код подразделени€ (по типу 6)
 --     	 =8 - возвращает код области и код подразделени€ (по типу 5)
 ----------------------------------------------------------------
mfo_  VARCHAR2(12);
nbuc_ VARCHAR2(20):=NULL;
isp_  NUMBER;
type_branch_ NUMBER;
b040_ VARCHAR2(20);
bpos_ NUMBER;
pr_ NUMBER:=0;
nbs_  VARCHAR2(4);

sql_	VARCHAR2(1000);
TYPE CURSORType IS REF CURSOR;
CURS_ CURSORType;

r_type_ NUMBER;

BEGIN

   mfo_:=gl.aMFO;

   if mfo_ is null then
      mfo_ := f_ourmfo;
   end if;

   IF type_ IN (6, 7, 8) THEN
      IF type_= 6 THEN
         r_type_ := 1;
      ELSIF type_ = 7 THEN
         r_type_ := 3;
      ELSE
         r_type_ := 5;
      END IF;
   ELSE
      r_type_ := type_;
   END IF;

   IF r_type_ = 1 THEN  -- тип 1
      IF mfo_ = 303398 THEN --
      	 BEGIN
            SELECT NVL(TRIM(nbs),'0') INTO nbs_
            FROM accounts
            WHERE acc = acc_;
         EXCEPTION
                   WHEN NO_DATA_FOUND THEN
            NULL;
         END;

         IF nbs_ = '1004' THEN
            pr_ := 1;
            sql_ := 'SELECT NVL(TRIM(value),''000000000000'') nbuc FROM accountsw WHERE tag = ''B040''';
         ELSE
            sql_ := 'SELECT NVL(TRIM(p.param_value),''000000000000'') nbuc '||
                    'FROM bank_acc a, branch_params_values p '||
                    'where p.name=''KODOBL'' and p.mfo=a.mfo ';
         END IF;
      ELSE
            sql_ := 'SELECT NVL(TRIM(p.param_value),''000000000000'') nbuc '||
                    'FROM bank_acc a, branch_params_values p '||
                    'where p.name=''KODOBL'' and p.mfo=a.mfo ';
      END IF;
   ELSIF r_type_ IN (2, 3) THEN  -- тип 2
      IF mfo_ = 300120 THEN --
         BEGIN
            SELECT NVL(TRIM(nbs),'0') INTO nbs_
            FROM accounts
            WHERE acc = acc_;
         EXCEPTION
                   WHEN NO_DATA_FOUND THEN NULL;
         END;

         IF nbs_ = '1004' THEN
            sql_ := 'SELECT NVL(TRIM(value),''000000000000'') nbuc FROM accountsw WHERE tag = ''B040''';
         ELSE
            sql_ := 'select distinct trim(s.b040) nbuc '||
                    'from accounts a, staff s '||
                    'where s.b040 is not null and s.id=a.isp ';
         END IF;
      ELSE
         sql_ := 'select distinct trim(s.b040) nbuc '||
                 'from accounts a, staff s '||
                 'where s.b040 is not null and s.id=a.isp ';  -- возратил 04.01.06 OAB
-- заменил 07.10.05 OAB  'where s.b040 is not null and s.id=a.isp '; на
--              'where s.id=a.isp ';
      END IF;
   ELSIF r_type_ IN (4, 5) THEN  -- тип 3
      IF type_ = 8 THEN
         BEGIN
            SELECT NVL(TRIM(nbs),'0') INTO nbs_
            FROM accounts
            WHERE acc = acc_;
         EXCEPTION
                   WHEN NO_DATA_FOUND THEN NULL;
         END;

         IF nbs_ = '1004' THEN
            sql_ := 'SELECT NVL(TRIM(value),''000000000000'') nbuc FROM accountsw WHERE trim(tag) = ''B040''';
         else
            sql_ := 'select distinct NVL(trim(b.b040),''000000000000'') nbuc '||
                    'from accounts a, tobo b '||
                    'where a.tobo is not null and a.tobo=b.tobo ';
         END IF;
      ELSE
         sql_ := 'select distinct NVL(trim(b.b040),''000000000000'') nbuc '||
                 'from accounts a, tobo b '||
-- заменил 07.10.05 OAB  'where a.tobo is not null and a.tobo=b.tobo and b.b040 is not null '; на
                 'where a.tobo is not null and a.tobo=b.tobo ';
      END IF;
   ELSE
      sql_ := NULL;
   END IF;

   IF sql_ IS NOT NULL THEN
      sql_ := sql_ || 'and acc=:acc_ ';

      OPEN CURS_ FOR sql_ USING acc_;
      LOOP
      FETCH CURS_ INTO nbuc_;
      EXIT WHEN CURS_%NOTFOUND;

         IF r_type_ BETWEEN 2 AND 5 OR (r_type_ = 1 AND pr_ = 1) THEN
            b040_ := nbuc_;

            IF b040_ IS NOT NULL THEN
               type_branch_ := TO_NUMBER(SUBSTR(b040_, 9, 1));

               IF type_branch_ = 0 THEN
                  bpos_ := 4;
               ELSIF type_branch_ = 1 THEN
                  bpos_ := 10;
               ELSE
                  bpos_ := 15;
               END IF;

               -- код области
               nbuc_:=SUBSTR(b040_, bpos_, 2);

               -- в разрезе кода области+код подразделени€
               IF r_type_ IN (3, 5) THEN
                  nbuc_:=nbuc_ || SUBSTR(Trim(b040_), -12);
               END IF;
            ELSE
               nbuc_:=NULL;
            END IF;
         END IF;
      END LOOP;
      CLOSE CURS_;
    ELSE
       nbuc_:=NULL;
    END IF;

    IF NVL(nbuc_, 0)=0 AND type_ IN (6, 7) THEN
       IF type_= 6 THEN
          r_type_ := 4;
       ELSE
          r_type_ := 5;
       END IF;

       nbuc_ := F_Codobl_Tobo(acc_, r_type_);
    END IF;

    RETURN nbuc_;
END;
/
 show err;
 
PROMPT *** Create  grants  F_CODOBL_TOBO ***
grant EXECUTE                                                                on F_CODOBL_TOBO   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CODOBL_TOBO   to SALGL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_codobl_tobo.sql =========*** End 
 PROMPT ===================================================================================== 
 