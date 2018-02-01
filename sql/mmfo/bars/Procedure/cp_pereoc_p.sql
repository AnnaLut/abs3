

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_PEREOC_P.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_PEREOC_P ***

CREATE OR REPLACE PROCEDURE CP_PEREOC_P (mode_ in INT, p_vob in oper.vob%type)
IS
   -- v.1.14 31/01/2018
   title   CONSTANT VARCHAR2 (20) := 'CP_PEREOC_P:';
   --ce               cp_deal%ROWTYPE;  -- ��������� ������ � ��
   l_accs           cp_deal.accs%type; -- ���� ���������� /������/��������
   l_ryn            cp_deal.ryn%type;
   ar               accounts%ROWTYPE;
   ad               accounts%ROWTYPE; -- ��������� ����� ���������� (cp_deal.accs)
   ca               cp_accc%ROWTYPE;
   a6               accounts%ROWTYPE;
   op               oper%ROWTYPE;
   fl_              INT;
   S_               NUMBER;
   SQ_              NUMBER;
   dk_              INT;
   l_err            VARCHAR2 (4000);
   l_msg            VARCHAR2 (10);
   l_prev_vdat      DATE;             -- COBUSUPABS-3715 ���������, ��� ����������, �� ������� ���������, ����������� �� ����� ��� �� ���� �� ���������� (���� ���������� �������� �� ���������� � ���).
   l_valdate        DATE;             -- ��� ���� �������� ���� ����� �� ���� ���������� ��� ������
   l_can3800_branch branch.branch%type;
