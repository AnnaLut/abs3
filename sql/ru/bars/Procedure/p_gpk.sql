

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_GPK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_GPK ***

  CREATE OR REPLACE PROCEDURE BARS.P_GPK 
(MODE_  int   , -- = 1 -������������, =2- � ����� �����, 3- �������
 MODE2_ char  , -- = 1 - ���� �� ����.�����
 OST4_  number, -- ����� � ��������� � ��������
 DATN_  date,   -- ������ ���������
 DAT4_  date,   -- ����������
 p_RATE  number, -- ������� % ������
 FREQ_  int ,   -- ��� �������������
 BASEY_ int ,
 Metr96_ int, --  ��������,% ����.��������, ��������� �����
 p_RKOM  number,
 DIG_   int ) IS

-- 19.02.2009 ������.
-- ������������ �� ���� ���������� ��������� (��� ����������������� ������)
-- DEL2_:= to_number( pul.Get_Mas_Ini_Val('DEL2_'));

 -- ���������� ���.
 S_     number;
 K_     number;
 DATNk_ date  ;
 DAT4k_ date  ;
 Dtmp_  date  ;  --
 FDAT_  date  ;  -- �������� ���� ������ ����������
 DATi_  date  ;  -- ����.���� ��������� ������
 DATj_  date  ;  -- ����.���� ��������� ������
 KOL2_  int   ;  -- ��� ��������
 LIM2_  number;  -- ����� ������ �� ���� FDAT_
 DEL2_  number;  -- ������������� ������ ���������
 nTMP_  number;
---------------------

BEGIN
 delete from TMP_GPK;
 --������ ����:
 DATNk_:= cck.CorrectDate(gl.baseval, DATN_, DATN_+1);
 INSERT INTO TMP_GPK(fdat,sumg,sumo) VALUES (DATNk_,0,0);
 DAT4k_:= cck.CorrectDate(gl.baseval, DAT4_, DAT4_);
 INSERT INTO TMP_GPK(fdat,sumg,sumo) VALUES (DAT4k_,0,0);

