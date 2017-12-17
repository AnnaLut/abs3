SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

update DPU_VIDD
   set TERM_MAX = case  
                  when TERM_TYPE = 1
                  then TERM_MIN 
                  else case 
                       when TERM_MIN >= 1 
                       then case when DPU_TYPE = 2 then 36 else 12 end
                       else case when DPU_TYPE = 2 then 0.1095 else 0.365 end
                       end
                  end
 where TERM_MAX < TERM_MIN
   and FLAG = 1;

commit;

update DPU_TYPES_OB22
   set ( NBS_DEP, OB22_DEP ) = ( select R020_NEW, OB_NEW from TRANSFER_2017 where R020_OLD = NBS_DEP and OB_OLD = OB22_DEP )
 where ( NBS_DEP, OB22_DEP ) in ( select R020_OLD, OB_OLD from TRANSFER_2017 );

commit;

delete DPU_TYPES_OB22
 where ( NBS_DEP, OB22_DEP ) in ( select R020, OB22 from SB_OB22 where D_CLOSE Is Not Null );

commit;
