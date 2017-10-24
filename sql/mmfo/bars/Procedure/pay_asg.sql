

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_ASG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_ASG ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_ASG 
  (flg_  int,
   ref_  int,
   dk_   in out int,
   nlsm_ varchar2,
   KV_   int,
   nlsk_ in out varchar2,
   KVK_  int,
   datv_ date,
   SS_   number,
   SA_   number ) is

 -- версия от 11.02.2005

 Dnls_   varchar2(15) ;
 Dnls1_  varchar2(15) ;
 sNLSG_  varchar2(15) ;
 dTip_   char(3)      ;
 dkv_    int          ;
 kACC_   int          ;
 ISP_    int          ;
 GRP_    int          ;
 dACC_   int          ;
 DS_     number       ;
 OS_     number       ;
 dz_     varchar2(160);
 i_      int          ;
 cc_id_  varchar2(20) ;
 cc_dat_ date         ;
 TT_ASG_ char(3)      ;

 sLike1_ varchar2(160):=
         'В_дсотки за користування позикою зг_дно кредитно_ угоди №%';
 sLike2_ varchar2(160):=
         'Сплата боргу за користування позикою зг_дно кредитно_ угоди №%';
 sLike3_ varchar2(160):=
         'Сплата боргу за кредит зг_дно договору №%';

   ern    CONSTANT POSITIVE := 203;
   erm    VARCHAR2(180);
   err    EXCEPTION;


begin

begin

  select nazn, tt into dz_,TT_ASG_ from oper where ref=ref_;

  if dk_ in (0,1) then

     if    dk_ =1 then dnls_:= nlsk_; dnls1_:= nlsm_; dkv_:=kvk_ ; DS_:=SS_ ;
     elsif dk_ =0 then dnls_:= nlsm_; dnls1_:= nlsk_; dkv_:=kv_  ; DS_:=SA_ ;
     end if;

     select d.tip, k.ACC, d.ACC
     into  dTip_, kACC_ , dACC_
     from accounts k, accounts d
     where k.tip ='ASG' and  k.kv=dkv_  and  k.nls=dnls_
                        and  d.kv=dkv_  and  d.nls=dnls1_ ;

     if dTip_ = 'T00' and dkv_=gl.baseval and DK_=1 and
        dnls_ like '22%'   then
        --подмена счета 22%(ASG) на 2909(ASG) в ответных СЭП
        nlsk_:='290931118';
        dnls_:=nlsk_ ;
        insert into NLK_REF( REF1, ACC )
        select REF_,acc from accounts where kv=dKV_ and nls= nlsk_;
        return;
     end if;

     if dTip_='ASG' and (dACC_<>kACC_ or TT_ASG_<>'ASG')   then
        update oper set sos=5, dk=dk+2 where ref=REF_;
        dk_ := dk_ +2;
        return;
     end if;
     i_ := instr(dz_,'№');
     If dz_ NOT like sLike1_  and
        dz_ NOT like sLike2_  and
        dz_ NOT like sLike3_  OR
        I_ < 30   then
        insert into NLK_REF( REF1, ACC ) values (REF_, kACC_);
        return;
     end if;
--erm := '9351 - TEST:'||dTip_||','|| kACC_||' ,'|| dACC_;
--raise err;
     dz_:= substr(dz_, i_+1); i_ := instr (dz_,'в'||chr(179)||'д');

     if i_ >1 then
        begin
          cc_id_  := trim(substr(dz_, 1, i_-1) );
          -- вычленям дату
          begin
             cc_dat_ := to_date(substr(dz_,i_+4,10), 'dd-mm-yyyy');
          exception when others then
             erm := '9351 - Ошибка даты. Кр.дог.НЕ НАЙДЕН: №'||CC_ID_;
             raise err;
          end;
          select c.nd into i_ from cc_deal c, cc_add a
          where c.cc_id=CC_ID_ and c.nd=a.nd
            and (c.sdate=CC_DAT_ or
                 c.sdate=dat_next_u(CC_DAT_,-1) or  a.wdate=CC_DAT_)
            and vidd=11 and sos<15 ;

          for k in (select a.nls, (-a.ostb-a.ostf)  OSTB
                    from accounts a, nd_acc n
                    where a.ostc<0 and a.acc=n.acc and n.nd=i_
                      and a.tip in ('SS ','SN ','SP ','SPN','SL ','SLN')
                      and a.kv=dkv_
                    order by decode(a.TIP, 'SLN',1,
                                           'SL ',2,
                                           'SPN',3,
                                           'SP ',4,
                                           'SN ',5,
                                            6)
                   )
          loop
             if ds_>0 then  os_:= least( ds_, k.ostb); ds_:=ds_ - os_;
                gl.payv(flg_,ref_,pul.NEXT_BDATE,'ASG',0,dkv_,k.nls,os_,dkv_,dnls_,os_);
             end if;
          end loop;
          if ds_>0 then
             -- переплата
             begin
               --ищем счет гашения
               SELECT a.nls  INTO sNLSG_
               FROM accounts a, nd_acc n
               WHERE  a.tip = 'SG '  and a.kv  = dkv_  and a.acc = n.acc
                  and n.nd  = i_     and a.dazs is null;
             EXCEPTION WHEN NO_DATA_FOUND THEN
               --откр.счет гашения по основному счету
               select VKRZN(substr(gl.aMFO,1,5),'29090'||substr(nls,6,9) ),
                      isp, grp
               into sNLSG_ , ISP_, GRP_
               from accounts a, nd_acc n
               where  a.tip = 'SS '
                  and a.kv  = dkv_
                  and a.acc = n.acc
                  and n.nd  = i_
                  and a.dazs is null and rownum=1;
               cck.CC_OP_NLS(i_,dkv_,sNLSG_,'SG ',ISP_,GRP_,'1',null,kACC_);
             end;
             --зачисляем перепрату
             gl.payv(flg_,ref_,pul.NEXT_BDATE,'ASG',0,dkv_,sNLSG_,ds_,dkv_,dnls_,ds_);
          end if;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
               erm := '9351 - Кр.дог.НЕ НАЙДЕН: №'||
                      CC_ID_ ||' от '|| to_char(CC_DAT_,'dd/mm/yyyy');
               RAISE err;
          WHEN TOO_MANY_ROWS THEN
               erm := '9351 - Кр.дог.БОЛЬШЕ ОДНОГО:№'||
                       CC_ID_ ||' от '|| to_char(CC_DAT_,'dd/mm/yyyy');
               RAISE err;
        end;
     end if;
  end if;
EXCEPTION WHEN NO_DATA_FOUND THEN null;
end;

EXCEPTION
   WHEN err THEN
      raise_application_error(-(20000+ern),'\' ||erm,TRUE);
   WHEN OTHERS THEN
      raise_application_error(-(20000+ern),SQLERRM,TRUE);
end pay_ASG;
------------------------
/
show err;

PROMPT *** Create  grants  PAY_ASG ***
grant EXECUTE                                                                on PAY_ASG         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_ASG.sql =========*** End *** =
PROMPT ===================================================================================== 
