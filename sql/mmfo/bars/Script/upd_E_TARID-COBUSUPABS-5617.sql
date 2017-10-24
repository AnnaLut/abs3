BEGIN
update BARS.E_TARIF set npd_3570=Replace(npd_3570, ':R_DATE', ':F_DATE'),
                        npk_3570=Replace(npk_3570, ':R_DATE', ':F_DATE'),
                        npd_3579=Replace(npd_3579, ':R_DATE', ':F_DATE'),
                        npk_3579=Replace(npk_3579, ':R_DATE', ':F_DATE')  
       where id in (4301,4302,4303)
         and fl1 =1;
END;
/

COMMIT;