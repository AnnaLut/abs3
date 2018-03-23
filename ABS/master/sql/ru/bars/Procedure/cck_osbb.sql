CREATE OR REPLACE PROCEDURE BARS.cck_OSBB (p_mode int, p_nd1 number) is

-- p_mode = 0 �������� ������� ��� ������������� ���
-- p_mode = 1 ����������� ���������� �� ����
-- p_mode = 2 Գ��       ���������� �� ���� + ����-����� ���������� �� ����
-- p_mode = 3 ����������� ���������� �� ���� - �� ����������� ��
/*
08/02/2018 LitvinSO COBUSUPABS-7041 ��� �������� ������ �������� ��������� ����������� ����������� �������� CIG_D13 � ��������� 1
10/11/2017 LitvinSO ��� p_mode = 2 � ������ �� ������� ����� ���� ������ ��� ��� �� �� ������ cc_deal.PROD ����������� ������� 
26/05/2017 Pivanova ������ ����� ���� �� ������ ��� ���������� ���� S_SDI
18.11.2015 LitvinSO ���������� � ������� ��� ���������� �볺��� �� ���������� �� ��� � ����� K050 = 320 � K051 = 62.
17.11.2015 LitvinSO �� ����������� ����� �. �������� �� ��������� ���� �� ������������ ���� � cc_deal � ����� ������������� �������.
16.11.2015 Sta ³� ����� �:
   ��� ��� ����� ������ ������� ������������� ����� �� �� ������� �� 20/11/2015
   (ElsIf -aa1.ostc >= dd1.sdog*100 then  s_Txt2 := '. ����� ������� �������';)

12.11.2015 Sta ���������� � ������ ������ ���� p_mode = 2 Գ��
03.11.2015 Sta
 - �������������� �������� 2600 � ��
 - ���������� ���� = 6 ��� ��2
 - ���������� ���� = 6 ��� MODE= 3

28.10.2015 Sts �������-�� ���� ��22
22.10.2015 Sta p_mode = 0 �������� ������� ��� ������������� ��
22.10.2015 Sta � �����-2 ����������� ������� �� �����-1
21.10.2015 Sta ���������� ��������� ������� ��� -- p_mode = 3 ����������� ���������� �� ���� - �� ����������� ��
17.09.2015 LitvinSO ϳ������� ���������� > 6 ��. : ���� dd1.sdate ���� ������, ������ ����� ���� �����.
17.09.2015 Sta �� ����������� ������������ ���� ��������� ���������.
1+ ��� ������������ ������� �������� � ������ ������� ����� ������������ ������, ��� ����� ������ ���� ������� � ����������.
2+ ������� �������� ����������� �������� � �����-������ �� ������ 6 ������� � ���� ��������.
4+ �� �������� ����������  �������� 2 ��� ����� ������ ������� (. ����� ������� �������).
5+ ���������� �� �������� ���.
3. ���������� �������� ������ ��������. ��������� �� ���� �������� ���� . ������ ��� ����� ��������.
   �������� ��� ������ �������, ���� �������� ���� (��������) �� ������� �������� (2066,3600) ��� ��������� ��� ���� �����������
   �� ��������  ������ (��1, ��2,�) ���� ��������� �� ���������� ���� �������� ��� ���� (2062/��22, 2063/��22)
   ��� ����������� ������� �������� � ������� ���� �� ����������.
------------------------------------------------------------------------------------------------------------
 01.09.2015 ������ ��������� ����� �����-�������
 28.08.2015 ������ �������� ����-�����������
 27.08.2015 ������ �����-���� �� ���.����
 25.08.2015 ������ p_mode = 3 ����������� ���������� �� ���� - �� ����������� ��
 18.08.2015 ������. ������������ ��������.
 15.06.2015 Sta
 ���� �������: ������������ �� � ������������ �ᒺ����� ����������� ���������������� ������� (����).
 --------------------
2063  09  �������, �� ����� ��"�������� ����������� ���������������� �������
2062  19  �������, �� ����� ��"�������� ����������� ���������������� �������
������� (���� ������ ���� �������� ��������� ��� ��) ��������
2063  ��  ������ ��� ��
2062  yy  ������ ��� ��
*/
  kl1 customer%rowtype ;
  nn1 nd_acc%rowtype   ; aa8 accounts%rowtype ;
  dd1 cc_deal%rowtype  ; aa1 accounts%rowtype ; ad1 cc_add%rowtype   ;  sd1 accounts%rowtype ; ii1 int_accn%rowtype;
  dd2 cc_deal%rowtype  ; aa2 accounts%rowtype ; oo1 oper%rowtype     ;  l_pl1  number        ; SumR_ number        ; SumP_ number ;
  l_datnp date         ; l_ir number          ; s_Txt1 varchar2(250) ;  s_Txt2 varchar2(250) ; nTmp_ number        ; sTmp_ varchar2(100);
  sErr varchar2(2000)  ; nlchr char(2)        := chr(13)||chr(10)    ;  s_GRAC1 varchar2(10) ; d_GRAC1 date        ;
