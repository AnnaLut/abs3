--==============================================================================
--
--  Cкрипт внесет в задачу "Плата за РО" тек.счета ЮЛ, которые в ней отсутствуют
--  и открыты после 01/12/2016
--
--==============================================================================

EXEC bc.go(300465);

Begin

 For k in ( SELECT ACC, NLS, NMS 
            from   Accounts 
            where  KV=980 and  DAZS is NULL    and
                   NBS in ('2600','2603','2604','2650') and      
                   ACC not in (Select ACC from RKO_LST) and 
                   RNK not in (Select nvl(RNK,-1) from RNKP_KOD) and 
                   DAOS >= to_date('01/12/2016','dd/mm/yyyy')
          )
 Loop
   INSERT INTO rko_lst (ACC) values (k.ACC);
 End Loop;

End;
/

commit;


EXEC bc.home;

--=============================================================================
