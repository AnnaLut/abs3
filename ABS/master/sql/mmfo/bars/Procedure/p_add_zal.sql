
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/procedure/p_add_zal.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PROCEDURE BARS.P_ADD_ZAL 
(
  p_nd   NUMBER
 , --���.����� �����
  p_accs NUMBER
 , --���� �����
  ------------
  p_rnk    NUMBER
 ,p_pawn   NUMBER
 ,p_acc    NUMBER
 , --���� ������
  p_kv     INT
 ,p_sv     NUMBER
 ,p_del    NUMBER
 ,p_cc_idz VARCHAR2
 ,p_sdatz  DATE
 ,p_mdate  DATE
 ,p_nree   VARCHAR2
 ,p_depid  NUMBER
 ,p_mpawn  INT
 ,p_pr_12  INT
 ,p_nazn   VARCHAR2 DEFAULT NULL
 ,p_ob22   VARCHAR2 DEFAULT NULL
 ,p_R013   VARCHAR2 DEFAULT NULL
 ,p_strahz NUMBER DEFAULT NULL
) IS
  --���� ����� �������
  -- 07/12/2016 -- COBUMMFOTEST-361 ���������� ������� �� �����
  --11/10/2016 Sta ���������� ��������� ��� ������ �� ACCS, � �� ������ �� ND. ��������� ����� � ����
  -- ������ � ����

  g_errn NUMBER := -20203;
  g_errs VARCHAR2(5) := 'PAWN:';
  -------------------
  az     accounts%ROWTYPE;
  dd     cc_deal%ROWTYPE;
  aa     accounts%ROWTYPE;
  oo     oper%ROWTYPE;
  l_nd   NUMBER;
  l_accs NUMBER;
  p4_    NUMBER;
  acc8_  NUMBER;
  l_pawn NUMBER;
  v_r013 varchar2(2) := p_R013;
  v_flag integer := 0;
  v_err  varchar2(4000);
BEGIN
  /*raise_application_error(g_errn
                               ,g_errs || p_pawn);*/
  if p_rnk is not null and p_acc is not null then
    if p_sv is null  and p_del is null then
       v_err := ' �������� ���������� ���������� ���� [�����.����.������] �� [+���-�����]!!<br/>';
    end if;
  elsif  p_acc is  null then
      if    p_sv is not null  then
        v_err := '��� �������� ������ ������������ ���� [�����.����.������] ������� ���� �����!<br/>';
      elsif p_del is null then
        v_err := '��� �������� ������ ������������ ���� [���� �������] �� ���� ����������!<br/>';
      end if;
  end if;

  -- ob22 ������ ���� �������� �����������!
  if p_ob22 is null then
    v_err := v_err|| '�������� OB22 �� ���� ����"������ ����������!<br/>';
  else
    az.ob22 := p_ob22;
  end if;

  if (p_strahz  is null or  p_cc_idz is null or  p_sdatz is null) then
    v_err := v_err||'�� ��� ���� ("� ���.���","���� ���. �����","����������� �������") ����� ���� ��������!<br/>';
  end if;


  bars.bars_audit.info('P_ADD_ZAl params.p_nd=' || p_nd || ' ,p_ACCS' ||
                       p_accs || ' ,p_RNK=' || p_rnk || ' ,p_pawn=' ||
                       p_pawn || ' ,p_ACC=' || p_acc || ' ,p_kv' || p_kv ||
                       ' ,p_sv=' || p_sv || ' ,p_del=' || p_del || ' ,p_cc_idz=' || p_cc_idz || ' ,p_sdatz=' ||
                       p_sdatz || ' ,p_mdate=' || p_mdate || ' ,p_nree=' ||
                       p_nree || ' ,p_Depid=' || p_depid || ' ,p_mpawn=' ||
                       p_mpawn || ' ,p_PR_12=' || p_pr_12 || ' ,p_nazn=' ||
                       p_nazn||', p_ob22 = '||p_ob22);

  IF pul.get_mas_ini_val('PAP') = 2 THEN
    l_pawn := 999999;
  ELSE
    l_pawn := p_pawn;
  END IF;

  IF p_accs IS NULL
     OR p_nd IS NULL THEN
    l_nd   := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));
    l_accs := nvl(p_accs, to_number(pul.get_mas_ini_val('ACC')));
  END IF;
  ---------------------------
