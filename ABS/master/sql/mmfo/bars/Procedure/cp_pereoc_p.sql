

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_PEREOC_P.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_PEREOC_P ***

CREATE OR REPLACE PROCEDURE CP_PEREOC_P (mode_ in INT, p_vob in oper.vob%type)
IS
   -- v.1.19 26/09/2018
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

   l_nlss2         cp_accc.nlss2%type;
   l_nlss2_6       cp_accc.nlss2_6%type;
   l_accs2_6       accounts.acc%type;
   l_nlss2_vnesist accounts.nls%type;
   l_nmss2_vnesist accounts.nms%type;
   l_accs2_vnesist accounts.acc%type;   
   l_accs2_sist    accounts.acc%type;
   l_grp           accounts.grp%type;   
   l_dazs          cp_deal.dazs%type;   
   l_s8            varchar2(8);   
   l_p4            integer;   
--   l_nls_fxp       cp_accc.nls_fxp%type;
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
    FOR K IN (     SELECT   V.SOS,    V.ND,     V.DATD,   V.SUMB,       V.DAZS,       V.DATP_A,     V.FL_REPO,
                   V.TIP,     V.REF,    V.ID,     V.NAME,   V.CP_ID,      V.MDATE,      V.CENA,       V.IR,
                   V.ERAT,    V.RYN,    V.VIDD,   V.KV,     V.KOL,        V.KOL_CP,     V.N,          V.D,
                   V.P,       V.R,      V.R2,     V.S,      V.BAL_VAR,    V.BAL_VAR1,   V.NKD1,       V.RATE_B,
                   V.K20,     V.K21,    V.K22,    V.OSTR,   V.OSTR_F,     V.OSTAF,      V.OSTS_P,     V.EMI,
                   V.DOX,     V.RNK,    V.PF,     V.PFNAME, V.DAT_ZV,     V.DAPP,       V.DATP,       V.QUOT_SIGN,
                   V.FL_ALG
              FROM CP_PEREOC_V V, CP_RATES_SB S
             WHERE V.ref = S.REF and ((V.K22 <> 0) or (V.BAL_VAR1 = V.RATE_B and V.MDATE = V.DAT_ZV)))
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
         SELECT nvl(MAX (o.fdat), gl.bd)
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

      
      if ca.pf not in (1, 4) or k.kv != 980
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
        bars_audit.info(title|| 'ca.pf = '||ca.pf);
            --pf = 1 http://jira.unity-bars.com.ua:11000/browse/COBUPRVN-246
            /* �������� ������������ ��� ���� "Millenium"- ��� "ֳ�� ������", � ���� - ����� ��������� ��� � 400 ���������� ������ ������
               � ������� �� ������ ������� ��������������� �� ������ �� ����������� � ��������� ����������� (�� �����).
               ���������� � ��������� ������� ������� ���������� ��� ���� �����������, ����� ���������� ��������� � ������� �ᒺ� � ����������� ����.
               ��������� ����� ��������� ���������� ������, ���������� � �������� �����. � ����, � ���������� ������ ��� ���������� ��������� ����������� ���� ������ ���������� ����������.
               �� ��������� ��� ����������� ������� ������� ���������� � ������� �� ������ 5102.
               �����, ������� ������� 5102 (980) �� ���������� ������� ������� 1415 (840) �� ����� ���� ����������.
               �������� �����, �� � ���������� ������� ������ ������ ��� ���������� ���������� (��� "ֳ�� ������"- �������" ����� ���������� ����������",
               ��������� �������� ( � ������ ) ���� ������� �� ��������� ���� �������, � ����� ��-������� �� �������� ����������� ��������. */
               
             /* http://jira.unity-bars.com:11000/browse/COBUMMFO-8649 
                Գ�������: 
             ������ ����, ����� ������ ���� : �� ���������� �� ������ � �������� �� �������. ��� ���� ���������� �� ���������� ���������� 400. � �������� �� ������� ��� ����� ����������� ����� , ��� ��� ��������� ����������, ���� ��������� ����� ����������. �.�. ���������� ������ ���� ��������� �� ������ ����� ���������� � ���������. ��� ���� ��������� ��� �������� �� �������. � ��� ��������� - ������ ������ �� ����. ������� ����� �������� ����� ������ ����������.
             � ����� 14-� ���������� ������ ��������������� ���������- ���.
             ������� ���� ��� ��������� ������� ��� ������ ����������- �� ������ ��� ������������� ���������� � ��������������� ����� ���������� (������������� �������).
             ������� ������ ���:
                                ��������� ���������� ���������� � �������� �� ������� ��� ��������� ���������, �. �. ��������� ���������� ���� �� ������, � �������� ����������� ������� �� ���������� �� ����������� ����� � ����� ���������� �� ������ �����.
                                ����� ������ ����������� ���� ���������� � ��� ��������� ��������.
             */  
               
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
              SQ_ := op.s2;-- ����� ��������� �� ����������� ����� ��� �������� 

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

   -- ��� �� � ����� CP_PEREOC_V (�� ����� ��� ���������� (��������)), �� ���� 'OPCION', 'N', '������-��~�����~ �� �������' �� ���� ����
   -- http://jira.unity-bars.com:11000/browse/COBUPRVNIX-157 ������������� ��������� �������� �� ����������� ���������� ��������� �������� ��� ������������ ���� 9
   FOR K IN (     SELECT   V.SOS,    V.ND,     V.DATD,   V.SUMB,       V.DAZS,       V.DATP_A,     V.FL_REPO,
                   V.TIP,     V.REF,    V.ID,     V.NAME,   V.CP_ID,      V.MDATE,      V.CENA,       V.IR,
                   V.ERAT,    V.RYN,    V.VIDD,   V.KV,     V.KOL,        V.KOL_CP,     V.N,          V.D,
                   V.P,       V.R,      V.R2,     V.S,   V.BAL_VAR,    V.BAL_VAR1,   V.NKD1,       V.RATE_B,
                   V.K20,     V.K21,    V.K22,    V.OSTR,   V.OSTR_F,     V.OSTAF,      V.OSTS_P,     V.EMI,
                   V.DOX,     V.RNK,    V.PF,     V.PFNAME, V.DAT_ZV,     V.DAPP,       V.DATP,       V.QUOT_SIGN,
                   V.FL_ALG, V.OPCION, V.NLS,     V.S2
              FROM CP_PEREOC_V V, CP_RATES_SB S
             WHERE V.ref = S.REF and V.OPCION <> 0)
   loop
      l_err := '';
      bars_audit.info(title|| 'ID = ' || to_char(k.ID) ||',S = ' || to_char(k.S)||',OPCION='||to_char(k.OPCION)||' ...����� ��������� ��� ��������� ���������');
      
      /*if k.pf != 4 then
        l_err := '���������� �� ������� ��������� ����� ��� ��������� �������� (4.��.�������� ��������)';
        bars_audit.error(title|| ': ' || l_err);
        raise_application_error(-20001, l_err );
      end if;  
      */
      
      --��������� ������� ���������� �������
      select  a.nlss2,
              (select ac.cp_acc from cp_accounts ac where ac.cp_ref = k.ref and ac.cp_acctype = 'S2') as accs2,
              a.nlss2_6,
              (select acc from accounts where nls = a.nlss2_6 and kv = 980) accs2_6
         into l_nlss2,
              l_accs2_vnesist,
              l_nlss2_6,
              l_accs2_6
      from cp_kod kod
      left join cp_accc a on (a.ryn = k.ryn and nvl(k.pf, a.pf) = a.pf and k.emi = a.emi and substr(k.nls,1,4)=a.vidd )
      where kod.id = k.id;

      -- ��������� ������������������ ����� ����������
      begin
         l_msg := 'a6';

         select *
           into a6
           from accounts
          where kv = 980
            and dazs is null
            and nls = l_nlss2_6;
        exception
          when NO_DATA_FOUND then 
            l_err := l_err||CHR(10)||CHR(13)||'�� ������� ������� �������������� ������� ����������(������) � cp_accc ('||l_nlss2_6||') ��� ref='|| k.REF || ' ' || l_msg;
      end;

      if l_accs2_vnesist is null then
           bars_audit.info(title ||' �� �������� ������� ���������� �� ������� ���������� �� �����. ������ �������� �� �������... ');
           --���������� ��������������
           if l_nlss2 is null  then
             l_err := l_err||CHR(10)||CHR(13)||'�� ������� ���� ������� �������������� ���������� (������) � cp_accc ��� ref='|| k.REF;
             elsif l_nlss2_6 is null  then
               l_err := l_err||CHR(10)||CHR(13)||'�� ������� ���� ������� 6 ����� ���������� (������) � cp_accc ��� ref='|| k.REF; 
             else 
               l_dazs := null;
               begin
                 select a.dazs, a.acc,        a.grp, k.cp_id||'/'||a.nms
                   into l_dazs, l_accs2_sist, l_grp, l_nmss2_vnesist
                 from accounts a
                 where a.nls = l_nlss2 and a.kv = k.kv;
                 exception
                   when NO_DATA_FOUND then
                     l_err := l_err||CHR(10)||CHR(13)||'������������� ������� ���������� (������) '||l_nlss2||' � ����� '||k.kv||' �� ��������'; 
               end;
               if l_dazs is not null then
                 l_err := l_err||CHR(10)||CHR(13)||'������������� ������� �������� '||l_nlss2||' �������� '||l_dazs;
               end if;

               if l_err is null then
                 l_s8 := substr('000000000'|| k.ref, -8 );
                 l_nlss2_vnesist := substr(l_nlss2,1,5)||'1'||l_s8;
                 --�������
                 cp.CP_REG_EX(99,0,0,l_grp,l_p4, k.rnk , l_nlss2_vnesist,k.kv, l_nmss2_vnesist,'ODB',gl.aUid,l_accs2_vnesist);
                 update accounts
                 set accc=l_accs2_sist, seci=4, pos=1
                 where acc=l_accs2_vnesist;

                 cp.cp_inherit_specparam (l_accs2_vnesist, l_accs2_sist, 0);

                 --��������
                 insert into cp_accounts(cp_ref, cp_acctype, cp_acc)
                 values(k.ref, 'S2', l_accs2_vnesist);
               end if;  
           end if;
      end if;

      -- �������� ������� ���������� 
      begin
         l_msg := 'ad';

         select *
           into ad
           from accounts
          where acc = l_accs2_vnesist and dazs is null;
        exception
          when NO_DATA_FOUND then 
            l_err := l_err||CHR(10)||CHR(13)||'�� ������� ���� ������� ����������  ('||to_char(l_accs2_vnesist)||') ��� ref='|| k.REF || ' ' || l_msg;
      end;

      if l_err is null then
        bars_audit.info(title || ' ����������� - ��');
        else   
          bars_audit.error(title || ' '||l_err);
          bars_error.raise_nerror('BRS', 'NO_DATA_FOUND', l_err);
      end if;
      
      bars_audit.info( title|| ' ����� ���������� ����������');
      begin                                                 
        select nvl(max (o.fdat), gl.bd)
           into l_prev_vdat
           from opldok o, cp_payments cp
          where o.acc = l_accs2_vnesist
            AND o.sos = 5
            AND o.ref = cp.op_ref
            AND o.fdat >= ad.daos
            AND o.fdat < gl.bd
            AND cp.cp_ref = k.ref;
        bars_audit.info( title|| '���� ���������� ���������� = '|| to_char(l_prev_vdat,'dd.mm.yyyy'));
      exception
         when NO_DATA_FOUND then 
           l_prev_vdat := gl.bd;
           bars_audit.info(title|| '���� ���������� ���������� �� ��������');
      end;  

      -- ����������� �������� 
      if k.opcion >= 0 then  
        op.dk := 1;
        bars_audit.info(title||' ������������ ���������� ���������� k.opcion >= 0 '||op.dk);
        else  
          op.dk := 0;
          bars_audit.info(title||' ������������ ���������� ���������� k.opcion < 0 '||op.dk);
      end if;

      op.nazn := '������i��� (������)'  || to_char(k.cp_id)
                || ' ����� � '  || to_char(k.ND)
                || ' �� ����� ' || to_char(k.k20)
                || ' ���� '     || to_char(k.dat_zv,'dd.mm.yyyy')
                || ' ����� '    || to_char(k.kol_cp)
                || ' ��.';
      bars_audit.info(title|| op.nazn);


      --����� ���������� �� ����� ��������� ���� '������-��~�����~ �� �������' 
      op.s := abs(k.opcion) * 100;
      -- ���������� ���������� �� "�������"
      if k.kv = a6.kv then  
        op.vob := nvl(op.vob,6);    
        op.s2 := op.S;
        else  
          op.vob := nvl(op.vob,16);   
          op.s2 := gl.p_icurval(k.kv, op.S, l_valdate);
      end if;
      if k.kv != a6.kv then
        bars_audit.info(title|| ' l_valdate='||l_valdate||' gl.p_icurval(k.kv, op.S, l_valdate)='||gl.p_icurval(k.kv, op.S, l_valdate)||' l_prev_vdat='||l_prev_vdat);
      end if;

      gl.ref(i_ref => op.REF);
      gl.in_doc3( ref_     => op.REF,
                  tt_      => op.tt,
                  vob_     => op.vob,
                  nd_      => to_char (op.REF),
                  pdat_    => sysdate,
                  vdat_    => l_valdate,
                  dk_      => op.dk,
                  kv_      => k.kv,
                  s_       => op.s,
                  kv2_     => a6.kv,
                  s2_      => op.s2,
                  sk_      => null,
                  data_    => gl.bd,
                  datp_    => gl.bd,
                  nam_a_   => substr(ad.nms, 1, 38),
                  nlsa_    => ad.nls,
                  mfoa_    => gl.aMfo,
                  nam_b_   => substr(a6.nms, 1, 38),
                  nlsb_    => a6.nls,
                  mfob_    => gl.amfo,
                  nazn_    => op.nazn,
                  d_rec_   => null,
                  id_a_    => gl.aOkpo,
                  id_b_    => gl.aOkpo,
                  id_o_    => null,
                  sign_    => null,
                  sos_     => 1,
                  prty_    => null,
                  uid_     => null);

                gl.payv (0,     op.REF,     l_valdate,
                         op.tt, op.dk,
                         ad.kv, ad.nls,     op.s,
                         a6.kv, a6.nls,     op.s2);
             bars_audit.info(title|| ' ���������� - 1 ����� - ��, ref =' || to_char(op.ref));
             --������������ ������ � ���������� ������
             S_ := 0;
             if k.S2 <> 0 then
                if k.S2 > 0 then DK_ := 1;
                  else DK_ := 0;
                end if;

                S_  := ABS (k.S2 * 100);
                SQ_ := gl.p_icurval (k.kv, S_, l_prev_vdat);-- ����������� �������� �� ������������ �����

                PAYtt (0,           op.REF,     l_valdate,
                       op.tt,       DK_,
                       ad.kv,        ad.NLS,     S_,
                       gl.baseval,  a6.nls,     SQ_);

             end if;
             
             
             begin
               insert into cp_payments
               values(k.ref, op.ref);
               exception 
                 when dup_val_on_index then  bars_audit.info(title ||' ���������� ��� � � cp_payments');
             end;


             delete from cp_rates_sb  where ref = k.ref;
             
   end loop;
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
