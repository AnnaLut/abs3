

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_RMANY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_RMANY ***

  CREATE OR REPLACE PROCEDURE BARS.CC_RMANY 
 (ND_   int, -- ����� �� ���� �� =0, ��� �� ������ =ND_
  DAT_ date, -- ���.����
  MODE_ int  -- 1 - ������� c ����������,
             -- 0 - ������� ��� ��������,
             -- 2 - ������ �����,
             -- 3 - �������� �������� �� �����
  ) is



/*
 ������ ���������� ��� AWK.exe ���  AW.bat
 -- OLD  ��� ������ ��������� (���������� ����� �������� ����) ������ �����������
 �����:   AWK CCK.crd CCK.<xxx> <���������>
 AWK CC_Rmany.prc CC_Rmany.sql           * ������
 AWK CC_Rmany.prc CC_Rmany.dem OLD       * ��� �������

*/

--    ������

/*
 10.11.2013 DAV ���������� ������ �� �������� ������ 3600, �������  ��������� � ���������� ���������,
            ���� �������� �������� ���� 3600.

 07.05.2013 ������ ������ ��� �� �� 24.04.2013 � 31/5-03/589

 28-11-2012 Nov ����� ��������� �������� ����������� �������� �� ������� �� ��<>0 �� �� � ���������,
                � ��� �� ��� �������������� (������ �����������) ������ �������� �� �������������.
                ����������� ����������� �� �� ������� �����. ������� �������.
 04-09-2012 Sta �� IRR �� ������ �� TTS
 02-11-2011 Nov ������ ���������� �� ������������ ���� ������� .��� ����������
            ��� � ���� �������� ����������� ��� �� ����.
 02-06-2010 ���� ���� �������, �� �� ��������� ������,�� ������������
            ������ ������������ �� ���� ��������� �������.
 12-02-2010 Nov  ������� ������� ��� ��������� �� ����������� ������������� ������������
 11-12-2009 � �������� ��������� ������ ���� ��� ���������� 8999  ��������� �� ������� ����� 8999
 29-05-09 ��� ��������� ������ 01/06/2009 ����������� ��������� ��-������� (������)
 27-05-09 ���� ��.������ ��� ����������� �������� ������� 0 - ������ �� ������
          (0 ����������, ���� ��.������ ���������� � ��������� ����� �������� ��������, ����� ������������� ��������� ������� �� �����������)
 06-05-09 ��������� �����������
 05-05-09 �������� ���������� ������� ��� �����-��� �������� - �������� ����� ��������
          ���������������
 28-01-09 ��������� ��������� "��������" ��� ����������� �������
 22-01-09 �������� ����������� �� ����� ����  MODE_ =3
          gl.BDATE �������� �� DAT_ �� ����������
 05-01-09 ������ ������ "�������� ������ �������� ������� �� ��"
          -- ��� ������ �� DELL_IGR 2352, ��� 727 � ��� ��.���
 30-12-08 ����������� ���� �������. ���� SDI-�������� � SPI-������
 23-12-08 ��������� ������ (����/����) � ����������� ���.�������
          � ����� �������� �� ����������� ���������� ��������
*/

  RET_  int;

  sDate_  date := to_date('01-01-2006','dd-mm-yyyy'); -- ������.����, � ������� ��������
  DAT_NEW date := to_date('01-06-2009','dd-mm-yyyy'); -- ���� ������ ����������� ��-������
  DAPP_   date;

  FAKT_T number; --���������� �������� ������� ����
  FAKT_P number; --���������� �������� ������� ���������
  PLAN_T number; --�� �����   �������� ������� ����
  PLAN_P number; --�� �����   �������� ������� ���������

  TELO_  number; PROC_ number ;  FDAT_ date;

  -- ���������� ��� ��������
  ACC_  accounts.acc%type ;
  OST_  accounts.ostB%type;
  NLSB_ oper.NLSB%type    ;
  NMSB_ oper.NAM_B%type   ;
  VOB_  oper.VOB%type     ;
  REF_  oper.REF%type     ;
  TT_   oper.TT%type      :='IRR';
  NAZN_ oper.NAZN%type    ;
  DK_   oper.DK%type      ;
  --------------------------
  NLS_DP accounts.NLS%type ;
  NMS_DP accounts.NMS%type ;
  KV_    accounts.KV%type  ;
  OST_DP accounts.OSTC%type;
  ACC_DP accounts.ACC%type ;
  TIP_DP accounts.TIP%type ;
  Y1_    number :=0        ;
  S_     number ; Q_ number;
  --------------------------
  PRD_Al char(1)           :=GetGlobalOption('ASG-SN'); -- ���� ����.����� �� �����
  PRD_KD char(1)           ; -- 0= ���� ����,
                             -- 1= ���� �����
  --------------------------
  KAN_Al char(1)           :=GetGlobalOption('CC_GPK'); -- �������� �� �����
  KAN_KD char(1)           ; -- 0=���� (������, ����� � ��������),
                             -- 1=���  (���� ����, ����� ������)
   L_VIDD number           ; -- ��� ��������
  --------------------------
  D3000 Date               ; -- ��� ���������� �� ���� ��� ��������
  --------------------------
  IRR_ number; IRN_ number;  SR_ number; SE_ number ; Name1_ varchar2(35);
  --------------------------
  l_title varchar2(20) := 'CCK CC_RMANY: ';
  FLAG_ int;

  Flag36_ int := 0 ; -- / =1 � ���� ������

