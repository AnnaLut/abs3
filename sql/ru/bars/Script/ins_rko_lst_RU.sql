--==============================================================================
--
--  Cкрипт внесет в задачу "Плата за РО" тек.счета ЮЛ, которые в ней отсутствуют
--
--                               Для РУ !!!
--
--==============================================================================


Begin
  Execute immediate 'DROP trigger TU_ACCOUNTS_RKO' ;
End;
/



EXEC tuda;

Begin

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

End;
/

commit;


EXEC suda;

--=============================================================================
