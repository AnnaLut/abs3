

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SN8_8008.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SN8_8008 ***

  CREATE OR REPLACE PROCEDURE BARS.SN8_8008 ( BRANCH_ varchar2, DAT_ date)  IS
-- Ђвто-открытие счетов пени
--  BRANCH_ accounts.BRANCH%type :='/333368/';
--  DAT_ date := to_date('03-02-2009','dd-mm-yyyy') ;
  NLS_     accounts.NLS%type ;
  OSTC_    accounts.OSTC%type;
  ND_      cc_deal.ND%type       := -1 ;
  SPN_BRI  int                   := 100;
  NAM_BRI  BRATES.name%type      := '100.Обл.ст. НБУ (для пенi буде*2)' ;
  COM_BRI  PARAMS$BASE.comm%type := 'КП: Iд.баз.ставки для пенi';
  SPN_SD8  accounts.NLS%type     := '80060';
  COM_SD8  PARAMS$BASE.comm%type := 'КП:Рах. для облiку пенi';

  RET_  int;
  ACRA_ int;
  ACRB_ int;
begin

  bc.set_context;
  update brates set name= NAM_BRI where br_id=SPN_BRI;
  if SQL%rowcount=0  then
     Insert into BRATES (BR_ID, BR_TYPE, NAME) Values (SPN_BRI, 1, NAM_BRI);
  end if;

  bars_context.subst_branch(branch_);
  update PARAMS$BASE set val=SPN_BRI,comm=COM_BRI where par='SPN_BRI';
  if SQL%rowcount=0  then
     Insert into PARAMS$BASE (PAR,VAL,COMM) Values ('SPN_BRI',SPN_BRI,COM_BRI);
  end if;
  SPN_BRI := to_number(GetGlobalOption('SPN_BRI')) ; -- ЃазоваЯ ставка пени;

  SPN_SD8 := VKRZN(substr(gl.aMFO,1,5), SPN_SD8);
  update PARAMS$BASE set val=SPN_SD8,comm=COM_SD8 where par='SPN_SD8';
  if SQL%rowcount=0  then
     Insert into PARAMS$BASE (PAR,VAL,COMM) Values ('SPN_SD8',SPN_SD8,COM_SD8);
  end if;
  SPN_SD8 := GetGlobalOption('SPN_SD8') ;

  op_reg (99,0,0,null,RET_,gl.aRNK,SPN_SD8,980,COM_SD8,'SD8',null,ACRB_);
  op_reg (99,0,0,null,RET_,gl.aRNK,SPN_SD8,840,COM_SD8,'SD8',null,ACRB_);
  op_reg (99,0,0,null,RET_,gl.aRNK,SPN_SD8,978,COM_SD8,'SD8',null,ACRB_);
  op_reg (99,0,0,null,RET_,gl.aRNK,SPN_SD8,643,COM_SD8,'SD8',null,ACRB_);
/*
for k in (

select d.branch, d.nd, a.KV, a.ISP, a.GRP, a.nls, d.wdate, a.ACC
          from cc_deal d, nd_acc n, accounts a
          where d.sos<14 and n.nd=d.nd and a.tip in ('SP ','SPN','SK9')
            and a.acc=n.acc
            and d.vidd in (1,2,3,11,12,13)
            and a.ostc <0
            --and a.daos < DAT_
            --and not exists (select 1 from int_accn where acc=a.acc and id=2)
--and n.nd=8884

          )
loop
logger.info('S6: acc='||k.ACC);
   If ND_ <> k.ND then
      ND_ := k.ND ;
      
      delete from int_ratn where acc=k.acc and id=2;
      delete from int_accn where acc=k.acc and id=2;
      -- открыть счет пени
      NLS_:= VKRZN(substr(gl.aMFO,1,5),'80080'||substr(k.nls,6,9) );
      cck.cc_op_nls( k.ND, k.KV, NLS_, 'SN8', k.ISP, k.GRP,'1',k.wdate, ACRA_);
      If BRANCH_ <> k.BRANCH then
         update accounts set tobo=k.BRANCH where acc=ACRA_;
      end if;
   end if;

end loop;
*/
  commit;
  bc.set_context;
end SN8_8008;
/
show err;

PROMPT *** Create  grants  SN8_8008 ***
grant EXECUTE                                                                on SN8_8008        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SN8_8008.sql =========*** End *** 
PROMPT ===================================================================================== 
