

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_EMI_LOT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_EMI_LOT ***

  CREATE OR REPLACE PROCEDURE BARS.P_EMI_LOT (mode_ int, DAT1_ date, DAT2_ date,
branch_ varchar2) Is

/*

15.03.2013 Sta ������� ������� �������� �� SNP.fost.
               ������ ����� PROVODKI
12-02-2011 Sta ��22 ��������� � ACCOUNTS
18-01-2011 Sta �� ��������� ��������, ��� "��������������"                VS2 �������� �i������� �i �������.
02-12-2010 ������. + ������� -             �� ������ ��� ��� (�������� ���.���� �������� ��������)
07-05.2010 ����� ��� � �������.
06.08.2009 ����������� "�� ���� �����"
*/


 l_EMI       TMP_EMI_LOT1.EMI%type :='..'; --��� ��������
 l_NAME_EMI  TMP_EMI_LOT1.NAME_EMI%type; --������������ ��������
 l_SV_2905   TMP_EMI_LOT1.SV_2905%type ; --��.���.2905 �� ��������
 l_SI_2905   TMP_EMI_LOT1.SI_2905%type ; --���.���.2905 �� ��������
 l_SV_2805   TMP_EMI_LOT1.SV_2805%type ; --��.���.2805 �� ��������
 l_SI_2805   TMP_EMI_LOT1.SI_2805%type ; --���.���.2805 �� ��������
 L_KV_9819   TMP_EMI_LOT1.KV_9819%type ; --��.���.9819 �� ������� ��������(���-��)
 L_KI_9819   TMP_EMI_LOT1.KI_9819%type ; --���.���.9819 �� ������� ��������(���-��)
 --------------------------------------------------------------

 DAT0_ date   := DAT1_ - 1;
 ACC_  int    :=0;
 ob22_ char(2);
 L_branch branch.branch%type;
 sTmp_ operw.value%type;

 l_KD_9819   TMP_EMI_LOT1.KD_9819%type ; --�������������     - ����������
 l_KK_9819   TMP_EMI_LOT1.KK_9819%type ; --�������           - ����������
 l_KZ_9819   TMP_EMI_LOT1.KZ_9819%type ; --�����������       - ����������
 l_SK_2905   TMP_EMI_LOT1.SK_2905%type ; --�������           - �����
 l_KD_9812   TMP_EMI_LOT1.KD_9812%type ; --�������� �������� - ����������
 l_SD_2805   TMP_EMI_LOT1.SD_2805%type ; --�������� �������� - �����
 l_SD_2805xx TMP_EMI_LOT1.SD_2805xx%type ; --���� �������� - �����

 l_SD_2805pfu    TMP_EMI_LOT1.SD_2805pfu%type;    -- ������� � ��� 15%
 l_SD_2805vz     TMP_EMI_LOT1.SD_2805vz%type;     -- ³�������� ��� 1,5%
 l_LOT       TMP_EMI_LOT1.LOT%type     ; --��� ������ �������� (�������)
 l_LOT1      TMP_EMI_LOT1.LOT%type     ; --��� ������ �������� (�������)

 l_NAME_LOT  TMP_EMI_LOT1.NAME_LOT%type; --������������ ������ �������� (�������)
 l_cena      TMP_EMI_LOT1.cena%type    ; -- ����

 DI0_ number;
 DI2_ number;
begin

 DI0_ := to_char ( DAT0_, 'J' ) - 2447892 ;
 DI2_ := to_char ( DAT2_, 'J' ) - 2447892 ;

 execute immediate ' truncate table TMP_EMI_LOT1 ';

--����-1  ��������� �� � ���.������� ��  ��� � �������
FOR l in (SELECT r.lot, r.BRANCH, r.KV_9819, r.KI_9819,   v.NAME name_lot, v.ob22_205 emi, v.CENA
          FROM Valuables v ,
              (select '9819' || a.ob22 LOT, substr(a.branch,1,mode_) BRANCH,
                      -Nvl( sum( snp.fost(a.acc,DI0_, 0,7)) ,0 )/100 KV_9819,
                      -Nvl( sum( snp.fost(a.acc,DI2_, 0,7)) ,0 )/100 KI_9819
               from accounts a
               where a.nbs='9819' and (a.dazs is null or a.dazs>DAT0_) and a.branch like BRANCH_||'%'
               group by a.ob22, substr(a.branch,1,mode_)
               ) r
          WHERE v.OB22_205 is not null and r.lot=v.ob22
          )
