create or replace procedure PAYTT
( flg_ SMALLINT,  -- ���� ������
  ref_ INTEGER,   -- ����������
 datv_ DATE,      -- ���� ������������
   tt_ CHAR,      -- ��� ����������
  dk0_ NUMBER,    -- ������� �����-������
  kva_ SMALLINT,  -- ��� ������ �
 nls1_ VARCHAR2,  -- ����� ����� �
   sa_ DECIMAL,   -- ����� � ������ �
  kvb_ SMALLINT,  -- ��� ������ �
 nls2_ VARCHAR2,  -- ����� ����� �
   sb_ DECIMAL    -- ����� � ������ �
) IS

--***************************************************************--
--             ����� ������������ ��� ��������� ������
--                    Version 7.8  10/06/2014

--             OSC - ��� ��������� 
--                   � ������������ ������� ���� + ����������� �� ����������
--             BRANCH - ��� ����� � ����� 'branch'
--             ZAY - ��� ������ "�������� ��������" (������� ����� ��������)
--             S36 - ������ �� ������ 3600 S36 (�������� �����)
--             SPN - � �������� ������.���. SPM �� �������� ��� (��� �� � ���)
--                   ��������  � doc\Modules Manual\SPM\Den_0.doc,
--             OVR - � ����-�����������

--             RU - ���.���. �������� ����� ������:
--             2009:�i���,�����,�������,������, 
--             2010:I�.��,�i�����,�������,����i��i,�����i���,����,����i�
--             2011:��������������, ������, ��������, ������, �������, ...
--             2012: ���� �����

--             CASH - c ������ ������ ����� � ��������� ������������� ���
--             ��� �����
--***************************************************************--

-- ����� ����������
   l_SERR  varchar2(35); l_NERR  int;

   flv_   SMALLINT;
   kv_    SMALLINT;

   NLSM_  tts.nlsm%type;
   NLSK_  tts.nlsk%type;

   kvk_   SMALLINT;
   l_s4   char(4) ;

   nlsa_  tts.nlsa%type; --VARCHAR2(15);
   nlsb_  tts.nlsb%type; --VARCHAR2(15);

   flg19_ CHAR(1); flg20_ CHAR(1);
   flg21_ CHAR(1); flg22_ CHAR(1);
   flg23_ CHAR(1); flg24_ CHAR(1);
   flg25_ CHAR(1); -- ���� �������� + ��� ��������
   flg38_ CHAR(1);
   nls_k_ VARCHAR2(15);
   ss_    DECIMAL(24);
   nbsd_  CHAR(4);
   rnk_   INTEGER;
   isp_   SMALLINT;
   tobo_  VARCHAR2(100);
   nmk_   customer.nmk%type;
   nms_   accounts.nms%type;
   tip_   accounts.tip%type;
   acc_   INTEGER;
   tmp_   NUMBER;
   grp_   NUMBER;
   dk_    BINARY_INTEGER;
   suf_   VARCHAR2(4);
   mfo_   VARCHAR2(12) DEFAULT NULL;
   accmask_ NUMBER;
   l_ostc   number;
   l_lim    number;
   l_tobo   varchar2(30);
   l_acco   number;
   l_acc    number;
   l_nls2   accounts.nls%type;

