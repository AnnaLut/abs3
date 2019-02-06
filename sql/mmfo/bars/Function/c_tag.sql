
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/c_tag.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.C_TAG (tag_ VARCHAR2, val_ VARCHAR2)
   RETURN NUMBER
IS
   -- RETURN 0 - ��� �����

   -- �������� ���������� �������� ��������

   -- ��� ���������
   -- ��� BRANCH �����

   -- Ver 6.2.0 �i� 2016/01/13 SAI �������� ����� � ������ �������� PASPN
   -- Ver 6.1.9 �i� 2013/11/11 mom 150000
   -- Ver 6.1.8 �i� 2013/09/20 OAB �����i��� ���� ����� ��� D8#70
   -- Ver 6.1.7 �� 2012/10/02 NVV ������� ��� �������� TOBO3
   -- Ver 6.1.6 �i� 2012/07/26 OAB �����i��� ���� ����� ��� D6#70,D6#E2,D1#E9
   -- Ver 6.1.5 �i� 2012/07/12 MIK ������� ���������
   -- Ver 6.1.4 �i� 2012/06/20 NVV ���� ��� ����.�����i��i
   -- Ver 6.1.3 �i� 2012/02/14 Sta ���� ����.�����i��i
   -- Ver 6.1.2 �i� 2011/05/18 Sta MDATE = ���� ��������� DD.MM.YYYY
   -- Ver 6.1.1 �i� 2011/02/21 ��� ������������ ���.��������� SK �� ��-�� SK
   -- Ver 6.1.0 �� 2010/10/04

   n1_     INT := 1;
   D1_     NUMBER;
   l_dat   DATE;
   sTmp_   VARCHAR2 (64);
