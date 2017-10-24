
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_new.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_NEW 
                 ( kod_ INTEGER,   -- ��� ������
                   kv_  INTEGER,   -- ������ ��������
                   nls_ VARCHAR2,  -- ���.����� �����
                   s_   NUMERIC,   -- ����� ��������
                   kvk_ number default 0)  -- =1 - ����� ������ � ������� ������
-----------------------------------------------------------------------------

-- ������ "�� �����" ��������� ������ "���" = 1,2,3,4:
-- ---------------------------------------------------
-- ���=1 - �� �����. �������� ��� �����.
--    =2 - �� �����. �������� ��� �������������� - ���� ������ ���� � ACC_TARIF.
--    =3 - �� ���.�������� �� �������� �����  ("����").
--                   �������� ��� �������������� - ���� ������ ���� � ACC_TARIF.
--    =4 - �� �������� ������� �� ����� �� ������� ����� ("������").
--                   �������� ��� �������������� - ���� ������ ���� � ACC_TARIF.
--
--  �������� !      ������ "�� �����" ����� 2,3,4 �������� ������ ��� ���
--  ������, ��� ������� �� ��������� ��� ��������������, �.�. ���� � ����
--  ������� ������ ����������� ���� � ACC_TARIF.
--  ���=1 - �������� ��� ����� - ������� � ACC_TARIF �� �����������.
------------------------------------------------------------------------------

RETURN NUMERIC IS
 nkv_ NUMERIC ;  -- ���.������
 bkv_ NUMERIC ;  -- ������� ������ ������
 so_  NUMERIC ;  -- ����� �������� � ������� ������
 min_ NUMERIC ;  -- ���������� ���������� ����� ��������
 max_ NUMERIC ;  -- ����������� ���������� ����� ��������
 sk_  NUMERIC ;  -- ��������� ����� ��������
 tip_ NUMBER;    -- ��� ������: 0 - �������, 1 - �����

BEGIN

  nkv_:=gl.BASEVAL ;
  BEGIN
     -- ����� ���� ������� ������, "�����" ��������� �������� �
     -- ����������� ���� ������: 0 - �������, 1 - �� �����:
     SELECT kv,   nvl(tip,0), smin, smax
     INTO   bkv_, tip_,       min_, max_
     FROM  v_tarif
     WHERE kod=kod_ ;

  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0 ;
  END ;

  -- ������� ����� �������� � ������� ������ (����� ���.������)

  so_ := s_;

  IF bkv_ <> kv_ THEN
      -- ��������� � ���.������
      IF kv_<> nkv_ THEN
         so_ := gl.p_icurval(kv_, s_, gl.bd) ;
      END IF;
      -- ������� ������ HE ���.������, ��������� � �������
      IF bkv_ <> nkv_ THEN
         so_ := gl.p_ncurval(bkv_,so_,gl.bd);
      END IF;
  END IF;

