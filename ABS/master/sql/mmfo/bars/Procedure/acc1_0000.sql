

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ACC1_0000.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ACC1_0000 ***

  CREATE OR REPLACE PROCEDURE BARS.ACC1_0000 
  (p_branch varchar2, Id_ int, dat_ date,  S_ number ) is
-- отображение приращения одного показателя (любого из BS0 )
-- на внесистемном счете типа 0000kBBBBIIII
   acc_ accounts.ACC%Type;
   nls_ accounts.NLS%Type;
   nms_ accounts.NMS%Type;
   kos_ accounts.KOS%Type;
   branchN_ accounts.BRANCH%type;
   branchO_ accounts.BRANCH%type;
   BBBB_ char(4)         ;
   kol_ int := 0;
   gl_bdate date;
begin
   If S_ <0 or length(p_branch) <>22 then RETURN; end if;
   -----------------------------
   BranchN_ := p_branch ;
   BBBB_    := substr ( substr(BRANCHn_,-5), 1,4) ;
   nls_     := '0000' || '0' || BBBB_  || Abs(id_);
--logger.info('AAAA 1:' ||p_branch ||', '||Id_ ||', '|| dat_ || ' , '||  S_
--||' ' || BBBB_ || ' '|| nls_);
   nls_     := vkrzn (substr(gl.amfo,1,5), nls_);
   begin
     select acc, branch into  acc_, brancho_  from accounts
     where kv=gl.baseval and nls=NLS_ and nbs is null;
     begin
       select kos into KOL_ from saldoa  where acc=ACC_ and fdat=DAT_;
     EXCEPTION WHEN NO_DATA_FOUND THEN  kol_:=0;
     end;
   EXCEPTION WHEN NO_DATA_FOUND THEN
     acc_ := bars_sqnc.get_nextval('s_accounts');
     select substr(name,1,70) into nms_ from bs0 where nrep=2 and id=ID_;
     brancho_ := branchN_;
     INSERT INTO ACCOUNTS (rnk,ACC ,KV ,NLS , PAP, nms , daos, vid, pos, tobo    )
                    VALUES(1  ,ACC_,980,NLS_,   2, nms_, DAT_, 0  , 1  , branchn_);
   end;
   kos_:= - KOl_  + S_;
   begin
      gl_bdate := gl.bdate;
      gl.bdate := DAT_;

      update accounts set ostc=ostc+KOS_ where acc=ACC_;

      update saldoa   set dos=0, kos = S_ where acc = ACC_ and fdat=DAT_;

      If brancho_ <> branchn_ then
         update accounts set tobo=branchn_ where acc=ACC_;
      end if;

      gl.bdate := gl_bdate;

   EXCEPTION WHEN OTHERS THEN

      gl.bdate := gl_bdate;

      raise_application_error(-(20203), '\     Ош.acc1_0000'
             || ': branch=' || branchn_
             || ', Id='     || id_
             || ', dat='    || dat_
             || ' ' || SQLERRM,  TRUE);
   end;

end ACC1_0000;
/
show err;

PROMPT *** Create  grants  ACC1_0000 ***
grant EXECUTE                                                                on ACC1_0000       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ACC1_0000       to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ACC1_0000.sql =========*** End ***
PROMPT ===================================================================================== 
