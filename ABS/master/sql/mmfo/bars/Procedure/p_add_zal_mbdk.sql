CREATE OR REPLACE PROCEDURE p_add_zal_mbdk
(
  p_nd   NUMBER
 , --дог.займа займа
  p_accs NUMBER
 , --счет займа
  ------------
  p_rnk    NUMBER
 ,p_pawn   NUMBER
 ,p_acc    NUMBER
 , --счет залога
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
) IS
  -- 01.09.2017 VL коректное отображение активов
  -- 15.08.2017 VL редактирование засатав 2700 и тд.
  -- 09.08.2017 МБДК пассив ( в т.ч. 2700)
  --ввод новых залогов
  -- 07/12/2016 -- COBUMMFOTEST-361 Назначение платежа из формы
  --11/10/2016 Sta Расширение процедуры для работы по ACCS, а не только по ND. Использую также в МБДК
  -- Работа с ПАСС

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

  l_tipD cc_tipd.tipD%type;  -- 1=Розміщення (актив),  2=Залучення (пасив)

BEGIN

if p_rnk is not null and p_acc is not null then
  if p_sv is null  and p_del is null then   raise_application_error(g_errn ,' Перевірте коректність заповнення полів ''Справ.варт.забезп'' та ''+Доб-Зменш''!!'); end if;
elsif  p_acc is  null then
    if    p_sv is not null  then     raise_application_error(g_errn   ,'При додаванні нового забезпечення поле ''Справ.варт.забезп'' повинне буде пусте!');  end if;
end if;



  IF pul.get_mas_ini_val('PAP') = 2 THEN    l_pawn := 999999;  ELSE    l_pawn := p_pawn;  END IF;

  IF p_accs IS NULL     OR p_nd IS NULL THEN
     l_nd   := nvl(p_nd, to_number(pul.get_mas_ini_val('ND')));
     l_accs := nvl(p_accs, to_number(pul.get_mas_ini_val('ACC')));
  END IF;
  ---------------------------
/*logger.info('P_ADD_ZAl_MBDK params.p_nd=' || p_nd || ' ,p_ACCS' ||
                       p_accs || ' ,p_RNK=' || p_rnk || ' ,p_pawn=' ||
                       p_pawn || ' ,p_ACC=' || p_acc || ' ,p_kv=' || p_kv ||
                       ' ,p_sv=' || p_sv || ' ,p_del=' || p_del || ' ,p_cc_idz=' || p_cc_idz || ' ,p_sdatz=' ||
                       p_sdatz || ' ,p_mdate=' || p_mdate || ' ,p_nree=' ||
                       p_nree || ' ,p_Depid=' || p_depid || ' ,p_mpawn=' ||
                       p_mpawn || ' ,p_PR_12=' || p_pr_12 || ' ,p_nazn=' ||
                       p_nazn);*/


 IF l_nd > 0 THEN
     BEGIN
       SELECT * INTO dd FROM cc_deal WHERE nd = l_nd;
        IF dd.vidd in (1211,1510,1511,1512,1515,1517,1521,1522,1523,1524,1526,1527) THEN  --(АКТИВ)
            l_tipD := 1 ; ----1=Розміщення (актив)
            SELECT a.acc  INTO acc8_  FROM accounts a, nd_acc n    WHERE n.nd = dd.nd      AND a.acc = n.acc
            and(a.nls LIKE '1211%' or a.nls LIKE '1510%' or a.nls LIKE '1511%' or a.nls LIKE '1512%' or a.nls LIKE '1515%'or a.nls LIKE '1517%'
            or a.nls LIKE '1521%' or a.nls LIKE '1522%' or a.nls LIKE '1523%' or a.nls LIKE '1524%' or a.nls LIKE '1526%' or a.nls LIKE '1527%');
        else
            select tipd   into l_tipD from cc_vidd where vidd = dd.vidd;  -- 1=Розміщення (актив),  2=Залучення (пасив)
        END IF;

         az.isp    := dd.user_id;
         az.branch := dd.branch;
    EXCEPTION     WHEN no_data_found THEN     raise_application_error(g_errn ,g_errs || 'Не знайдено дог ND=' || l_nd);
    END;
  END IF;

  IF l_accs > 0 THEN
     BEGIN  SELECT * INTO aa FROM accounts WHERE acc = l_accs;
     EXCEPTION  WHEN no_data_found THEN  raise_application_error(g_errn ,g_errs || 'Не знайдено позичк. accs=' ||  l_accs);
     END;
     az.isp    := aa.isp;
     az.branch := aa.branch ;
     l_tipD    := NVL( l_tipD, aa.pap ) ;   -- 1=Розміщення (актив),  2=Залучення (пасив)
  END IF;

  az.acc := p_acc;

  IF    p_rnk IS not NULL THEN az.rnk :=  p_rnk  ;
  ElsIf l_accs > 0        THEN az.rnk := aa.rnk  ;
  ELSIF dd.nd  > 0        THEN az.rnk := dd.rnk  ;
  else                         az.rnk := gl.aRnk ;
  END IF;

  IF p_acc IS NULL THEN   -- Новый(insert) -- Открыть счет обеспечения с PAWN_ACC Дополнить его спец.параметрами (PAWN_ACC)

     BEGIN
        SELECT substr(nmk || ' Забезпечення.', 1, 38)   INTO az.nms
           FROM customer
            WHERE rnk = az.rnk;
     EXCEPTION   WHEN no_data_found THEN   raise_application_error(g_errn ,g_errs || 'Не знайдено РНК заставодавця =' || az.rnk);
     END;

     BEGIN
       If l_tipD = 1 then ------------------------------------------------------- 1=Розміщення (актив) , бал.сч зависит от вида обеспечения
             SELECT f_newnls2( nvl(acc8_,l_accs), 'ZAL', decode(p_mpawn,1, nbsz,2,nvl(nbsz2, nbsz),nvl(nbsz3, nbsz)) ,az.rnk ,NULL) INTO az.nls  FROM cc_pawn   WHERE pawn = l_pawn;
           else           -----------------------------------------------------   2=Залучення (пасив)  , бал.сч всегда = 9510 и НЕ зависит от вида обеспечения
              az.nls  := f_newnls2( nvl(acc8_,l_accs), 'ZAL', '9510', az.rnk ,NULL) ;
           end if;
     EXCEPTION WHEN no_data_found THEN  raise_application_error(g_errn ,g_errs || 'Не знайдено Код забесп pawn=' ||  l_pawn);
     END;

     az.nls := vkrzn(substr(gl.amfo, 1, 5), az.nls);
     op_reg ( 2, l_nd,l_pawn,p_mpawn,p4_,az.rnk,az.nls,p_kv,az.nms,'ZAL', az.isp, az.acc);


     UPDATE accounts SET mdate = p_mdate, tobo = az.branch WHERE acc = az.acc;