begin
  return;  --COBUPRVNIX-161 ���������� ������� ��������������� ����������� ��������/���쳿
  bars_audit.info('=======> 1');
   bars_audit.trace('%s 0.�����: ND_=>%s, DAT_=>%s,  MODE_=>%s', l_title, to_char(ND_), to_char(DAT_), to_char(MODE_));

   If ( getglobaloption('MFOP')='300465' or gl.aMfo='300465')
    -- �������� �� ��������� ������������ ���� ������
      and
      to_char (gl.bdate,'yyyy.mm') <> to_char (Dat_Next_U (gl.bdate, 1),'yyyy.mm') then
      Flag36_ := 1;
   end if;

   If     ND_ = -1   then   L_VIDD :=  1  ;
   elsIf  ND_ = -11  then   L_VIDD := 11  ;
   else                     L_VIDD := null;
   end if;
 bars_audit.info('=======> 2');
   -- ���� ������ ��� ��.�����
   If flag36_ = 1 then
      declare
         l_bvq    number;
         r_sdi    accounts%rowtype;
         r_is36   int_accn%rowtype;
         r_s36    accounts%rowtype;
      begin
        bars_audit.info('=======> 3');
         for mm in ( select D.nd
                       from cc_deal D
                      where ( (  L_VIDD= 1 and D.VIDD in ( 2, 3)
                              or L_VIDD=11 and D.VIDD in (12,13))
                           OR d.nd = decode (nd_, 0, d.nd, nd_) )
                        and d.vidd in (2,3,12,13)
                        and D.sos  >= 10   and D.sos  <  14
                    )
         LOOP
            bars_audit.info('=======> 3_1 mm.nd = '||mm.nd);
         -- �������� ���� ���� SDI � �������� (���� ��� ��� ����� - ������ �� ����� �� ������ �� �����)
           begin

              select a.* into r_sdi from accounts a, nd_acc n
               where n.nd = mm.nd and n.acc = a.acc and tip = 'SDI' and (nbs like '20_6' or nbs like '22_6') and ostc >0;
           exception when no_data_found then bars_audit.info('=======> 3_1 nodf mm.nd = '||mm.nd); goto nextrec;
                     when too_many_rows then bars_audit.info('=======> 3_1 tmr mm.nd = '||mm.nd); goto nextrec;
           end;

         -- ���.��������� � ������ ���������� SDI
         select nvl(sum(a.ostc),0) into l_bvq  from accounts a, nd_acc n
         where n.nd = mm.ND and n.acc= a.acc and a.tip in ('SS ', 'SN ', 'SNO', 'SP ', 'SPN', 'SDI') and a.kv = r_sdi.kv;
         -- SS + SN + SNO + SP + SPN < SDI
         If l_bvq >= 0 then
         bars_audit.info('=======> 3_1 l_bvq >= 0 mm.nd = '||mm.nd);
               -- ������������� ������� ���� 3600 � ����� S36 � ������ 2066
               --r_s36.nls := vkrzn( substr(gl.amfo,1,5) , '36000'|| substr( r_sdi.nls,6,9) );
                select f_newnls2(r_sdi.ACC,'S36',null,null,r_sdi.kv)  INTO r_s36.nls from dual;
                    bars_audit.info('=======> 3_1 r_s36.nls = '||r_s36.nls);
               cck.CC_OP_NLS( mm.nd, r_sdi.kv, r_s36.nls, 'S36', r_sdi.isp, r_sdi.GRP, null, r_sdi.mdate, r_s36.acc);

               if  r_s36.acc is null then   bars_audit.info('=======> 3_1 r_s36.acc is null '||r_s36.nls); goto nextrec; end if;
               select * into r_s36 from accounts where acc = r_s36.acc;
               bars_audit.info('=======> 3_1 r_s36.acc = '||r_s36.acc);
               --������ % �������� �� 2066-SDI
               begin
               select i.* into r_is36 from int_accn i where i.acc = r_sdi.acc and i.acrb is not null and rownum=1;
               exception when no_data_found then  goto nextrec;
               end;
                 bars_audit.info('=======> 3_1 r_sdi.acc = '||r_sdi.acc);
               -- �������� % �������� 3600 ��� ���.�����������
               update int_accn set id    = nvl(r_is36.id,1),
                                   metr  = nvl(r_is36.metr,4),
                                   basem = nvl(r_is36.basem,0),
                                   basey = nvl(r_is36.basey,0),
                                   freq  = nvl(r_is36.freq,1),
                                   acr_dat = nvl(r_is36.acr_dat,(gl.bdate-1)) ,
                                   tt    = '%%1',
                                   acra  = r_s36.acc,
                                   acrb  = r_is36.acrb,
                                   s     = nvl(r_is36.s,0),
                                   io    = nvl(r_is36.io,0)
               where acc = r_s36.acc;
                  bars_audit.info('=======> 3_1 r_s36.acc = '||r_s36.acc);
               if SQL%rowcount = 0 then
                  bars_audit.info('=======> 3_1 insert mm.nd = '||mm.nd);
                     insert into int_accn (ACC,   ID,METR,BASEM,BASEY,FREq,ACR_DAT,      tt  ,ACRA  , ACRB   , S, IO )
                                 values   (r_s36.acc, nvl(r_is36.id,1),   nvl(r_is36.metr,4),   nvl(r_is36.basem,0),    nvl(r_is36.basey,0), nvl(r_is36.freq,1), nvl(r_is36.acr_dat,(gl.bdate-1)),
                                           '%%1', r_s36.acc, r_is36.acrb, nvl(r_is36.s,0), nvl(r_is36.io,0) );
               end if;

           -- ����� �������� �� ����� SDI ��������� �� S36
               GL.REF (REF_);
                 bars_audit.info('=======> 3_1 insert ref = '||REF_);
               GL.IN_DOC3(ref_  =>REF_,    tt_ =>'013', vob_ =>6,   nd_ =>substr(to_char(REF_),-10),
                          pdat_ =>SYSDATE, vdat_=>gl.bdate,dk_=>1,   kv_ =>r_sdi.kv,  s_=>r_sdi.ostc,
                          kv2_  =>r_sdi.kv,    s2_ =>r_sdi.ostc,sk_ =>null,  data_=>gl.bdate, datp_=>gl.bdate,
                          nam_a_=>substr(r_sdi.nms ,1,38), nlsa_=>r_sdi.nls, mfoa_=>gl.amfo ,
                          nam_b_=>substr(r_s36.nms,1,38), nlsb_=>r_s36.nls,mfob_=>gl.amfo ,
                          nazn_ =>'����������� ���� �������� � ��`���� �i ���������� ������� �������i',
                          d_rec_=>null,  id_a_ =>gl.aokpo, id_b_=>gl.aokpo,id_o_=>null, sign_ =>null,
                          sos_  =>0,     prty_ =>0,        uid_ => NULL);

                  bars_audit.info('=======> 3_1 ok '||REF_);
               GL.PAYV(0,REF_,GL.BDATE,TT_, 1, r_sdi.kv,r_sdi.NLS,r_sdi.ostc,r_sdi.kv,r_s36.NLS,r_sdi.ostc);

                bars_audit.info('=======> 3_1 okPAYV '||REF_);
               GL.PAY (2,REF_,GL.BDATE);
                bars_audit.info('=======> 3_1 okPAY2 '||REF_);
         end if;
         <<nextrec>> null;
         end loop;
      end;
   end if;


