
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/snp.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SNP IS
----------------------------------------------------------------------
 VSTN_ number; -- обычный вх.остаток за дату в ном
 VSTQ_ number; -- обычный вх.остаток за дату в экв
 DOSN_ number; -- обычный дебет  за дату в ном
 DOSQ_ number; -- обычный дебет  за дату в экв
 KOSN_ number; -- обычный кредит за дату в ном
 KOSQ_ number; -- обычный кредит за дату в экв
 OSTN_ number; -- обычный исх.остаток за дату в ном
 OSTQ_ number; -- обычный исх.остаток за дату в экв

 VSMN_ number; -- вх.остаток с Корр за мес в ном
 VSMQ_ number; -- вх.остаток с Корр за мес в экв
 DOMN_ number; -- дебет  с Корр за мес в ном
 DOMQ_ number; -- дебет  с Корр за мес в экв
 KOMN_ number; -- кредит с Корр за мес в ном
 KOMQ_ number; -- кредит с Корр за мес в экв
 OSMN_ number; -- исх.остаток с Корр за мес в ном
 OSMQ_ number; -- исх.остаток с Корр за мес в экв

 ACC_OLD int ;
 DI_OLD  int ;
 ZO_OLD  int ;
-------------
FUNCTION IDAT (p_DAT date, p_MODE char DEFAULT 'M')  return int
 result_cache;
-------------
Function FOST
( ACC_    in  int,
  DI_     in  int,
  ZO_     in  int,
  MOD_    in  int
) return number;

END SNP;
/
CREATE OR REPLACE PACKAGE BODY BARS.SNP IS

FUNCTION IDAT (p_DAT date, p_MODE char DEFAULT 'M')  return int result_cache is
  nTmp_ int ;
  dTmp_ date;
begin

  If    p_MODE ='M'  then dTmp_ := trunc( p_DAT, 'mm'  );
  ElsIf p_MODE ='Y'  then dTmp_ := trunc( p_DAT, 'YYYY');
  else
    select max(fdat) into dTmp_ from fdat where fdat<=p_DAT;
  end if;

  select caldt_id into nTmp_ from ACCM_CALENDAR where caldt_date =dTmp_;

  RETURN nTmp_;
end;
------------------

Function FOST
( ACC_    in  int,
  DI_     in  int,
  ZO_     in  int,
  MOD_    in  int
) return number is

 nn_  NUMBER :=0;
 di2_ DATE   := TO_DATE (DI_ + 2447892, 'J');

begin

  If ACC_=SNP.ACC_OLD and DI_=SNP.DI_OLD and ZO_=SNP.ZO_OLD then
     null;
  else
     SNP.ACC_OLD:=ACC_;
     SNP.DI_OLD :=DI_ ;
     SNP.ZO_OLD :=ZO_ ;

     If ZO_ = 0 then
        -- обычный день
        begin
           select   OST  ,    OSTQ ,    DOS  ,    DOSQ ,    KOS  ,    KOSQ
           into SNP.OSTN_,SNP.OSTQ_,SNP.DOSN_,SNP.DOSQ_,SNP.KOSN_,SNP.KOSQ_
           from SNAP_BALANCES
           where acc=ACC_ and fdat=di2_;
           SNP.VSTN_ := SNP.OSTN_ + SNP.DOSN_ - SNP.KOSN_;
           SNP.VSTQ_ := SNP.OSTQ_ + SNP.DOSQ_ - SNP.KOSQ_;
        exception when no_data_found then
           SNP.OSTN_:=0; SNP.OSTQ_:=0; SNP.DOSN_:=0; SNP.DOSQ_:=0;
           SNP.KOSN_:=0; SNP.KOSQ_:=0; SNP.VSTN_:=0; SNP.VSTQ_:=0;
        end;
     else
        -- отчетны день с ЗО
        begin
           select ost + CRkos-CRdos, ostQ + CRkosQ-CRdosQ,
                  DOS + CRDos-CuDos, DOSQ + CRDosQ-CuDosQ,
                  KOS + CRKos-CuKos, KOSQ + CRKosQ-CuKosQ
           into SNP.OSMN_,SNP.OSMQ_, SNP.DOMN_,SNP.DOMQ_, SNP.KOMN_,SNP.KOMQ_
           From  AGG_MONBALS
           where acc=ACC_ and fdat=Di2_;
           SNP.VSMN_ := SNP.OSMN_ + SNP.DOMN_ - SNP.KOMN_;
           SNP.VSMQ_ := SNP.OSMQ_ + SNP.DOMQ_ - SNP.KOMQ_;
        exception when no_data_found then
           SNP.OSMN_:=0; SNP.OSMQ_:=0; SNP.DOMN_:=0; SNP.DOMQ_:=0;
           SNP.KOMN_:=0; SNP.KOMQ_:=0; SNP.VSMN_:=0; SNP.VSMQ_:=0;
        end;

     end if;

  end if;

     If zo_ = 0 then

           If Mod_ = 1 then
              NN_ := snp.VSTN_; -- обычный вх.остаток за дату в ном
        elsIf Mod_ = 2 then
              NN_ := snp.VSTQ_; -- обычный вх.остаток за дату в экв
        elsIf Mod_ = 3 then
              NN_ := snp.DOSN_; -- обычный дебет  за дату в ном
        elsIf Mod_ = 4 then
              NN_ := snp.DOSQ_; -- обычный дебет  за дату в экв
        elsIf Mod_ = 5 then
              NN_ := snp.KOSN_; -- обычный кредит за дату в ном
        elsIf Mod_ = 6 then
              NN_ := snp.KOSQ_; -- обычный кредит за дату в экв
        elsIf Mod_ = 7 then
              NN_ := snp.OSTN_; -- обычный исх.остаток за дату в ном
        elsIf Mod_ = 8 then
              NN_ := snp.OSTQ_; -- обычный исх.остаток за дату в экв
        end if;


  elsIf ZO_ = 1 then

           If Mod_ = 1 then
              NN_ := snp.VSMN_; -- вх.остаток с ЗО за мес в ном
        elsIf Mod_ = 2 then
              NN_ := snp.VSMQ_; -- вх.остаток с ЗО за мес в экв
        elsIf Mod_ = 3 then
              NN_ := snp.DOMN_; -- дебет  с ЗО за мес в ном
        elsIf Mod_ = 4 then
              NN_ := snp.DOMQ_; -- дебет  с ЗО за мес в экв
        elsIf Mod_ = 5 then
              NN_ := snp.KOMN_; -- кредит с ЗО за мес в ном
        elsIf Mod_ = 6 then
              NN_ := snp.KOMQ_; -- кредит с ЗО за мес в экв
        elsIf Mod_ = 7 then
              NN_ := snp.OSMN_; -- исх.остаток с ЗО за мес в ном
        elsIf Mod_ = 8 then
              NN_ := snp.OSMQ_; -- исх.остаток с ЗО за мес в экв
        end if;

  end if;

  RETURN nn_;

end;

END SNP;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/snp.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 