----------------------------------------------------------------------

  IF tip_ = 0 THEN         -- ������� ����� ( �� �������� )

     sk_ := NULL ;

     -- ���� ����� ��������������:
     BEGIN
       SELECT ta.smin, nvl(ta.tar,0) + SO_* nvl(ta.pr,0)/100, ta.smax
       INTO   min_ , sk_ , max_
       FROM acc_tarif ta, accounts a
       WHERE a.kv   = kv_    AND
             a.nls  = nls_   AND
             a.acc  = ta.acc AND
             ta.kod = kod_   AND
             trunc(gl.bdate,'dd')>=decode(ta.bdate,null,trunc(gl.bdate,'dd'),ta.bdate) AND
             trunc(gl.bdate,'dd')<=decode(ta.edate,null,trunc(gl.bdate,'dd'),ta.edate) ;
     EXCEPTION WHEN NO_DATA_FOUND THEN sk_ := NULL ;
     END;


     -- ���� ��� ��������������� - ����� �����:
     IF sk_ IS NULL THEN
        BEGIN
          SELECT  nvl(t.tar,0) + SO_* nvl(t.pr,0)/100
          INTO    sk_
          FROM  v_tarif t
          WHERE t.kod=kod_ ;
        EXCEPTION WHEN NO_DATA_FOUND THEN sk_ := NULL ;
        END;
     END IF;

     -- ���� ��������� ��������   �
     -- ������� ����� �������� � ������ �������� (����� ���.������)
     IF sk_ IS NULL THEN
        -- �������.����� �� ���� kod_
        sk_ := 0 ;
     ELSE

        IF max_=0 THEN
           max_:= NULL;
        END IF;

        sk_ := iif_n(sk_, min_, min_,min_,sk_) ;
        sk_ := iif_n(max_,sk_,  max_,max_,sk_) ;

        IF bkv_ <> kv_ THEN
           -- ���� ������ kvk_=1, ���������� ����� ������ � ������� ������
           if kvk_ = 1 then
              return sk_;
           end if;
           -- ������� ������ HE ���.������, ��������� � ���.������
           IF bkv_<> nkv_ THEN
              sk_ := gl.p_icurval(bkv_,sk_,gl.bd ) ;
           END IF;
           -- ������ ����� HE ���.������, ��������� � ������ �����
           IF kv_ <> gl.BASEVAL THEN
              sk_:=gl.p_ncurval(kv_, sk_,gl.bd );
           END IF;
        END IF;
     END IF;


  ELSE    -----------   tip_ >0    -  �� ����� !!!     --------------


    --  �������, ���������� S0_  -  ��� ����� ���������.
    --  ��� tip_ =3,4 ���� ������� �� �cc_tarif.NDOK_RKO ��� OST_AVG:

     IF tip_ =1    then --  tip_=1 - ����� �� ����� �� ����� ���., ��� ����� !

        NULL;

     ELSIF tip_ =2 then --  tip_=2 - ����� �� ����� �� ����� ���., ����.���
                        --           ��������������.
                        --           ������� ����� � ACC_TARIF ����������� !
        BEGIN
          SELECT t.tip INTO tip_    -- ��� �������� ������� ������ acc_tarif � 1
            FROM v_tarif t, ACC_TARIF ta, accounts a
           WHERE a.acc = ta.acc AND t.kod  =ta.kod  AND t.kod = kod_
             AND nvl(ta.PR,0) + nvl(ta.TAR,0) > 0
             AND a.nls = nls_  AND a.kv = kv_;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;


     ELSIF tip_ =3 then  --  tip_=3 - ����� �� ����� �� ���.���.
                         --  �� �������� �����.   ("����")
                         --  ��������� S0_ �� �cc_tarif.NDOK_RKO
                         --  ������� ����� � ACC_TARIF ����������� !
        BEGIN
          SELECT t.NDOK_RKO INTO so_
            FROM ACC_TARIF t, accounts a
           WHERE a.acc = t.acc AND t.kod = kod_
             AND nvl(t.PR,0) + nvl(t.TAR,0) > 0
             AND a.nls = nls_  AND a.kv = kv_;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;



     ELSIF tip_ =4  then  --  "������":  tip_=4  - ����� �� �����
                          --  �� C������� ������� �� ����� �� ������� �����.
                          --  ��������� S0_  �� �cc_tarif.OST_AVG
                          --  ������� ����� � ACC_TARIF ����������� !
        BEGIN
          SELECT t.ost_avg INTO so_
            FROM acc_tarif t, accounts a
           WHERE a.acc = t.acc AND t.kod = kod_
             AND nvl(t.PR,0) + nvl(t.TAR,0) > 0
             AND a.nls = nls_  AND a.kv = kv_;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

     ELSE               --  ��� ���� ��������� tip_  -  RETURN 0

        RETURN 0;

     END IF;

     ---------------------------

     -- ������ �������� �� ����� :
     IF so_ IS NULL THEN              -- ���� so_ is NULL
        SELECT t.sum_tarif INTO sk_
          FROM tarif_scale t
         WHERE t.kod = kod_ AND t.sum_limit = 0;
     ELSE
       BEGIN
         SELECT nvl(t.sum_tarif,0) + so_*nvl(t.pr,0)/100 INTO sk_
           FROM tarif_scale t
          WHERE t.kod = kod_ AND
                t.sum_limit =
                             (SELECT min(sum_limit) FROM tarif_scale
                               WHERE kod = t.kod AND sum_limit >= so_);
       EXCEPTION
         WHEN NO_DATA_FOUND THEN sk_ := NULL ;
       END;
     END IF;


     -- ���� ��������� ��������   �
     -- ������� ����� �������� � ������ �������� (����� ���.������)
     IF sk_ IS NULL THEN
        -- �������.������ �� ���� kod_
        sk_ := 0 ;
     ELSE

        IF max_=0 THEN
           max_:= NULL;
        END IF;

        sk_ := iif_n(sk_, min_, min_,min_,sk_) ;
        sk_ := iif_n(max_,sk_,  max_,max_,sk_) ;

        IF bkv_ <> kv_ THEN
           -- ���� ������ kvk_=1, ���������� ����� ������ � ������� ������
           if kvk_ = 1 then
              return sk_;
           end if;
           -- ������� ������ HE ���.������, ��������� � ���.������
           IF bkv_<> nkv_ THEN
              sk_ := gl.p_icurval(bkv_,sk_,gl.bd ) ;
           END IF;
           -- ������ ����� HE ���.������, ��������� � ������ �����
           IF kv_ <> gl.BASEVAL THEN
              sk_:=gl.p_ncurval(kv_, sk_,gl.bd );
           END IF;
        END IF;
     END IF;

  END IF;

  RETURN sk_;

END F_TARIF_NEW ;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF_NEW ***
grant EXECUTE                                                                on F_TARIF_NEW     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF_NEW     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_new.sql =========*** End **
 PROMPT ===================================================================================== 
 