If MODE_ = 2 then
   -- ������ ������ "�������� ������ �������� ������� �� ��"
   -- ��� ������ �� DELL_IGR 2352, ��� 727 � ��� ��.���
   delete from CCK_AN_TMP;
   for k in (select d.ND,d.CC_ID,d.RNK,d.IR,substr(c.nmk,1,30) NMK,d.sdate, d.wdate dat3
               from cc_deal d, customer c
              where d.rnk=c.rnk and ( ND_=0 and d.SDATE =DAT_ OR ND_=d.nd)
            )
   LOOP
      begin
         select a.acc,acrn.FPROCN(a.acc,-2,DAT_), acrn.FPROCN(a.acc,0,DAT_)
         into ACC_, IRR_, IRN_
         from  accounts a, nd_acc n
         where n.acc=a.acc and a.tip='LIM' and n.nd=k.ND;
         If IRR_ is null then GOTO nextrecP;  end if;
         select basey into Y1_ from int_accn where acc=ACC_ and id=0;
         select substr(name,1,35) into Name1_ from basey where basey=Y1_;
      EXCEPTION WHEN NO_DATA_FOUND THEN  GOTO nextrecP;
      end;
      Q_:= null;
      for m in (select FDAT, SS1, SDP, SS2, SN2
                from cc_many where nd=k.ND order by fdat )
      loop
         select  SUM( (SS2+SN2)/power( 1+IRR_/100,(FDAT-m.FDAT)/365 )),
                 SUM( (SS2+SN2)/power( 1+k.IR/100,(FDAT-m.FDAT)/365 ))
         into SR_,SE_
         from cc_many where nd=k.ND and fdat>=m.FDAT ;
         SR_:=Round(SR_,2);
         SE_:=Round(SE_,2);
         S_ := SE_ - SR_ ;
         insert into CCK_AN_TMP (ND,cc_id,UV,PR,PRS,SROK,
                n1,n2,n3,n4,n5,ZAL,name,nls,REZ,REZQ,name1)
         values (k.ND,k.CC_ID,IRN_,k.IR,IRR_,to_number(to_char(m.FDAT,'yyyymmdd')),
                m.SS1,m.SDP,m.SS2,m.SN2,S_,Q_-S_,
                k.nmk, to_char(k.SDATE,'dd/mm/yyyy'), SE_, SR_, Name1_ );
         Q_:= S_;
      end loop;
      -- ������� �� ������ ������ �������
      <<nextrecP>> null;
   END LOOP;
   RETURN;
