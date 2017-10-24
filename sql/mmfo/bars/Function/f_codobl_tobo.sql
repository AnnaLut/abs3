
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_codobl_tobo.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CODOBL_TOBO (acc_ IN NUMBER, type_ IN NUMBER DEFAULT 1) RETURN VARCHAR2 IS
 -------------------------------------------------------------------
 -- ������:  23.04.2013 (26.03.2013, 20.02.2013, 08.11.2011)
 -------------------------------------------------------------------
 -- 23.04.2013 ������� ������� TRIM ��� ��������� TAG (trim(tag)='B040')
 -- 26.03.2013 ��������� ��������� ������ ������������
 -- 19.03.2013 ��� type_ = 8 (������ ���� ���=300465) � ���.����� 1004
 --            ����� ������������ ���.�������� TAG='B040' � �� �������
 --            ���� ����������� ��� ������� � ��� �������������
 -- ��� �� ��� ���� ����� #94 ������� PR_TOBO � 5 �� 8
 -- ��� ���=300465 � ���.����� 1004 ����� ������������ ���.��������
 -- TAG='B040' � �� ������� ���� ����������� ��� ������� � ���
 -- �������������
 -- ��� ������� ��� ������������� ��������� ��� ��� �������������
 -- ���������:
 --    acc_ - ��� �����
 --    type_ - ��� ������ ���� ������� ��� ��
 --          =1 - ��-������� ++++++++++ (��� offline - �������������) ++++++++++++++
 --
 --     	 =2 - ��-������, ����� ��. ���. ���� ������������� (B040) ++++++++++ (������������� �������� ����� ������������) ++++++++++
 --     	 =3 - ���������� ��� ������� � ��� ������������� (�� ���� 2)
 --
 --     	 =4 - ����� ������� ACCOUNTS ���� TOBO ++++++++++ (��� online - �������������) ++++++++++
 --     	 =5 - ���������� ��� ������� � ��� ������������� (�� ���� 4)
 --
 --     	 =6 - ��������� ��� ++++++++++ (���� ���� � offline, � online - �������������) ++++++++++
 --     	 =7 - ���������� ��� ������� � ��� ������������� (�� ���� 6)
 --     	 =8 - ���������� ��� ������� � ��� ������������� (�� ���� 5)
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

   IF r_type_ = 1 THEN  -- ��� 1
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
   ELSIF r_type_ IN (2, 3) THEN  -- ��� 2
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
                 'where s.b040 is not null and s.id=a.isp ';  -- �������� 04.01.06 OAB
-- ������� 07.10.05 OAB  'where s.b040 is not null and s.id=a.isp '; ��
--              'where s.id=a.isp ';
      END IF;
   ELSIF r_type_ IN (4, 5) THEN  -- ��� 3
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
-- ������� 07.10.05 OAB  'where a.tobo is not null and a.tobo=b.tobo and b.b040 is not null '; ��
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

               -- ��� �������
               nbuc_:=SUBSTR(b040_, bpos_, 2);

               -- � ������� ���� �������+��� �������������
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
 