/*  IF nvl(l_nd, 0) <= 0
     AND nvl(l_accs, 0) <= 0 THEN
    raise_application_error(g_errn
                           ,g_errs ||
                            '�� �������� � ��������, � ��� ������');
  END IF;*/
  ---------------------------



  IF l_nd > 0 THEN
    BEGIN
      SELECT * INTO dd FROM cc_deal WHERE nd = l_nd;
      IF acc8_ IS NULL
         AND dd.vidd IN (1, 2, 3, 5, 11, 12, 13, 10) THEN
        SELECT a.acc
          INTO acc8_
          FROM accounts a, nd_acc n
         WHERE n.nd = dd.nd
           AND a.acc = n.acc
           AND a.nls LIKE '899%';
      END IF;
      az.isp    := dd.user_id;
      az.branch := dd.branch;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || '�� �������� ��� ND=' || l_nd);
    END;
  END IF;

  IF l_accs > 0 THEN
    BEGIN
      SELECT * INTO aa FROM accounts WHERE acc = l_accs;
      IF aa.nls LIKE '8%' THEN
        l_accs := NULL;
      END IF;
      az.isp    := aa.isp;
      az.branch := aa.branch;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || '�� �������� ������. accs=' ||
                                l_accs);
    END;
  END IF;

  az.acc := p_acc;
  IF p_rnk IS NULL THEN
    IF l_accs > 0 THEN
      az.rnk := aa.rnk;
    ELSIF dd.nd > 0 THEN
      az.rnk := dd.rnk;
    END IF;
  ELSE
    az.rnk := p_rnk;
  END IF;

  IF p_acc IS NULL THEN
    -- �����(insert) -- ������� ���� ����������� � PAWN_ACC ��������� ��� ����.����������� (PAWN_ACC)

    BEGIN
      SELECT substr(nmk || ' ������������.', 1, 38),
             okpo
        INTO az.nms,
             oo.id_a
        FROM customer
       WHERE rnk = az.rnk;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || '�� �������� ��� ������������ =' ||
                                az.rnk);
    END;

    BEGIN
      SELECT f_newnls2(nvl(acc8_, l_accs)
                      ,'ZAL'
                      ,decode(p_mpawn
                             ,1
                             ,nbsz
                             ,2
                             ,nvl(nbsz2, nbsz)
                             ,nvl(nbsz3, nbsz))
                      ,az.rnk
                      ,NULL)
        INTO az.nls
        FROM cc_pawn
       WHERE pawn = l_pawn;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(g_errn
                               ,g_errs || '�� �������� ��� ������ pawn=' ||
                                l_pawn);
    END;

    az.nls := vkrzn(substr(gl.amfo, 1, 5), az.nls);
    op_reg(2
          ,l_nd
          ,l_pawn
          ,p_mpawn
          ,p4_
          ,az.rnk
          ,az.nls
          ,p_kv
          ,az.nms
          ,'ZAL'
          ,az.isp
          ,az.acc);

    UPDATE accounts
      SET mdate = p_mdate, tobo = az.branch
      WHERE acc = az.acc;

    accreg.setaccountsparam(az.acc, 'OB22', az.ob22);
    IF l_nd > 0 THEN
      INSERT INTO nd_acc (nd, acc) VALUES (l_nd, az.acc);
    END IF;

  END IF;

  BEGIN
    SELECT * INTO az FROM accounts WHERE acc = az.acc;
  EXCEPTION
    WHEN no_data_found THEN
      raise_application_error(g_errn
                             ,g_errs || '�� �������� ���.������.���=' ||
                              az.acc);
  END;

  if v_R013 is null then
    select count(1) into v_flag
      from kl_r013 r
      where r.r020 = substr(az.nls,1,4)
        and r.d_close is null;
    if v_flag>0 then
      v_err :=  v_err||'�������� R013 �� ���� ����������!<br/>';
    end if;
  end if;


  if v_err is not null then
    raise_application_error(g_errn,'<br/><b>'||v_err||'</b>');
  end if;

  UPDATE PAWN_ACC SET pawn=l_pawn WHERE acc=az.acc;

  if v_R013 is not null then
        accreg.setAccountSParam(az.acc, 'R013', v_R013);
  end if;

  if p_strahz is not null then
    accreg.setAccountwParam(az.acc, 'Z_POLIS', p_strahz);
  end if;

  v_flag := 0;
  FOR k IN (SELECT *
              FROM accounts
             WHERE accc = acc8_
                OR acc = l_accs/*
                or (tip = 'CR9' and acc in (select acc from nd_acc where nd = p_nd))*/
           )
  LOOP
    p_pawn_nd(l_nd
             ,az.acc
             ,az.ob22
             ,k.acc
             ,NULL
             ,p_nree
             ,p_cc_idz
             ,p_sdatz
             ,p_mdate
             ,NULL
             ,p_sv
             ,p_depid
             ,p_pr_12
             ,p_pawn);
    v_flag := 1;
  END LOOP;
  if dd.vidd = 5 or (dd.sos = 0 and v_flag = 0) then
    insert into cc_accp (acc,
                         accs,
                         nd,
                         pr_12,
                         idz)
      select az.acc, a.acc, dd.nd, 1, p_cc_idz
        from accounts a, nd_acc n
        where n.nd = dd.nd
          and n.acc = a.acc
          and a.tip = 'LIM'
          and not exists (select 1 from cc_accp where acc = az.acc and accs = a.acc and nd = dd.nd);
  end if;
  
  if dd.nd = nvl(dd.ndg,-1) then -- �������� ����������� ����� � ������������, ���� ����� ��� ���
    for deal in (select nd from cc_deal where ndg= dd.nd and nd != dd.nd)
    loop
      
      for zal in (select distinct acc, idz, mpawn, pawn, rnk from cc_accp where nd = dd.nd)
      loop
        for acc in (select n.acc from nd_acc n, accounts a where n.nd = deal.nd and n.acc = a.acc and a.tip in ('SS ','SP ','CR9','SN ','SPN'))
        loop
          insert into cc_accp (acc,
                               accs,
                               nd,
                               pr_12,
                               idz,
                               mpawn,
                               pawn,
                               rnk)
           select zal.acc, acc.acc, deal.nd, 1, zal.idz, zal.mpawn, zal.pawn, zal.rnk from dual
             where not exists (select 1 from cc_accp where acc = zal.acc and accs = acc.acc);
        end loop;
      end loop;
    end loop;
  end if;
  -----------------------------
  IF nvl(p_del, 0) = 0 THEN
    RETURN;
  END IF;

