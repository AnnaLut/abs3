CREATE OR REPLACE procedure BARS.BANK_PF
( p_mode    int
, p_dat1    date default null
, p_dat2    date default null
) is
  l_dat1    date;
  l_dat2    date;
   -- ������ ��� �� ��, ��� ��, �����
   /*
   20.10.2016 MMFO ��� P_MODE in (1, 3, 4) ������ ���� �� �F (���), return ������� �� continue;
   20.11.2015 ing 3622/38 ������������� ��� ����� �� ������ �� v_pdfo (� �� �����)
   29.05.2015 Sta ³� ����:  �������� �.�.  ���� 27.05.2015  REF �: 13/3-03/301
                  ������� : ���  ��� �� �� �� :
                  ����������� ����-���������� ��.��� ��� ������������� ���������� ����� � ������
                  � ������� 3622/38 = "��������� ���, ��������� � ������ �λ  �� ������� ���
                  ��������� ������� ����������/������������� ���������� ����� � ���.3622/36  - � ������ � ������ ��������� ���������� ����������.
                  ³������� - ������� ���������� 3522 �������.

   19-02-2015 Sta ³� �������� �.�., ����: 18.02.2015, ���. � 13/1-03/74
   09-01-2015 Sta ����������, ������������� ��� ���� �� �� �� ������� �� �������  ank_PF ( 2, DATETIME_Null, DATETIME_Null )
   18-09-2014 Sta ������������� ������ ��� 300465
   18-08-2014 Sta ��������� �������
   13-08-2014 Sta ���� �� �� �� ��������
   11-08-2014 Sta ����������, ������������� ��� ���� �� ������� �� ������� (3522/29,3622/37)
                  p_mode = 2
   01-07-2014 Sta ��� ������������ � 2902 ������ � �� �� ��������� ���-��������
   24.04.2014 ���  ������ � ���������, ������� �������. ��������.���. (044) 247-8578
   nvl(P_MODE,0) = 0 - ������ ����� �� ��������� ������� ���
                 = 1 - �������� �� ��������� ������� ���
                 = 2 - ����������, ������������� ��� ���� �� ������� �� ������� (3522/29,3622/37)
   */
   -------------------------------------------------------------
   Q5_        NUMBER := 0;
   oo         oper%ROWTYPE;
   A12        ACCOUNTS%ROWTYPE;
   A35        ACCOUNTS%ROWTYPE;
   nls7_      accounts.nls%TYPE;
   rat_       NUMBER;
   ob36_nal   CHAR (2);
   ob36_bez   CHAR (2);
   ob29_nal   CHAR (2);
   ob29_bez   CHAR (2);
   ob74_      CHAR (2);
   MFOP_      VARCHAR2 (6);
   z_         INT;
-- nTmp_      INT;
   sDet_      oper.nazn%type;
   sMes_      VARCHAR2 (30);
   sSql_      VARCHAR2 (2000);
   l_dat3     DATE;

   title    constant varchar2(50) := 'Bank_PF:';