-- OVR:���������� ��� ����������
   OVR_SUM_ number  ;
   OVR_NS8_ varchar2(15);
   l_cntDk1 number;
   l_cntDk0 number;

   nls_kom_ VARCHAR2(15);

  -------
  FUNCTION f_GetNSC (p_nazn IN VARCHAR2)  RETURN   VARCHAR2
  IS
    tmp_   VARCHAR2(200);   L_  NUMBER;  NSC_    VARCHAR2(200);
  BEGIN
    L_   := instr (p_nazn, ';');   tmp_ := substr(p_nazn, L_+1,200  );
    L_   := instr (tmp_,   ';');   NSC_ := substr(tmp_  , 1   , L_-1);
    RETURN NSC_;
  END f_GetNSC;
  --------
  FUNCTION f_GetDBCODE (p_nazn IN VARCHAR2) RETURN  VARCHAR2
  IS
    tmp_     VARCHAR2(200);  L_ NUMBER;  DBCODE_  VARCHAR2(200);
  BEGIN
    L_   := instr (p_nazn, ';');   tmp_   := substr(p_nazn, L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   DBCODE_:= substr(tmp_  , 1   ,L_-1);
    RETURN  DBCODE_;
  END f_GetDBCODE;
  ---------

PROCEDURE auto_op (flg_ SMALLINT,nls_  VARCHAR2,kv_  NUMBER,
                                 nls0_ VARCHAR2,kv0_ NUMBER)
IS -- ������������ ������      (flg = ����� 23 24 minus 1)
  branch_  accounts.branch%type;
  tobo_    accounts.tobo%type;
  ob22_    accounts.ob22%type;
  sec_     accounts.sec%type;
BEGIN
   SELECT acc INTO acc_
     FROM accounts WHERE nls=nls_ AND kv=kv_ AND DAZS IS NULL;
EXCEPTION WHEN NO_DATA_FOUND THEN -- AutoOpening
   BEGIN
      BEGIN
         SELECT a.rnk,a.isp,a.nms,a.grp,c.nmk,a.acc,a.sec
           ,a.branch,a.tobo
	   ,a.ob22
         INTO     rnk_,isp_,nms_,grp_,nmk_,accmask_,sec_
           ,branch_,tobo_
           ,ob22_
         FROM accounts a, customer c
         WHERE a.nls=nls0_ AND a.kv=kv0_ AND a.rnk=c.rnk;
      EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
      END;
      IF BITAND(flg_,1)=1 THEN nms_:=nmk_; END IF;

      BEGIN
         SELECT tip INTO tip_ FROM nbs_tips 
          WHERE nbs=SUBSTR(nls_,1,4) AND BITAND(opt,1)=1 AND rownum=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN tip_:='ODB';
      END;

      OP_REG(99,0,0,grp_,tmp_,rnk_,nls_,kv_,nms_,tip_,isp_,acc_);

      update accounts set sec=sec_
           ,branch=branch_,tobo=tobo_
       where acc=acc_;
      IF BITAND(flg_,8)=8 THEN  -- specparam_int 
      	 BEGIN
            update specparam_int
               set ob22=
              case when substr(nls0_,1,4)='1602' and ob22_='03' then '05'
                   when substr(nls0_,1,4)='2600' and ob22_='10' then '06'
                   when substr(nls0_,1,4)='2650' and ob22_='09' then '06'
                   when substr(nls0_,1,4)='2610' and ob22_='19' then '07' 
               end	
             where acc=acc_;

            if sql%rowcount=0 then
               insert into specparam_int(acc, ob22)
               values (acc_, case when substr(nls0_,1,4)='1602' and ob22_='03' then '05'
                                  when substr(nls0_,1,4)='2600' and ob22_='10' then '06'
                                  when substr(nls0_,1,4)='2650' and ob22_='09' then '06'
                                  when substr(nls0_,1,4)='2610' and ob22_='19' then '07' 
                             end );
            end if; 
         END; 
      END IF;

   EXCEPTION  WHEN OTHERS THEN
      raise_application_error(-(20203),'\9356 - Unable to open acc #'||nls_||'('||kv_||') ' || SQLERRM,TRUE);
   END;
END; -- auto_op

FUNCTION sb_nls (P VARCHAR2) RETURN VARCHAR2
IS -- ���������� ������ ����� �� �������
  S  varchar2(254);
BEGIN
  S := REPLACE(P,'#(REF)',TO_CHAR(ref_));
  S := REPLACE(S,'#(TT)',''''||tt_||'''');
  S := REPLACE(S,'#(NLSA)',''''||nls1_||'''');
  S := REPLACE(S,'#(NLSB)',''''||nls2_||'''');
  S := REPLACE(S,'#(KVA)',TO_CHAR(kva_));
  S := REPLACE(S,'#(KVB)',TO_CHAR(kvb_));
  S := REPLACE(S,'#(S)',   TO_CHAR(sa_));
  S := REPLACE(S,'#(SA)',  TO_CHAR(sa_));
  S := REPLACE(S,'#(SB)',  TO_CHAR(sb_));
  S := REPLACE(S,'#(S2)',  TO_CHAR(sb_));
  S := REPLACE(S,'#(DK)',  TO_CHAR(dk0_));
  S := REPLACE(S,'#(VDAT)','TO_DATE('||TO_CHAR(datv_,'YYYYMMDD')||',''YYYYMMDD'')');
  RETURN S;
END; -- nls substitution



BEGIN

  bars_audit.trace('PAYTT('
        ||'flg_ => '||flg_
        ||',ref_ =>  '||ref_
        ||',datv_  => '''||to_char(datv_,'DD.MM.YYYY')||''''
        ||',tt_  => '''||tt_||''''
        ||',dk0_  => '||dk0_
        ||',kva_  => '||kva_
        ||',nls1_  => '''||nls1_||''''
        ||',sa_  => '||sa_
        ||',kvb_  => '||kvb_
        ||',nls2_  => '''||nls2_||''''
        ||',sb_  => '||sb_
        );

  l_nls2 := nls2_;

  IF sa_=0 THEN RETURN; END IF;  -- SUB

  -- ��� ������ � ������ � ������������ ��� - ����� ��������� ������� �� 
  -- ����� � ������������ ���
  if bars_cash.G_ISUSECASH = 1 and bars_cash.G_CURRSHIFT = 0 then
     -- ��i�� �� �� ���� �������
     bars_cash.open_cash(p_shift => 1, p_force => 1);
  end if;

  --
  -- ������ ��������� ���������� ������� ���������� ��� (���)
  --
  --------------
  If gl.aMFO  ='300465' and  dk0_=1 and
     (   tt_  ='TK '    and nls1_='2906401'
      OR tt_  ='TK2'    and nls1_='2906603'
      OR tt_  ='TK3'    and nls1_='29067003'
      ) THEN
/*
    �������� �������� �� ����������
    ��������� ���������� �� ���������� ���������.������
    ��� �������� � ����������� ������������ �� DB_LINK
    � ���o������ �������

    1. �������� 'TK ', ���� ��������� nls1_='2906401'   , ��� ��� = NLA
       ������� ����.����              nls2_='2906301301', ��� ��� = TK

    2. �������� 'TK2', ���� ��������� nls1_='2906603'   , ��� ��� = NLP
       ����.���� �� ���������         nls2_='2906501202 , ��� ��� = TK2

    3. �������� 'TK3', ���� ��������� nls1_='29067003'  , ��� ��� = NL3
       ����.���� ����� ��������       nls2_='2906301301', ��� ��� = TK3
*/
     declare
         p_ND     oper.nd%type  ; -- �� �� ��� ���������� ���������
         p_REF    oper.ref%type ; --
         p_nazn   oper.nazn%type; -- ����� ������.�������
         tmp_     varchar2(200);  L_    int;
         p_DBCODE varchar2(160);  -- ��� �������          � �� �� DB_LINK
         L_DBCODE int;            -- �������� ����� ���a �������
         p_NSC    varchar(160) ;  -- � ����� (����������) � �� �� DB_LINK
         L_NSC    int;            -- �������� ����� � ����� (����������)
         s_source    number;         -- ����� ���������� ���������
         kv_source   number;         -- ������ ���������� ���������
         nazn_source oper.nazn%type; -- ���������� ���������� ���������
         l_tip    char(3);        -- ��� �����
         l_mfob   oper.mfob%type;
         l_ru     banks_ru.ru%type;
         l_dig    varchar2(1);
         l_namb   oper.nam_b%type;
         l_br     crv_back_refs%rowtype;
         l_manual boolean;  -- ���� ������� �������
     -- ������ �� �������������� ��� �������
     begin
        bars_audit.trace('PAYTT-' || ref_ || '. USSR');

        --
        -- ������ ����� ��������� � ���������� ������� ���� ��*
        select nd, nazn into p_ND, p_nazn
        from oper where ref= ref_;
        bars_audit.trace('PAYTT-' || ref_ || '. p_nd=>'||p_nd);

        if p_ND='DBF' then
            -- ������� � ��������� DBF 3902? ������� �������� � ������� �� ����� ����� ������ ���������
            NULL;
        else
            -- ����� ��������� ������������� ������� ������ ��������� ��������� ���������
            begin
               p_REF := to_number(p_ND);
            EXCEPTION  WHEN OTHERS THEN
               bars_audit.trace('PAYTT-' || ref_ || '. ��.� ���(�� �����) ='|| p_ND);
               RAISE_APPLICATION_ERROR (-20001, '��.� ���(�� �����) ='|| p_ND);
            end;
            bars_audit.trace('PAYTT-' || ref_ || '. p_ref=>'||p_ref);

            -- ������ ����� � ������ ���������(������������ ��������) ���-��
            -- + ��� ���������� ������� � ��� ��� ������� (��)
            select s, kv, mfob, mfo_ru(mfob), nazn into s_source, kv_source, l_mfob, l_ru, nazn_source
            from oper where ref= p_ref;
            bars_audit.trace('PAYTT-' || ref_ || '. s_source=>'||s_source||' kv_source=>'||kv_source||', mfob='||l_mfob||', ru='||l_ru);

            -- ������ ��� ����� �
            select tip into l_tip from accounts where nls=l_nls2 and kv=kvb_;
            bars_audit.trace('PAYTT-' || ref_ || '. l_tip=>'||l_tip);

            -- �������� ����� ���� ������� � ������� crv_back_refs(������������ ��������� � ��������� ������)
            -- � ��� ������� ������ ���������� ������������� ��������, ��� ������� ����� ������� ���� ��������� �������
            begin
                select * into l_br from crv_back_refs where payment_ref=p_ref;
                l_manual := true;  -- ������ ������
            exception when no_data_found then
                l_manual := false;
            end;

            if l_manual then

                p_NSC    := NULL;
                p_DBCODE := NULL;

            else

                p_NSC    := f_GetNSC   (p_nazn);  L_NSC   := Nvl(length(p_NSC   ),0);
                bars_audit.trace('PAYTT-' || ref_ || '. p_nsc=>'||p_nsc);
                If L_NSC <1 OR L_NSC >19 then
                    bars_audit.trace('PAYTT-' || ref_ || '. ��.� �����');
                    RAISE_APPLICATION_ERROR (-20001, '��.� �����');
                end if;

                If tt_ in ('TK ','TK3')  then
                    p_DBCODE := f_GetDBCODE(p_nazn);  L_DBCODE:= Nvl(length(p_DBCODE),0);
                    bars_audit.trace('PAYTT-' || ref_ || '. p_dbcode=>'||p_dbcode);
                    If L_DBCODE <1 OR L_DBCODE >11 then
                        bars_audit.trace('PAYTT-' || ref_ || '. ��.DBCODE');
                        RAISE_APPLICATION_ERROR (-20001, '��.DBCODE');
                    end if;
                end if;

                -- ��������� �� ����������
                If s_source <> sa_ then
                   bars_audit.trace('PAYTT-' || ref_ || '. ������ �����: ��������� '||s_source/100||', ���������� '||sa_/100);
                   raise_application_error (-20001, '������ �����: ��������� '||s_source/100||', ���������� '||sa_/100);
                end if;

                if kv_source <> kva_ then
                   bars_audit.trace('PAYTT-' || ref_ || '. ������ ������: '|| kv_source ||'(������ �������) HE= '||kva_||'(������ ��������)');
                   raise_application_error (-20001, '������ ������: '|| kv_source ||'(������ �������) HE= '||kva_||'(������ ��������)');
                end if;

                if ( l_tip <> 'TK3' and substr(p_nazn,1,1) =  '�' ) or
                   ( l_tip =  'TK3' and substr(p_nazn,1,1) <> '�' ) then
                   bars_audit.trace('PAYTT-' || ref_ || '. ��. ������������� �����(TK3)-���������� �������(�)');
                   RAISE_APPLICATION_ERROR (-20001, '��. ������������� �����(TK3)-���������� �������(�)');
                end if;

            end if;

            -- ��������� ���� � �� ���� ������������ ����������, ������ ������ ������
            l_dig := replace(substr(l_tip,3,1),' ','1');
            l_nls2 := vkrzn(substr(gl.amfo,1,5),'290600'||l_dig||lpad(l_ru,2,'0'));
            begin
                -- ������ ������������ �����
                select substr(nms,1,38) into l_namb from accounts where nls=l_nls2 and kv=kva_;
            exception when no_data_found then
                raise_application_error (-20001, '�� ������ ���� �: '||l_nls2||'('||kva_||')');
            end;
            -- ������ ������� � � oper
            update oper set nlsb=l_nls2, nam_b=l_namb where ref=ref_;
            --
            If tt_ in ('TK ','TK3')  then
               -- ������� ������� ������� (1000 ��� ��� ����������)
               execute immediate
                'begin USSR_PAYOFF.payoff_back_ex@DEPDB(:p_REF, :p_DBCODE, :p_NSC, :p_RETURNED_REF); end;'
                 using p_ref, p_dbcode, p_nsc, ref_;
            ElsIf tt_='TK2' then
               -- ����������� �� ��������� 500 ��� (������ ������ ���������� �������)
               execute immediate
                'begin USSR_PAYOFF.payoff_back2@DEPDB(:p_REF, :p_NSC); end;'
                 using p_ref, p_nsc;
            end if;
            --
        end if;

     end;
  end if;
  --------------
  --
  -- �������� �������� C14 �� ����� 2906401201
  --
  if gl.aMFO  ='300465' and  dk0_=1 and tt_  ='C14' and nls1_='2906401201'
  then
      declare
        l_ref_ssr     integer;
      begin
        -- ND(����� ���������) ��������� C14 ������ ��������� � ���������� SSR ���-��
        select to_number(nd) into l_ref_ssr from oper where ref=ref_;
        execute immediate
            'begin ussr_payoff.assign_c14_to_ssr@depdb(:p_ref_ssr, :p_ref_c14); end;'
             using l_ref_ssr, ref_;
      end;
  end if;
  --------------
  --
  -- ����� ��������� ���������� ������� ���������� ��� (���)
  --
        
-- ������� ���������� dk_ ����� ����� ����������
   dk_  := dk0_;

   BEGIN
      SELECT flv, kv, trim(nlsm), kvk, trim(nlsk),
             SUBSTR(flags,19,1), SUBSTR(flags,20,1),
             SUBSTR(flags,21,1), SUBSTR(flags,22,1),
             SUBSTR(flags,23,1), SUBSTR(flags,24,1), 
             SUBSTR(flags,25,1), SUBSTR(flags,38,1)
        INTO flv_,kv_,nlsm_,kvk_,nlsk_,
             flg19_,flg20_,flg21_,flg22_,flg23_,flg24_,flg25_,flg38_
        FROM tts WHERE tt=tt_;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         raise_application_error(-(20203),'\9350 - No '||tt_||' operation defined ' || SQLERRM,TRUE);
   END;

-- ���������� ����� ����� �� �������, ���� ����

   IF SUBSTR(nlsk_,1,2)='#(' THEN -- Dynamic account number present
      BEGIN
      EXECUTE IMMEDIATE
        'SELECT '||sb_nls(SUBSTR(nlsk_,3,LENGTH(nlsk_)-3))||' FROM DUAL' INTO nlsk_;
      EXCEPTION WHEN OTHERS THEN
         raise_application_error(-(20203),'\9351 - Cannot get account nom via #'||nlsk_||' '||SQLERRM,TRUE);
      END;
   END IF;

   IF SUBSTR(nlsm_,1,2)='#(' THEN -- Dynamic account number present
      BEGIN
      EXECUTE IMMEDIATE
        'SELECT '||sb_nls(SUBSTR(nlsm_,3,LENGTH(nlsm_)-3))||' FROM DUAL' INTO nlsm_;
      EXCEPTION WHEN OTHERS THEN
         raise_application_error(-(20203),'\9351 - Cannot get account nom via #'||nlsm_||' '||SQLERRM,TRUE);
      END;
   END IF;

   IF flg19_='1' THEN  kv_  := NVL(kvk_, kvb_); ELSE kv_  := NVL(kv_, kva_); END IF;
   IF flg20_='1' THEN  kvk_ := NVL(kv_, kva_);  ELSE kvk_ := NVL(kvk_,kvb_); END IF;
   IF flg21_='1' THEN nlsa_:=trim(l_nls2); ELSE nlsa_:=trim(nls1_); END IF;
   IF flg22_='1' THEN nlsb_:=trim(nls1_); ELSE nlsb_:=trim(l_nls2); END IF;

-- A Side -----------------------------------------------------------------
-- ������� ����� ������������ ������� ��� ������ "�������� ��������" ----------
   IF tt_ = 'GO3' AND kv_ = gl.baseval THEN
     BEGIN
       SELECT decode(o.kv, 980, z.nls_kom2, z.nls_kom)
         INTO nls_kom_
         FROM oper o, tts t, accounts a, cust_zay z
        WHERE o.ref = ref_
          AND o.tt IN ('GO1','GO5')
          AND t.tt = 'GO3'
          AND o.nlsa = a.nls
          AND o.kv = a.kv
          AND a.rnk = z.rnk(+)
          AND decode(o.kv, 980, z.nls_kom2, z.nls_kom) IS NOT NULL;
      nlsk_ := nls_kom_;
     EXCEPTION
       WHEN NO_DATA_FOUND THEN NULL;
     END;
   END IF;

   IF nlsm_ IS NULL THEN
      nlsm_ := nlsa_;
   ELSE
      IF FALSE THEN NULL;
      ELSIF tt_ IN ('K01','K02','K03','K04')
         OR tt_ IN ('028')
      THEN
         BEGIN
            SELECT a.rnk,a.isp,a.nms,a.grp,k.nmk,b.mfo,a.acc, a.tobo
              INTO   rnk_, isp_, nms_, grp_, nmk_, mfo_, accmask_, tobo_
              FROM accounts a, customer k, bank_acc b
             WHERE a.nls=nlsa_ AND a.kv=kva_ AND a.rnk=k.rnk AND a.acc=b.acc(+);
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            raise_application_error(-(20203),'\9354 - No account found #'||nlsa_||' ' || SQLERRM,TRUE);
         END;
         nlsm_ := sb_acc(nlsm_,nlsa_,ref_,datv_,tt_,dk0_,kva_,sa_,kvb_,sb_);
         IF SUBSTR(tt_,1,2)='K2' THEN
            suf_ := 'K2: ';

         ELSIF SUBSTR(tt_,1,2)='K0' THEN
            suf_ := 'PO: ';
         ELSE
            suf_ := tt_||' ';
         END IF;
         nlsm_:=VKRZN(SUBSTR(gl.aMFO,1,5),nlsm_);

         BEGIN
            SELECT acc INTO acc_ FROM accounts WHERE nls=nlsm_ AND kv=kva_ AND dazs IS NULL;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            IF mfo_ IS NULL THEN
               OP_REG(99,0,0,grp_,tmp_,rnk_,nlsm_,kva_,
                      TRIM(SUBSTR(suf_||nmk_,1,70)),'ODB',isp_,acc_);
               p_setAccessByAccmask(acc_,accmask_);
            ELSE
               OP_REG(5,mfo_,0,grp_,tmp_,rnk_,nlsm_,kva_,
                      TRIM(SUBSTR(suf_||nmk_,1,70)),'ODB',isp_,acc_);
               p_setAccessByAccmask(acc_,accmask_);
            END IF;
--  H����������� ���� ����: 
            UPDATE Accounts set TOBO=tobo_ where ACC=acc_;
         END;

--  ʳ���� else_KAZ

      ELSIF tt_='1KZ' THEN
         nlsm_ := sb_acc(nlsm_,nlsb_,ref_,datv_,tt_,dk0_,kva_,sa_,kvb_,sb_);
      ELSE
         nlsm_ := sb_acc(nlsm_,nlsa_,ref_,datv_,tt_,dk0_,kva_,sa_,kvb_,sb_);
      END IF;
   END IF;

-- B Side -----------------------------------------------------------------

   IF nlsk_ IS NULL THEN
      nlsk_ := nlsb_;
   ELSE
      IF FALSE THEN NULL;
      ELSIF tt_='OVD'
      THEN
         BEGIN
            SELECT b.nls INTO nlsk_
              FROM accounts b WHERE b.acc =
           (SELECT o.acco FROM acc_over o,accounts a
             WHERE a.nls=nlsa_ AND a.kv=kva_ AND a.acc=o.acc);
         EXCEPTION WHEN NO_DATA_FOUND THEN
            raise_application_error(-(20203),'\9357 - No OVERDRAFT account found for #'||nlsa_||' ' || SQLERRM,TRUE);
         END;
      ELSE
         nlsk_ := sb_acc(nlsk_,nlsb_,ref_,datv_,tt_,dk0_,kva_,sa_,kvb_,sb_);
      END IF;
   END IF;

   IF flv_=1 THEN
      ss_ := NVL( sb_, gl.p_iCurval(KV_, SA_, gl.BDATE ) ) ;
   ELSE
      ss_ := sa_; kvk_ := kv_; -- ��� ������������ ������ sb=sa
--      IF flg20_='1' THEN kv_ := kvk_; ELSE kvk_ := kv_; END IF;
   END IF;

---- ��� "�����������":  ������� �� 8000

   Select count(*) into l_cntDk1 from dual
   where exists
      (select 1 from acc_over_nbs where nbs2600 = substr(nlsm_,1,4));
   select count(*) into l_cntDk0 from dual
   where exists
       (select 1 from acc_over_nbs where nbs2600 = substr(nlsk_,1,4));
   if (DK_=1 and (substr(NLSM_,1,4) = '2600' or l_cntDk1 > 0)) or
      (DK_=0 and (substr(NLSK_,1,4) = '2600' or l_cntDk0 > 0)) then
      --���� ���������� � ������ ����?� DK_
      BEGIN
         SELECT least(a.lim+least(a.ostb,0), SA_-greaTEST(a.ostb,0)) ,
                a8.nls
         into OVR_SUM_, OVR_NS8_
         from accounts a, acc_over o, accounts a8
         where SA_>a.ostb and a.lim+a.ostb>0 and
               a.kv=KV_  and a.nls=decode(DK_,1,NLSM_,NLSK_) and
               a.acc=o.acc and a.acc=o.acco and a8.acc=o.acc_8000;
      EXCEPTION WHEN NO_DATA_FOUND THEN OVR_SUM_:=0;
      end;
      if OVR_SUM_ >0 then
         gl.payv(flg_,ref_,datv_,tt_,dk_,kv_,OVR_NS8_,OVR_SUM_,kv_,OVR_NS8_,OVR_SUM_);
      end if;
   end if;

-----
  IF flg23_ BETWEEN '1' AND '9' THEN auto_op(ASCII(flg23_)-48,nlsm_,kv_, nlsa_,kva_); END IF;
  IF flg24_ BETWEEN '1' AND '9' THEN auto_op(ASCII(flg24_)-48,nlsk_,kvk_,nlsb_,kvb_); END IF;
-----


--
/* ************************************************************** */

declare
  VDAT_ date   ;
  NBS2_ char(4);
begin
  VDAT_ := datv_;
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    -- ���� ������ ��� ��.�����
    --If ( getglobaloption('MFOP')='300465' or gl.aMfo='300465') then  
       EXECUTE IMMEDIATE 
         'begin PAY_S36 (:flg_,:ref_, :VDAT_, :tt_,:dk_,:kv_,:nlsm_,:sa_,:kvk_,:nlsk_,:ss_); end;'
       USING flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_;
    --end if;

--��� �������� ����������� ���������������.
If nvl(sa_,0) <> 0  OR  nvl(ss_,0) <>0  then
   declare
   l_ttx  VARCHAR2(3);
   l_nbsd PAYTT_NO.nbsd%type;
   l_nbsk PAYTT_NO.nbsk%type;
   begin
     -- 21-12-2011 Sta
     If nlsm_ = nlsk_ and kv_=kvk_ then
        l_s4 := substr(nlsm_,1,4);
        If Not ( l_s4 like '8%'   OR
                 l_s4 in ( '1001', '1002', '9819' , '9820','9821') ) 
        then
          raise_application_error( -(20203), '\9358 - ���������� �������������� ������� # "��� �� ����"', TRUE );
        end if;
     end if;

     If kv_<> kvk_ and (nlsm_ like '3739%' OR nlsk_ like '3739%') then 
        null;
     else 
       select n.nbsd, n.nbsk, n.tt 
         into l_nbsd, l_nbsk, l_ttx  
         from PAYTT_NO n
        where  rownum=1
          and TT_ = Nvl(n.TT,TT_)
          and (dk_=1 and nlsm_ like trim(NBSD)||'%' AND nlsk_ like trim(NBSK)||'%'
               OR 
               dk_=0 and nlsk_ like trim(NBSD)||'%' AND nlsm_ like trim(NBSK)||'%'
              );
       raise_application_error( -(20203), '\9358 - ���������� �������������� ������� #' ||TRIM(l_nbsd)||' �� '||TRIM(l_nbsk)||
                                          CASE WHEN l_ttx IS NULL THEN '' ELSE ' ����� �������� '||l_ttx END, TRUE );
     end if;
    
   EXCEPTION
     WHEN NO_DATA_FOUND THEN null;
   end;

/*
   -- 21-02-2011 Sta �������� ������ 
   If kv_ = kvk_ and kv_<> gl.baseval AND 
     (substr(nlsm_,1,4) in ('2809','2909') and substr(nlsk_,1,2)='10'
      OR 
      substr(nlsk_,1,4) in ('2809','2909') and substr(nlsm_,1,2)='10' 
     )
      then
      PAY_MONEY(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_);
   end if;
*/

/*
    ³������� �� ����� ������� ���������� � 2012 ���� ������ ���������� ������ ����������� ����� 
    �� ���������� �������� ����������, ��������� �� 02.01.1992 ���� � �������� �������� ����� ����, 
    �� ���� �� ������� ������, �� � �������� �������� ������� ������������ ������ 1990 ����, 
    ������� ����������� �����'������ ���� � ����������� �������� ����� ����, ������� �� �������
    ��������� ���, ������������� ������� �������� �� 08.05.2012 � 31/-04/33 �� ����������� 
    ̳���������� ������� ������ �� 23.05.2012 �31-11020-09/13030, ������� ����������� �� ��������� 
    ���������, �� ������� � 2005-2012 �����, ����������� ������ ����������� ����� �� ������ 
    ������� ����������.
    
    �������� - ����� 2906(09) ������ 1001(1002) - ����� ������ �� "��������" 03.07.2012 �. � 14/2-1/1563
*/ 
     
     Declare
       l_acc_ob22 accounts.ob22%type := null;
     begin
       If dk_ = 1 and Substr(nlsm_,1,4) = '2906' THEN
         begin
         select ob22 into l_acc_ob22 from accounts where nls=nlsm_ and  kv=kv_;
         exception WHEN NO_DATA_FOUND then null; 
         end; 
       ElsIf   dk_ = 0 and Substr(nlsk_,1,4) = '2906' THEN 
         begin
         select ob22 into l_acc_ob22 from accounts where nls=nlsk_ and  kv=kvk_;
         exception WHEN NO_DATA_FOUND then null; 
         end;
       end If;
       If l_acc_ob22='09' and ((dk_ = 1 and Substr(nlsk_,1,3) = '100') or (dk_ = 0 and Substr(nlsm_,1,3) = '100')) 
       then
         raise_application_error( -(20203), '\9350 - ���������� �������������� ������� 2906(09) �� ���� '||(case when dk_=0 then Substr(nlsm_,1,4) else Substr(nlsK_,1,4) end), TRUE );
       end if;
     End;


end if;

    If tt_ NOT in ('ARE','AR*') and (nlsm_ like '77%' OR nlsk_ like '77%' ) then  -- 15-02-2012 Sta+�������� ����  �������� ������ �������� �� ���.�����
       pay_REZ(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_);
    end if;

    --------- ���������� ������ �������
    if nlsm_ like '61%' or nlsk_ like '61%' and gl.doc.DEAL_TAG is not null and  gl.aRef = gl.doc.ref then
       update operw set value = to_char ( gl.doc.DEAL_TAG ) where ref = gl.aRef and tag = 'KTAR ';
       if SQL%rowcount = 0 then  insert into operw (ref,tag, value) values (gl.aRef, 'KTAR ', to_char ( gl.doc.DEAL_TAG ) ) ;    end if;
    end if;

    ------------######    ���� ������-������  #########################################################################################-----------------------------
    if TT_='CCK' then    -- ���-������� - <<�����.������� ���i����>>
       EXECUTE IMMEDIATE 'begin PAY_CCK_UPB(:flg_,:ref_, :VDAT_, :tt_,:dk_,:kv_,:nlsm_,:sa_,:kvk_,:nlsk_,:ss_); end;'  USING flg_, ref_, VDAT_, tt_, dk_, kv_, nlsm_, sa_, kvk_, nlsk_, ss_ ;
    -----------------------------------------------------------------------------------------------------------------------------
    Elsif TT_ in ('KK1','KK2' ) and dk_ = 1 and nlsm_ like '22%' then   --- 21.03.2016 ������ COBUSUPABS-4313
       EXECUTE IMMEDIATE 'begin PAY_KK(:flg_,:ref_, :VDAT_, :tt_,:dk_,:kv_,:nlsm_,:sa_,:kvk_,:nlsk_,:ss_); end;'       USING flg_, ref_, VDAT_, tt_, dk_, kv_, nlsm_, sa_, kvk_, nlsk_, ss_ ;
    -----------------------------------------------------------------------------------------------------------------------------
    elsIF dk_=1 and kv_= kvk_ and sa_= ss_ and kv_= gl.baseval and nlsk_ like '3739_05' and gl.aMfo <> '300465' then --- 05.04.2016 Sta  ����-������� ���������� �� 3739.05 �� ������������ ����� �� ���������� ������� (����������������)
       EXECUTE IMMEDIATE 'begin ESCR.PAY1(:flg_,:ref_, :VDAT_, :tt_,:dk_,:kv_,:nlsm_,:sa_,:kvk_,:nlsk_,:ss_); end;'    USING flg_, ref_, VDAT_, tt_, dk_, kv_, nlsm_, sa_, kvk_, nlsk_, ss_ ;
    -----------------------------------------------------------------------------------------------------------------------------
    elsIF TT_='HPX' and dk_=1  then     -- ���-"����������" - <<�������I>>
       EXECUTE IMMEDIATE 'begin PAY_HPX(:flg_,:ref_, :VDAT_, :tt_,:dk_,:kv_,:nlsm_,:sa_,:kvk_,:nlsk_,:ss_); end;'      USING flg_, ref_, VDAT_, tt_, dk_, kv_, nlsm_, sa_, kvk_, nlsk_, ss_ ;
    -----------------------------------------------------------------------------------------------------------------------------
    elsIf kv_<>gl.baseval and (nlsm_ like '26_8%' and nlsk_ like '3800%' OR nlsk_ like '26_8%' and  nlsm_ like '3800%') and tt_ not like 'OW%'  then    -- ��� ������� ����� 3800 �� 7 �� ��� ���.%% (��� �������) � ����
       EXECUTE IMMEDIATE 'begin PAY_ASVO(:flg_,:ref_, :VDAT_, :tt_,:dk_,:kv_,:nlsm_,:sa_,:kvk_,:nlsk_,:ss_); end;'     USING flg_, ref_, VDAT_,  tt_, dk_, kv_, nlsm_, sa_, kvk_, nlsk_, ss_ ;
    -----------------------------------------------------------------------------------------------------------------------------
    elsif  KV_ = GL.BASEVAL  and gl.doc.NLSA  LIKE '2620%' and   gl.doc.MFOA  =  gL.aMfo  and  gl.doc.MFOB  <> gl.aMfo THEN   --  23.08.2017 Sta COBUSUPABS-6338 ����� ���� (��� ���) ����� ��������    
       EXECUTE IMMEDIATE 'begin PAY_2620(:flg_,:ref_, :VDAT_, :tt_,:dk_,:kv_,:nlsm_,:sa_,:kvk_,:nlsk_,:ss_); end;'     USING flg_, ref_, VDAT_,  tt_, dk_, kv_, nlsm_, sa_, kvk_, nlsk_, ss_ ;
    -----------------------------------------------------------------------------------------------------------------------------
    elsif kv_=gl.baseval and dk_= 1 and nlsm_ not like '2900%' and gl.aMFO <> '380764'  then -- Sta 11-05-2011 �i����i��� �� ����� �. 3.10 ����i�� 3 ��������� �����i��� ��� �i� 10.08.2005 �. �280 "��� ������������ ������ i��������� i����������� � ������", ... :
       EXECUTE IMMEDIATE 'begin PAY_NLN(:flg_,:ref_, :VDAT_, :tt_,:dk_,:kv_,:nlsm_,:sa_,:kvk_,:nlsk_,:ss_); end;'      USING flg_, ref_, VDAT_,  tt_, dk_, kv_, nlsm_, sa_, kvk_, nlsk_, ss_ ;
    -----------------------------------------------------------------------------------------------------------------------------
    else                         gl.payv(flg_,ref_ , VDAT_ ,  tt_, dk_, kv_, nlsm_, sa_, kvk_, nlsk_, ss_);
    end if;
    ------------############################################################################################################################-----------------------------
end;

/* ************************************************************** */
-- 10.03.2011 ���� �.
If tt_ not like 'GO%' 
then
  If kva_ = gl.baseval and kvb_ <> gl.baseval OR kvb_ = gl.baseval and kva_ <> gl.baseval 
  then 
    declare
       w_ref operw.ref%type;
       w_tag operw.tag%type;
       w_val operw.value%type;
    Begin
       If kva_ in (959,961,962) or kvb_ in (959,961,962) then w_tag := 'MKURS';
       else                                                   w_tag := 'KURS' ;
       end if;
    
       select  ref into w_ref from operw where ref=REF_ and tag = w_tag ; 
    
    EXCEPTION  WHEN NO_DATA_FOUND THEN
       If kva_   = gl.baseval and sb_<>0 then w_val :=to_char(round(sa_/sb_,4));
       elsIf kvb_= gl.baseval and sa_<>0 then w_val :=to_char(round(sb_/sa_,4));
       end if;
       insert into operw (ref,tag, value) values (REF_, w_tag, w_val );
    End;
  end if;
end if;

---------------------BEGIN: SPM ���---------------------
-- � �������� ������.���. SPM �� �������� ��� (��� �� � ���)
-- ��������  � doc\Modules Manual\SPM\Den_0.doc,
--26.03.2008 ������ �������� � ������ �������-������� ����.������� 
 IF kv_ <>kvk_            AND
    SUBSTR(nlsm_,1,1)<'8' AND
    SUBSTR(nlsk_,1,1)<'8' AND
    NVL(sa_,0)<>0         AND
    NVL(Ss_,0)<>0         THEN
--  05-04-2012 Sta
--  PAY_SPM ( flg_,ref_,datv_,tt_,dk0_,kva_, nlsa_,sa_,kvb_,nlsb_,sb_);
    PAY_SPM ( flg_,ref_,datv_,tt_,dk_ ,kv_ , nlsm_,sa_,kvk_,nlsk_,ss_);

 End if;

 If substr(TT_,1,2) ='BM' and
    nlsa_ like '11%'      and
    nlsb_ like '38%'      and
    kva_=kvb_             THEN
    PAY_SPM(flg_,ref_,datv_,tt_,dk0_,kva_, nlsa_,sa_,gl.baseval,nlsb_,sb_);
 END IF;
---------------------END: SPM ���---------------------

  -- �������� MT200 �� ��������� CVE
  If gl.aMFO  = '300465' and tt_ = 'CVE' 
  then
    execute immediate 'begin sw_200(:p_REF); end;' using ref_;
  end if;

  ---������� � ����� ��� �������� � ��� �� �����������
  if instr(getglobaloption('TTLST'),tt_)>0 
  then
    execute immediate 'insert into val_queue(ref, tt) values(:ref, :tt)' using ref_, tt_;
  end if;

end PAYTT;
/

show err;

grant EXECUTE on PAYTT to ABS_ADMIN;
grant EXECUTE on PAYTT to BARS_ACCESS_DEFROLE;
grant EXECUTE on PAYTT to CP_ROLE;
grant EXECUTE on PAYTT to INSPECTOR;
grant EXECUTE on PAYTT to OPER000;
grant EXECUTE on PAYTT to OPERKKK;
grant EXECUTE on PAYTT to PYOD001;
grant EXECUTE on PAYTT to RCC_DEAL;
grant EXECUTE on PAYTT to START1;
grant EXECUTE on PAYTT to WR_ALL_RIGHTS;
grant EXECUTE on PAYTT to WR_DOC_INPUT;
grant EXECUTE on PAYTT to WR_IMPEXP;
