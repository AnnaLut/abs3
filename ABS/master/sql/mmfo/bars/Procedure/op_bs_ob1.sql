CREATE OR REPLACE PROCEDURE BARS.OP_BS_OB1
( PP_BRANCH       varchar2
, P_BBBOO         varchar2 
) is
/*
 16.05.2017 - BAA: ���������� ��� �� ����� �������� ��������� PP_BRANCH
 26.10.2016 - BAA: ��22 �������� � ACCOUNTS
 27-06-2013 ��� ��� ���, ����� �����
    ����-�i���.���. �� ��+��22 ��� ������ 2,2+,3 �i���
    FunNSIEdit("[PROC=>OP_BSOBV(1,:V,:A,:B,'''','''',''''  )][PAR=>:A(SEM=������,REF=V_NBSOB22),:B(SEM=�����,REF=BRANCH_VAR)][MSG=>OK]")

 17-12-2012 Sta ��� ����������� ����� (���� ��� ��)
 03-11-2011 Sta ����������� ����.������ � CCK_AN_TMP
 03-11-2011 Sta  ������ commit
 30-09-2011    ������� �������� ������, ����� ������ DATE_CLOSED is null
 27-12-2010 ���� �� ���������, ������� ������� � ��������� OP_BMASK

 ����-�i���.���. �� ��+��22 ��� ������ 2,2+,3 �i���

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
      raise_application_error( -20666, '�������� ��� �������� '||PP_BRANCH||' �������� ������ ������!', true );
    end if;
  end if;
  
  kv_ := nvl( kv_, gl.baseval );
  
  execute immediate 'truncate table CCK_AN_TMP';
  
  for p in ( select branch 
               from branch
              where length(branch) in (15,22)
                and branch like PP_BRANCH
                and DATE_CLOSED is null )
  loop
    
    begin
      --  �.�. ��� ����
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
        -- ������������� � �������� �����
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

show err

grant EXECUTE on OP_BSOBV to BARS_ACCESS_DEFROLE;
