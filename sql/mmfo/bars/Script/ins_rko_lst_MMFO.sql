--==============================================================================
--
--  Cкрипт внесет в задачу "Плата за РО" счета ЮЛ, которые в ней отсутствуют
--
--                               Для MMFO !!!
--
--==============================================================================


Begin
  Execute immediate 'DROP trigger TU_ACCOUNTS_RKO' ;
End;
/




Begin

 FOR x in ( Select KF from MV_KF )

 LOOP

   bc.go(x.KF);

   For k in ( SELECT ACC, NLS, NMS 
              from   Accounts 
              where  KV=980 and DAZS is NULL                     and
                     NBS in ('2600','2603','2604','2650')        and      
                     ACC not in (Select ACC from RKO_LST)        and 
                     DAOS >= to_date('12/12/2017','dd/mm/yyyy')
            )
   Loop
     INSERT INTO rko_lst (ACC) values (k.ACC);
   End Loop;

   Commit;
 
 END LOOP;

End;
/

commit;

