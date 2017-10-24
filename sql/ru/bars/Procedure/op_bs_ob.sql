

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BS_OB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BS_OB ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BS_OB (P_BBBOO varchar2 ) is

/*

 27-06-2013 Доб код вал, новый вызов
            Авто-вiдкр.рах. по БР+ОБ22 для всiх бранчiв 2
            FunNSIEdit("[PROC=>OP_BSOBV(0,:V,:A,'''','''','''','''')][PAR=>:A(SEM=ББББОО,REF=V_NBSOB22)][MSG=>OK]")

 03-11-2011 Sta запоминание откр.счетов в CCK_AN_TMP
 30-09-2011  Обходим закрытые бранчи, берем только DATE_CLOSED is null
 27-12-2010 МСКА ПО АЛГОРИТМУ, КОТОРЫЙ ВЫНЕСЕН В ПРОЦЕДУРУ OP_BMASK

 Авто-вiдкр.рах. по БР+ОБ22 для всiх бранчiв 2
 FunNSIEdit("[PROC=>OP_BS_OB(:sPar1)][PAR=>:sPar1(SEM=ББББОО,TYPE=S,REF=V_NBSOB22)][MSG=>OK OP_BS_OB!]")

*/

  NBS_  char(4)     := substr(P_BBBOO,1,4);
  OB22_ char(2)     := substr(P_BBBOO,5,2);
   acc_ int         ;
   nls_ varchar2(15);
   nms_ varchar2(38);
   kv_ int          ;
------------------------------------------------------------------------
begin

  execute immediate 'truncate TABLE CCK_AN_TMP';
  -------------
  kv_ := nvl ( to_number( pul.get_mas_ini_val ('OP_BSOB_KV') ), gl.baseval );

  for p in (select * from branch  where length(branch)=15 and DATE_CLOSED is  null and branch like '%'||f_ourmfo||'%' )
  loop
     --  м.б. уже есть
     begin
       select a.acc into  acc_ from accounts a,  specparam_int s
       where a.acc = s.acc and a.branch = p.BRANCH and a.nbs = NBS_ and s.ob22 = ob22_ and a.dazs is null and a.kv = KV_ and rownum=1 ;
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

end OP_BS_OB;
/
show err;

PROMPT *** Create  grants  OP_BS_OB ***
grant EXECUTE                                                                on OP_BS_OB        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_BS_OB        to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BS_OB.sql =========*** End *** 
PROMPT ===================================================================================== 
