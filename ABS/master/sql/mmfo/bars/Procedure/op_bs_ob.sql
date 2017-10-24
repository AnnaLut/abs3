create or replace procedure BARS.OP_BS_OB
( P_BBBOO varchar2 )
is
/*
 06.07.2016 Sta Переделала specparam_int        ->      Accreg.setAccountSParam(aa.acc, 'OB22', aa.ob22) ;
 FunNSIEdit("[PROC=>OP_BS_OB(:sPar1)][PAR=>:sPar1(SEM=ББББОО,TYPE=S,REF=V_NBSOB22)][MSG=>OK OP_BS_OB!]")
*/
  aa accounts%rowtype;
------------------------------------------------------------------------
begin
  
  bars_audit.trace( $$PLSQL_UNIT||': Entry with P_BBBOO='||P_BBBOO );
  
  aa.NBS  := substr(P_BBBOO,1,4);
  aa.OB22 := substr(P_BBBOO,5,2);
  aa.kv   := nvl ( to_number( pul.get_mas_ini_val ('OP_BSOB_KV') ), gl.baseval );
  aa.kv   := nvl ( aa.kv, 980 );
  
  bars_audit.trace( $$PLSQL_UNIT||': nbs='||aa.NBS||', OB22='||aa.OB22||', KV='||to_char(aa.kv) );
  
  for p in ( select BRANCH
               from BARS.BRANCH
              where BRANCH like '/'||gl.aMfo||'/______/'
                and DATE_CLOSED is null )
  loop
    begin
      -- м.б. уже есть
      select * 
        into aa 
        from accounts 
       where branch = p.BRANCH 
         and nbs  = aa.nbs 
         and ob22 = aa.ob22 
         and kv   = aa.kv 
         and dazs is null 
         and rownum = 1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN  
        OP_BMASK( P.BRANCH, aa.NBS, aa.OB22, null, null, null, aa.NLS, aa.ACC );
        -- Accreg.setAccountSParam(aa.acc, 'OB22', aa.ob22);
        update BARS.ACCOUNTS 
           set TOBO = p.branch
             , OB22 = aa.ob22
         where ACC  = aa.ACC;
    end;
  end loop;
  
  bars_audit.trace( $$PLSQL_UNIT||': Exit.' );
  
end OP_BS_OB;
/

show err;

grant EXECUTE on OP_BSOBV to BARS_ACCESS_DEFROLE;