----------------------------------------------------
 UPDATE pawn_acc SET nree=p_nree ,
                     cc_idz = p_cc_idz,
                     sdatz = p_sdatz,
                     SV = p_SV*100,
                     deposit_id=p_depid,
                     pawn = nvl(p_pawn, pawn)
                     WHERE acc=az.acc;
------------------------------------------------
     SELECT MIN (ob22)     INTO az.ob22      FROM sb_ob22     WHERE d_close IS NULL       AND r020 = substr(az.nls, 1, 4);
     accreg.setaccountsparam(az.acc, 'OB22', az.ob22);

     IF l_nd > 0 THEN
        INSERT INTO nd_acc (nd, acc) VALUES (l_nd, az.acc);
        END IF;

  END IF;
----============== редактирование справедлива вартості та план.дати
   if  p_acc >0 then
    begin
    update accounts set  mdate=p_mdate, tobo=az.branch where acc=az.acc;
   begin
   update pawn_acc set sv=p_SV*100,deposit_id=p_depid,pawn=l_pawn where acc=az.acc;
       end;
    end;
    end if;
--------------------------------------------------
  if p_R013 is not null then       accreg.setAccountSParam(az.acc, 'R013', p_R013); end if;
  if p_ob22 is not null then       accreg.setAccountSParam(az.acc, 'OB22', p_ob22); end if;

  BEGIN    SELECT * INTO az FROM accounts WHERE acc = az.acc;
  EXCEPTION    WHEN no_data_found THEN
         raise_application_error(g_errn  ,g_errs || 'Не знайдено рах.забезп.асс=' ||     az.acc);
  END;

  If l_tipD in (1,2)  then   --insert в cc_accp

     INSERT INTO cc_accp (ACC,   ACCS,       pr_12,     nd )
                select az.acc, x.accs, nvl(p_pr_12,1), x.nd
                from cc_add x
                where x.nd = l_nd and adds= 0
                  and not exists (select 1 from  cc_accp where acc = az.acc and accs = x.accs);
  /*Else
     ----Связать счет займа и счет обеспечения не только для АКТ , но и для ПАСС --==========
     FOR k IN (SELECT *  FROM accounts  WHERE accc = acc8_  OR acc = l_accs)
     LOOP    p_pawn_nd(l_nd,az.acc,az.ob22,k.acc,NULL,p_nree,p_cc_idz,p_sdatz,p_mdate,NULL,p_sv,p_depid,p_pr_12,p_pawn);
      END LOOP;*/
  end if;

  -------------===========================================================================

  IF nvl(p_del, 0) = 0 THEN    RETURN;  END IF;

  BEGIN SELECT t.nls,substr(t.nms ,1,38) INTO oo.nlsb, oo.nam_b      FROM accounts t     WHERE t.kv =az.kv      and t.nls = BRANCH_USR.GET_BRANCH_PARAM2('NLS_9900',0);
  EXCEPTION    WHEN no_data_found THEN      raise_application_error(g_errn,g_errs || 'Не визначено рахунко кредит для операції!');
  END;

  IF p_del > 0 THEN IF az.pap = 2 THEN  oo.dk := 0;    ELSE   oo.dk := 1;    END IF;    oo.nazn := 'Оприбуткування';
  ELSE              IF az.pap = 2 THEN  oo.dk := 1;    ELSE   oo.dk := 0;    END IF;    oo.nazn := 'Списання';
  END IF;

  oo.tt    := 'ZAL';
  oo.nazn := CASE
               WHEN p_nazn IS NOT NULL THEN
                substr(p_nazn, 1, 160)
               ELSE
                substr(oo.nazn || ' забеcпечення ' || CASE
                         WHEN p_cc_idz IS NULL THEN
                          ''
                         ELSE
                          'згідно договору № ' || p_cc_idz
                       END || CASE
                         WHEN p_sdatz IS NULL THEN
                          ''
                         ELSE
                          ' від ' || to_char(p_sdatz, 'dd.mm.yyyy')
                       END || CASE
                         WHEN l_nd IS NULL THEN
                          ''
                         ELSE
                          ' для кред.угоди ' || dd.cc_id || ' від ' ||
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

END p_add_zal_mbdk;
/