-------------------
BEGIN
  execute immediate 'alter session set NLS_DATE_FORMAT=''dd.mm.yyyy''';
  l_dat3:=to_date(PUL.GET('WDAT'),'dd.mm.yyyy');
  PUL_DAT(l_dat3,'');

  l_dat1 := nvl( p_dat1, to_date( pul.Get_Mas_Ini_Val('sFdat1'), 'dd.mm.yyyy' ) ) ;
  l_dat2 := nvl( p_dat2, to_date( pul.Get_Mas_Ini_Val('sFdat2'), 'dd.mm.yyyy' ) ) ;

   IF NVL (P_MODE, 0) NOT IN (0, 1, 2, 3, 4)
   THEN
      RETURN;
   END IF;

   -------------------------------------------------------------
   IF p_mode = 2
   THEN
      --����������, ������������� ��� ���� �� ������� �� ������� (3522/29,3622/37)
      --����������, ������������� ��� ��   �� ������� �� ������� (3522/30,3622/36+38)

      SELECT ' �� ' || NAME_PLAIN || ' ' || to_char( extract( year from l_dat3 ) )
        INTO sMes_
        FROM META_MONTH
       WHERE N = extract( month from l_dat3 );

      oo.id_a := gl.aOkpo;
      oo.dk   := 1;
      oo.kv   := gl.baseval;
      oo.mfoa := gl.aMfo;
      oo.id_a := gl.aOkpo;

      FOR k IN (SELECT *
                  FROM (SELECT nls6 NLS6,
                               a6.nms NMS6,
                               nls5 NLS5,
                               a5.nms NMS5,
                               a6.BRANCH,
                               V100 as V,
                               P100 as P,
                               a6.nbs B6,
                               a6.ob22 O6,
                               a5.nbs B5,
                               a5.ob22 O5
                          FROM V_PDFO v, accounts a5, accounts a6
                         WHERE a5.acc(+) = v.acc5 AND a6.acc = v.acc6)
                 WHERE (v > 0 OR p > 0))
      LOOP
         BEGIN
            SELECT SUBSTR (val, 1, 06)
              INTO oo.mfob
              FROM BRANCH_PARAMETERS
             WHERE branch = k.branch AND tag = 'PDFOMFO' AND val IS NOT NULL;

            SELECT SUBSTR (val, 1, 08)
              INTO oo.id_b
              FROM BRANCH_PARAMETERS
             WHERE branch = k.branch AND tag = 'PDFOID' AND val IS NOT NULL;

            SELECT SUBSTR (val, 1, 38)
              INTO oo.nam_b
              FROM BRANCH_PARAMETERS
             WHERE branch = k.branch AND tag = 'PDFONAM' AND val IS NOT NULL;

            /*
              19-02-2015
            - ��� ������������� ���������� ����� � �������� �������� /11011000/.
            - ��� ������������� ���� � ����������� �������� /11010800/;
            */
        if (INSTR (oo.nam_b, '/') != 0)
            then
              oo.nam_b := SUBSTR (oo.nam_b, 1, INSTR (oo.nam_b, '/') - 1);
            end if;

            IF k.B6 = '3622' AND k.o6 IN ('36', '38')
            THEN
				sDet_ := '³�������� ��� '||case when  k.o6='38' then '�� ��������� ������ ������������� ���������� ' else  ' � ���������� ������ ' end;
               --sDet_ := '³�������� ���';
               oo.nam_b := SUBSTR ('/11011000/'||oo.nam_b, 1, 38);

               SELECT SUBSTR (val, 1, 14)
                 INTO oo.nlsb
                 FROM BRANCH_PARAMETERS
                WHERE branch = k.branch
                  AND tag = 'PDFOVZB'
                  AND val IS NOT NULL;
            ELSE
			    sDet_ := '���� � ���������� ������ ';
               --sDet_ := '����';
               oo.nam_b := SUBSTR ('/11010800/' || oo.nam_b, 1, 38);

               SELECT SUBSTR (val, 1, 14)
                 INTO oo.nlsb
                 FROM BRANCH_PARAMETERS
                WHERE branch = k.branch
                  AND tag = 'PDFONLS'
                  AND val IS NOT NULL;
            END IF;

            SELECT SUBSTR ('. ' || name, 1, 160)
              INTO oo.nazn
              FROM branch
             WHERE branch = k.branch;

            gl.REF (oo.REF);
            oo.nd := TRIM (SUBSTR ('     ' || TO_CHAR (oo.REF), -10));
            oo.nlsa := k.nls6;
            oo.nam_a := SUBSTR (k.nms6, 1, 38);

            SELECT SUBSTR (k.nmkk, 1, 38)
              INTO oo.nam_a
              FROM customer k, accounts a
             WHERE k.rnk = a.rnk AND a.kv = 980 AND a.nls = oo.nlsa;

            IF k.p > 0
            THEN
               oo.tt := 'PS2';
               oo.s := k.P;
               oo.vob := 1;
               oo.nazn := SUBSTR ('*;101;' || gl.aOkpo || ';' || sDet_ || sMes_ || ';;;' || oo.nazn, 1, 160);
             --oo.nazn := SUBSTR ('*;101;' || gl.aOkpo || ';' || sDet_ || ' � ���������� ������ ' || sMes_ || ';;;' || oo.nazn, 1, 160);
            /*
            --13-08-2014 Sta ���� �� �� �� ��������
            *;101;<gl.aOkpo>;���� � ���������� ������ <sMes_>;;;
            -- 09.01.2015
            �� ������� ��� ���������: ������� ��� 09304612
            *;101;09304612;���� � ���������� ������  ��__________ 2014;;;
            *;101;09304612;³�������� ��� � ���������� ������ ��__________ 2014;;;

            */
            ELSE
               oo.tt   := 'PS1';
               oo.s    := k.V;
               oo.vob  := 6;
               oo.nazn := SUBSTR ('���������� ��� ' || sDet_ || '.' || sMes_ || oo.nazn, 1, 160);
               oo.id_b := gl.aOkpo;
               oo.mfob := gl.aMfo;
               oo.nlsb := k.nls5;
               oo.nam_b := SUBSTR (k.nms5, 1, 38);
            END IF;

            gl.in_doc3 (ref_     => oo.REF,
                        tt_      => oo.tt,
                        vob_     => oo.vob,
                        nd_      => oo.nd,
                        pdat_    => SYSDATE,
                        vdat_    => gl.bdate,
                        dk_      => oo.dk,
                        kv_      => oo.kv,
                        s_       => oo.S,
                        kv2_     => oo.kv,
                        s2_      => oo.s,
                        sk_      => NULL,
                        data_    => gl.bdate,
                        datp_    => gl.bdate,
                        nam_a_   => oo.nam_a,
                        nlsa_    => oo.nlsa,
                        mfoa_    => oo.Mfoa,
                        nam_b_   => oo.nam_b,
                        nlsb_    => oo.nlsb,
                        mfob_    => oo.mfob,
                        nazn_    => oo.nazn,
                        d_rec_   => NULL,
                        id_a_    => oo.id_a,
                        id_b_    => oo.id_b,
                        id_o_    => NULL,
                        sign_    => NULL,
                        sos_     => 1,
                        prty_    => NULL,
                        uid_     => NULL);
            PAYTT (0,
                   oo.REF,
                   gl.bdate,
                   oo.tt,
                   oo.dk,
                   oo.kv,
                   oo.nlsa,
                   oo.s,
                   oo.kv,
                   oo.nlsb,
                   oo.s);

            IF k.p > 0 AND k.v > 0
            THEN
               gl.payv (0,
                        oo.REF,
                        gl.bdate,
                        'PS1',
                        oo.dk,
                        oo.kv,
                        oo.nlsa,
                        k.V,
                        oo.kv,
                        K.NLS5,
                        oo.s);
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN NULL;                                                        --
                 raise_application_error (-20000,'�� �������� ��.����i���� ��� ����/�� ��� ������='|| k.branch);
         END;
      END LOOP;
      RETURN;
   END IF;
   ---------------------------------------------------------------------------
   PUL_DAT (TO_CHAR (l_DAT1, 'DD.MM.YYYY'), TO_CHAR (l_DAT2, 'DD.MM.YYYY'));

   EXECUTE IMMEDIATE 'truncate table CCK_AN_TMP ';

   IF NVL (P_MODE, 0) IN (0)
   THEN
      -- ������  �����
      INSERT INTO CCK_AN_TMP (branch, kv, n1, pr, nd, Name, name1, n2, n3, n4)
         SELECT branch, kv,
                ROUND (q * 5 / 1000, 0) n1,
                nal, REF, tt, tt1, s, q, q / s
           FROM (SELECT NVL (T.NAL, 0) NAL,
                        a.kv,
                        p.branch,
                        p.REF,
                        p.tt tt,
                        o.tt tt1,
                        o.s,
                        NVL (
                           (SELECT ROUND (o.s * RATE_B / BSUM, 0)
                              FROM cur_rates$base
                             WHERE kv = a.kv
                               AND branch = a.branch
                               AND vdate = o.fdat),
                           gl.p_icurval (a.kv, o.s, o.fdat))        q
                   FROM opldok o,
                        accounts a,
                        PF_TT3800 T,
                        oper p
                  WHERE o.dk = 1
                    AND o.fdat >= l_dat1
                    AND o.fdat <= l_dat2
                    AND o.acc = a.acc
                    AND a.nbs IN ('3800')
                    AND ob22 IN ('10', '20')
                    AND T.tt = o.tt
                    AND p.REF = o.REF
                    AND p.sos = 5
                    AND o.s > 0);

      -- ����������� ������ - ��� ������
      IF gl.aMfo = '300465'
      THEN
         sSql_ :=
            'insert into CCK_AN_TMP ( branch, kv   ,   n1,pr,   nd, Name, name1, n2 , n3                 , n4 )
          select                 p.branch, f.kva,  o.s, 0,o.ref, p.tt, o.tt , f.S, round(f.S*f.KURS,0), f.kurs
          from oper p, (select * from opldok where fdat >= :l_dat1 and fdat <= :l_dat2 and tt =''PS1'' and dk=1 and sos=5   ) o,
              (select x.ref, x.kva, x.sumb/x.suma kurs, (x.suma-to_number(y.value)) S
               from  fx_deal x, operw y
               where x.dat >= :l_dat1 and x.dat <= :l_dat2 and x.kva<>980 and x.kvb=980 and x.ref=y.ref and y.tag= ''SUMKL'' ) f
          where p.ref = o.ref and o.ref = f.ref ';

         --logger.info ('PF*'||sSql_);
         EXECUTE IMMEDIATE sSql_
            USING l_dat1,
                  l_dat2,
                  l_dat1,
                  l_dat2;
      END IF;

      RETURN;
   END IF;

   -------------------------------------
   IF p_mode IN (1, 3, 4)
   THEN                                           -- ���������� � ������������
   for k in (SELECT SUBSTR (TRIM (val), 1, 6) as MFOP_, SUBSTR (TRIM (KF), 1, 6) as KF FROM params$base WHERE par = 'MFOP') -- ������ ���� �� ������� params$base ��� �������� ��������� MFO
  loop
    begin
        bc.go(k.KF);
        bars_audit.info('������������� ���: '||to_char(k.KF));
        bars_context.set_policy_group(p_policy_group => 'FILIAL'); -- �������� �������
    end;
    bars_audit.trace('%s ����� � ���������� p_mode = %s',title,p_mode);

   /*   BEGIN
         SELECT SUBSTR (TRIM (val), 1, 6)
           INTO MFOP_
           FROM params$base
          WHERE par = 'MFOP';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN raise_application_error (-20000, '�� �������� ���.MFOP');
      END; */

      bars_audit.trace('%s MFOP_= %s',title,K.MFOP_);
      IF '300465' IN (K.MFOP_, gl.aMfo)
      THEN
         ob36_nal := '12';
         ob36_bez := '35';
         ob29_nal := '09';
         ob29_bez := '15';
         ob74_ := '07';                                                  -- ��
      ELSE
         ob36_nal := '16';
         ob36_bez := '15';
         ob29_nal := '06';
         ob29_bez := '07';
         ob74_ := '09';                         -- NADRA If gl.aMfo = '380764'
      END IF;
      bars_audit.trace('%s ob36_nal= %s',title,ob36_nal);
      -- ������ �������� �������� - � ������ ������ �� ����������
      oo.vob := 6;

      BEGIN
         SELECT *
           INTO A12
           FROM accounts
          WHERE LENGTH (branch) = 8
            AND kv = 980
            AND dazs IS NULL
            AND nbs = '3622'
            AND ob22 = ob36_nal;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN bars_audit.info('bank_pf: �� �������� ��� 3622/' || ob36_nal || ' �� ���');
		       return;
      END;
       bars_audit.trace('%s A12= %s',title,to_char(A12.nls));
      BEGIN
         SELECT *
           INTO A35
           FROM accounts
          WHERE LENGTH (branch) = 8
            AND kv = 980
            AND dazs IS NULL
            AND nbs = '3622'
            AND ob22 = ob36_bez;
      EXCEPTION
         WHEN NO_DATA_FOUND then
           bars_audit.info('bank_pf:  �� �������� ��� 3622/' || ob36_bez || ' �� ���');
      END;
      bars_audit.trace('%s ob36_bez= %s, A35 = %s',title,to_char(ob36_bez),to_char(A35.nls));
      -- ������� �� ������������� ��������� �� ������ PF_TT3800  - ����� ������
      FOR k
         IN (SELECT NVL (T.NAL, 0) NAL,
                    a.kv,
                    SUBSTR (a.branch, 1, 15) BRANCH,
                    o.s,
                    NVL (
                       (SELECT ROUND (o.s * RATE_B / BSUM, 0)
                          FROM cur_rates$base
                         WHERE kv = a.kv
                           AND branch = a.branch
                           AND vdate = o.fdat),
                       gl.p_icurval (a.kv, o.s, o.fdat))                       q
               FROM opldok o,
                    accounts a,
                    PF_TT3800 T,
                    oper p
              WHERE o.dk = 1
                AND o.fdat = l_dat1
                AND o.acc = a.acc
                AND a.nbs IN ('3800')
                AND ob22 IN ('10', '20')
                AND T.tt = o.tt
                AND p.REF = o.REF
                AND p.sos = 5
                AND o.s > 0)
      LOOP
         rat_ := k.q / k.s;
         q5_ := ROUND (k.q * 5 / 1000, 0);
         bars_audit.trace('%s rat_= %s, q5_ = %s',title,to_char(rat_), to_char(q5_));
         IF k.q > 0
         THEN
            UPDATE CCK_AN_TMP
               SET n1 = n1 + q5_,                -- ������� ����� ������ � ���
                                 n2 = n2 + k.s,            -- ������� ��������
                                               n3 = n3 + k.q -- ���������� ��������
             WHERE branch = k.branch AND pr = k.nal AND kv = k.kv;

            IF SQL%ROWCOUNT = 0
            THEN
            bars_audit.trace('%s k.nal= %s',title,k.nal);
               IF k.nal = 1
               THEN OO.NLSA := A12.NLS;
               ELSE OO.NLSA := A35.NLS;
               END IF;

               --        OP_BS_OB1 (PP_BRANCH => k.branch, P_BBBOO => '7419'|| ob74_  );
               nls7_ := SUBSTR (nbs_ob22_null ('7419', ob74_, k.branch), 1, 14);
               bars_audit.trace('%snls7_= %s',title,nls7_);
               INSERT INTO CCK_AN_TMP (kv, branch, n1, NLS, NLSALT, PR, n2, n3, n4)
                    VALUES (k.kv,                                           --
                            k.branch,                               -- �����-2
                            q5_,            -- n1 = ������� ����� ������ � ���
                            nls7_,                               -- �� 7419/07
                            OO.NLSA,                                -- �� 3622
                            K.NAL,                   -- PR =1 - ������� ������
                            k.s,                      -- n2 = ������� ��������
                            k.q,                   -- n3 = ���������� ��������
                            rat_                        -- n4 = ��������� ����
                                );
            END IF;
         END IF;
      END LOOP;                                                           -- k

      -------------------------------------------------------------------------------
      --������������� ��� ��������� ���������� �� ������
      IF gl.aMfo = '300465'
      THEN
         sSql_ :=
            'insert into CCK_AN_TMP ( branch, kv   , n1,pr, n2 , n3                 , n4 ,          NLS, NLSALT )
             select                 a.branch, f.kva,o.s, 0, f.S, round(f.S*f.KURS,0), f.kurs, null, a.nls
             from accounts a,
                  (select * from opldok where fdat >= :l_dat1 and fdat <= :l_dat2 and tt =''PS1'' and dk=1 and sos=5   ) o,
                  (select x.ref, x.kva, x.sumb/x.suma kurs, (x.suma-to_number(y.value)) S
                   from  fx_deal x, operw y
                   where x.dat >= :l_dat1 and x.dat <= :l_dat2 and x.kva<>980 and x.kvb=980 and x.ref=y.ref and y.tag= ''SUMKL'' ) f
             where o.ref = f.ref and a.acc= o.acc ';

         --logger.info ('PF*'||sSql_);
         EXECUTE IMMEDIATE sSql_
            USING l_dat1,
                  l_dat2,
                  l_dat1,
                  l_dat2;
         bars_audit.trace('%s sSql_= %s',title,sSql_);
      END IF;

      --����� ����� �������������
      FOR Z IN (  SELECT PR, NLSALT, SUM (N1) S
                    FROM CCK_AN_TMP
                   WHERE n1 > 0
                GROUP BY pr, nlsalt)
      LOOP
         gl.REF (oo.REF);
         bars_audit.trace('%s oo.REF= %s, z.pR = %s, z.nlsalt = %s',title,to_char(oo.REF), to_char(z.pr),to_char(z.nlsalt));
         UPDATE CCK_AN_TMP
            SET nd = oo.REF
          WHERE pr = z.pR AND nlsalt = z.nlsalt;

         IF Z.PR = 1
         THEN
            OO.NLSA := A12.NLS;
            OO.NAM_A := SUBSTR (A12.NMS, 1, 38);
         ELSE
            OO.NLSA := A35.NLS;
            OO.NAM_A := SUBSTR (A35.NMS, 1, 38);
         END IF;

         -- ��.��������� ��� ������������ ���� "������" � �� (��) ��� ����� � �� (�����)
         IF '300465' IN (K.MFOP_, gl.aMfo)
         THEN
            oo.mfob := '300465';
            oo.id_b := '00032129';                     -- �� �� � �O� ��������

            IF Z.PR = 1
            THEN
               OO.NLSB := '36228012017';
               OO.NAM_B := '������i� � ���i����';
            ELSE
               OO.NLSB := '36227035017';
               OO.NAM_B := '������i� � ���/���i����';
            END IF;

            OO.NAZN := '����-��� �� �������. ����. ����. �����. �� ����. �� �� ' || TO_CHAR (l_dat1, 'dd.mm.yyyy');
         ELSE
            oo.mfob  := '820019';
            oo.id_b  := '37995466'; -- ������� ��������� �������� ������������ ������ ������ � �. ���
            oo.nlsb  := '31217222700011';
            OO.NAM_B := '����� � �������������� �-� �.����';

            IF z.PR = 1
            THEN oo.nazn := SUBSTR ('*;101;20025456;24140100;222;0.5% � ����� �������� �������� ������ ��� "��"�����" ��� ������ 20025456;;;', 1, 160);
            ELSE oo.nazn := SUBSTR ('*;101;20025456;24140100;222;0.5% � ����� ����������� �������� ������ ��� "��"�����" ��� ������ 20025456;;;', 1, 160);
            END IF;
         END IF;

         oo.nd := TRIM (SUBSTR ('     ' || TO_CHAR (oo.REF), -10));
         bars_audit.trace('%s oo.nd= %s',title,to_char(oo.nd));

         IF gl.aMfo = oo.mfob
         THEN oo.tt := '420';
         ELSE oo.tt := 'PS6';
         END IF;

         IF p_mode IN (1, 4)
         THEN
            gl.in_doc3 (ref_     => oo.REF,
                        tt_      => oo.tt,
                        vob_     => oo.vob,
                        nd_      => oo.nd,
                        pdat_    => SYSDATE,
                        vdat_    => gl.bdate,
                        dk_      => 1,
                        kv_      => 980,
                        s_       => Z.S,
                        kv2_     => 980,
                        s2_      => Z.S,
                        sk_      => NULL,
                        data_    => gl.bdate,
                        datp_    => gl.bdate,
                        nam_a_   => oo.nam_a,
                        nlsa_    => oo.nlsa,
                        mfoa_    => gl.aMfo,
                        nam_b_   => oo.nam_b,
                        nlsb_    => oo.nlsb,
                        mfob_    => oo.mfob,
                        nazn_    => oo.nazn,
                        d_rec_   => NULL,
                        id_a_    => gl.aOkpo,
                        id_b_    => oo.id_b,
                        id_o_    => NULL,
                        sign_    => NULL,
                        sos_     => 1,
                        prty_    => NULL,
                        uid_     => NULL);

            IF gl.aMfo = '300465'
            THEN             -- �O� ��������, ��������������� �������� �� ����
               UPDATE oper
                  SET nlsa = '74196007010000',
                      nam_a = 'C����� ������i� � �� �� ����.���.'
                WHERE REF = oo.REF;
            ELSE
               paytt (0,
                      oo.REF,
                      gl.bdate,
                      oo.tt,
                      1,
                      980,
                      oo.nlsa,
                      z.s,
                      980,
                      oo.NLSb,
                      z.s);
            END IF;
         END IF;

         IF p_mode IN (3)
         THEN
           bars_audit.trace('%s IF p_mode IN (3) %s',title,to_char(oo.REF));
            gl.in_doc3 (
               ref_     => oo.REF,
               tt_      => '420',
               vob_     => oo.vob,
               nd_      => oo.nd,
               pdat_    => SYSDATE,
               vdat_    => gl.bdate,
               dk_      => 1,
               kv_      => 980,
               s_       => Z.S,
               kv2_     => 980,
               s2_      => Z.S,
               sk_      => NULL,
               data_    => gl.bdate,
               datp_    => gl.bdate,
               nam_a_   => oo.nam_a,
               nlsa_    => nls7_,
               mfoa_    => gl.aMfo,
               nam_b_   => 'C����� ������i� � �� �� ����.���.',
               nlsb_    => oo.nlsa,
               mfob_    => gl.aMfo,
               nazn_    => oo.nazn,
               d_rec_   => NULL,
               id_a_    => gl.aOkpo,
               id_b_    => gl.aOkpo,
               id_o_    => NULL,
               sign_    => NULL,
               sos_     => 1,
               prty_    => NULL,
               uid_     => NULL);
         END IF;

         IF p_mode IN (1, 3)
         THEN
            FOR k IN (SELECT kv,
                             branch,
                             n1,
                             n2,
                             n3,
                             n4,
                             nls
                        FROM CCK_AN_TMP
                       WHERE n1 > 0 AND pr = z.pr        --and nls is not null
                                                 )
            LOOP
             bars_audit.trace('%s k.nls = %s',title,to_char(k.nls));
               IF k.nls IS NULL
               THEN raise_application_error ( -20000, '�� �������� NLS ��� ������=' || k.branch);
               END IF;

               gl.payv (0,
                        oo.REF,
                        gl.bdate,
                        '420',
                        0,
                        980,
                        oo.nlsa,
                        k.n1,
                        980,
                        K.NLS,
                        k.n1);

               UPDATE opldok
                  SET txt = SUBSTR ( '���=' || k.kv || ', ���=' || k.n2 || ', ���=' || k.n3 || ', ����=' || k.n4, 1, 50)
                WHERE REF = oo.REF
                  AND stmt = gl.aStmt;
            END LOOP;                                     -- ������ 1 ��������

            IF p_mode IN (3)
            THEN
               gl.pay2 (2, oo.REF, l_dat1);
            END IF;
         END IF;
      END LOOP;                                                           -- Z

      -- ������ ��� ���� - ������� ��������
      IF gl.aMfo = '300465'
      THEN                   -- �O� ��������, ��������������� �������� �� ����
         --RETURN;
         continue;
      END IF;

      --------------------
      IF p_mode = 3
      THEN                   -- �O� ��������, ��������������� �������� �� ����
       bars_audit.trace('%s �O� ��������, ��������������� �������� �� ����',title);
       --RETURN;
       continue;
      END IF;

      FOR z_ IN 0 .. 1
      LOOP
         IF Z_ = 1
         THEN
            BEGIN
               SELECT *
                 INTO A12
                 FROM accounts
                WHERE LENGTH (branch) = 8
                  AND kv = 980
                  AND dazs IS NULL
                  AND nbs = '2902'
                  AND ob22 = ob29_nal;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN raise_application_error (-20000, '�� �������� ��� 2902/' || ob29_nal || ' �� ���');
            END;
         ELSE
            BEGIN
               SELECT *
                 INTO A12
                 FROM accounts
                WHERE LENGTH (branch) = 8
                  AND kv = 980
                  AND dazs IS NULL
                  AND nbs = '2902'
                  AND ob22 = ob29_bez;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN raise_application_error ( -20000, '�� �������� ��� 2902/' || ob29_bez || ' �� ���');
            END;
         END IF;

         OO.NLSA := A12.NLS;
         OO.NAM_A := SUBSTR (A12.NMS, 1, 38);

         -- ��.��������� ��� ������������ ���� "������" � �� (��) ��� ����� � �� (�����)
         IF K.MFOP_ = '300465'
         THEN
            oo.mfob := K.MFOP_;
            oo.id_b := '00032129';                             -- �O� ��������

            IF Z_ = 1
            THEN
               OO.NLSB := '29022009017';
               OO.NAM_B := '������i� � ���i����';
            ELSE
               OO.NLSB := '29027015017';
               OO.NAM_B := '������i� � ���/���i����';
            END IF;

            OO.NAZN := '����-������������� �� �������. ����. ����. �����. �� ������� �� �� ' || TO_CHAR (l_dat1, 'dd.mm.yyyy');
         ELSE
            oo.mfob  := '820019';
            oo.id_b  := '37995466'; -- ������� ��������� �������� ������������ ������ ������ � �. ���
            oo.nlsb  := '31217222700011';
            OO.NAM_B := '����� � �������������� �-� �.����';
            oo.nazn  := '*;101;00032129; ��� � �������� �����-������� �������� ������ �� ������;;;';

            IF z_ = 1
            THEN oo.nazn := SUBSTR ('*;101;20025456;24140100;222;0.5% � ������� �������� �������� ������ ��� "��"�����" ��� ������ 20025456;;;', 1, 160);
            ELSE oo.nazn := SUBSTR ('*;101;20025456;24140100;222;0.5% � ������� ����������� �������� ������ ��� "��"�����" ��� ������ 20025456;;;', 1, 160);
            END IF;
         END IF;

         -- ������ ��� ����-������
         SELECT NVL (SUM (s), 0)
           INTO oo.s
           FROM opldok
          WHERE acc = a12.acc
            AND fdat = l_dat1
            AND tt = 'BAK'
            AND dk = 0;

         -- ���� ��� �������
         oo.s := (-oo.s) + fkos (a12.acc, l_dat1, l_dat1);
         -- �� �� �����, ��� �������
         oo.s := LEAST (oo.s, a12.ostc);

         IF gl.amfo = '380764'
         THEN                             -- � ������ ����� 2902 �� 2-� ������
            SELECT NVL (SUM (LEAST (fkos (acc, l_dat1, l_dat1), ostc)), 0)
              INTO oo.s
              FROM accounts
             WHERE nbs = a12.nbs
               AND ob22 = a12.ob22
               AND branch <> a12.branch;
         END IF;

         IF oo.s > 0
         THEN
            gl.REF (oo.REF);
            oo.nd := TRIM (SUBSTR ('    ' || TO_CHAR (oo.REF), -10));

            IF gl.aMfo = oo.mfob
            THEN oo.tt := '420';
            ELSE oo.tt := 'PS6';
            END IF;

            gl.in_doc3 (ref_     => oo.REF,
                        tt_      => oo.tt,
                        vob_     => oo.vob,
                        nd_      => oo.nd,
                        pdat_    => SYSDATE,
                        vdat_    => gl.bdate,
                        dk_      => 1,
                        kv_      => 980,
                        s_       => oo.S,
                        kv2_     => 980,
                        s2_      => oo.S,
                        sk_      => NULL,
                        data_    => gl.bdate,
                        datp_    => gl.bdate,
                        nam_a_   => oo.nam_a,
                        nlsa_    => oo.nlsa,
                        mfoa_    => gl.aMfo,
                        nam_b_   => oo.nam_b,
                        nlsb_    => oo.nlsb,
                        mfob_    => oo.mfob,
                        nazn_    => oo.nazn,
                        d_rec_   => NULL,
                        id_a_    => gl.aOkpo,
                        id_b_    => oo.id_b,
                        id_o_    => NULL,
                        sign_    => NULL,
                        sos_     => 1,
                        prty_    => NULL,
                        uid_     => NULL);

            IF gl.amfo = '380764'
            THEN
               FOR k
                  IN (SELECT nls, LEAST (fkos (acc, l_dat1, l_dat1), ostc) s
                        FROM accounts
                       WHERE nbs = a12.nbs
                         AND ob22 = a12.ob22
                         AND branch <> a12.branch)
               LOOP
                  IF k.s > 0
                  THEN
                     gl.payv (0,
                              oo.REF,
                              gl.bdate,
                              'PS6',
                              0,
                              980,
                              oo.nlsa,
                              k.s,
                              980,
                              K.NLS,
                              k.s);
                  END IF;
               END LOOP;
            END IF;

            paytt (0,
                   oo.REF,
                   gl.bdate,
                   oo.tt,
                   1,
                   980,
                   oo.nlsa,
                   oo.s,
                   980,
                   oo.NLSb,
                   oo.s);

            UPDATE oper
               SET s = oo.s, s2 = oo.s
             WHERE REF = oo.REF;
         END IF;
      END LOOP; -- z_
    end loop; --��������� ����� �� ������� params$base
   END IF;

END BANK_PF;
/

show err