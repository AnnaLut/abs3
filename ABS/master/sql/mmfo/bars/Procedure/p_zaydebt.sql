

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAYDEBT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAYDEBT ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAYDEBT 
( mod_            INT
, acc_            INT
, ref_            NUMBER
, s1_             NUMBER
, s2_             NUMBER
, d27_1           CHAR
, d27_2           CHAR
, namekb_         VARCHAR2
, idkb_           VARCHAR2
, nazn_           VARCHAR2
, soper_          NUMBER
) IS
---
-- version 11/11/2016
---
-- mod_ - 1-��������� �� ����.����
--      - 2-�������� ������ + ��������� �� ����.����
--      - 3-�������� ������ �� ������������ ������� �� ��������� �����
---
  mfo_            VARCHAR2(12); -- ��� �����
  okpo_           VARCHAR2(15); -- ��� ���� �����
  tt_             CHAR(3); -- ��� �������� 2603 -> 2600
  vob_            NUMBER; -- ��� ���������
  kv_             NUMBER; -- ������
  nls_            VARCHAR2(15); -- ����� ����� 2603/���
  nms_            VARCHAR2(38); -- ������������ ����� 2603/���
  rnk_            NUMBER; -- ���.� �������
  acc26_          INT; -- ��� ����� 2600/���
  nls26_          VARCHAR2(15); -- ����� ����� 2600/���
  nms26_          VARCHAR2(38); -- ������������ ����� 2600/���
  okpo26_         VARCHAR2(15); -- ��� ���� �������
  refd_           INT := null; -- �������� �������� 2603 -> 2600
  kurs_           NUMBER; -- ���� ������� ������
  kom_            NUMBER; -- ������� ��������
  nd_             VARCHAR2(10); -- ����� ���������
  acc980_         INT; -- ��� ����� 2600/���
  mfo980_         VARCHAR2(12); -- ��� ����� 2600/���
  nls980_         VARCHAR2(15); -- ����� ����� 2600/���
  l_zay           zay_debt_klb%rowtype;
  l_reqid         number;
  l_nls0          accounts.nls%type;
  l_nls1          accounts.nls%type;
  l_d020          char(2);
--------------------------------------------------------------------
  ern             CONSTANT POSITIVE := 208;
  err             EXCEPTION;
  erm             VARCHAR2(160);
