
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif2.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF2 
                 ( ref_ NUMBER )   -- �������� ���������
RETURN NUMERIC IS
 min_ 	NUMERIC ;  -- ���������� ���������� ����� ��������
 max_ 	NUMERIC ;  -- ����������� ���������� ����� ��������
 sk_  	NUMERIC ;  -- ��������� ����� ��������
 kod_   INTEGER ;  -- ��� ������
 tt_    oper.tt%type ;      -- ��� ��������
 mfob_ 	oper.mfob%type ;    -- ��� �����-����������
 s_     oper.s%type  ;      -- ����� �������
 nlsa_  oper.nlsa%type;     -- ����� ����� �����������
 nazn_  oper.nazn%type;     -- ���������� �������
 corp2flag_ NUMBER;    -- ���� ��������� �������� �� �������� IB2 (c ���.���)

BEGIN

  sk_  := 0 ;
  kod_ := 0 ;

  SELECT tt, nlsa, mfob, s, nazn INTO tt_, nlsa_, mfob_, s_, nazn_ FROM oper WHERE ref=ref_;

  SELECT to_number(trim(val),'9') INTO corp2flag_ FROM params WHERE par='CORP2KOM';

  -- �������� ��� ��������
  -- ( ���� �������� CORP2 � ���������� �� - �������� �� ���������� )
  IF tt_ = 'IB2' AND substr(nlsa_,1,3) <> '262' THEN
    RETURN sk_;
  END IF;

  IF mfob_ like '8%' THEN
    -- ������, ����� ������.������
    kod_ := 31;
  ELSE
    BEGIN
      -- �������� ��� ��������
      IF tt_ = 'IB2' AND substr(nlsa_,1,3) = '262' AND corp2flag_ = 1 THEN
        BEGIN
          -- ���� ������ �� ������� ���������, ���������� �� � �������� ������������ �� CORP2 - �������� �� ����������
          -- � ��������� ������ - ���������� �������� �������� ������
          SELECT 0 INTO kod_
            FROM banks_ob
           WHERE mfo=mfob_;
        EXCEPTION WHEN NO_DATA_FOUND THEN kod_ := 37 ;
        END;
      END IF;

      -- �� ��������� �������, ������ ����������� %%
      IF (kod_ = 0) AND (tt_<>'IB2') THEN
        BEGIN
          SELECT 36 INTO kod_
            FROM banks_ob
           WHERE mfo=mfob_      -- ������ �� ������� ���������
             AND ( UPPER(nazn_) like '%�����%' or
                   UPPER(nazn_) like '%������%' or
                   UPPER(nazn_) like '%�������%' or
                   UPPER(nazn_) like '%²����%' );
        EXCEPTION WHEN NO_DATA_FOUND THEN kod_ := 0 ;
        END;
      END IF;

      IF (kod_ = 0) AND (tt_<>'IB2') THEN
        -- ������ � ������ ��,���
        -- �� ������, ������, ������ � ����.
       CASE
         -- ������� ��� ������ � ����������� �� ����� �������
         WHEN s_ <= 100000                    THEN kod_ := 32;
         WHEN s_ >  100000  AND s_ <= 2500000 THEN kod_ := 33;
         WHEN s_ >  2500000 AND s_ <= 5000000 THEN kod_ := 34;
         WHEN s_ >  5000000                   THEN kod_ := 35;
       END CASE;
      END IF;
    END;
  END IF;

  -- �������� ����� ��������
  BEGIN
    SELECT t.smin, t.tar + S_* t.pr/100, t.smax
    INTO   min_  , sk_                  , max_
    FROM tarif t
    WHERE t.kod=kod_ ;
  EXCEPTION WHEN NO_DATA_FOUND THEN sk_ := NULL ;
  END;

  -- ���� ��������� ��������
  IF sk_ IS NULL THEN
    sk_ := 0 ; -- �������.������ �� ���� kod_
  ELSE
    sk_ := iif_n(sk_, min_, min_,min_,sk_) ;
    sk_ := iif_n(max_,sk_,  max_,max_,sk_) ;
  END IF;

  RETURN sk_;

END f_tarif2 ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif2.sql =========*** End *** =
 PROMPT ===================================================================================== 
 