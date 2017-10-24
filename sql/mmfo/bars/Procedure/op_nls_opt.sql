

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_NLS_OPT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_NLS_OPT ***

  CREATE OR REPLACE PROCEDURE BARS.OP_NLS_OPT (DAT_ date) is
-- 06.07.2016 Sta specparam_int        ->      Accreg.setAccountSParam(aa.acc, 'OB22', aa.ob22) ;

--оптовое открытие ЛС

--Структура рахунку: 3739 К 03 ММММММ,
--де ММММММ - код банку балансової установи Ощадбанку.
--Рахунки в_дкриваються на RNK в_дпов_дного рег_онального управл_ння.
--Найменування рахунку - найменування балансової установи Ощадбанку.
--Валюта - гривня.
ISP_   accounts.ISP%type       := 170; -- исполнитель
GRP_   accounts.ISP%type       := 31 ; -- группа доступа
mfo_   bank_acc.MFO%type       :='999984'; --MFO
OB22_  accounts.OB22%type :='09'; --OB22
S180_  SPECPARAM.s180%type     :=5   ;
S240_  SPECPARAM.s240%type     :=5   ;
IDG_   SPECPARAM.idg%type      :=5   ;
IDS_   SPECPARAM.ids%type      :=3739;
SPS_   SPECPARAM.sps%type      :=763 ;
ret_ int;
acc_ accounts.ACC%type ;
nls_ accounts.NLS%type ;
begin

  for k in (select decode(b.mfop,gl.amfo,b.mfo, b.mfop) RU, b.mfo, b.nb, a.rnk
            from banks b, accounts a, bank_acc ba
            where b.mfou=gl.amfo and b.blk=0 and b.mfo<>gl.amfo
              and ba.mfo=decode(b.mfop,gl.amfo,b.mfo, b.mfop)
              and ba.acc=a.acc and a.kv=980 and a.tip='L00'
            order by 1,2
            )
  loop

     nls_:= vkrzn( substr(gl.aMFO,1,5), '3739003'||k.MFO ) ;
     op_reg(9,0,0, GRP_, ret_, k.rnk, nls_, 980, k.NB, 'ODB', isp_, acc_);
     Accreg.setAccountSParam( acc_, 'OB22', ob22_) ;

     update SPECPARAM set s180=S180_, S240=s240_, IDG=idg_, IDS=IDS_,SPS=SPS_
            where acc=ACC_;
     if SQL%rowcount = 0 then
        insert into SPECPARAM (acc,s180, S240, IDG, IDS,SPS)
            values (ACC_,s180_,S240_,IDG_,IDS_,SPS_) ;
     end if;

     update BANK_ACC set mfo=mfo_
            where acc=ACC_;
     if SQL%rowcount = 0 then
        insert into BANK_ACC (acc,mfo)
            values (ACC_,mfo_) ;
     end if;

  end loop;

  commit;

end OP_NLS_OPT;
/
show err;

PROMPT *** Create  grants  OP_NLS_OPT ***
grant EXECUTE                                                                on OP_NLS_OPT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_NLS_OPT      to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_NLS_OPT.sql =========*** End **
PROMPT ===================================================================================== 