BEGIN
   BEGIN
      IF tag_ IN ('MDATE')
      THEN
         BEGIN
            -- �������� ���������� ����
            l_dat := TO_DATE (RTRIM (LTRIM (val_)), 'dd.mm.yyyy');

            -- ��� �.�. �������, ��� �������.
            IF l_dat <= gl.bdate
            THEN
               RETURN 0;
            END IF;
         EXCEPTION
            WHEN OTHERS
            THEN
               RETURN 0;
         END;
      ------------------------------------------------
      ELSIF tag_ = 'BM__C'
      THEN
         BEGIN
            SELECT 1
              INTO n1_
              FROM (select kod from bank_metals
                    union
                    select kod from bank_mon )
              WHERE kod = val_;
            RETURN n1_;
         EXCEPTION
            WHEN OTHERS
            THEN
               RETURN 0;
         END;
      ------------------------------------------------
      ELSIF tag_ = 'BM__K'
      THEN
         BEGIN
            SELECT 1
              INTO n1_
              FROM DUAL
              WHERE trunc(to_number(val_)) = to_number(val_);
            RETURN n1_;
         EXCEPTION
            WHEN OTHERS
            THEN
               RETURN 0;
         END;
      ------------------------------------------------
      ELSIF tag_ = 'OP758'
      THEN                                             ----- 758 ��������� !!!
         SELECT COUNT (*)
           INTO n1_
           FROM ISKL_758
          WHERE RTRIM (LTRIM (val_)) = RTRIM (LTRIM (TXT)) OR val_ IS NULL;
      ------------------------------------------------

      ELSIF tag_ = 'D'
      THEN                                -- �������� ���� ������������� � ���
         IF    LENGTH (val_) <> 6
            OR SUBSTR (val_, 1, 2) < '02'
            OR SUBSTR (val_, 3, 2) < '01'
            OR SUBSTR (val_, 3, 2) > '12'
            OR SUBSTR (val_, 5, 2) < '01'
            OR SUBSTR (val_, 5, 2) > '31'
         THEN
            RETURN 0;
         END IF;

         IF    TO_DATE (val_, 'YYMMDD') - 10 > gl.bdate
            OR TO_DATE (val_, 'YYMMDD') <= gl.bdate
         THEN
            RETURN 0;
         END IF;
      ELSIF tag_ = 'VIDPL'
      THEN                                    -- �������� ���� ��������� � �-2
         IF val_ NOT IN ('1', '2', '4', '5')
         THEN
            n1_ := 0;
         END IF;
      ELSIF tag_ = 'n'
      THEN
         IF NOT (   LENGTH (val_) = 4 AND SUBSTR (val_, 1, 1) IN ('�', '�')
                 OR     LENGTH (val_) = 8
                    AND (       SUBSTR (val_, 1, 1) = '�'
                            AND SUBSTR (val_, 5, 1) = '�'
                         OR     SUBSTR (val_, 1, 1) = '�'
                            AND SUBSTR (val_, 5, 1) = '�'))
         THEN
            RETURN 0;
         END IF;
      ELSIF tag_ IN ('C', 'S')
      THEN
         IF    LENGTH (val_) > 57
            OR INSTR (val_,
                      '#',
                      1,
                      1) <> 0
         THEN
            RETURN 0;
         END IF;
      ELSIF tag_ IN ('KOD_N', 'N')
      THEN
         SELECT COUNT (*)
           INTO n1_
           FROM bopcode
          WHERE RTRIM (LTRIM (val_)) = RTRIM (LTRIM (transcode));
      ELSIF tag_ = 'KOD_G'
      THEN
         SELECT COUNT (*)
           INTO n1_
           FROM bopcount
          WHERE RTRIM (LTRIM (val_)) = RTRIM (LTRIM (kodc));
      ELSIF tag_ = 'KOD_B'
      THEN
         SELECT COUNT (*)
           INTO n1_
           FROM rcukru
          WHERE RTRIM (LTRIM (val_)) = RTRIM (LTRIM (GLB));
      ELSIF tag_ IN ('KOLCH', 'NOMCH', 'KOMCH')
      THEN
         RETURN TO_NUMBER (val_);
      ELSIF tag_ = 'INK_S'
      THEN
         IF TRIM (TRANSLATE (val_, '0123456789.,', ' ')) = 0
         THEN
            RETURN 0;
         END IF;
      ELSIF tag_ = 'SK_P'
      THEN
         IF SUBSTR (val_, 1, 2) > '39' OR LENGTH (val_) > 2
         THEN
            RETURN 0;
         END IF;
      ELSIF tag_ = 'SK_V'
      THEN
         IF    SUBSTR (val_, 1, 2) < '40'
            OR SUBSTR (val_, 1, 2) > '99'
            OR LENGTH (val_) > 2
         THEN
            RETURN 0;
         END IF;
      ELSIF tag_ = 'RNKNN'
      THEN
         BEGIN
            SELECT rnk
              INTO n1_
              FROM customer
             WHERE rnk = LTRIM (RTRIM (val_));
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN 0;
         END;
      ELSIF tag_ IN ('D6#70', 'D6#E2', 'D1#E9', 'D8#70')
      THEN                        -- ��� ����� �������������/��������� ������
         SELECT COUNT (*)
           INTO n1_
           FROM kl_k040
          WHERE RTRIM (LTRIM (val_)) = RTRIM (LTRIM (k040));

         IF val_ = '804'
         THEN
            n1_ := 0;
         END IF;
      ELSIF tag_ = 'SK'
      THEN                     -- ���.�������� ���������� ������ ��� ����� #12
         IF LENGTH (val_) > 2
         THEN
            RETURN 0;
         END IF;

         SELECT COUNT (*)
           INTO n1_
           FROM sk
          WHERE     RTRIM (LTRIM (val_)) = TO_CHAR (sk)
                AND sk < 74
                AND d_close IS NULL;
      ELSIF tag_ = 'TELEF'
      THEN
         IF REGEXP_LIKE (val_, '\+[0-9]{12}') AND LENGTH (TRIM (val_)) = 13
         THEN
            n1_ := 1;
         ELSE
            n1_ := 0;
         END IF;
      ELSIF tag_ = 'REZID'
      THEN                                   -- ��������, ����� ������ 1 ��� 2
         IF val_ NOT IN ('1', '2')
         THEN
            n1_ := 0;
         END IF;
      -- ��������� ��� ����� (�������� 01D) ������ ���� ������ 1000
      ELSIF tag_ IN ('M_1', 'M_2', 'M_5', 'M_10', 'M_25', 'M_50')
      THEN
         IF val_ / 1000 <> TRUNC (val_ / 1000)
         THEN
            n1_ := 0;
         END IF;
      -- ����� ����� �������� � �������� (������ ������ ������ ��������)
      ELSIF tag_ = 'PASP'
      THEN
         -- IF val_ not IN ('����� ��������',
         -- '�������',
         -- '³�������� ������',
         -- '�������� ��� ����������',
         -- '�������',
         -- '������� ����������',
         -- '��������� �������',
         -- '����������� ������� ��.������',
         -- '������������� ������� ��.������',
         -- '������� �����������',
         -- '������� ������',
         -- 'I���� ��������',
         -- '��������� ���������� �����',
         -- '���������� ������') THEN
         -- IF trim(val_) not IN (select trim(name)
         -- from passp) then
         -- n1_ := 0;
         -- END IF;
         BEGIN
            SELECT 1
              INTO n1_
              FROM passp
             WHERE TRIM (name) = TRIM (val_);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               n1_ := 0;
         END;
      --



      ELSIF tag_ LIKE 'S_DZ_'
      THEN
         BEGIN
            D1_ := TO_NUMBER (val_);
         EXCEPTION
            WHEN OTHERS
            THEN
               RETURN 0;
         END;
      ELSIF tag_ = 'KODDZ' OR tag_ LIKE 'K_DZ_'
      THEN
         BEGIN
            -- �������� ���� ����.�����i��i
            SELECT 1
              INTO n1_
              FROM kod_dz
             -- where n1=val_;
             WHERE TRIM (n1) = val_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN 0;
         END;
      ELSIF tag_ = 'SK_ZB'
      THEN                              -- �������������� ������ ��� ����� #13
         SELECT COUNT (*)
           INTO n1_
           FROM a_sk_zb
          WHERE RTRIM (LTRIM (val_)) = RTRIM (LTRIM (kod));
      ELSIF tag_ = 'PASPV'
      THEN
         -- IF trim(val_) not IN (select trim(name)
         -- from passpv
         -- where rezid=1) then
         -- n1_ := 0;
         -- END IF;
         BEGIN
            SELECT 1
              INTO n1_
              FROM passpv
             WHERE TRIM (name) = TRIM (val_);   -- AND rezid = 1;  COBUMMFO-10624
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               n1_ := 0;
         END;
      -- ELSIF tag_='PASPN' THEN
      --   if instr(val_,'-')+instr(val_,'_')+instr(val_,'*')+instr(val_,'=')+instr(val_,'+')+
      --      instr(val_,'!')+instr(val_,'#')+instr(val_,'%')+instr(val_,'\')+instr(val_,'/')+
      --      instr(val_,'"')+instr(val_,':')+instr(val_,';')+instr(val_,'|')+instr(val_,'?')+
      --      instr(val_,'<')+instr(val_,'>')+instr(val_,'.')+instr(val_,',')+instr(val_,'~')+
      --      instr(val_,'`')+instr(val_,'@')+instr(val_,'$')+instr(val_,'^')+instr(val_,'&')+
      --      instr(val_,'(')+instr(val_,')')+instr(val_,'{')+instr(val_,'}')+instr(val_,'[')+
      --     instr(val_,']')+instr(val_,'''')>0 or length(val_)>32 or REGEXP_COUNT(trim(val_),' ',1,'i')>1 then
      --     n1_ := 0;
      -- else
      -- Begin
      -- n1_ := to_number(substr(replace(val_,' '),-6))+1;
      -- begin
      -- n1_ := to_number(substr(replace(val_,' '),1,1))+1;
      -- RETURN 0;
      -- exception when others then
      -- begin
      -- n1_ := to_number(substr(replace(val_,' '),2,1))+1;
      -- RETURN 0;
      -- exception when others then
      -- n1_ := 1;
      -- end;
      -- end;
      -- exception when others then
      -- RETURN 0;
      -- End;
      --   end if;



      -- �������� ����������� TOBO3
      ELSIF tag_ = 'TOBO3'
      THEN
         BEGIN
            SELECT 1
              INTO n1_
              FROM branch
             WHERE branch = LTRIM (RTRIM (val_)) AND date_closed IS NULL;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN 0;
         END;
      ELSIF TRIM (tag_) = 'F1'
      THEN
         BEGIN
            IF LENGTH (TRIM (val_)) <> 10
            THEN
               RETURN 0;
            END IF;

            BEGIN
               SELECT country
                 INTO stmp_
                 FROM country
                WHERE LPAD (country, 3, '0') = SUBSTR (val_, -3);

               IF stmp_ = 804
               THEN
                  RETURN 0;
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  RETURN 0;
            END;

            RETURN 1;
         END;
      END IF;

      RETURN n1_;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;
END c_tag;
/
 show err;
 
PROMPT *** Create  grants  C_TAG ***
grant EXECUTE                                                                on C_TAG           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on C_TAG           to START1;
grant EXECUTE                                                                on C_TAG           to WR_ALL_RIGHTS;
grant EXECUTE                                                                on C_TAG           to WR_DOC_INPUT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/c_tag.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 