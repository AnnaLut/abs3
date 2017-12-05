

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_REG_LOCK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_REG_LOCK ***

  CREATE OR REPLACE PROCEDURE BARS.OP_REG_LOCK (
          mod_       INTEGER,   -- Opening mode : 1, 2, 3, 4, 5, 6, 9, 99, 77
          p1_        INTEGER,   -- 1st Par      : 1-nd, 2-nd, 3-main acc, 4-mfo, 5-mfo, 6-acc
          p2_        INTEGER,   -- 2nd Par      : 2-pawn, 4-acc
          p3_        INTEGER,   -- 3rd Par (Grp): 2-mpawn, others-grp
          p4_ IN OUT INTEGER,   -- 4th Par      : 2-ndz(O)
         rnk_        INTEGER,   -- Customer number
       p_nls_        VARCHAR2,  -- Account  number
          kv_        SMALLINT,  -- Currency code
         nms_        VARCHAR2,  -- Account name
         tip_        CHAR,      -- Account type
         isp_        SMALLINT,
        accR_    OUT INTEGER,
     nbsnull_        VARCHAR2 DEFAULT '1',
     pap_            NUMBER   DEFAULT NULL,
     vid_            NUMBER   DEFAULT NULL,
     pos_            NUMBER   DEFAULT NULL,
     sec_            NUMBER   DEFAULT NULL,       -- unused
     seci_           NUMBER   DEFAULT NULL,
     seco_           NUMBER   DEFAULT NULL,
     blkd_           NUMBER   DEFAULT NULL,
     blkk_           NUMBER   DEFAULT NULL,
     lim_            NUMBER   DEFAULT NULL,
     ostx_           VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
     nlsalt_         VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
     tobo_           VARCHAR2 DEFAULT NULL,
     accc_           NUMBER   DEFAULT NULL,       -- 'NULL' for update
     -- old values of parameters
     rnk_old         INTEGER  DEFAULT NULL,
     nls_old         VARCHAR2 DEFAULT NULL,
     kv_old          SMALLINT DEFAULT NULL,
     nms_old         VARCHAR2 DEFAULT NULL,
     tip_old         CHAR     DEFAULT NULL,
     isp_old         SMALLINT DEFAULT NULL,
     pap_old         NUMBER   DEFAULT NULL,
     vid_old         NUMBER   DEFAULT NULL,
     pos_old         NUMBER   DEFAULT NULL,
     sec_old         NUMBER   DEFAULT NULL,
     seci_old        NUMBER   DEFAULT NULL,
     seco_old        NUMBER   DEFAULT NULL,
     blkd_old        NUMBER   DEFAULT NULL,
     blkk_old        NUMBER   DEFAULT NULL,
     lim_old         NUMBER   DEFAULT NULL,
     ostx_old        VARCHAR2 DEFAULT NULL,
     nlsalt_old      VARCHAR2 DEFAULT NULL,
     tobo_old        VARCHAR2 DEFAULT NULL,
     accc_old        NUMBER   DEFAULT NULL,
     fl_             NUMBER   DEFAULT NULL
) IS

--***************************************************************--
--          ����������� - �������� ������
--             ver 5.4    04.12.2018
--
--          ������� ��������/���������� ���������� �����
--          � ��������������� �����������
--          ������������ �������� ������ �������� ����������
--          ��� ��������� �� �����������
--          SERG  23.03.2005
--
--                    ����.����� - ��� - MISYS
--          CCK     - �������� ������ ��� ���������� ��������
--          KF      - ����� � ����� 'kf'
--          PROF    - �������� ������ � �������������� ��������
--          ERR     - � ����� ���������� ������
--          ADDPROC - � �������������� ����������
--***************************************************************--

p0_        INTEGER;
l_nls      VARCHAR2(14);
grp_       INTEGER;
acc_       INTEGER;
ap_        NUMBER;
nbs_       CHAR(4);
l_bankdate DATE;
l_datbs    DATE;
l_datkv    DATE;
l_dazs     DATE;
l_isp      accounts.isp%type;
l_grp      accounts.grp%type;
l_blkd     accounts.blkd%type;
l_blkk     accounts.blkk%type;
l_sec      accounts.sec%type;
l_tobo     accounts.tobo%type;
l_dat      date;
er         NUMBER;
ern        CONSTANT POSITIVE := 021;
erm        VARCHAR2(254);
err        EXCEPTION;
par1       VARCHAR2(25)  := null;
l_count    number;
l_title    varchar2(100) := 'op_reg: ';

