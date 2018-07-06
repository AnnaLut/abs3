begin EXECUTE IMMEDIATE 'alter table bars.cck_ob22 add ( SNA CHAR(6) ) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.CCK_OB22.SNA  IS 'БС+Об22~для Невизнаних рах.SNA';

update CCK_OB22 set SNA = case   when NBS like '150_'  then '150907'
                                 when NBS like '152_'  then '152915'
                                 when NBS like '202_'  then '202915'
                                 when NBS like '203_'  then '203911'
                                 when NBS like '206_'  then '206973'
                                 when NBS like '207_'  then '207936'
                                 when NBS like '208_'  then '208939'
                                 when NBS like '210_'  then '210923'
                                 when NBS like '211_'  then '211924'
                                 when NBS like '212_'  then '212939'
                                 when NBS like '213_'  then '213939'
                                 when NBS like '220_'  then '2209J1'
                                 when NBS like '223_'  then '223970'
                                 when NBS like '2043'  and   ob22 = '01' then '204917'
                                 when NBS like '2043'  and   ob22 = '03' then '204917'
                                 when NBS like '2043'  and   ob22 = '05' then '204917'
                                 when NBS like '2043'  and   ob22 = '07' then '204917'
                                 when NBS like '2044'  and   ob22 = '01' then '204918'
                                 when NBS like '2044'  and   ob22 = '03' then '204918'
                                 when NBS like '2045'  and   ob22 = '01' then '204916'
                                 when NBS like '2140'  and   ob22 = '01' then '214913'
                                 when NBS like '2141'  and   ob22 = '01' then '214915'
                                 when NBS like '2142'  and   ob22 = '01' then '214914'
                                 when NBS like '2143'  and   ob22 = '01' then '214916'
                                 when NBS like '2240'  and   ob22 = '01' then '224907'
                                 when NBS like '2243'  and   ob22 = '01' then '224908'
                                 Else                        Substr (NBS,1,3) || '9'
                          end ;
commit;
---****************************************--------------------------------------------------------------------
