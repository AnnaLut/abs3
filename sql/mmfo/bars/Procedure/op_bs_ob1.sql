prompt ---------------------------------------------------------------
prompt 12. function PROCEDURE BARS.OP_BS_OB1
prompt ---------------------------------------------------------------

CREATE OR REPLACE PROCEDURE BARS.OP_BS_OB1
( PP_BRANCH       varchar2
, P_BBBOO         varchar2
) is
/*
 16.05.2017 - BAA: прикидаємся МФО на основі значення параметру PP_BRANCH
 26.10.2016 - BAA: ОБ22 переїхало в ACCOUNTS
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
  NBS_  char(4) := substr(P_BBBOO,1,4);
  OB22_ char(2) := substr(P_BBBOO,5,2);
  acc_  number;
  nls_  varchar2(15);
  nms_  varchar2(38);
  kv_   int;
begin

  bars_audit.trace( $$PLSQL_UNIT||': Entry with ( PP_BRANCH=%s, P_BBBOO=%s ).', PP_BRANCH, P_BBBOO );

  kv_ := to_number( PUL.GET_MAS_INI_VAL('OP_BSOB_KV') );

  if ( gl.aMFO Is Null )
  then
    bars_context.subst_mfo( bars_context.extract_mfo( PP_BRANCH ) );
  else
    if ( gl.aMFO <> BC.EXTRACT_MFO( PP_BRANCH ) )
    then
      raise_application_error( -20666, 'Вказаний код підрозділу '||PP_BRANCH||' належить іншому філіалу!', true );
    end if;
  end if;

  kv_ := nvl( kv_, gl.baseval );

  ------execute immediate 'truncate table CCK_AN_TMP';

  for p in ( select branch
               from branch
              where length(branch) in (15,22)
                and branch like PP_BRANCH
                and DATE_CLOSED is null )
  loop

    begin
      --  м.б. уже есть
      select a.ACC
        into acc_
        from ACCOUNTS a
       where a.branch = p.BRANCH
         and a.nbs    = NBS_
         and a.ob22   = ob22_
         and a.kv     = kv_
         and a.dazs is null
         and rownum = 1;
    exception
      when NO_DATA_FOUND THEN
        OP_BMASK( p.BRANCH, NBS_, OB22_, null, null, null, NLS_, ACC_ );
        -- дополнительно к открытию счета
        update BARS.ACCOUNTS
           set TOBO = p.BRANCH
             , OB22 = OB22_
         where ACC  = ACC_;
    end;

  end loop;

  -- commit;

  bars_audit.trace( $$PLSQL_UNIT||': Exit.' );

end OP_BS_OB1;
/
SHOW ERR;
