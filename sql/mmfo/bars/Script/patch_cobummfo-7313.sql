SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET APPINFO      ON

exec bars.bc.home;

prompt -- ===================
prompt -- == COBUMMFO-7313 ==
prompt -- ===================

merge
 into PRVN_FIN_DEB t
using ( select fd.ACC_SS
          from PRVN_FIN_DEB fd
          join ACCOUNTS ac
            on ( ac.ACC = fd.ACC_SP )
          join ( select substr(NBS_N,1,4) as R020
                      , substr(NBS_N,5,2) as OB22
                   from FIN_DEBT
               ) ob
            on ( ob.R020 = ac.NBS and ob.OB22 = ac.OB22 )
         where fd.ACC_SS = fd.ACC_SP
       ) s
    on ( s.ACC_SS = t.ACC_SS )
  when MATCHED
  then update set t.ACC_SP = null;

commit;
