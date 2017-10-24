
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF (
  kod_ INTEGER,              -- ��� ������
  kv_  INTEGER,              -- ������ ��������
  nls_ VARCHAR2,             -- ���.����� �����
  s_   NUMERIC,              -- ����� ��������
  kvk_ number default 0,     -- =1 - ����� ������ � ������� ������
  dat_ date   default null ) -- ����, �� ������� ������� �����, null=gl.bdate
-------------------------------------------------------------------------------
-- version 3.1 05.01.2015
-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------

RETURN NUMERIC IS

  l_nkv   NUMERIC;  -- ���.������
  l_so    NUMERIC;  -- ����� �������� � ������� ������
  l_sk    NUMERIC;  -- ��������� ����� ��������
  l_tarif v_tarif%rowtype;
  l_acc   number;
  l_dat   date;

-- ������� ����� � ������� ������ (����� ���.������)
function s_to_bkv (p_s number, p_kv number, p_bkv number) return number
is
  l_s number;
begin
  l_s := p_s;
  if p_bkv <> p_kv THEN
     -- ��������� � ���.������
     if p_kv <> l_nkv THEN
        l_s := gl.p_icurval(p_kv, l_s, gl.bd);
     end if;
     -- ������� ������ HE ���.������, ��������� � �������
     if p_bkv <> l_nkv THEN
        l_s := gl.p_ncurval(p_bkv, l_s, gl.bd);
     end if;
  end if;
  return l_s;
end;

BEGIN

  l_nkv := gl.BASEVAL;

  l_dat := dat_;
  if l_dat is null then l_dat := trunc(gl.bdate,'dd'); end if;

  -- ����� ���� ������� ������, "�����" ��������� �������� �
  -- ����������� ���� ������: 0 - �������, 1 - �� �����:
  begin
     select * into l_tarif from v_tarif where kod = kod_;
  exception when no_data_found then return 0;
  end ;
  l_tarif.tip     := nvl(l_tarif.tip,0);
  l_tarif.tar     := nvl(l_tarif.tar,0);
  l_tarif.pr      := nvl(l_tarif.pr,0);
  l_tarif.kv_smin := nvl(l_tarif.kv_smin,l_tarif.kv);
  l_tarif.kv_smax := nvl(l_tarif.kv_smax,l_tarif.kv);

  if l_dat < nvl(l_tarif.dat_begin,l_dat)
  or l_dat > nvl(l_tarif.dat_end,  l_dat) then
     bars_error.raise_nerror('DOC', 'TARIF_DAT', kod_);
  end if;

  -- ������� ����� �������� � ������� ������ (����� ���.������)
  l_so := s_;
  IF l_tarif.kv <> kv_ THEN
     l_so := s_to_bkv(l_so, kv_, l_tarif.kv);
  END IF;

  begin
     select acc into l_acc
       from accounts
      where nls = nls_ and kv = kv_;
  exception when no_data_found then
     l_acc := null;
  end;