-- ������ ��� ���� ? H��, ��������
 FDAT_:= DATN_;
 DATj_:= FDAT_;
 DATi_:= FDAT_;
 KOL2_:= 1 ;
 WHILE DATj_ < DAT4k_
 loop
       If FREQ_=   3 then  DATj_:=DATj_ + 7;
    elsIf FREQ_=   5 and mode_=1 then  DATj_:=last_day(add_months(FDAT_,   KOL2_ )) ;   
    elsIf FREQ_=   5 then  DATj_:=add_months(FDAT_,   KOL2_ ) ;
    elsIf FREQ_=   5 then  DATj_:=last_day(add_months(FDAT_,   KOL2_ )) ;
    elsIf FREQ_=   7 then  DATj_:=add_months(FDAT_, 3*KOL2_ ) ;
    elsIf FREQ_= 180 then  DATj_:=add_months(FDAT_, 6*KOL2_ ) ;
    elsIf FREQ_= 360 then  DATj_:=add_months(FDAT_,12*KOL2_ ) ;
    else                   DATj_:=DAT4k_    ;
    end if;
   -- DATj_:= cck.CorrectDate(gl.baseval, DATj_, DATj_+1);
    if DATj_< DAT4k_ then
       insert into TMP_GPK (FDAT,SUMG) values (DATj_,0);
       KOL2_:=KOL2_ + 1;
       DATi_:=DATj_;
    end if;
 end loop;

 -- ������ ��� ���� !
 LIM2_:= OST4_;

 if MODE_  = 1 then
    -- ������� ������ ����� �������
    DEL2_:= to_number( pul.Get_Mas_Ini_Val('DEL2_'));
    If DEL2_ is null then
       DEL2_:= round( LIM2_/KOL2_,0);  -- � ���.
       if DIG_ >0 then
          DEL2_:= round( (DEL2_/power(10,DIG_)) - 0.5, 0) * power(10,DIG_) ;
       end if;
    end if;

    update TMP_GPK set sumg=DEL2_, sumo=DEL2_;

    --������������ �� ���� ���������
    nTMP_:= LIM2_ - DEL2_*(KOL2_-1);
    If nTmp_>=0 then
       update TMP_GPK set sumg=nTMP_, sumo=nTMP_ where fdat=DAT4k_ ;
    else
       For k in (select fdat from TMP_GPK order by fdat desc)
       loop
          If nTmp_ <=0 then
             update TMP_GPK set sumg=0, sumo=0   where fdat=k.FDAT ;
             nTmp_:= nTmp_ + DEL2_;
          elsIf nTmp_ <> DEL2_ then
             update TMP_GPK set sumg=nTMP_, sumo=nTMP_ where fdat=k.FDAT;
             nTmp_:= DEL2_;
          end if;
       end loop;
    end if;

 elsif MODE_ =2 then
    --����� ������ � ����� �����
    update TMP_GPK set sumg=decode(fdat,DAT4k_,LIM2_,0)  where fdat>=DATNk_ ;

 else --- MODE_ = 3
    select count(*)-1 into KOL2_ from TMP_GPK;

    declare
       PV_ number := OST4_ ;         --  ������� ��������� = ����� �������
       FV_ number := 0         ;         --  ������� ���������=0
       r_  number := p_RATE/100 ; --  ������� % �� (����)
       n_  number := (DAT4k_-DATNk_)/365; --  ���� �������� (���)
       m_  number := (KOL2_)/n_;       --  ���-�� �������� � ����
       G_  number :=1 ; -- ����.�������� ����
       CF_ number ;                      --  �������� �������;
       SG_ number ;                      -- ����� �������
       SO_ number ;
       FDAT1_ date;
       SS_ number ;
       par1_ number;
       par2_ number;
       IRK_ number ;
       SKO_ number ;
       int_   number;
    BEGIN
       If BASEY_ =3  then G_  :=365/360; end if;

       IF Metr96_=96 then IRK_:= p_RKOM/100;
       else               IRK_:= 0;
       end if;

       r_   := r_ + IRK_;
       par1_:= r_ * G_/m_;
       par2_:= n_ * m_;
       CF_  := -cck.PMT1 ( par1_, par2_, PV_, FV_)  ;
       CF_  := trunc(CF_/power(10,DIG_)) * power(10,DIG_);

       FOR k in (select fdat from TMP_GPK where fdat>=DATNk_ order by fdat)
       LOOP
          SG_:=0; SO_:=0; SKO_:= 0;
          If k.FDAT > DATNk_ then

             -- �� ������ ���������� ����, ��������� %
             int_:= ROUND( calp(PV_, p_RATE, FDAT1_, k.fdat-1, basey_), 0);
             If IRK_>0 then
                SKO_:= ROUND( calp( PV_, p_RKOM, FDAT1_, k.fdat-1, basey_), 0);
             end if;

             If k.FDAT = Dtmp_ then
                -- ��������� ����
                SG_:= PV_; SO_:=PV_+int_+SKO_;
             ElsIf CF_ > (int_ + SKO_) then
                --������� ����. ���� % ������ ����� �����
                SG_:= CF_ - (int_+SKO_) ; SO_:=CF_ ;
             else
                --������� ����. ���� % ������= ����� �����
                SG_:= 0 ; SO_:=int_ + SKO_   ;
             end if;
             update TMP_GPK
                set sumg=SG_    ,
                    lim2=PV_-SG_,
                    sumk=SKO_   ,
                    sumo=SO_
              where fdat=k.FDAT;
          end if;
          FDAT1_ := k.FDAT;
          PV_:= PV_ - SG_;
          SS_:= SS_ + SG_;
       END LOOP;
    end ;
 end if;

 --��������� � ������

 S_:= OST4_; K_:=0;
 update TMP_GPK set lim2=S_,sumg=0,sumo=0, sumK=0 where fdat=DATNk_;

 for k in (SELECT FDAT,nvl(SUMG,0) G from TMP_GPK WHERE fdat>DATNk_ ORDER by 1)
 loop
    update TMP_GPK set LIM2= S_, SumO=Nvl(SumO,0) where fdat=k.FDAT;
    S_:= S_ - k.G;
 end loop;
 If S_>0 then
    update TMP_GPK set SumO=SumO+ S_, sumg =sumG+S_ where fdat=DAT4k_;
 end if;


  -- ��� ��� ����������� ��������
  LIM2_  := OST4_;