loop
   update TMP_EMI_LOT1  set KV_9819=l.KV_9819, KI_9819 =l.KI_9819   where LOT = l.LOT and branch=l.BRANCH;
   if SQL%rowcount = 0 then
      begin
         select substr(txt,1,45) into l_NAME_EMI  from sb_ob22  where r020='2905' and ob22=l.emi;
      EXCEPTION WHEN NO_DATA_FOUND THEN L_NAME_EMI:='';
      end;
      insert into TMP_EMI_LOT1 (EMI, LOT, branch, name_emi, name_lot, cena,
          KD_9819,KK_9819, KZ_9819, SK_2905, KD_9812, SD_2805, SV_2905,SI_2905, SV_2805, SI_2805, KV_9819, KI_9819, SD_2805xx, SD_2805pfu, SD_2805vz  )
        values   (l.EMI,l.LOT, L.branch,l_name_emi,l.NAME_lot, l.cena, 0,0,0,0,0,0,0,0,0,0,l.KV_9819,l.KI_9819,0,0,0 );
   end if;
end loop;
-------

--����-2 �� ���������
for p in (select ACC, tt, REF, NBS, NLSD, NLSK, s/100 S, BRD,  BRK
          from (SELECT ad.ACC, o.tt, o.REF, ad.NBS, ad.nls NLSD, ak.nls NLSK, o.s, ad.branch BRD, ak.branch BRK
                FROM (select acc,nbs,nls,branch from accounts where nbs in ('9819','9812','2905','2805')
                                               and BRANCH like case when substr(nbs,1,1) = '9' then branch_ else substr(branch_,1,15) end||'%' and length(BRANCH) >= 15     ) ad,
                     (select acc,nbs,nls,branch from accounts where nls not like '9819%' and BRANCH like case when substr(nbs,1,1) = '1' then branch_ else substr(branch_,1,15) end||'%'                ) ak,
                     (SELECT REF,stmt,tt,s,SUM(DECODE(dk,0,acc,0)) accd, SUM(DECODE(dk,1,acc,0)) acck
                      FROM opldok WHERE sos=5 and fdat >=DAT1_ and fdat <= DAT2_ GROUP BY REF,stmt,tt,s  ) o
                WHERE o.accd = ad.acc  AND o.acck = ak.acc
                union ALL
                SELECT ak.ACC, o.tt, o.REF, ak.NBS, ad.nls NLSD, ak.nls NLSK, o.S, ad.branch BRD, ak.branch BRK
                FROM (select acc,nbs,nls,branch from accounts where BRANCH like case when substr(nbs,1,1) = '1' then branch_ else substr(branch_,1,15) end||'%' ) ad,
                     (select acc,nbs,nls,branch from accounts where nbs in ('9819','9812','2905','2805')
                                                 and BRANCH like case when substr(nbs,1,1) = '9' then branch_ else substr(branch_,1,15) end||'%'  and length(BRANCH) >=15    ) ak,
                     (SELECT REF,stmt,tt,s,SUM(DECODE(dk,0,acc,0)) accd, SUM(DECODE(dk,1,acc,0)) acck
                      FROM opldok WHERE sos=5 and fdat >=DAT1_ and fdat <= DAT2_ GROUP BY REF,stmt,tt,s   ) o
                WHERE o.accd = ad.acc  AND o.acck = ak.acc
               )
          ORDER BY acc
          )