BEGIN
   bars_audit.info (l_title||'����� �������� ����� kf='||gl.amfo||', nls='||p_nls_);
   
   bars_audit.trace('%s params: mod_=%s, p1_=%s, p2_=%s, p3_=%s, p4_=%s, rnk_=%s, p_nls_=%s, kv_=%s',
        l_title, to_char(mod_), to_char(p1_), to_char(p2_), to_char(p3_), to_char(p4_), to_char(rnk_), p_nls_, to_char(kv_));
   bars_audit.trace('%s params: nms_=%s, tip_=%s, isp_=%s, accR_=%s, nbsnull_=%s, pap_=%s, vid_=%s, pos_=%s',
        l_title, nms_, tip_, to_char(isp_), to_char(accR_), nbsnull_, to_char(pap_), to_char(vid_), to_char(pos_));
   bars_audit.trace('%s params: blkd_=%s, blkk_=%s, lim_=%s, ostx_=%s, nlsalt_=%s, tobo_=%s, accc_=%s',
        l_title, to_char(blkd_), to_char(blkk_), to_char(lim_), ostx_, nlsalt_, tobo_, to_char(accc_));

   -- �������� �������, �� �������� ����������� ���� / �������� ��������� �����
   begin
      select date_off into l_dat from customer where rnk = rnk_;
      if l_dat is not null then
         erm  := '��������� ������� ������� / ��i���� ����i���� ������� - ������� �볺��� ��� #' || rnk_ ;
         er   := 41;
         par1 := rnk_;
         raise err;
      end if;
   exception when no_data_found then
      erm  := '�볺��� �� �������� #' || rnk_ ;
      er   := 42;
      par1 := rnk_;
      raise err;
   end;

   -- ����������
   l_bankdate := gl.bDATE;
   accR_ := NULL;
   IF mod_ <> 2 AND p3_ > 0 THEN
      grp_ := p3_;
   ELSE
      grp_ := NULL;
   END IF;
   
   l_nls := p_nls_ ;

   bars_audit.trace('%s ����������: l_bankdate=%s, grp_=%s, l_nls=%s',
        l_title, to_char(l_bankdate, 'dd/MM/yyyy'), to_char(grp_), l_nls);

   if acc_ is null then
      if (mod_ = 9 and p1_ <> -1) or mod_ <> 9  then
         l_nls := vkrzn(substr(f_ourmfo,1,5), p_nls_);
         bars_audit.trace('%s ����������� ����� nls= vkrzn(%s, %s) =%s',
              l_title, substr(f_ourmfo,1,5), p_nls_, l_nls);
      else
         l_nls := p_nls_;
         bars_audit.trace('%s ����������� ����� nls=%s', l_title,  p_nls_);
      end if;
   end if;

  
 
      
      select count(*) into l_count from transform_2017_forecast where kf = gl.amfo and new_nls  = l_nls;     
      if l_count  > 0 then 
         raise_application_error(-(20000 + 10), '������� '||l_nls||' ������������� �� ����� ���� �������', TRUE);
      end if;         
      
   -- ����������, ���� �� ����
   BEGIN

      if mod_ = 4 and p2_ > 0 then
         select acc, dazs into acc_, l_dazs from accounts where acc=p2_ ;
      else
         select acc, dazs into acc_, l_dazs from accounts where nls=l_nls and kv=kv_ ;
      end if;

	  
	  
	  
      bars_audit.trace('%s ������ ����: acc_=%s, l_dazs=%s',  l_title, to_char(acc_), to_char(l_dazs, 'dd/MM/yyyy'));

   EXCEPTION WHEN NO_DATA_FOUND THEN
      acc_   := NULL;
      l_dazs := null;
      bars_audit.trace('%s ���� �� ������.', l_title);
   END;

   -- ���� ���������� , �� �� ������
   IF acc_ is not null AND l_dazs is not null THEN

      if fl_ is not null then
        goto nowarn;
      end if;

      bars_audit.trace('%s ���������� �������� ��������� ��������� ����� %s', l_title, l_nls);

      erm := '9206 - ��������� ��i���� ����i���� ��������� ������� #'||l_nls ;
      er  := 5;
      par1 := l_nls;

      RAISE err;

   END IF;

   IF nbsnull_ IS NOT NULL THEN

      nbs_ := SUBSTR(l_nls,1,4) ;

      bars_audit.trace('%s nbsnull_ is not null, nbs_=%s', l_title, nbs_);

      IF acc_ is null THEN

         BEGIN

            SELECT pap, nbs, d_close INTO ap_, nbs_, l_datbs FROM ps WHERE nbs=nbs_ ;

         EXCEPTION WHEN NO_DATA_FOUND THEN

            if fl_ is not null and l_dazs is not null then
              goto nowarn;
            end if;

            bars_audit.trace('%s ����������� ���������� ���� %s', l_title, nbs_);

            erm := '9202 - Improper balance acc number #'||nbs_ ;
            er  := 6;
            par1 := nbs_;

            RAISE err;

         END;

         IF pap_ IS NOT NULL THEN
            ap_ := pap_;
         END IF;

      END IF;

      bars_audit.trace('%s nbsnull_ is not null, ap_=%s', l_title, to_char(ap_));

   ELSE

      nbs_:= NULL;
      ap_:= pap_;

      IF ap_ IS NULL THEN
         ap_ := 3;
      END IF;

      bars_audit.trace('%s nbsnull_ is null, nbs_=%s, ap_=%s', l_title, nbs_, to_char(ap_));

   END IF;


   -- ACCOUNTS
   IF acc_ IS NOT NULL THEN

      bars_audit.trace('%s ���������� ���������� ����� acc=%s', l_title, to_char(acc_));

      UPDATE accounts
         SET nls=decode(mod_,4,l_nls,nls),
             -- nbs=nbs_,
             nms=substr(nms_,1,70),
             pap=nvl(pap_,pap),
             tip=decode(tip,'CAS',tip,tip_),
             vid=nvl(vid_,vid),
             pos=nvl(pos_,pos),
             isp=isp_,
             lim=nvl(lim_,lim),
             -- rnk=rnk_,
             ostx=decode(ostx_,'NULL',NULL,NULL,ostx,TO_NUMBER(ostx_)),
             seci=nvl(seci_,seci),
             seco=nvl(seco_,seco),
             grp=nvl(grp_,grp),
             blkd=nvl(blkd_,blkd),
             blkk=nvl(blkk_,blkk),
             nlsalt=decode(nlsalt_,'NULL',NULL,NULL,nlsalt,nlsalt_),
             daos=DECODE(dazs,NULL,daos,l_bankdate),
             dazs=NULL,
             tobo=decode(tobo_,null,tobo,tobo_),
             accc=decode(accc_,'NULL',NULL,NULL,accc,accc_)
       WHERE
       acc=acc_
         and
         (   (rnk    is null   and   rnk_old    is null   or   rnk   = rnk_old   ) -- rnk
         and (nls    is null   and   nls_old    is null   or   nls   = nls_old   ) -- nls
         and (kv     is null   and   kv_old     is null   or   kv    = kv_old    ) -- kv
         and (nms    is null   and   nms_old    is null   or   nms   = nms_old   ) -- nms
         and (tip    is null   and   tip_old    is null   or   tip   = tip_old   ) -- tip
         and (isp    is null   and   isp_old    is null   or   isp   = isp_old   ) -- isp
         and (pap    is null   and   pap_old    is null   or   pap   = pap_old   ) -- pap
         and (vid    is null   and   vid_old    is null   or   vid   = vid_old   ) -- vid
         and (pos    is null   and   pos_old    is null   or   pos   = pos_old   ) -- pos
         and (seci   is null   and   seci_old   is null   or   seci  = seci_old  ) -- seci
         and (seco   is null   and   seco_old   is null   or   seco  = seco_old  ) -- seco
         and (blkd   is null   and   blkd_old   is null   or   blkd  = blkd_old  ) -- blkd
         and (blkk   is null   and   blkk_old   is null   or   blkk  = blkk_old  ) -- blkk
         and (lim    is null   and   lim_old    is null   or   lim   = lim_old   ) -- lim
         and (ostx   is null   and   ostx_old   is null   or   ostx  = to_number(ostx_old)  ) -- ostx
         and (nlsalt is null   and   nlsalt_old is null   or   nlsalt= nlsalt_old) -- nlsalt
         and (tobo   is null   and   tobo_old   is null   or   tobo  = tobo_old  ) -- tobo
         and (accc   is null   and   accc_old   is null   or   accc  = accc_old  ) -- tobo
         or
               rnk_old    is null
         and   nls_old    is null
         and    kv_old    is null
         and   nms_old    is null
         and   tip_old    is null
         and   isp_old    is null
         and   pap_old    is null
         and   vid_old    is null
         and   pos_old    is null
         and   seci_old   is null
         and   seco_old   is null
         and   blkd_old   is null
         and   blkk_old   is null
         and   lim_old    is null
         and   ostx_old   is null
         and   nlsalt_old is null
         and   tobo_old   is null
         and   accc_old   is null);

      IF sql%rowcount = 0 THEN

         bars_audit.trace('%s ���� ���������� ������ �������������, acc=%s', l_title, to_char(acc_));

         erm := '9225 - Account modified by another user. ACC='||acc_;
         er  := 7;
         par1 := to_char(acc_);

         RAISE err;

      END IF;

   ELSE

      if nbs_ is not null and l_datbs <= l_bankdate then

         bars_audit.trace('%s ������������ ���������� ���� nbs=%s, d_close=%s',
              l_title, nbs_, to_char(l_datbs, 'dd/MM/yyyy'));

         erm := '9202 - Improper balance acc number #'||nbs_;
         er  := 6;
         par1 := nbs_;

         RAISE err;

      end if;

      BEGIN

         SELECT d_close INTO l_datkv FROM tabval WHERE kv=kv_;

      EXCEPTION WHEN NO_DATA_FOUND THEN

         bars_audit.trace('%s ������������ ��� ������ kv=%s',
              l_title, to_char(kv_));

         erm := '9205 - Improper currency #'||kv_;
         er  := 8;
         par1 := to_char(kv_);

         RAISE err;

      END;

      if l_datkv is not null and l_datkv <= l_bankdate then

         bars_audit.trace('%s ������������ ��� ������ kv=%s, d_close=%s',
              l_title, to_char(kv_), to_char(l_datkv,'dd/MM/yyyy'));

         erm := '9205 - Improper currency #'||kv_;
         er  := 8;
         par1 := to_char(kv_);

         RAISE err;

      end if;

      if mod_ = 6 and p1_ is not null then

         begin

            select decode(isp_, null, isp, isp_),
                   decode(grp_, null, grp, grp_),
                   decode(tobo_, null, tobo, tobo_),
                   sec
              into l_isp, l_grp, l_tobo, l_sec
              from accounts
             where acc = p1_;

         exception when no_data_found then

            l_isp  := isp_;
            l_grp  := grp_;
            l_tobo := tobo_;
            l_sec  := null;

         end;

      else

         l_isp  := isp_;
         l_grp  := grp_;
         l_tobo := tobo_;
         l_sec  := null;

      end if;

      l_blkd := blkd_;
      l_blkk := blkk_;
      -- ���������� ����� �� ����� �� ��������� ��������� �� ���
      declare
         l_tmp varchar2(200);
         l_blk number := null;
         i     number;
      begin
         -- ��������� ������ ���� ���� ������������ � ���
         if nvl(vid_,0) <> 0 then
            -- ��� ����������
            l_tmp := trim(getglobaloption('DPA_BLK'));
            -- ��� ���������� ������
            if l_tmp is not null then
               -- ���� ����� ��� ����������?
               begin
                  select rang into l_blk from rang where to_char(rang) = l_tmp;
                  -- ���� ��� ���������� ��� ������ �����������, ��������� ��� � ��������� ����
                  if l_blk > nvl(l_blkd,0) then
                     -- ���� ������������ � ���?
                     begin
                        select 1 into i from dpa_nbs where type = 'DPA' and nbs = nbs_ and taxotype = 1;
                        l_blkd := l_blk;
                     exception when no_data_found then null;
                     end;
                  end if;
               exception when no_data_found then null;
               end;
            end if;
         end if;
      end;

      acc_ := bars_sqnc.get_nextval('s_accounts');

      bars_audit.trace('%s ��. ����� acc=%s', l_title, to_char(acc_));


      INSERT INTO accounts (acc, nls, kv,
         nbs, daos, isp, nms, pap, tip, vid, pos,
         ostb, ostc, ostf, ostq, dos, kos, dosq, kosq, lim, rnk,
         trcn, sec, seci, seco, grp, blkd, blkk, ostx, nlsalt, tobo, accc)
      VALUES (acc_, l_nls, kv_,
         nbs_, l_bankdate, l_isp, substr(nms_,1,70), ap_, tip_, nvl(vid_,0), nvl(pos_,1),
         0, 0, 0, 0, 0, 0, 0, 0, nvl(lim_,0), rnk_,
         0, l_sec, nvl(seci_,7), nvl(seco_,0), l_grp,
         nvl(l_blkd,0), nvl(l_blkk,0),
         decode(ostx_,'NULL',NULL,NULL,NULL,TO_NUMBER(ostx_)),
         decode(nlsalt_,'NULL',NULL,nlsalt_),
         l_tobo,
         decode(accc_,'NULL',NULL,accc_) );

      bars_audit.trace('%s ��������� ������ � accounts', l_title);

      --============================================================
      -- mod_99 ������������ � SpecParam registration
      -- mod_77 (����� �� ������, ������ �� ���������������) = mod_99
      -- mod_5 = mod_4 + mod_99
      -- (�������������� ����� � ������������ ��������������)
      --============================================================
      IF mod_ = 5 OR mod_ = 77 OR mod_ = 99 THEN
         bars_audit.trace('%s ����������� ��������������.', l_title);
         reg_sp(acc_,nbs_);
         bars_audit.trace('%s ���������������� �������������.', l_title);
      END IF;

      -- ������� ��� �������� ���������� ������ ��� ������������� �������� (�� �� �������� �����)
      IF mod_ <> 77 then
         bars_audit.trace('%s ���������� �� �������.', l_title);
         accreg.setAccountProf(acc_, nbs_);
         bars_audit.trace('%s ��������� ��������� �� �������.', l_title);
      END IF;
   END if;

   IF 1=0 THEN -- ������� �� ����������� - ��� ���������� ����

      NULL;

   ELSIF  mod_ = 1 THEN   -- nd_acc
      --============================================================
      -- mod_ = 1 ������������ � �� �� � ��
      --============================================================

      BEGIN

         SELECT acc INTO acc_ FROM nd_acc WHERE acc=acc_ AND nd=p1_;

         bars_audit.trace('%s mod=1: ���� acc=%s � nd=%s ��� ���� � nd_acc',
              l_title, to_char(acc_), to_char(p1_));

      EXCEPTION WHEN NO_DATA_FOUND THEN

         INSERT INTO nd_acc(acc, nd) VALUES (acc_, p1_);

         bars_audit.trace('%s mod=1: ��������� acc=%s � nd=%s � nd_acc',
              l_title, to_char(acc_), to_char(p1_));

      END;

      IF tip_='SS' THEN   -- Specially for Tanja STA

         UPDATE cc_add SET accs=acc_ WHERE nd=p1_ AND adds=0;

         bars_audit.trace('%s mod=1: ���������� cc_add: accs=%s ��� nd=%s � adds=0',
              l_title, to_char(acc_), to_char(p1_));

      END IF;

   ELSIF mod_ = 2 THEN    -- pawn_acc (p1-nd, p2-pawn, p3-pawn_p, p4=ndz_)
      --============================================================
      -- mod_ = 2 ������������ �����, ��� ���.����������� ����� �����������
      --============================================================

      bars_audit.trace('%s mod=2: p4_=%s', l_title, to_char(p4_));

      IF p4_ IS NULL THEN SELECT bars_sqnc.get_nextval('S_CC_DEAL') INTO p4_ FROM dual; END IF;

      p0_ :=p4_;

      bars_audit.trace('%s mod=2: p0_=%s', l_title, to_char(p0_));

      BEGIN

         update PAWN_ACC set PAWN=p2_, MPAWN=p3_,IDZ=USER_ID, NDZ=p0_ where acc=ACC_;

         if SQL%rowcount = 0 then

            INSERT INTO PAWN_ACC(ACC, PAWN, MPAWN, IDZ, NDZ)
            VALUES (ACC_, p2_, p3_, USER_ID, p0_);

            bars_audit.trace('%s mod=2: ���������� � pawn_acc acc=%s, pawn=%s, mpawn=%s, idz=%s, ndz=%s',
                 l_title, to_char(acc_), to_char(p2_), to_char(p3_), to_char(user_id), to_char(p0_));

         else

            bars_audit.trace('%s mod=2: ���������� pawn_acc ��� acc=%s: pawn=%s, mpawn=%s, idz=%s, ndz=%s',
                 l_title, to_char(acc_), to_char(p2_), to_char(p3_), to_char(user_id), to_char(p0_));

         end if;

      END;

   ELSIF mod_ = 3 THEN    -- acc_over (acc_ overdraft acc, p1_ main acc)
      --============================================================
      -- mod_ = 3 ������������ ��� ����������
      --============================================================

      BEGIN

         SELECT acco INTO p0_ FROM acc_over WHERE acc=p1_;

         bars_audit.trace('%s mod=3: acc_over.acco=%s ��� acc=%s',
              l_title, to_char(p0_), to_char(p1_));

         IF acc_ <> p0_ THEN

            bars_audit.trace('%s mod=3: ���� ���������� ��� ������', l_title);

            erm := '9203 - Overdraft acc exists for acc #'||p1_;
            er  := 12;
            par1 := to_char(p1_);

            RAISE err;

         END IF;

      EXCEPTION WHEN NO_DATA_FOUND THEN

         INSERT INTO acc_over (acc, acco) VALUES (p1_, acc_);

         bars_audit.trace('%s mod=3: �������� ���� ���������� acc=%s, acc0=%s',
                    l_title, to_char(p1_), to_char(acc_));

      END;

   ELSIF mod_ = 4 OR mod_ = 5 THEN    -- bank_acc (acc_ bank acc, p1_ bank mfo)
      --============================================================
      -- mod_ = 4 ������������ ��� ����.������
      --============================================================

      BEGIN

         SELECT mfo INTO p0_ FROM bank_acc WHERE acc=acc_;

         bars_audit.trace('%s mod=4: mfo=%s ��� acc=%s',
              l_title, to_char(p0_), to_char(acc_));

         IF p1_ IS NULL OR p1_ = 0 THEN
            DELETE FROM bank_acc WHERE acc=acc_ AND mfo=p0_;
            bars_audit.trace('%s mod=4: �������� �� bank_acc mfo=%s, acc=%s',
                 l_title, to_char(p0_), to_char(acc_));
         ELSIF p0_ <> p1_ THEN
            UPDATE bank_acc SET mfo=p1_ WHERE acc=acc_;
            bars_audit.trace('%s mod=4: ���������� bank_acc mfo=%s ��� acc=%s',
                 l_title, to_char(p1_), to_char(acc_));
         END IF;

      EXCEPTION

         WHEN NO_DATA_FOUND THEN

            IF p1_ > 0 THEN
               INSERT INTO bank_acc(mfo, acc
                                   ,kf

               )
               VALUES (p1_, acc_
                                   ,gl.aMFO
               );

            bars_audit.trace('%s mod=4: ���������� � bank_acc mfo=%s, acc=%s',
                 l_title, to_char(p1_), to_char(acc_));

            END IF;

         WHEN TOO_MANY_ROWS THEN

            IF tip_ <> 'T00' AND tip_ <> 'T0D' THEN

               bars_audit.trace('%s mod=4: ���� acc=%s �������� � ���������� ���',
                    l_title, to_char(acc_));

               erm := '9204 - Account was registered to many mfo-#'||l_nls;
               er  := 15;
               par1 := l_nls;

               RAISE err;

            END If;

      END;

   ELSIF mod_ <> 77 and mod_ <> 99 and mod_ <> 9 and mod_ <> 6 THEN

      bars_audit.trace('%s ����������� ����� �������� ����� mod=%s',
           l_title, to_char(mod_));

      erm := '9239 - No mode '||mod_||' implemented';
      er  := 16;
      par1 := to_char(mod_);

      RAISE err;

   END IF;  -- mod_

   IF mod_ <> 2 AND mod_ <> 77 AND grp_ IS NOT NULL THEN
      sec.addAgrp(acc_, grp_);
      bars_audit.trace('%s ���������� ����� acc=%s � ������ ������ grp=%s',
           l_title, to_char(acc_), to_char(grp_));
   END IF;

   accR_ := acc_;

   execute immediate 'begin p_after_open_acc(:accR_); end;' using accR_;

<<nowarn>> null;

EXCEPTION
   WHEN err THEN
      bars_error.raise_error('CAC', er, par1);
END op_reg_lock;
/
show err;

PROMPT *** Create  grants  OP_REG_LOCK ***
grant EXECUTE                                                                on OP_REG_LOCK     to ABS_ADMIN;
grant EXECUTE                                                                on OP_REG_LOCK     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_REG_LOCK     to CUST001;
grant EXECUTE                                                                on OP_REG_LOCK     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_REG_LOCK.sql =========*** End *
PROMPT ===================================================================================== 