BEGIN
   bars_audit.info(title||' ������ ������. �������������.');

   if nvl(p_vob, 0) = 96
   then
    l_valdate := DAT_NEXT_U(DAT_NEXT_U(last_day(add_months(gl.bd,-1)), 1),-1); --DAT_NEXT_U(����, 0) - ���� �� ��������, �� �����. � ���� ����-���� (+1, -1) �� � ��� ���� �� ��������, ����� ��������� �������.
    op.vob := p_vob;
    bars_audit.info(title||' gl.bdate = %s, op.vob = %s ' || to_char(gl.bdate)|| to_char(op.vob));
    op.tt := '096'; -- �� ������ �������� � �.
   else
    op.tt := 'FXP';
    l_valdate := gl.bd;
   end if;
    -- ������ 'FXP' ������ � ���� = � ��� 096, � �� ���� �� ������ � �������
   op.tt := 'FXP';
   begin
   select distinct branch
     into l_can3800_branch
     from accounts
    where nbs ='3800'
      and dazs is null
      and ob22 = '22' --(select substr(s3800, length(s3800)-4,2) from tts where tt = op.tt) 
      and branch like '/'|| sys_context('bars_context','user_mfo') ||'/%';
   exception when no_data_found then bars_error.raise_nerror('CAC','������� 3800 �� ����');
   end;
   bc.go(l_can3800_branch);

   -- �������� ������� ���� � �������� �������� op.tt
   BEGIN
      SELECT DECODE (SUBSTR (flags, 38, 1), '1', 2, 0)
        INTO FL_
        FROM tts
       WHERE tt = op.tt;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN bars_error.raise_nerror('DOC', 'TRANSACTION_DOES_NOT_EXIST', op.tt);
   END;

   -- ��� ����� �� ����� CP_PEREOC_V (�� ����� ��� ���������� (��������)), ��� ���� ������-��~�����~ ���.22 �� ����� ����
    FOR K IN (     SELECT   SOS,    ND,     DATD,   SUMB,       DAZS,       DATP_A,     FL_REPO,
                   TIP,     REF,    ID,     NAME,   CP_ID,      MDATE,      CENA,       IR,
                   ERAT,    RYN,    VIDD,   KV,     KOL,        KOL_CP,     N,          D,
                   P,       R,      R2,     S,      BAL_VAR,    BAL_VAR1,   NKD1,       RATE_B,
                   K20,     K21,    K22,    OSTR,   OSTR_F,     OSTAF,      OSTS_P,     EMI,
                   DOX,     RNK,    PF,     PFNAME, DAT_ZV,     DAPP,       DATP,       QUOT_SIGN,
                   FL_ALG
              FROM CP_PEREOC_V
             WHERE (K22 <> 0) or (BAL_VAR1 = RATE_B and MDATE = DAT_ZV))
   LOOP
      l_err := '';
      l_msg := '';
      bars_audit.info(title|| 'ID = ' || to_char(k.ID) ||',S = ' || to_char(k.S)||',K22='||to_char(k.K22)||',BAL_VAR1='||to_char(k.BAL_VAR1)||', RATE_B ='|| to_char(k.RATE_B));
      -- ��������� ������ cp_deal
      BEGIN
         SELECT accs, ryn
           INTO l_accs, l_ryn
           FROM cp_deal
          WHERE REF = k.REF
            AND accs IS NOT NULL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := title||'�� ������� ������ ������ cp_deal c ����������� ������ ���������� (accs) ��� ref='|| k.REF;
      END;

      -- ��������� ����� ���������� cp_deal.accs
      BEGIN
         l_msg := 'ad';

         SELECT *
           INTO ad
           FROM accounts
          WHERE acc = l_accs
           AND dazs IS NULL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := l_err||CHR(10)||CHR(13)||'�� ������� ������ ����� ���������� cp_deal.accs ('||to_char(l_accs)||') ��� ref='|| k.REF || ' ' || l_msg;
      END;
      -- ACC ������������������ ����� ad.accc
      BEGIN
         l_msg := 'ar';

         SELECT *
           INTO ar
           FROM accounts
          WHERE acc = ad.accc
            AND dazs IS NULL
            AND kv = ad.kv;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err :=  l_err||CHR(10)||CHR(13)||'�� ������� ������ ������������������ ����� ����������('||to_char(ad.accc)||') ��� ref='|| k.REF || ' ' || l_msg;
      END;
      -- ������ ����������������� ������ ������ (����� �� ����������� � ����� ����������)
      BEGIN
         l_msg := 'ca';

         SELECT *
           INTO ca
           FROM cp_accc
          WHERE ryn = l_ryn
            AND nlss = ar.nls;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := l_err||CHR(10)||CHR(13)||'�� ������� ������ ����������������� ������ '||ar.nls ||' ryn = '|| to_char(l_ryn)||') ��� ref='|| k.REF || ' ' || l_msg;
      END;
      -- ��������� ������������������ ����� ����������
      BEGIN
         l_msg := 'a6';

         SELECT *
           INTO a6
           FROM accounts
          WHERE kv = 980
            AND dazs IS NULL
            AND nls = ca.NLS_FXP;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_err := l_err||CHR(10)||CHR(13)||'�� ������� ��������� ������������������ ����� ���������� ('||ca.NLS_FXP||') ��� ref='|| k.REF || ' ' || l_msg;
      END;

      bars_audit.info( title|| ' ����� ���������� ����������');
      BEGIN                                                 --COBUSUPABS-3715
         SELECT MAX (o.fdat)
           INTO l_prev_vdat
           FROM opldok o, cp_payments cp
          WHERE o.acc = ad.acc
            AND o.sos = 5
            AND o.ref = cp.op_ref
            AND o.fdat >= ad.daos
            AND o.fdat < gl.bd
            AND cp.cp_ref = k.ref;
         bars_audit.info( title|| '���� ���������� ���������� = '|| to_char(l_prev_vdat,'dd.mm.yyyy'));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_prev_vdat := gl.bd;
              bars_audit.info(title|| '���� ���������� ���������� �� �������');
      END;                                                  --/COBUSUPABS-3715
      IF l_err IS NULL
        THEN   bars_audit.info(title || ' ������������� - ��');
        ELSE   bars_error.raise_nerror('BRS', 'NO_DATA_FOUND', l_err);
      END IF;
      bars_audit.info(title|| ' ���������� - �����' );

      -- ����������� �������� ����������
      IF      k.k22 >= 0
        THEN  op.dk := 1;
              bars_audit.info(title||' ����������� �������� ���������� k.k22 >= 0 '||op.dk);
        ELSE  op.dk := 0;
              bars_audit.info(title||' ����������� �������� ���������� k.k22 < 0 '||op.dk);
      END IF;

      op.nazn := '������i��� '  || to_char(k.cp_id)
                || ' ����� � '  || to_char(k.ND)
                || ' �� ����� ' || to_char(k.k20)
                || ' ���� '     || to_char(k.dat_zv,'dd.mm.yyyy')
                || ' ����� '    || to_char(k.kol_cp)
                || ' ��.';
      bars_audit.info(title|| op.nazn);

      if ca.pf != 1 or k.kv != 980
      then
         bars_audit.info(title|| 'ca.pf != 1 ,k.kv ='|| k.kv);
          --����� ���������� �� ����� ��������� ���� ������-��~�����~ ���.22
          op.s := ABS (k.k22) * 100;
          -- ���������� ���������� �� "�������"
          IF      ad.kv = a6.kv
            THEN  op.vob := nvl(op.vob,6);    op.s2 := op.S;
            ELSE  op.vob := nvl(op.vob,16);   op.s2 := gl.p_icurval (ad.kv, op.S, l_valdate);
          END IF;

          gl.REF (i_ref => op.REF);
          gl.in_doc3 (ref_     => op.REF,
                      tt_      => op.tt,
                      vob_     => op.vob,
                      nd_      => TO_CHAR (op.REF),
                      pdat_    => SYSDATE,
                      vdat_    => l_valdate,
                      dk_      => op.dk,
                      kv_      => ad.kv,
                      s_       => op.s,
                      kv2_     => a6.kv,
                      s2_      => op.s2,
                      sk_      => NULL,
                      data_    => gl.bd,
                      datp_    => gl.bd,
                      nam_a_   => SUBSTR (ar.nms, 1, 38),
                      nlsa_    => ar.nls,
                      mfoa_    => gl.aMfo,
                      nam_b_   => SUBSTR (a6.nms, 1, 38),
                      nlsb_    => a6.nls,
                      mfob_    => gl.amfo,
                      nazn_    => op.nazn,
                      d_rec_   => NULL,
                      id_a_    => gl.aOkpo,
                      id_b_    => gl.aOkpo,
                      id_o_    => NULL,
                      sign_    => NULL,
                      sos_     => 1,
                      prty_    => NULL,
                      uid_     => NULL);

                gl.payv (0,     op.REF,     l_valdate,
                         op.tt, op.dk,
                         ad.kv, ad.nls,     op.s,
                         a6.kv, a6.nls,     op.s2);
             bars_audit.info(title|| ' ���������� - 1 ����� - ��, ref =' || to_char(op.ref));
             --�������������� � ������������ ������
             S_ := 0;
             IF k.S <> 0
             THEN
                IF k.S > 0
                  THEN DK_ := 1;
                  ELSE DK_ := 0;
                END IF;

                S_  := ABS (k.S * 100);
                SQ_ := gl.p_icurval (k.kv, S_, l_prev_vdat);-- ������������ �������� �� ����������� �����

                PAYtt (0,           op.REF,     l_valdate,
                       op.tt,       DK_,
                       k.kv,        ad.NLS,     S_,
                       gl.baseval,  a6.nls,     SQ_);
                       
                --��� kk22=0 � ���� ���������� � 0, ������� ���������
                bars_audit.info(title|| ' ���������� - ref =' || to_char(op.ref)||' ����������� oper:  s='||S_||' s2='||SQ_);
                update oper o
                set o.s = S_,
                    o.s2 = SQ_
                where o.ref = op.REF;           
             END IF;
      else
        bars_audit.info(title|| 'ca.pf = 1 ');
            --pf = 1 http://jira.unity-bars.com.ua:11000/browse/COBUPRVN-246
            /* �������� ������������ ��� ���� "Millenium"- ��� "ֳ�� ������", � ���� - ����� ��������� ��� � 400 ���������� ������ ������
               � ������� �� ������ ������� ��������������� �� ������ �� ����������� � ��������� ����������� (�� �����).
               ���������� � ��������� ������� ������� ���������� ��� ���� �����������, ����� ���������� ��������� � ������� �ᒺ� � ����������� ����.
               ��������� ����� ��������� ���������� ������, ���������� � �������� �����. � ����, � ���������� ������ ��� ���������� ��������� ����������� ���� ������ ���������� ����������.
               �� ��������� ��� ����������� ������� ������� ���������� � ������� �� ������ 5102.
               �����, ������� ������� 5102 (980) �� ���������� ������� ������� 1415 (840) �� ����� ���� ����������.
               �������� �����, �� � ���������� ������� ������ ������ ��� ���������� ���������� (��� "ֳ�� ������"- �������" ����� ���������� ����������",
               ��������� �������� ( � ������ ) ���� ������� �� ��������� ���� �������, � ����� ��-������� �� �������� ����������� ��������. */
             --����� ���������� �� ����� ��������� ���� ������-��~�����~ ���.22
          op.s := ABS (k.k22) * 100;
             if (op.s != 0) then
              -- ���������� ���������� �� "�������"
              IF      ad.kv = a6.kv
                THEN  op.vob := nvl(op.vob,6);    op.s2 := op.S;
                ELSE  op.vob := nvl(op.vob,16);   op.s2 := gl.p_icurval (ad.kv, op.S, l_valdate);
              END IF;

              bars_audit.info(title|| ' op.s='|| to_char(op.s)||', op.s2='|| to_char(op.s2));

              S_  := op.S;
              SQ_ := op.s2;-- ����� ��������� �� ����������� ����� ��� �������� �� ������ pf = 1

              IF   (k.k22 > 0)
                THEN  op.dk := 1;
                ELSE  op.dk := 0;
              END IF;

              bars_audit.info(title|| '!!!===!!! k.S ='||to_char(k.S)||',op.dk ='||to_char(op.dk) ||',S='|| to_char(S_)||',SQ='|| to_char(SQ_));
              gl.REF (i_ref => op.REF);
              gl.in_doc3 (ref_     => op.REF,
                          tt_      => op.tt,
                          vob_     => op.vob,
                          nd_      => TO_CHAR (op.REF),
                          pdat_    => SYSDATE,
                          vdat_    => l_valdate,
                          dk_      => op.dk,
                          kv_      => ad.kv,
                          s_       => S_,
                          kv2_     => a6.kv,
                          s2_      => SQ_,
                          sk_      => NULL,
                          data_    => gl.bd,
                          datp_    => gl.bd,
                          nam_a_   => SUBSTR (ar.nms, 1, 38),
                          nlsa_    => ar.nls,
                          mfoa_    => gl.aMfo,
                          nam_b_   => SUBSTR (a6.nms, 1, 38),
                          nlsb_    => a6.nls,
                          mfob_    => gl.amfo,
                          nazn_    => op.nazn,
                          d_rec_   => NULL,
                          id_a_    => gl.aOkpo,
                          id_b_    => gl.aOkpo,
                          id_o_    => NULL,
                          sign_    => NULL,
                          sos_     => 1,
                          prty_    => NULL,
                          uid_     => NULL);
                    gl.payv (0,     op.REF,     l_valdate,
                             op.tt, op.dk,
                             ad.kv, ad.nls,     S_,
                             a6.kv, a6.nls,     SQ_);
             end if;
          end if;
          bars_audit.info(title||' ���������� - 2 ����� - ��,'|| to_char(op.ref)||' S_ = '||to_char(S_)||', SQ_ = '|| to_char(SQ_));
          -- ���������� ��������
          --gl.pay (1, op.REF, coalesce(l_valdate, gl.bdate));

          bars_audit.info(title|| ' ���������� - ��');

          begin
           insert into cp_payments
           values(k.ref, op.ref);
          exception when dup_val_on_index then  bars_audit.info(title ||' �������� ��� ���� � cp_payments');
          end;


          DELETE FROM CP_RATES_SB
                WHERE REF = k.REF;

   END LOOP;
   bars_audit.info(title|| ' �����.');
END CP_PEREOC_P;
/
show err;

PROMPT *** Create  grants  CP_PEREOC_P ***
grant EXECUTE                                                                on CP_PEREOC_P     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CP_PEREOC_P     to CP_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_PEREOC_P.sql =========*** End *
PROMPT ===================================================================================== 