BEGIN
  
  bars_audit.trace( $$PLSQL_UNIT||': Entry with ( mod_=%s, acc_=%s, ref_=%s, s1_=%s, s2_=%s, nazn_=%s, d27_1=%s, d27_2=%s ).'
                  , to_char(mod_), to_char(acc_), to_char(ref_), to_char(s1_), to_char(s2_)
                  , to_char(nazn_), d27_1, d27_2 );
  /*
  case
    when ( mod_ = 1 and nvl(s2_,0) = 0 )
    then
      erm := '';
      raise err;
    when ( mod_ = 2 and nvl(s1_,0) = 0 and nvl(s2_,0) = 0 )
    then
      erm := '';
      raise err;
    when ( mod_ = 3 and nvl(s1_,0) = 0 )
    then
      erm := '';
      raise err;
    else
      null;
  end case;
  */
  
  mfo_  := f_get_params('MFO');
  okpo_ := f_get_params('OKPO');
  tt_   := 'GO8';
  
  BEGIN
    select to_number(val)
      into vob_ 
      from BARS.PARAMS
     where par='MBK_VZAL' 
       and val IS NOT NULL;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      vob_ := 6;
  END;
  
  IF nvl(s2_,0) <> 0 
  THEN -- ���� ���� ������ ���� ����� ���������� ���������
    
    BEGIN
       -- 1. ����� ���������� ��������� ����� ������� (2600,2650)
       SELECT a1.kv,  a1.nls, substr(a1.nms,1,38), c.rnk,
              a2.acc, a2.nls, substr(a2.nms,1,38), c.okpo
         INTO kv_,nls_,nms_,rnk_,acc26_,nls26_,nms26_,okpo26_
         FROM accounts a1, customer c, accounts a2 
        WHERE a1.acc = acc_            
          AND a1.kv  = a2.kv 
          AND a1.rnk = c.rnk  
          AND a1.rnk = a2.rnk 
          AND a2.nbs IN ('2600', '2650', '2530', '2541', '2542', '2544', '2545', '2555')
          AND a2.tip = 'ODB' 
          AND a2.dazs IS NULL 
          AND substr(a1.nls,6,9)=substr(a2.nls,6,9);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          SELECT a1.kv,  a1.nls, substr(a1.nms,1,38), c.rnk,
                 a2.acc, a2.nls, substr(a2.nms,1,38), c.okpo
            INTO kv_,nls_,nms_,rnk_,acc26_,nls26_,nms26_,okpo26_
            FROM accounts a1, customer c, accounts a2
           WHERE a1.acc = acc_   
             AND a1.kv  = a2.kv 
             AND a1.rnk = c.rnk   
             AND a1.rnk = a2.rnk 
             AND a2.nbs IN ('2600', '2650', '2530', '2541', '2542', '2544', '2545', '2555')
             AND a2.tip = 'ODB' 
             AND a2.dazs IS NULL
             AND rownum = 1
           GROUP
              BY a1.kv, a1.nls,substr(a1.nms,1,38),c.rnk,
                 a2.acc,a2.nls,substr(a2.nms,1,38),c.okpo;
        --HAVING count(*)=1;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            erm := '��������� �������� ���� ������� �� ������!';
            RAISE err;
        END;
     END;
  -- ����� ����� ��������� ���� �����, ��� ����������
  ELSE 
    SELECT a.kv, a.nls, a.rnk, c.okpo
      INTO kv_, nls_, rnk_, okpo26_
      FROM accounts a
         , customer c
     WHERE a.acc = acc_ 
       AND a.rnk = c.rnk;
  END IF;

  bars_audit.trace( $$PLSQL_UNIT||': 1. kv_=%s, nls_=%s, nms_=%s, rnk_=%s, acc26_=%s,nls26_=%s'
                  , to_char(kv_), to_char(kv_), to_char(nms_), to_char(rnk_), to_char(acc26_), to_char(nls26_) );

  -- 2. ���������� ������ �� ��������� ����
  IF mod_ in (1, 2) and nvl(s2_,0) <> 0 
  THEN
    
    SELECT nd INTO nd_ FROM oper WHERE ref = ref_;
    
    BEGIN
      
      gl.ref (refd_);
      
      gl.in_doc3( ref_   => refd_
                , tt_    => tt_      , dk_    => 1
                , vob_   => vob_     , nd_    => nd_
                , pdat_  => sysdate  , data_  => gl.bdate
                , vdat_  => gl.bdate , datp_  => gl.bdate
                , kv_    => kv_      , kv2_   => kv_
                , s_     => s2_      , s2_    => s2_
                , mfoa_  => mfo_     , mfob_  => mfo_
                , nlsa_  => nls_     , nlsb_  => nls26_
                , nam_a_ => nms_     , nam_b_ => nms26_
                , id_a_  => okpo26_  , id_b_  => okpo26_
                , nazn_  => nazn_    , uid_   => null -- USER_ID()
                , d_rec_ => null     , sk_    => null
                , id_o_  => null     , sign_  => null
                , sos_   => 1        , prty_  => null );
      
      gl.pay2(null,refd_,gl.bdate,tt_,kv_,0,acc_,  s2_,0,1,'������������� ����� �� �������� �������');
      gl.pay2(null,refd_,gl.bdate,tt_,kv_,1,acc26_,s2_,0,0,'������������� ����� �� �������� �������');
      
      gl.pay2(0,refd_,gl.bdate);

      if ( d27_2 IS NOT NULL )
      then
        insert
          into OPERW (REF, TAG, VALUE) 
        values ( refd_, 'D#27 ', d27_2 );
      end if;
      
    END;
    
  END IF;

  -- 3. ���������� ������� ������ �� ������������ �������
  IF mod_ in (2, 3) and nvl(s1_,0) <> 0 
  THEN
    
    -- ���� �������
    BEGIN
      SELECT kurs_s 
        INTO kurs_ 
        FROM DILER_KURS
       WHERE kv  = kv_ 
         AND dat = ( select max(dat) 
                       from DILER_KURS
                      where kv = kv_ 
                        and dat >=trunc(sysdate) );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN kurs_ := NULL;
    END;

     -- ���� ��� ���������� ���
    BEGIN
      
      SELECT mfo26, nls26, okpo26, kom2 
        INTO mfo980_,nls980_,okpo26_,kom_ 
        FROM cust_zay 
       WHERE rnk = rnk_;
        
      if mfo_ = mfo980_ 
      then
        
        begin
          select acc 
            into acc980_ 
            from accounts
           where nls = nls980_
             and kv  = 980;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            erm :='��������� ���� (���) �� ���������� ������� �� ������!';
            RAISE err;
        end;
        
      end if;
      
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
           SELECT a.acc, a.nls INTO acc980_,nls980_
             FROM accounts a
            WHERE a.rnk = rnk_    
              AND a.kv  = 980  
              AND a.nbs IN ('2600', '2650', '2530', '2541', '2542', '2544', '2545', '2555') 
              AND a.dazs IS NULL 
              AND substr(a.nls,6,9) = substr(nls_,6,9)
              and rownum = 1;
        EXCEPTION 
          WHEN NO_DATA_FOUND THEN
            BEGIN
              SELECT a.acc, a.nls INTO acc980_, nls980_
                FROM accounts a
               WHERE a.rnk = rnk_ 
                 AND a.kv  = 980    
                 AND a.nbs IN ('2600', '2650', '2530', '2541', '2542', '2544', '2545', '2555')
                 AND a.dazs IS NULL 
                 --and not exists (select 1 from accounts where nls = a.nls and kv <> a.kv)
                 and rownum = 1;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                erm :='��������� ���� (���) �� ������!';
                RAISE err;
            END;
        END;
     END;
     
     bars_audit.trace( $$PLSQL_UNIT||': 3. mfo980_=%s, nls980_=%s, okpo26_=%s, kom_=%s, acc980_=%s'
                     , to_char(mfo980_), to_char(nls980_), to_char(okpo26_), to_char(kom_), to_char(acc980_) );

     -- ������, ����������� �� ������� ������-����
     IF namekb_ IS NOT NULL AND idkb_ IS NOT NULL 
     THEN

        select * into l_zay from zay_debt_klb where fnamekb=namekb_ and identkb=idkb_;
        
        begin
          select nls into l_nls0 from accounts 
           where acc = l_zay.acc0;
        exception
          when no_data_found then
           l_nls0 := null;
        end;
        
        begin
           select nls into l_nls1 from accounts
            where acc = acc_;
        exception
          when no_data_found then
           l_nls1 := null;
        end;

        bars_zay.create_request_ex 
           (p_reqtype       => 2,                        -- ��� ������ (1-�������, 2-�������, 3-���������)
            p_custid        => l_zay.rnk,                -- �������.� �������
            p_curid         => l_zay.kv2,                -- ����.��� ������ (��� dk(1,3) - ������� ����������, ��� 2 - ������� ���������)
            p_curconvid     => null,                     -- ����.��� ������ �� ������� ���������� (��� dk = 3)
            p_amount        => l_zay.s2/100,             -- ����� ���������� ������ ("�����������")
            p_reqnum        => l_zay.nd,                 -- ����� ������
            p_reqdate       => l_zay.datz,               -- ���� ������
            p_reqrate       => nvl(l_zay.kurs_z,kurs_),  -- ���� ������
            p_nls_acc1      => l_nls1,                   -- � ����� � ��.���. (��� 1 - ��� ���� ����������, ��� 2 - ��� ���� ��������, ��� 3 - ��� ���� ����������)
            p_nls_acc0      => l_nls0,                   -- � ����� � ���.���.(��� 1 - ��� ���� ��������, ��� 2 - ��� ���� ����������(��� ���������� �����.��� �� ������� - ���� �������,���� ����������� ���� mfo0, nls0,okpo0), ��� 3 - ��� ���� ��� ��������)
            p_nataccnum     => l_zay.nls0,               -- ���� � ���.������ � ��.�����     (��� dk = 2)
            p_natbnkmfo     => l_zay.mfo0,               -- ��� ����� ����� � ���.������     (��� dk = 2)
            p_cmsprc        => kom_,                     -- ������� (%) ��������
            p_cmssum        => null,                     -- ����.����� ��������
            p_taxflg        => 1,                        -- ������� ���������� � ��          (��� dk = 1) 
            p_taxacc        => null,                     -- ���� ������� ��� ���������� � �� (��� dk = 1) 
            p_aimid         => null,                     -- ��� ���� �������/�������
            p_contractid    => null,                     -- ������������� ���������
            p_contractnum   => null,                     -- ����� ���������/����.��������
            p_contractdat   => null,                     -- ���� ���������/����.��������
            p_custdeclnum   => null,                     -- ����� ��������� �����.����������
            p_custdecldat   => null,                     -- ���� ��������� �����.����������
            p_prevdecldat   => null,                     -- ���� ��������.�����.����������    (��� dk = 1)
            p_basis         => null,                     -- ��������� ��� ������� ������      (��� dk = 1)
            p_countryid     => null,                     -- ��� ������ ������������ ������    (��� dk = 1)
            p_bnfcountryid  => null,                     -- ��� ������ �����������            (��� dk = 1)
            p_bnfbankcode   => null,                     -- ��� ����� (B010)                  (��� dk = 1)
            p_bnfbankname   => null,                     -- �������� �����                    (��� dk = 1)
            p_productgrp    => null,                     -- ��� �������� ������               (��� dk = 1)
            p_details       => null,                     -- ����������� ������
            p_flag          => 0,                        -- ������� ��-� (����)
            p_fio           => null,                     -- ��� ���������������
            p_tel           => null,                     -- ��� ���������������
            p_branch        => null,                     -- ����� ������
            p_operid_nokk   => null,                     -- ��������� ����� �������� � ������ �볺��-���� (����, �����) 
            p_req_type      => null,                     -- ��� ������
            p_vdateplan     => null,                     -- �������� ���� �������������
            p_obz           => 1,                        -- ������� ������ �� ������������ ������� (1)
            p_reqid         => l_reqid);

        update zayavka
           set okpo0     = l_zay.okpo0,
               rnk_pf    = d27_1,
               priority  = 0,
               fnamekb   = l_zay.fnamekb,
               identkb   = l_zay.identkb,
               tipkb     = l_zay.tipkb,
               datedokkb = l_zay.datedokkb,
               datt      = l_zay.datt,
               soper     = soper_,
               refoper   = ref_ 
         where id = l_reqid;

        DELETE FROM zay_debt_klb WHERE fnamekb=namekb_ AND identkb=idkb_;

     -- ������� ������ �� ������.������� ������
     ELSE
        bars_audit.trace( $$PLSQL_UNIT||': zayavka. rnk_=%s, acc980_=%s, nls980_=%s, okpo26_=%s, acc_=%s'
                        , to_char(rnk_), to_char(acc980_), to_char(okpo26_), to_char(okpo26_), to_char(acc_) );

        begin
          select nls into l_nls0 from accounts 
           where acc = acc980_;
        exception
          when no_data_found then
           l_nls0 := null;
        end;
        
        begin
          select nls into l_nls1 from accounts
           where acc = acc_;
        exception
          when no_data_found then
           l_nls1 := null;
        end;

        bars_zay.create_request_ex 
           (p_reqtype       => 2,                        -- ��� ������ (1-�������, 2-�������, 3-���������)
            p_custid        => rnk_,                     -- �������.� �������
            p_curid         => kv_,                      -- ����.��� ������ (��� dk(1,3) - ������� ����������, ��� 2 - ������� ���������)
            p_curconvid     => null,                     -- ����.��� ������ �� ������� ���������� (��� dk = 3)
            p_amount        => s1_/100,                  -- ����� ���������� ������ ("�����������")
            p_reqnum        => null,                     -- ����� ������
            p_reqdate       => gl.bdate,                 -- ���� ������
            p_reqrate       => kurs_,                    -- ���� ������
            p_nls_acc1      => l_nls1,                   -- � ����� � ��.���. (��� 1 - ��� ���� ����������, ��� 2 - ��� ���� ��������, ��� 3 - ��� ���� ����������)
            p_nls_acc0      => l_nls0,                   -- � ����� � ���.���.(��� 1 - ��� ���� ��������, ��� 2 - ��� ���� ����������(��� ���������� �����.��� �� ������� - ���� �������,���� ����������� ���� mfo0, nls0,okpo0), ��� 3 - ��� ���� ��� ��������)
            p_nataccnum     => nls980_,                  -- ���� � ���.������ � ��.�����     (��� dk = 2)
            p_natbnkmfo     => nvl(mfo980_,mfo_),        -- ��� ����� ����� � ���.������     (��� dk = 2)
            p_cmsprc        => kom_,                     -- ������� (%) ��������
            p_cmssum        => null,                     -- ����.����� ��������
            p_taxflg        => 1,                        -- ������� ���������� � ��          (��� dk = 1) 
            p_taxacc        => null,                     -- ���� ������� ��� ���������� � �� (��� dk = 1) 
            p_aimid         => null,                     -- ��� ���� �������/�������
            p_contractid    => null,                     -- ������������� ���������
            p_contractnum   => null,                     -- ����� ���������/����.��������
            p_contractdat   => null,                     -- ���� ���������/����.��������
            p_custdeclnum   => null,                     -- ����� ��������� �����.����������
            p_custdecldat   => null,                     -- ���� ��������� �����.����������
            p_prevdecldat   => null,                     -- ���� ��������.�����.����������    (��� dk = 1)
            p_basis         => null,                     -- ��������� ��� ������� ������      (��� dk = 1)
            p_countryid     => null,                     -- ��� ������ ������������ ������    (��� dk = 1)
            p_bnfcountryid  => null,                     -- ��� ������ �����������            (��� dk = 1)
            p_bnfbankcode   => null,                     -- ��� ����� (B010)                  (��� dk = 1)
            p_bnfbankname   => null,                     -- �������� �����                    (��� dk = 1)
            p_productgrp    => null,                     -- ��� �������� ������               (��� dk = 1)
            p_details       => null,                     -- ����������� ������
            p_flag          => 0,                        -- ������� ��-� (����)
            p_fio           => null,                     -- ��� ���������������
            p_tel           => null,                     -- ��� ���������������
            p_branch        => null,                     -- ����� ������
            p_operid_nokk   => null,                     -- ��������� ����� �������� � ������ �볺��-���� (����, �����) 
            p_req_type      => null,                     -- ��� ������
            p_vdateplan     => null,                     -- �������� ���� �������������
            p_obz           => 1,                        -- ������� ������ �� ������������ ������� (1)
            p_reqid         => l_reqid);

        update zayavka
           set okpo0   = okpo26_,
               rnk_pf  = d27_1,
               soper   = soper_,
               refoper = ref_
         where id = l_reqid;

     END IF;

  END IF;
  
  case
    when ( mod_ = 1 )
    then
      
      if ( refd_ Is not Null )
      then
        insert into BARS.ZAY_DEBT
          ( REF, REFD, TIP, ZAY_SUM, SOS )
        values
          ( ref_, refd_, 1, null, case when s2_ = soper_ then 2 else 0 end );
      end if;
      
    when ( mod_ = 2 )
    then
      
      if ( refd_ Is not Null )
      then
        insert into BARS.ZAY_DEBT
          ( REF, REFD, TIP, ZAY_SUM, SOS )
        values
          ( ref_, refd_, 2, s1_, 2 );
      end if;
      
    when ( mod_ = 3 )
    then
      
      if nvl(s1_,0) > 0 
      then
        
        insert into BARS.ZAY_DEBT
          ( REF, REFD, ZAY_SUM, TIP, SOS )
        values
          ( ref_, null, s1_, 2, 0 );
        
      end if;
      
    else
      null;
    
  end case;

EXCEPTION
  when ERR then
    raise_application_error( -(20000+ern),'\'||erm, true );
END P_ZAYDEBT;
/
show err;

PROMPT *** Create  grants  P_ZAYDEBT ***
grant EXECUTE                                                                on P_ZAYDEBT       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAYDEBT       to START1;
grant EXECUTE                                                                on P_ZAYDEBT       to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_ZAYDEBT       to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAYDEBT.sql =========*** End ***
PROMPT ===================================================================================== 