begin

If p_mode in (0,1,2) then

   -- �������� �i����� ����-1 ��  �i����� ����-2 ��
   Begin select substr(trim(txt),1,10) into s_GRAC1 from nd_txt where tag = 'GRAC1' and nd = p_nd1;
         begin d_GRAC1 := to_date( s_GRAC1, 'dd.mm.yyyy') ; exception when others then null;  end  ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
         If p_mode = 2 then RETURN; end if ; ---12.11.2015 Sta ���������� � ������ ������ ���� p_mode = 2 Գ��
   end;

   If p_mode in (0, 1 ) then -- ����������� ��-1

      begin select d.* into dd1 from cc_deal d, nd_txt x where  d.vidd=2 and d.nd = p_nd1 and d.sos<15 and x.nd = d.nd and x.tag = 'I_CR9' and x.txt = '1';
      EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||           '2) �� � �������.,�������. �������� ���';
      end;
      If d_GRAC1 is null OR   dd1.wdate <= d_GRAC1  OR     months_between (d_GRAC1, dd1.sdate) > 6  then
         sErr  := sErr || nlchr ||'5) �� ����./�����/>6 �� ���.������� GRAC1 = '|| s_GRAC1;
      end if;

   ElsIf p_mode = 2 then   -- Գ��       ���������� �� ���� + ����-����� ���������� �� ����
         If d_GRAC1 is null then RETURN; end if;
         -- ����� ������ �� (���) -1 .
         begin select d.* into dd1 from cc_deal  d  where d.vidd=2 and d.ndi is null and d.nd  = p_nd1 and d.sos < 15 ;
               select a.* into aa1 from accounts a, nd_acc n where a.tip = 'LIM' and a.ostc=a.ostb and a.acc = n.acc and n.nd  = dd1.nd and a.ostc < 0 ;
               s_Txt1 := '����������� �� � ��  ���='|| dd1.nd|| ' � ��������� �����.������, ���=';

               If d_GRAC1 <=  gl.bdate         then
                  s_Txt2 := '. ��������� ������ �����-������';

               ElsIf -aa1.ostc >= dd1.sdog*100 and  dd1.sdate < to_date ('26/11/2015', 'dd/mm/yyyy') then  -- ������������� ����� �� �� ������� �� 20/11/2015
                  s_Txt2 := '. ����� ������� �������';

               Else  RETURN;
               end if;

               select * into ad1 from cc_add   where nd= dd1.nd and adds = 0 ;
               select * into ii1 from int_accn where id= 0 and acc = aa1.acc ;
         EXCEPTION WHEN NO_DATA_FOUND THEN return;
         end;
   end if;
end if;

If p_mode = 3 then
   begin select d.* into dd1 from cc_deal d  where  d.vidd=1  and d.nd = p_nd1 and d.sos < 15 ;
   EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '2) �� � ����������� �� ';
   end;
end if ;