loop

   l_KD_9819:=0; l_KZ_9819:=0; l_KK_9819:=0; l_SK_2905:=0; l_KD_9812:=0; l_SD_2805:=0; l_SD_2805xx:=0; l_SD_2805pfu  :=0; l_SD_2805vz :=0;

   if acc_<> p.acc then
      -- � ����� �� ��� ���� ����, �.�. ����� �� �� ��������� � ��������
      begin
         select ob22 into ob22_ from accounts where acc=p.acc ;
         If    p.NBS = '9819' then
               select ob22, ob22_205    into l_lot, l_emi from valuables where ob22_205 is not null and  ob22='9819'||ob22_ and rownum=1;
         elsIf p.NBS = '9812' then
               select ob22, ob22_205    into l_lot, l_emi from valuables where ob22_205 is not null and  ob22_spl=ob22_  and rownum=1;
         else
              select '9819..', ob22_205 into l_lot1,l_emi from valuables where ob22_205=ob22_ and rownum=1;
         end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN GOTO NextRec;
      end;
      acc_:= p.acc;
   end if;

   --�������� ��� �������
   If l_lot1 = '9819..' then
      begin
        select value into sTmp_ from operw where ref=p.REF anD tag='VA_KC';
        l_LOT := substr(sTmp_,1,6);
      EXCEPTION WHEN NO_DATA_FOUND THEN l_lot := l_lot1;
      end;
   end if;

   If    p.NLSD LIKE '9819%' and  p.NLSK like '989%' then    -- ���i����       ���-��  -- 9819 - 989*
         l_KD_9819 := p.S;   L_branch := substr(p.BRD,1,MODE_);

   ElsIf p.NlSD LIKE '9910%' and p.NLSK like '9819%' then    -- �������������  ���-��  -- 9910 - 9819
         l_KK_9819 := p.S;   L_branch := substr(p.BRK,1,MODE_);

         If p.tt = 'VS2' and length(p.brD) <=15  and length(p.brK) <=15 then
            --18-01-2011 �� ��������� ��������, ��� "��������������"
            GOTO NextRec;
         end if;

   ElsIf p.NlSD LIKE '9812%' and p.NLSK like '9819%' then    -- �����������    ���-��  -- 9812 - 9819
         l_KZ_9819 := p.S;   L_branch := substr(p.BRK,1,MODE_);

   ElsIf p.NlSD like '9812%' and p.NlSK like '9910%' then    -- �����.�������� ���-��  -- 9812 - 9910
         l_KD_9812 := p.S;   L_branch := substr(p.BRD,1,MODE_);


   elsIf p.NlSD like '100%'  and p.NlSK like '2%'    then    -- �������, �����         -- 1001 - 2905/2805
         l_SK_2905 := p.S;   L_branch := substr(p.BRD,1,MODE_);

   elsIf p.NlSD like '2%'    and p.NlSK like '100%'  then    --�������� ��������,����� -- 2905/2805  - 1001
         l_SD_2805 := p.S;   L_branch := substr(p.BRK,1,MODE_);
		 l_SD_2805xx := greatest(nvl(to_number(f_dop(p.ref,'SUM_V')),0),p.S);
		 case when (l_SD_2805xx-l_SD_2805) > 0 then
		 l_SD_2805pfu :=  (l_SD_2805xx-l_SD_2805) - (round(l_SD_2805xx*100/100*1.5)/100);
		 l_SD_2805vz  :=  round(l_SD_2805xx*100/100*1.5)/100;
		 else null;
		 end case;

   else
      GOTO NextRec;
   end if;
   ---------------------
   update TMP_EMI_LOT1 set
          KD_9819 = KD_9819 + l_KD_9819, --�������������     - ����������
          KK_9819 = KK_9819 + l_KK_9819, --�������           - ����������
          KZ_9819 = KZ_9819 + l_KZ_9819, --�����������       - ����������
          SK_2905 = SK_2905 + l_SK_2905, --�������           - �����
          KD_9812 = KD_9812 + l_KD_9812, --�������� �������� - ����������
          SD_2805 = SD_2805 + l_SD_2805,  --�������� �������� - �����
		  SD_2805xx = SD_2805xx + l_SD_2805xx,
		  SD_2805pfu = SD_2805pfu +  l_SD_2805pfu,
		  SD_2805vz  = SD_2805vz  +  l_SD_2805vz
      where LOT = l_LOT and emi=l_emi and branch=L_branch;

   if SQL%rowcount = 0 then

      If l_lot = '9819..' then L_NAME_LOT:= null;
      else
        BEGIN
          --������������ ������� �� ���.���������
          select name, cena into L_NAME_LOT, l_cena   from valuables where ob22=l_lot ;
        EXCEPTION WHEN NO_DATA_FOUND THEN
           raise_application_error(     -20203, '\9356 - REF ='|| P.REF ||' ������� ���.����(���� �������) ='||l_lot , TRUE);
        END ;
      end if;
      -- ������������ ��������
      begin
         select substr(txt,1,45) into l_NAME_EMI from sb_ob22  where r020='2905' and ob22=l_emi;
      EXCEPTION WHEN NO_DATA_FOUND THEN
           raise_application_error(     -20203,  '\9356 - REF ='|| P.REF ||' ������ � sb_ob22  2905/' || l_emi , TRUE);
      END ;
      insert into TMP_EMI_LOT1  (LOT, emi, cena, name_lot, name_emi,branch,
          KD_9819, --�������������     - ����������
          KK_9819, --�������           - ����������
          KZ_9819, --�����������       - ����������
          SK_2905, --�������           - �����
          KD_9812, --�������� �������� - ����������
          SD_2805,  --�������� �������� - �����
		  SD_2805xx, SD_2805pfu, SD_2805vz,
          SV_2905, SI_2905, SV_2805, SI_2805, KV_9819, KI_9819   )
      values         ( l_LOT, L_EMI, L_CENA, L_NAME_LOT, L_NAME_EMI,
        L_branch ,
        l_KD_9819, --�������������     - ����������
        l_KK_9819, --�������           - ����������
        l_KZ_9819, --�����������       - ����������
        l_SK_2905, --�������           - �����
        l_KD_9812, --�������� �������� - ����������
        l_SD_2805,
		l_SD_2805xx, l_SD_2805pfu, l_SD_2805vz,
        0,0,0,0,0,0  --�������� �������� - �����
         );
   end if;

   <<NextRec>> NULL;

end loop;

 --�������           - �����
 -- update TMP_EMI_LOT1 set   SK_2905 = KK_9819 * cena /100 ;
--==============

 commit;

end p_EMI_Lot ;
/
show err;

PROMPT *** Create  grants  P_EMI_LOT ***
grant EXECUTE                                                                on P_EMI_LOT       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_EMI_LOT       to RPBN001;
grant EXECUTE                                                                on P_EMI_LOT       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_EMI_LOT.sql =========*** End ***
PROMPT ===================================================================================== 