end IF; -- ����� ������ MODE_ = 2
-------------------
bars_audit.info('=======> 4');
begin
 select to_number(substr(flags,38,1) ) into FLAG_ from tts where tt = TT_;
EXCEPTION WHEN NO_DATA_FOUND THEN  FLAG_:=0;
end;

for k in (select D.nd, d.sdate, D.ir, D.cc_id, cd.wdate dat3,d.wdate dat2
            from cc_deal D, cc_add cd
           where ( L_VIDD= 1 and D.VIDD in ( 1, 2)
                        or L_VIDD=11 and D.VIDD in (11,12) OR d.nd=decode (nd_, 0, d.nd, nd_))
                 and d.vidd in (1,2,11,12)
                 and D.sos  >= 10   and D.sos  <  15
                 and cd.nd=d.nd and cd.adds=0
                 and D.sdate>= sDate_
                 and exists (select 1 from cc_many where nd=D.nd )
           )
LOOP
   If MODE_= 3 then bars_audit.info('=======> 5'); GOTO Provodki; end if;
   ---------------------------------------
bars_audit.info('=======> 6');
   -- ����
   select Nvl(sum(DECODE(a.tip,'LIM', greatest(s.kos-s.dos,0), 0          )),0),
          Nvl(sum(DECODE(a.tip,'LIM', 0, s.kos-decode(a.tip,'SPN',s.dos,0))),0)
   into FAKT_T, FAKT_P
   from  accounts a, nd_acc n, saldoa s
   where n.nd=k.ND and n.acc=a.acc and a.acc=s.acc and s.fdat=DAT_  and a.tip in ('LIM','SN ','SPN');
   bars_audit.trace('%s 1.����: FAKT_T=>%s, FAKT_P=>%s, ND=>%s', l_title, to_char(FAKT_T), to_char(FAKT_P), to_char(k.nd));

   -- ����
   begin
     select ss2*100, sn2*100 into PLAN_T, PLAN_P from cc_many   where nd=k.ND and fdat=DAT_;
   EXCEPTION WHEN NO_DATA_FOUND THEN PLAN_T:=0; PLAN_P :=0;
   end;
   bars_audit.trace('%s 2.����: PLAN_T=>%s, PLAN_P=>%s', l_title, to_char(PLAN_T), to_char(PLAN_P));

   ----- ���������� �� ���� � �� ���������
   TELO_:=FAKT_T - PLAN_T;
   PROC_:=FAKT_P - PLAN_P;
   if FAKT_T=0 and FAKT_P=0 and PLAN_T=0 and PLAN_P =0 then
      -- ������� ������� ���
      GOTO nextrec;
   Elsif FAKT_T=PLAN_T and FAKT_P=PLAN_P then
      -- �������� ������� ��������� � �����������
      GOTO Provodki;
   end if;

   bars_audit.trace('%s 3.����������: TELO_=>%s, PROC_=>%s',  l_title, to_char(TELO_), to_char(PROC_));

   ----- ���������� �� ����
   KAN_KD :=null;
   IF TELO_>0 then

      -- ��������
      update cc_many set ss2=ss2+(TELO_/100) where nd=k.ND and fdat=DAT_;
      if SQL%rowcount = 0 then
         INSERT INTO cc_many (ND,FDAT,SS1,SDP,SS2,SN2) VALUES (k.ND,DAT_,0,0,TELO_/100,0);
      end if;

      begin
        --���� �� �������� ?
        SELECT Substr(txt,1,1) into KAN_KD  FROM ND_TXT WHERE nd=k.ND and tag='FLAGS';
      EXCEPTION WHEN NO_DATA_FOUND THEN KAN_KD:= KAN_Al;
      end;

      bars_audit.trace('%s 4.��������: KAN_KD=>%s', l_title, KAN_KD);

      If KAN_KD ='1' then         -- HET, ����� ����� ��������� ����
         D3000 := to_date('01-01-3000','dd-mm-yyyy') ;
      Else                        -- ����, ����� ������ ��������� ����
         D3000 := to_date('01-01-1000','dd-mm-yyyy') ;
      end if;

      for m in (select fdat, ss2*100 SS2 from cc_many where nd=k.ND and ss2>0 and fdat>DAT_
                 order by ABS( D3000 - fdat )
                )
      loop
         If TELO_>0 then
            S_:=least(TELO_,m.SS2);
            update cc_many set ss2=ss2 - (S_/100) where nd=k.ND and fdat=m.FDAT;
            TELO_:= TELO_ -S_;
         end if;
      end loop;
   ElsIf TELO_<0 then TELO_:=-TELO_;
      --���������
      update cc_many set ss2=ss2- (TELO_/100) where nd=k.ND and fdat=DAT_;
      --1) ����� ������ ������� �����
      select min(fdat) into FDAT_ from cc_many  where nd=k.ND and ss2=0 and fdat>DAT_;
      If FDAT_ Is null then
         --2) ��������� ���������
         select max(fdat) into FDAT_ from cc_many where nd=k.ND and ss2<>0  and fdat>DAT_;
      end if;

      If FDAT_ Is NOT null then
         update cc_many set ss2=SS2 +(TELO_/100) where nd=k.ND and fdat=FDAT_;
      end if;
   end if;

   ----- ���������� �� ���������
   IF PROC_>0 then
      --�������� - ����� ����� ��������� ����
      update cc_many set sn2=sn2+(PROC_/100) where nd=k.ND and fdat=DAT_;
      if SQL%rowcount = 0 then
         INSERT INTO cc_many (ND,FDAT,SS1,SDP,SS2,SN2) VALUES (k.ND,DAT_,0,0,0,PROC_/100);
      end if;

      for m in (select fdat, sn2*100 SN2 from cc_many where nd=k.ND and sn2>0 and fdat>=DAT_ order by fdat desc)
      loop
         If PROC_>0 then
            S_:=least(PROC_,m.SN2);
            update cc_many set sn2=sn2-S_/100 where nd=k.ND and fdat=m.FDAT;
            PROC_:= PROC_ -S_;
         end if;
      end loop;

   ElsIf PROC_<0 then PROC_:=-PROC_;
      --���������
      update cc_many set sn2=sn2- (PROC_/100) where nd=k.ND and fdat=DAT_;
      --1) ����� ������ ������� �����
      select min(fdat) into FDAT_    from cc_many  where nd=k.ND and sn2=0 and fdat>DAT_;
      If FDAT_ Is null then
         --2) ��������� ���������
         select max(fdat) into FDAT_ from cc_many where nd=k.ND and sn2<>0  and fdat>DAT_;
      end if;

      If FDAT_ Is NOT null then
         update cc_many set sn2=SN2 +(PROC_/100) where nd=k.ND and fdat=FDAT_;
      end if;
   end if;

   ------------------
   <<Provodki>> null;
   ------------------