If p_mode in (0, 1, 3) then
   If p_mode <> 3  then
      begin select d.* into dd1 from cc_deal d  where  d.nd = p_nd1 and d.sos < 15 ;
           select * into kl1 from customer where rnk = dd1.rnk and (( sed like '56%' or k050 like '855%') or (sed like '62%' or k050 like '320%')) ;
      EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '0)  RNK '||dd1.rnk ||' �� � ���� ��� ��� ';
      end;
   end if;
   begin select a.* into aa8 from accounts a, nd_acc n where a.tip='LIM' and a.acc= n.acc and n.nd = p_nd1;
         select *   into ad1 from cc_add               where nd = dd1.nd and adds = 0;
   EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '2`) �� �������� 8999*LIM';
   end;
   if aa8.kv<> gl.baseval then sErr := sErr || nlchr||                '1) ��� ��� - ����� ����������� ';
   end if ;
   begin select *   into ii1 from int_accn             where id= 0 and acc = aa8.acc and s >=1 ;
         If    p_mode in (   3 ) and ii1.basem<> 1 then sErr := sErr || nlchr||'3) �� ������ ���-������' ;
         elsIf p_mode in (0, 1 ) and ii1.basey<> 0 then sErr := sErr || nlchr||'3) ����� ����������� %% HE = �����/����' ;
         end if ;
   EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '4) �� ��������� ��.���� �� ';
   end;

   If p_mode <> 3  then
      SELECT - Nvl (sum(a9.ostb),0)   into nTmp_     FROM accounts a9  WHERE a9.dazs  IS  NULL  and a9.acc in
        (select z.acc from cc_accp z, pawn_acc p, cc_pawn w where z.nd = dd1.nd and z.acc=p.acc and p.pawn=w.pawn and w.s031 = '59');
         If nTmp_ = 0 then   sErr := sErr || nlchr||                     '6) ³������ �������-�������' ; end if;
   end if ;

   begin select * into aa1 from accounts where nbs='2600' and dazs is null and rnk  = dd1.rnk and kv = gl.baseval and rownum = 1 ;

----     begin select n.* into nn1 from accounts a, nd_acc n where a.nbs='2600' and a.dazs is null and a.acc = n.acc and n.nd  = dd1.nd ;
----     EXCEPTION WHEN NO_DATA_FOUND THEN          insert into nd_acc (nd, acc) values( dd1.nd, aa1.acc);
---      end ;
   EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '7) ³������ �������� ���.���. ������������ ���='|| dd1.rnk;
   end;

   If p_mode <> 3  then

      Begin select nvl(to_number(replace(txt,',','.')), 0) into nTmp_ from nd_txt where tag = 'S_SDI' and nd = p_nd1;
      exception when others then                nTmp_ := 0;
      end  ; If nTmp_<= 0 then sErr  := sErr || nlchr||      '8) ³����� ��� ��� ��������� �����'; end if;

   end if;

   If months_between(dd1.wdate,dd1.sdate)>60 then sErr :=sErr||nlchr||'9) �������� ���� ����� ������������ = 60 ��.' ;  end if;

   If p_mode in (0)       then  PUL.Set_Mas_Ini( 'ERR_OSBB', sErr, 'ERR_OSBB' );  RETURN ;
   else
      If length(sErr) > 0 then  raise_application_error(-(20203),'\8999 - cck_OSBB: �� '||p_ND1|| sErr ) ;  end if ;
   end if;
end if;
------------- #########################################

If p_mode = 1 then
   -- ����� �� ������ �������� ����� ���� ���������� �������� ������������ ����� �� ��������� �����-������
   update int_accn set metr=4 where id=1 and acc in (select a.acc from accounts a, nd_acc n where n.nd=dd1.nd and n.acc=a.acc and a.tip = 'SDI' );

   -- ���������� ������� ���������  ��� ������ �����
   --   GPK - ������ � ����� + ������ �������� ����������� �� ����� �������� ����� �������  ��̲����� ?
   CCK.CC_LIM_NULL( p_nd1 ) ;
   l_Ir :=  acrn.fprocn(aa8.acc, 0, gl.bdate);
   CCK.CC_GPK (MODE_ => 1        , --- int ,
               ND_   => p_nd1    , -- int ,
               ACC_  => aa8.acc  , -- int,
               BDAT_1=> gl.bdate , -- date,   -- ������
               DATN_ => cck.f_dat (ii1.s, trunc(add_months(gl.bdate,1),'MM')  ),   -- ii1.APL_DAT, --- date,   -- ������ ���� ���������
               DAT4_ => dd1.wdate, --  date,   -- ����������
               SUM1_ => dd1.sdog , -- number, -- ����� � ��������� � ��� (1.00)
               FREQ_ => 5        , -- int,
               RATE_ => l_ir     , ----number, -- ������� % ������
               DIG_  => 0) ;

   begin  Insert into cc_lim (ND, FDAT, LIM2, ACC, SUMG, SUMO, SUMK) Values(p_nd1, d_GRAC1, 0, aa8.acc, 0, 0, 0);
   exception when dup_val_on_index then  null;
   end;
   SumR_ := dd1.sdog*100   ;
   update cc_lim set sumg = decode (fdat, d_GRAC1, SumR_, 0) where nd = p_nd1 ;
   CCK.CC_GPK_LIM ( p_ND1, aa8.Acc    , gl.bdate, gl.bdate, SumR_) ;
   CCK.cc_TMP_GPK (ND_   => p_nd1     , --   int,     -- ��� ��
                   nVID_ => 2         , --   int,     -- ��� ��� = 4 ��� "���� �������", =2 �����( ���� + ������)
                   ACC8_ => aa8.acc   , --   int,     -- ��� ��� �� 8999
                   DAT3_ => gl.bdate  , --  date,    -- ������ ���� ������ ��
                   DAT4_ => dd1.wdate , --  date,    -- ���� ���������� ��
                   Reserv_=> null     , --  char,    --������. �� ���������
                   SUMR_  => null     , --  number,  --������. �� ��������� -- ����� ����� �� ��
                   gl_BDATE => null     -- date     --������. �� ���������
                  ) ;