----------------------------------------------------------------------

  IF l_tarif.tip = 0 THEN         -- ������� ����� ( �� �������� )

     l_sk := null;

     -- ���� ����� ��������������:
     BEGIN
        SELECT nvl(ta.tar,0) + l_so * nvl(ta.pr,0)/100, ta.smin, ta.smax
          INTO l_sk, l_tarif.smin, l_tarif.smax
          FROM acc_tarif ta
         WHERE ta.acc = l_acc
           and ta.kod = kod_
           and l_dat >= decode(ta.bdate,null,l_dat,ta.bdate)
           and l_dat <= decode(ta.edate,null,l_dat,ta.edate);
        -- ??? ��� ���.������� ��������� ����� ����������� � ������� ������ ������
        l_tarif.kv_smin := l_tarif.kv;
        l_tarif.kv_smax := l_tarif.kv;
     EXCEPTION WHEN NO_DATA_FOUND THEN l_sk := null;
     END;

     -- ���� ��� ��������������� - ����� �����:
     IF l_sk IS NULL THEN
        if l_acc is not null then
           BEGIN
              SELECT nvl(t.tar,0) + l_so* nvl(t.pr,0)/100, smin, smax
                INTO l_sk, l_tarif.smin, l_tarif.smax
                FROM v_acc_tarif t
               WHERE t.acc = l_acc
                 and t.kod = kod_ ;
           EXCEPTION WHEN NO_DATA_FOUND THEN l_sk := null;
           END;
        else
           l_sk := l_tarif.tar + l_so * l_tarif.pr/100;
        end if;
     END IF;

     -- ���� ��������� ��������   �
     -- ������� ����� �������� � ������ �������� (����� ���.������)
     IF l_sk IS NULL THEN
        -- �������.����� �� ���� kod_
        l_sk := 0;
     ELSE

        IF l_tarif.smax = 0 THEN
           l_tarif.smax := null;
        END IF;

        -- ������� ��������� ����� � ������� ������ (����� ���.������)
        IF l_tarif.kv <> l_tarif.kv_smin THEN
           l_tarif.smin := s_to_bkv(l_tarif.smin, l_tarif.kv_smin, l_tarif.kv);
        END IF;
        IF l_tarif.kv <> l_tarif.kv_smax and l_tarif.smax is not null THEN
           l_tarif.smax := s_to_bkv(l_tarif.smax, l_tarif.kv_smax, l_tarif.kv);
        END IF;

        l_sk := iif_n(l_sk, l_tarif.smin, l_tarif.smin, l_tarif.smin, l_sk);
        l_sk := iif_n(l_tarif.smax, l_sk, l_tarif.smax, l_tarif.smax, l_sk);

        IF l_tarif.kv <> kv_ THEN
           -- ���� ������ kvk_=1, ���������� ����� ������ � ������� ������
           if kvk_ = 1 then
              return l_sk;
           end if;
           -- ������� ������ HE ���.������, ��������� � ���.������
           IF l_tarif.kv <> l_nkv THEN
              l_sk := gl.p_icurval(l_tarif.kv, l_sk, gl.bd);
           END IF;
           -- ������ ����� HE ���.������, ��������� � ������ �����
           IF kv_ <> gl.BASEVAL THEN
              l_sk := gl.p_ncurval(kv_, l_sk, gl.bd);
           END IF;
        END IF;
     END IF;


  ELSE    -----------   tip >0    -  �� ����� !!!     --------------


     --  �������, ���������� S0_  -  ��� ����� ���������.
     --  ��� tip =3,4 ���� ������� �� �cc_tarif.NDOK_RKO ��� OST_AVG:

     IF l_tarif.tip = 1    then --  tip=1 - ����� �� ����� �� ����� ���., ��� ����� !

        NULL;

     ELSIF l_tarif.tip = 2 then --  tip=2 - ����� �� ����� �� ����� ���., ����.���
                                --                  ��������������.
                                --                  ������� ����� � ACC_TARIF ����������� !
        BEGIN
           SELECT t.tip INTO l_tarif.tip    -- ��� �������� ������� ������ acc_tarif � 1
             FROM v_tarif t, ACC_TARIF ta
            WHERE ta.acc = l_acc
              AND t.kod  = ta.kod
              AND t.kod  = kod_
              AND nvl(ta.PR,0) + nvl(ta.TAR,0) > 0;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

     ELSIF l_tarif.tip = 3 then  --  tip=3 - ����� �� ����� �� ���.���.
                                 --  �� �������� �����.   ("����")
                                 --  ��������� S0_ �� �cc_tarif.NDOK_RKO
                                 --  ������� ����� � ACC_TARIF ����������� !
        BEGIN
           SELECT t.NDOK_RKO INTO l_so
             FROM ACC_TARIF t
            WHERE t.acc = l_acc
              AND t.kod = kod_
              AND nvl(t.PR,0) + nvl(t.TAR,0) > 0;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

     ELSIF l_tarif.tip = 4  then  --  "������":  tip=4  - ����� �� �����
                                  --  �� C������� ������� �� ����� �� ������� �����.
                                  --  ��������� S0_  �� �cc_tarif.OST_AVG
                                  --  ������� ����� � ACC_TARIF ����������� !
        BEGIN
           SELECT t.ost_avg INTO l_so
             FROM acc_tarif t
            WHERE t.acc = l_acc
              AND t.kod = kod_
              AND nvl(t.PR,0) + nvl(t.TAR,0) > 0;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

     ELSE                         --  ��� ���� ��������� tip  -  RETURN 0

        RETURN 0;

     END IF;

     ---------------------------

     -- ������ �������� �� ����� :
     IF l_so IS NULL THEN              -- ���� l_so is NULL
        SELECT t.sum_tarif, t.smin, t.smax INTO l_sk, l_tarif.smin, l_tarif.smax
          FROM v_acc_tarif_scale t
         WHERE t.acc = l_acc
           and t.kod = kod_ AND t.sum_limit = 0;
     ELSE
        BEGIN
           SELECT nvl(t.sum_tarif,0) + l_so*nvl(t.pr,0)/100, t.smin, t.smax INTO l_sk, l_tarif.smin, l_tarif.smax
             FROM v_acc_tarif_scale t
            WHERE t.acc = l_acc
              and t.kod = kod_ AND
                  t.sum_limit = ( SELECT min(sum_limit)
                                    FROM v_acc_tarif_scale
                                   WHERE acc = t.acc
                                     and kod = t.kod AND sum_limit >= l_so );
        EXCEPTION
           WHEN NO_DATA_FOUND THEN l_sk := NULL ;
        END;
     END IF;

     -- ���� ��������� ��������   �
     -- ������� ����� �������� � ������ �������� (����� ���.������)
     IF l_sk IS NULL THEN
        -- �������.������ �� ���� kod_
        l_sk := 0 ;
     ELSE

        IF l_tarif.smax = 0 THEN
           l_tarif.smax := NULL;
        END IF;

        -- ������� ��������� ����� � ������� ������ (����� ���.������)
        IF l_tarif.kv <> l_tarif.kv_smin THEN
           l_tarif.smin := s_to_bkv(l_tarif.smin, l_tarif.kv_smin, l_tarif.kv);
        END IF;
        IF l_tarif.kv <> l_tarif.kv_smax and l_tarif.smax is not null THEN
           l_tarif.smax := s_to_bkv(l_tarif.smax, l_tarif.kv_smax, l_tarif.kv);
        END IF;

        l_sk := iif_n(l_sk, l_tarif.smin, l_tarif.smin, l_tarif.smin, l_sk);
        l_sk := iif_n(l_tarif.smax, l_sk, l_tarif.smax, l_tarif.smax, l_sk);

        IF l_tarif.kv <> kv_ THEN
           -- ���� ������ kvk_=1, ���������� ����� ������ � ������� ������
           if kvk_ = 1 then
              return l_sk;
           end if;
           -- ������� ������ HE ���.������, ��������� � ���.������
           IF l_tarif.kv<> l_nkv THEN
              l_sk := gl.p_icurval(l_tarif.kv,l_sk,gl.bd ) ;
           END IF;
           -- ������ ����� HE ���.������, ��������� � ������ �����
           IF kv_ <> gl.BASEVAL THEN
              l_sk:=gl.p_ncurval(kv_, l_sk,gl.bd );
           END IF;
        END IF;

     END IF;

  END IF;

  RETURN l_sk;

END f_tarif ;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF ***
grant EXECUTE                                                                on F_TARIF         to ABS_ADMIN;
grant DEBUG,EXECUTE                                                          on F_TARIF         to BARS009;
grant EXECUTE                                                                on F_TARIF         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF         to OPERKKK;
grant EXECUTE                                                                on F_TARIF         to PYOD001;
grant EXECUTE                                                                on F_TARIF         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 