bars_audit.info('=======> Provodki 1');
   begin
     -- ������� ���� �������
     select  a.acc,  a.ostb, a.KV, a.dapp into ACC_, OST_, KV_,dapp_
     from accounts a, nd_acc n
     where a.acc=n.acc and n.nd=k.ND and a.tip='LIM' and a.dazs is null;  --and a.nls like '8999_'||k.ND and a.dazs is null;
   EXCEPTION WHEN NO_DATA_FOUND THEN bars_audit.info('=======> Provodki excep'); GOTO nextrec;
   end;

--  � ����� ������ ����� �������� ���� ����������� ������ ������� ������� OST_=0
   if dapp_ is null and k.dat2>gl.bdate and OST_=0 then
     bars_audit.info('=======> Provodki dapp_ is null'); GOTO nextrec;
   end if;
   bars_audit.trace('%s 5.��������: ND=>%s, ACC=>%s, OST=>%s, kv=>%s,', l_title, to_char(k.nd), to_char(ACC_), to_char(OST_), to_char(KV_));

   If OST_ =0 then
      --�������� ������� � �������
       bars_audit.info('=======> Provodki  OST_ =0');
      update cc_many set ss2=0, sn2=0 where nd=k.ND and fdat> DAT_;
   else
      --����������� %% !!!   �� ������ !!!!
      null;
      bars_audit.info('=======> Provodki  OST_ !=0');
   end if;

   If mode_=0 then   bars_audit.info('=======> Provodki  mode_=0'); GOTO nextrec; end if;

   ------------�������� �� �����������.

   begin
   bars_audit.info('=======> Provodki -�������� �� �����������');
      select min(a.ACC) into ACC_DP   from accounts a, nd_acc n
      where n.nd=k.ND and n.acc=a.acc and a.tip in ('SDI','SPI')  and a.kv=KV_ and a.ostc<>0;
      If ACC_DP is null then
       bars_audit.info('=======> Provodki -ACC_DP is null');
         GOTO nextrec;
      end if;
      --------------------------------------------
      --
      select nls, substr(nms,1,38), ostc, tip into NLS_DP, NMS_DP, OST_DP, TIP_DP  from accounts where acc=ACC_DP ;
      bars_audit.trace('%s 7: ACC_DP=>%s, NLS_DP=>%s, OST_DP=>%s, TIP_DP=>%s', l_title, to_char(ACC_DP), NLS_DP, to_char(OST_DP), TIP_DP);

      select acrn.FPROCN(a.acc,i.id,DAT_), b.nls, substr(b.nms,1,38),   nvl(i.acr_dat,a.daos-1)+1
      into Y1_ , NLSB_, NMSB_, FDAT_
      from accounts a, accounts b, int_accn i
      where a.acc=ACC_   and b.kv =gl.baseval and b.acc = i.acrb
            and b.nbs is not null  and i.acc=a.acc  and i.id=-2
            and greatest(nvl(i.acr_dat,a.daos),k.dat3)<DAT_;
          --                         and nvl(i.acr_dat,a.daos-1)+1<DAT_;
          -- nov  � ��� � �� ����� ����� ����� ����������� � �������
   EXCEPTION WHEN NO_DATA_FOUND THEN
      begin
        select acrn.FPROCN(a.acc,i.id,DAT_), b.nls, substr(b.nms,1,38), nvl(i.acr_dat,a.daos-1)+1
        into Y1_ , NLSB_, NMSB_, FDAT_
        from accounts a, accounts b, int_accn i
        where a.acc=ACC_   and b.kv =gl.baseval and b.acc=cc_o_nls(substr(NLS_DP,1,4),a.RNK,4,k.ND,a.kv,'SD ')
          and b.nbs is not null  and i.acc=a.acc  and i.id=-2  and greatest(nvl(i.acr_dat,a.daos),k.dat3)<DAT_;
      EXCEPTION WHEN NO_DATA_FOUND THEN      GOTO nextrec;
      end;
   end;

   bars_audit.trace('%s 8: Y1_=>%s, NLSB_=>%s, FDAT_=>%s', l_title, to_char(Y1_), to_char(NLSB_), to_char(FDAT_));

   If k.IR is null or Y1_=0 then
      GOTO nextrec;
   end if;

   ------------------------------------------
   If OST_ =0 then
      Nazn_:= '��������� ���������i�';
      S_   := OST_DP;
      bars_audit.trace('%s 9: S_=>%s',   l_title, to_char(S_));
   else
      Nazn_:= '���������i�';
      select Abs( SUM( (SS2+SN2)*( 1/power( 1+Y1_/100 , (FDAT-DAT_)/365 )
                                 - 1/power( 1+k.IR/100, (FDAT-DAT_)/365 )
                                 )*100  ) )
      into S_ from cc_many where nd=k.ND and fdat>=DAT_;

      bars_audit.trace('%s 10: S_=>%s',  l_title, to_char(S_));
      S_ := Round( Abs(OST_DP) - S_,0);
      bars_audit.trace('%s 11: S_=>%s',  l_title, to_char(S_));

   end if;

   If TIP_DP='SDI' then NAZN_:= Nazn_||' ��������'; DK_:=1;
   else                 NAZN_:= Nazn_||' ����i�'  ; DK_:=0;
   end if;

   If S_>0 then
      NAZN_:=Nazn_||
           ' �� ����.���.� '||k.CC_ID||' (���='||k.nd||')'||
           ' �� ��.��.='||to_char(round(Y1_,4)) || ' �� ���i�� � ' ||
           to_char(FDAT_,'dd.mm.yyyy') || ' �� ' ||
           to_char( DAT_,'dd.mm.yyyy');

      bars_audit.trace('%s 12: NAZN_=>%s',  l_title, NAZN_);

      If kv_=gl.baseval then VOB_:=6 ; Q_:= S_;
      else                   VOB_:=16; Q_:= gl.p_icurval(kv_,S_,DAT_);
      end if;

      bars_audit.trace('%s 13: TT_=>%s',    l_title, TT_);

      GL.REF (REF_);
      GL.IN_DOC3
        ( REF_,   TT_, VOB_,  REF_, SYSDATE ,  GL.BDATE,     DK_,
          KV_,    S_, gl.baseval , Q_, null,   GL.BDATE, GL.BDATE,
          NMS_DP,NLS_DP, gl.AMFO, NMSB_ , NLSB_,  gl.AMFO,  NAZN_,
          NULL, gl.aokpo, gl.aokpo,  null,   null, 0, null, gl.aUid);
      bars_audit.trace('%s 15: GL.IN_DOC3 => OK!',   l_title, null);
      GL.PAYV(0,REF_,GL.BDATE,TT_, DK_, KV_,NLS_DP,S_,gl.baseval,NLSB_,Q_);
      bars_audit.trace('%s 16: GL.PAYV => OK!',   l_title, null);

      If FLAG_ = 1 then
         GL.PAY (2,REF_,GL.BDATE);
      end if;

      bars_audit.trace('%s 17.���������: GL.PAY => OK!',  l_title, null);

   end if;
   update int_accn SET ACR_DAT = DAT_ where acc = ACC_ and id=-2;


   -- ������� �� ������ ������ �������
   <<nextrec>> null;

END LOOP;

end CC_Rmany;
/
show err;

PROMPT *** Create  grants  CC_RMANY ***
grant EXECUTE                                                                on CC_RMANY        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_RMANY        to RCC_DEAL;
grant EXECUTE                                                                on CC_RMANY        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_RMANY.sql =========*** End *** 
PROMPT ===================================================================================== 