----- �������� �������-������ ��� �����-2    -------------------------RETURN ;
   cck.UNI_GPK_FL (p_lim2  => SumR_  ,  -- ����� �����
                   p_gpk   => 4      ,  -- 1-�������. 0 - �����
                   p_dd    => ii1.s  ,  -- <��������� ����>, �� ���� = DD �� �������� ����.���
                   p_datn  => d_GRAC1,  -- ���� ��� ��
                   p_datk  => dd1.wdate,   -- ���� ����� ��
                   p_ir    => l_ir   ,    -- ����.������
                   p_pl1   => cck.f_pl1(0, SumR_, 4, ii1.s, d_GRAC1, dd1.wdate, l_ir,0),        -- ����� 1 ��
                   p_ssr   => 0      ,     -- ������� =0= "� ����������� �����"
                   p_ss    => 0      ,     -- ������� �� ���� ����
                   p_acrd  => d_GRAC1,     -- � ����� ���� ��������� % acr_dat+1
                   p_basey => 2             -- ���� ��� ��� %%;
                        );

   select nvl(sum(sumo-sumg),0)  into SumP_ from cc_lim   where nd = p_nd1 and fdat >= d_GRAC1;
   delete                              from cc_lim        where nd = p_nd1 and fdat >  d_GRAC1;
   update cc_lim set sumg = 0, sumo = SumP_, lim2 = Sumr_ where nd = p_nd1 and fdat  = d_GRAC1;
   insert into cc_lim (ND,FDAT,LIM2,ACC,SUMG,SUMO,SUMK) select p_nd1,fdat,lim2,aa8.acc,sumg,sumo,nvl(sumk,0) from tmp_gpk where fdat>d_GRAC1;
   --------
   RETURN ;  ------- p_mode = 1
   --------
end if;
----------------------------------

If p_mode = 2 then  -- Գ��       ���������� �� ���� + ����-����� ���������� �� ����
   oo1.tt := '024' ;
   begin select a.* into sd1 from accounts a, nd_acc n where a.tip ='SDI' and a.ostb >0 and a.acc=n.acc and n.nd = dd1.nd;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;
end if;

----------��� ������ ��.����
l_datnp := trunc(gl.Bdate, 'MM') ;   l_datnp := cck.f_dat ( p_dd => ii1.s, p_DAT1 => l_datnp );
If l_datnp <= gl.bdate then          l_datnp := add_months ( l_datnp,1 ) ;              end if;

-------- ��� ����.������
If p_mode = 2 then
   l_ir := acrn.fprocn ( aa1.acc, 0, gl.bdate);

   -------��� ��������
   CCK.CC_OPEN ( ND_  => dd2.nd,
                 nRNK => dd1.rnk,
               CC_ID_ => dd1.cc_id||'/2',
               Dat1   => gl.bdate ,
               Dat4   => dd1.WDATE,
               Dat2   => gl.bdate,
               Dat3   => gl.bdate,
               nKV    => aa1.kv  ,
               nS     => -aa1.ostc/100,
               nVID   => 1,
               nISTO  => ad1.sour,
               nCEL   => ad1.aim,
               MS_NX  => null,
               nFIN   => dd1.fin,
               nOBS   => dd1.obs,
               sAIM   => null,
               ID_    => dd1.user_id,
               NLS    => null,
               nBANK  => null,
               nFREQ  => 5   ,
               dfPROC => l_ir,
               nBasey => 2,
               dfDen  => ii1.s,
               DATNP  => l_datnp,
               nFREQP => 5 ,
               nKom   => sd1.ostb ) ;
   
   if newnbs.g_state= 1 then
        begin  
            SELECT r020_new||ob_new
              INTO dd1.prod
              FROM TRANSFER_2017
             WHERE r020_old||ob_old = dd1.prod and r020_old <> r020_new;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        end;     
   end if;
   
   update cc_deal set prod  =  dd1.prod  where nd = dd2.nd ;
   select *       into dd2 from cc_deal  where nd = dd2.nd ;
   --------��� ���.����.
   CCK_APP.SET_ND_TXT(dd2.nd,'INIC' ,CCK_APP.Get_ND_TXT (dd1.ND,'INIC' ) );
   CCK_APP.SET_ND_TXT(dd2.nd,'EMAIL',CCK_APP.Get_ND_TXT (dd1.ND,'EMAIL') );