declare
--  nTMP_  number  ;            -- % �� ���� ������� ����
  INT_31 number  :=0;         -- % �� �� ������� �����
  INT_32 number  :=0;
  INT_   number  :=0;         -- % �� �� tek �����
  kom_   number  :=0;         -- �� �� tek �����
  IR_    number  ;
  KF_    number  ;
  SUMG_  number  ;
  SUMO_  number  ;
  SUMK_  number  ;
  DAT1_   date   :=to_date('01'||to_char(DATNk_,'MMYYYY'),'DDMMYYYY');
                   -- ������ ����� 01-MM-YYYY ������������ �������
  FDAT_   date   :=DATNk_ ;     -- ����.���� ��� ��� %
begin
----------------------------------
  IR_ := p_RATE;

  If    Metr96_= 95 and p_RKOM >0 then KOM_:= round( LIM2_*p_RKOM/100,0);
  elsIf Metr96_= 96 and p_RKOM >0 then IR_ := IR_ + p_RKOM; KF_:= p_RKOM /IR_;
  end if;

--���� �� �����
for k in (select FDAT, SUMG, nvl(sumo,sumg) SUMO, 1 GPK, to_char(fdat,'DD')+0 DD
          from tmp_gpk   where fdat > DATNk_
          union
          select add_months(DAT1_,num), 0, 0, 0, 1
          from conductor where NUM>0 and add_months(DAT1_,num) < DAT4k_
            and MODE2_='1'
          ORDER BY 1
          )
LOOP

   nTMP_:= ROUND( calp(LIM2_, IR_, FDAT_,k.FDAT-1, basey_), 0);
   --������� %
   if MODE2_='1' then /* --����� �� 01 ������, ���� ���� ������ */
      INT_  := INT_ + nTMP_;
      If k.DD=1 then
         INT_31:= INT_31 + INT_;
         INT_:= 0;
      end if;
   else
      INT_31:= INT_31 + nTMP_;
   end if;

   If k.GPK = 1 then
      if k.FDAT = DAT4k_ then
         -- ��������� ����
         INT_31:= INT_31 + INT_;
         INT_32:= greatest (INT_31,0);
         SUMG_ := LIM2_;
         SUMO_ := round(LIM2_ + INT_32,0);
      else
         INT_32:= greatest (INT_31,0);
         if MODE_ = 3 then
            --�������
            SUMO_:=round( greatest(least(LIM2_+INT_32,k.SUMO),INT_32),0);
            SUMG_:=round(SUMO_-INT_32, 0);
         else
            -- ��������
            SUMG_:=least(LIM2_,k.SUMG);
            SUMO_:=round(SUMG_+INT_32, 0);
         end if;
      end if;
      LIM2_:=greatest( LIM2_-SUMG_, 0);

      If Metr96_= 96 and p_RKOM > 0 then
         KOM_:= round( (SUMO_-SUMG_)*KF_,0);
         update tmp_gpk set lim2=LIM2_,sumg=SUMG_,sumo=SUMO_, SUMk=KOM_
             where fdat=k.FDAT;
      else
         update tmp_gpk set lim2=LIM2_,sumg=SUMG_,sumo=SUMO_+KOM_, SUMk=KOM_
                where fdat=k.FDAT;
      end if;

      INT_31:= 0; INT_32:= 0; nTmp_:=0;
   end if;

   FDAT_:=k.FDAT;

end loop;
--------
end ;

end P_GPK; 
/
show err;

PROMPT *** Create  grants  P_GPK ***
grant EXECUTE                                                                on P_GPK           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_GPK           to RCC_DEAL;
grant EXECUTE                                                                on P_GPK           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_GPK.sql =========*** End *** ===
PROMPT ===================================================================================== 
