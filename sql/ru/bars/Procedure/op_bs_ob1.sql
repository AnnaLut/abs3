

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BS_OB1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BS_OB1 ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BS_OB1 (PP_BRANCH varchar2,P_BBBOO varchar2 ) is


/*

 27-06-2013 Доб код вал, новый вызов
    Авто-вiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня
    FunNSIEdit("[PROC=>OP_BSOBV(1,:V,:A,:B,'''','''',''''  )][PAR=>:A(SEM=ББББОО,REF=V_NBSOB22),:B(SEM=Бранч,REF=BRANCH_VAR)][MSG=>OK]")

 17-12-2012 Sta Для Небранчевой схемы (типа ГОУ ОБ)
 03-11-2011 Sta запоминание откр.счетов в CCK_AN_TMP
 03-11-2011 Sta  Убрала commit
 30-09-2011    Обходим закрытые бранчи, берем только DATE_CLOSED is null
 27-12-2010 МСКА ПО АЛГОРИТМУ, КОТОРЫЙ ВЫНЕСЕН В ПРОЦЕДУРУ OP_BMASK

 Авто-вiдкр.рах. по БР+ОБ22 для бранчу 2,2+,3 рiвня

*/

  NBS_  char(4)    := substr(P_BBBOO,1,4);
  OB22_ char(2)    := substr(P_BBBOO,5,2);
  acc_  number     ;
  nls_ varchar2(15);
  nms_ varchar2(38);
  kv_ int          ;
------------------------------------------------------------------------
begin

  kv_ := nvl ( to_number( pul.get_mas_ini_val ('OP_BSOB_KV') ), gl.baseval );

  If GetGlobalOption('HAVETOBO') = '2' then   EXECUTE IMMEDIATE  'begin  tuda;  end; ';  end if;

  execute immediate 'truncate TABLE CCK_AN_TMP';

for p in (select branch from branch  where length(branch) in (15,22)  and branch like PP_BRANCH    and DATE_CLOSED is  null )
loop
   --  м.б. уже есть
   begin
     select a.acc into  acc_ from accounts a,  specparam_int s
     where a.acc=s.acc and a.branch=p.BRANCH and a.nbs = NBS_ and s.ob22=ob22_ and a.dazs is null and a.kv = kv_ and rownum=1 ;
     GOTO nexrec1;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
   end;

   OP_BMASK (P.BRANCH, NBS_, OB22_, null, null, null, NLS_, ACC_);

   -- дополнительно к открытию счета
   update accounts      set tobo = p.branch where acc=ACC_ ;
   update specparam_int set ob22 = OB22_ where acc=ACC_ ;
   if SQL%rowcount = 0 then
      insert into specparam_int (acc, ob22) values (ACC_,OB22_);
   end if;
   ---------------------------
   <<nexrec1>> null;
   ----------------------------
  end loop;
--  commit;

end OP_BS_OB1;
/
show err;

PROMPT *** Create  grants  OP_BS_OB1 ***
grant EXECUTE                                                                on OP_BS_OB1       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_BS_OB1       to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BS_OB1.sql =========*** End ***
PROMPT ===================================================================================== 