-- CCK_APP.SET_ND_TXT(dd2.nd,'CCRNG',CCK_APP.Get_ND_TXT (dd1.ND,'CCRNG') );
   CCK_APP.SET_ND_TXT(dd2.nd,'CCRNG', '6'                                );

   CCK_APP.SET_ND_TXT(dd2.nd,'S260' ,CCK_APP.Get_ND_TXT (dd1.ND,'S260' ) );
   CCK_APP.SET_ND_TXT(dd2.nd,'FLAGS','10'                                );
   if sd1.ostb >0 then
      CCK_APP.SET_ND_TXT(dd2.nd,'S_SDI',to_char(sd1.ostb/100)            );
   end if ;
   ------------??????????? TRIGGER tbu_ccdeal_eib10
   -- COBUSUPABS-7041 ϳ��� ��������� ������ TBU_CCDEAL_EIB10 �� �������� �� ����������� ��������� CIG_D13 ��������� ��������� ������� ��������� ������� �����-����� �������� ��
    BEGIN
      INSERT INTO mos_operw (ND, TAG, VALUE)
           VALUES (dd2.nd, 'CIG_D13', '1');
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
          NULL;
    END;
   CCK_APP.SET_ND_TXT(dd2.nd,'CPROD',CCK_APP.Get_ND_TXT (dd1.ND,'CPROD') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBIS',CCK_APP.Get_ND_TXT (dd1.ND,'EIBIS') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCW',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCW') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBTV',CCK_APP.Get_ND_TXT (dd1.ND,'EIBTV') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCR',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCR') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCE',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCE') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBND',CCK_APP.Get_ND_TXT (dd1.ND,'EIBND') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBNE',CCK_APP.Get_ND_TXT (dd1.ND,'EIBNE') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBIE',CCK_APP.Get_ND_TXT (dd1.ND,'EIBIE') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCS',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCS') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBSF',CCK_APP.Get_ND_TXT (dd1.ND,'EIBSF') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBPF',CCK_APP.Get_ND_TXT (dd1.ND,'EIBPF') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCB',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCB') );
   ------ ���������� � ������ ������.
   oo1.nazn := Substr( s_Txt1||dd2.nd||s_Txt2,1, 160) ;

ElsIf p_mode = 3     then l_ir := acrn.fprocn(aa8.acc, 0, gl.bdate) ;
   select d.*        into dd2 from cc_deal  d   where d.nd = p_nd1  ;
   oo1.nazn := '������ ��� ���� �� ��� ���� (��� ��, ��� �����-������) �����.������, ���='||dd2.nd;
   CCK_APP.SET_ND_TXT(dd2.nd,'CCRNG', '6'  );
end if ;

   select a.*        into aa2 from accounts a, nd_acc n where a.tip = 'LIM' and a.acc=n.acc and n.nd = dd2.nd ;
   update int_accn set baseM = 1, basey = 2 where acc = aa2.acc and id= 0 ;
   -- ���������� ���
   cck.CC_GPK (MODE_  => 3,
               ND_    => dd2.nd,
               ACC_   => aa2.acc,
               BDAT_1 => dd2.sdate,
               DATN_  => l_datnp,   -- ������ ���� ���������
               DAT4_  => dd2.wdate,
               SUM1_  => dd2.sdog, -- ����� � ��������� � ��� (1.00)
               FREQ_  => 5,
               RATE_  => l_ir,  -- ������� % ������
               DIG_   => 0 ) ;

If p_mode = 2 then
    -------����� ����������� ��������� �����������
----cck.cc_autor( dd2.ND, oo1.nazn, CCK_APP.Get_ND_TXT (dd1.ND ,'MS_UR' )   );------

   delete from cc_prol        where nd = dd2.nd ;
   delete from nd_txt         where nd = dd2.nd and tag in ('AUTOR', 'MS_UR'  );
   INSERT INTO nd_txt (ND,TAG,TXT)          values (dd2.ND, 'AUTOR', oo1.nazn );
   INSERT INTO nd_txt (ND,TAG,TXT)          select  dd2.ND, 'MS_UR', txt from nd_txt where tag = 'MS_UR' and nd  = p_nd1;
   insert into cc_prol(ND,NPP,MDATE,fdat )  select  dd2.ND, 0, dd2.wdate, min(fdat) from  cc_lim where nd = dd2.ND ;
   UPDATE cc_deal set  sos = 10  where nd = dd2.ND ;
   INSERT INTO cc_sob (ND,FDAT,ISP,TXT,otm) values (dd2.ND,gl.bDATE,gl.aUID,'������������ �������-2 �� ��='|| p_nd1,6);

end if;

    ----- ����������  ����������� ������ p_ND < 0 -- l_mode := 2; �� �������� ��� + �� �������� ��
    --p_irr_BV (p_ND => - dd2.nd, R_DAT => dd2.sdate );
    cck_dop.calc_sdi( dd2.nd, null);  -- ����� ��������� �� ����������� ��� ��������������� ������� ��.������
    --------�������� ������
    cck_dop.open_account(p_nd => dd2.nd,  p_tip => 'SS ') ;
    cck_dop.open_account(p_nd => dd2.nd,  p_tip => 'SN ') ;

    if sd1.ostb > 0 then
       cck_dop.open_account(p_nd => dd2.nd,  p_tip => 'SDI') ;
    end if;
    -----��������� ������ �� �����������
    insert into cc_accp(ACC,  ACCS,     ND )
      select distinct z.acc, s.acc, dd2.nd
      from (select * from cc_accp where nd = dd1.nd) z,
           (select a.acc from accounts a, nd_acc n where n.nd= dd2.nd and n.acc = a.acc and a.tip='SS ') s ;
    ------�������� 2600
    insert into nd_acc(nd,acc)
    select dd2.nd, a.acc  from nd_acc n, accounts a
    where a.nbs = '2600' and a.acc = n.acc and a.kv = aa2.kv and n.nd = dd1.nd
      and not exists ( select 1 from nd_acc where nd=dd1.nd and acc=a.acc );

If p_mode = 2 then
    -----������� ��� ��
    update cc_deal   set  ndi = dd1.nd  where nd in ( dd1.nd , dd2.nd) ;
    --------����������� ��� �� ����.����. ������ �� ����������� .��� �� ����������� (���� ���� ��������� %)
    for k in (select a.*
              from accounts a, nd_acc n
              where a.ostc <> 0
                and (a.accc=aa1.acc or a.tip in ('CR9','SDI' ) )
                and a.acc=n.acc and n.nd = dd1.nd
              order by a.acc )
    loop
       If k.tip = 'SDI' and k.ostb > 0 then oo1.dk := 0 ;
       else                                 oo1.dk := 1 ;
       end if;
       oo1.s := abs(k.ostb);
       begin
          If k.tip = 'CR9'  then
             select a.nls, substr(a.nms,1,38) into oo1.nlsa, oo1.nam_a from accounts a
             where  a.kv=k.kv and a.nls = BRANCH_USR.GET_BRANCH_PARAM2('NLS_9900',0) ;
          else
             select a.nls, substr(a.nms,1,38) into oo1.nlsa, oo1.nam_a from accounts a, nd_acc n
             where a.tip = decode (k.tip,'SDI',k.tip,'SS ') and a.kv=k.kv and a.acc=n.acc and n.nd = dd2.nd ;
          end if;

          If oo1.ref is null then
             gl.ref( oo1.ref);
             gl.in_doc3 (oo1.ref  , oo1.tt,6, substr(dd1.cc_id,1,10) , sysdate, gl.bdate, 1, k.kv, oo1.s, k.kv, oo1.s, null , gl.bdate, gl.bdate,
                         oo1.nam_a, oo1.nlsa, gl.amfo, substr(k.nms,1,38), k.nls, gl.amfo, oo1.nazn, null, gl.aOkpo, gl.aOkpo, null,null, 0,null, null);
          end if;
          gl.payv( 0, oo1.ref, gl.bdate, oo1.tt, oo1.dk, k.kv, oo1.nlsA, oo1.s, k.kv, k.nls, oo1.s);
       EXCEPTION WHEN NO_DATA_FOUND THEN return;
       end;
    end loop;

    if oo1.ref is not null then gl.pay (2, oo1.ref, gl.bdate) ; end if;
    RETURN ;
end if;

  RETURN;
end  cck_OSBB;
/