/*  BEGIN
    SELECT nls, substr(nms, 1, 38)
      INTO oo.nlsb, oo.nam_b
      FROM accounts
     WHERE kv = az.kv
       AND nbs = '9900'
       AND dazs IS NULL
       AND rownum = 1;
  EXCEPTION
    WHEN no_data_found THEN
      raise_application_error(g_errn
                             ,g_errs || '�� �������� �����/���.9900*');
  END;*/


  BEGIN
    SELECT t.nls,substr(t.nms ,1,38), c.okpo INTO oo.nlsb, oo.nam_b, oo.id_b
      FROM accounts t, customer c
      WHERE t.kv =az.kv
       and t.nls = BRANCH_USR.GET_BRANCH_PARAM2('NLS_9900',0)
       and t.rnk = c.rnk;
  EXCEPTION
    WHEN no_data_found THEN
      raise_application_error(g_errn
                             ,g_errs || '�� ��������� ������� ������ ��� ��������!');
 END;

  IF p_del > 0 THEN
    IF az.pap = 2 THEN
      oo.dk := 0;
    ELSE
      oo.dk := 1;
    END IF;
    oo.nazn := '��������������';
  ELSE
    IF az.pap = 2 THEN
      oo.dk := 1;
    ELSE
      oo.dk := 0;
    END IF;
    oo.nazn := '��������';
  END IF;
  oo.tt    := 'ZAL';
  oo.nazn := CASE
               WHEN p_nazn IS NOT NULL THEN
                substr(p_nazn, 1, 160)
               ELSE
                substr(oo.nazn || ' ����c������� ' || CASE
                         WHEN p_cc_idz IS NULL THEN
                          ''
                         ELSE
                          '����� �������� � ' || p_cc_idz
                       END || CASE
                         WHEN p_sdatz IS NULL THEN
                          ''
                         ELSE
                          ' �� ' || to_char(p_sdatz, 'dd.mm.yyyy')
                       END || CASE
                         WHEN l_nd IS NULL THEN
                          ''
                         ELSE
                          ' ��� ����.����� ' || dd.cc_id || ' �� ' ||
                          to_char(dd.sdate, 'dd.MM.yyyy')
                       END
                      ,1
                      ,160)
             END;
  oo.s     := abs(p_del) * 100;
  oo.nam_a := substr(az.nms, 1, 38);
  gl.ref(oo.ref);
  oo.nd := TRIM(substr('          ' || to_char(oo.ref), -10));
  gl.in_doc3(ref_   => oo.ref
            ,tt_    => oo.tt
            ,vob_   => 6
            ,nd_    => oo.nd
            ,pdat_  => SYSDATE
            ,vdat_  => gl.bdate
            ,dk_    => oo.dk
            ,kv_    => az.kv
            ,s_     => oo.s
            ,kv2_   => az.kv
            ,s2_    => oo.s
            ,sk_    => NULL
            ,data_  => gl.bdate
            ,datp_  => gl.bdate
            ,nam_a_ => oo.nam_a
            ,nlsa_  => az.nls
            ,mfoa_  => gl.amfo
            ,nam_b_ => oo.nam_b
            ,nlsb_  => oo.nlsb
            ,mfob_  => gl.amfo
            ,nazn_  => oo.nazn
            ,d_rec_ => NULL
            ,id_a_  => oo.id_a
            ,id_b_  => oo.id_b
            ,id_o_  => NULL
            ,sign_  => NULL
            ,sos_   => 1
            ,prty_  => NULL
            ,uid_   => NULL);
  gl.payv(0
         ,oo.ref
         ,gl.bdate
         ,oo.tt
         ,oo.dk
         ,az.kv
         ,az.nls
         ,oo.s
         ,az.kv
         ,oo.nlsb
         ,oo.s);

END p_add_zal;
/
 show err;
 
PROMPT *** Create  grants  P_ADD_ZAL ***
grant EXECUTE                                                                on P_ADD_ZAL       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ADD_ZAL       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/procedure/p_add_zal.sql =========*** End ***
 PROMPT ===================================================================================== 
 
