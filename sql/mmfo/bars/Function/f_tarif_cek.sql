CREATE OR REPLACE FUNCTION BARS.F_Tarif_CEK
                 ( z_cek_  VARCHAR2,     -- ������� �������.������ ('0'-��)
                   kv_     INTEGER,      -- ������ ��������
                   nls_    VARCHAR2,     -- ���.����� �����
                   s_      NUMERIC )     -- ����� ��������
-----------------------------------------------------------------------------
--            �-� �������� ����� �������� �� ������ �� ����
--
--   z_cek_ =  '0' - ������� ��������������� ������ �� ������ �������
--   z_cek_ =  '1' - ��� ������� ������
-----------------------------------------------------------------------------
RETURN NUMERIC IS
  kod_  integer;    -- ��� ������
  sk_   numeric;    -- ��������� ����� ��������
  n_tp  number;     -- � ��
BEGIN
                    --  ���������� � ������ n_tp:
  BEGIN
     SELECT to_number(w.VALUE)
     INTO   n_tp
     FROM   Accounts a, AccountsW w    -- ����� ����
     WHERE  a.NLS=nls_  and a.KV=kv_
        and a.ACC = w.ACC
        and w.TAG='SHTAR'
        and nvl(w.VALUE,0)>0;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     n_tp := 0;                        -- ������ ���
  END;



  IF n_tp >= 38  or  n_tp in (2.5, 2.9, 2.10, 2.11) then    ---  ������  > 38 :
     -----------------------------------------------

     if trim(z_cek_)<>'0' then

        if     s_ <= 10000000 then  kod_ := 214;
        elsif  s_ <= 50000000 then  kod_ := 215;  -- ��� ������
        elsif  s_  > 50000000 then  kod_ := 216;
        end if;

     else

        if     s_ <= 10000000 then  kod_ :=  32;
        elsif  s_ <= 50000000 then  kod_ := 332;  -- � �������
        elsif  s_  > 50000000 then  kod_ := 432;
        end if;

     end if;
                                        -----------------------
                                        ---  ������  < 38 :
                                        -----------------------


  ELSIF gl.amfo = '351823' and n_tp=0 then  -- �������, ��� ������ � n_tp < 38

        sk_:=F_TARIF_00C(32,kv_,nls_,s_); -- S < ���.10 ���EUR - 1%
        RETURN sk_;                       -- S > ���.10 ���EUR - 0.5%


  ELSIF gl.amfo = '337568' and trim(z_cek_)='0' then -- ���� � ������� �  n_tp < 38

     if     s_ <=  5000000 then  kod_ :=  32;
     elsif  s_ <= 10000000 then  kod_ := 332;
     elsif  s_ <= 15000000 then  kod_ := 432;
     elsif  s_ <= 20000000 then  kod_ := 532;
     elsif  s_ <= 25000000 then  kod_ := 632;
     elsif  s_  > 25000000 then  kod_ := 732;
     end if;

  ELSE                                 ---  ������ < 38 � ��� ������:
                                       ------------------------------
     if trim(z_cek_)<>'0' then

        if     s_ <=  5000000 then  kod_ := 214;
        elsif  s_ <= 25000000 then  kod_ := 215;  -- ��� ������
        elsif  s_  > 25000000 then  kod_ := 216;
        end if;

     else

        if     s_ <=  5000000 then  kod_ :=  32;
        elsif  s_ <= 25000000 then  kod_ := 332;  -- � �������
        elsif  s_  > 25000000 then  kod_ := 432;
        end if;

     end if;

  END IF;


  sk_:=F_TARIF(kod_,kv_,nls_,s_);

  RETURN sk_;

END F_Tarif_CEK ;
/

