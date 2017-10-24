

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAZS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_DAZS ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_DAZS 
   BEFORE UPDATE OF DAZS ON BARS.ACCOUNTS
FOR EACH ROW
declare
  l_active   number(1);
BEGIN
  /*
  -- 12.11.2015 BAA - Заборона реанімувати рахунок, що належить закритому картковому договору
  --
  -- 10.02.2015 BAA - Заборона закривати рах. 2625 за наявності залишків на інших рахунках договору БПК
  --
  -- 19.11.2013 BAA - Заборона реанімувати рахунки депозитних портфелів!
  --
  -- 29-08-2011 STA - т.к. снапы стали чувствительными к датам DAPP, DAPPQ, DAZS
  --                  то такой триггер не допустит их несоответствия
  */

  IF (:NEW.dazs is Not Null)
  THEN -- закриття захунка
    
    If (:new.dapp >= :NEW.dazs)
    Then
      raise_application_error( -20444, ' Рах.' || :new.nls  || ' вал.'|| :new.kv ||
                                       ' Дата остан.руху '  || to_char(:new.dapp,'dd.mm.yyyy') || ' >=' ||
                                       ' Датi закриття '    || to_char(:NEW.dazs,'dd.mm.yyyy') );
    End if;
    
    If (:new.kv <> gl.baseval and :new.dappQ >= :NEW.dazs)
    Then
      raise_application_error( -20444, ' Рах.' || :new.nls   || ' вал.'|| :new.kv ||
                                       ' Дата остан.переоц.' || to_char(:new.dappQ,'dd.mm.yyyy') || ' >=' ||
                                       ' Датi закриття '     || to_char(:NEW.dazs, 'dd.mm.yyyy') );
    End if;
    
    If (SubStr(:new.TIP,1,2) = 'W4')
    Then -- заборонено закривати рахунок 2625, якщо по договору існують рахунки із залишком
      
      with acnt as ( select acc_id 
                       from ( select ACC_OVR, ACC_9129, ACC_3570, ACC_2208, ACC_2627, ACC_2207, ACC_3579,
                                     ACC_2209, ACC_2625X, ACC_2627X, ACC_2625D, ACC_2628, ACC_2203 
                                from W4_ACC
                               where ACC_PK = :new.acc
                            ) unpivot (acc_id for acc_fild in ( ACC_2203  as '2203', ACC_2207  as '2207',
                                                                ACC_2208  as '2208', ACC_2209  as '2209',  
                                                                ACC_2627  as '2627', ACC_2628  as '2628',
                                                                ACC_3570  as '3570', ACC_2625X as '2625X', 
                                                                ACC_3579  as '3739', ACC_2625D as '2625D',
                                                                ACC_9129  as '9129', ACC_2627X as '2627X',
                                                                ACC_OVR   as 'OVER'  ) ) )
      select count(1)
        into l_active
        from SALDOA s, 
             acnt   a
       where s.acc = a.acc_id
         and (s.acc, s.fdat) = ( select c.acc, max(c.fdat)
                                   from saldoa c
                                  where c.acc = a.acc_id
                                  group by c.acc)
         and (s.ostf + s.kos-s.dos) <> 0;
 
      if (l_active > 0)
      then
        raise_application_error( -20444, 'Заборонено закриття рахунку (наявні залишки на інших рахунках договору БПК)!', true );
      end if;
      
    End If;
    
    -- Заявка на модифікацію № 14/2-01/ID-4455 16.11.2015р Щодо закриття рахунків ЮО COBUSUPABS-3939
    If :new.nbs in ('2512','2513','2520','2523','2526','2530','2531','2541','2542','2544','2545','2552','2553','2554','2555'
                   ,'2560','2561','2562','2565','2570','2571','2572','2600','2601','2602','2603','2604','2640','2641','2642'
                   ,'2643','2644','2650'
                    -- Поточні рахунки з використанням БПК: 
                   ,'2655', '2605'
                    --Депозитні рахунки: 
                   ,'2525','2546','2610','2611','2615','2651','2652'
                   ) and -- Рахунок відкритий до 01.09.2015 року;
       :new.daos < to_date('01.09.2015','dd.mm.yyyy') 
    then
      
      update SPECPARAM s 
         set s.nkd = coalesce(s.nkd, to_char(:new.rnk)||'_'||to_char(sysdate,'ddmmyyyy')||'_'||to_char(sysdate,'HH24MISS'))
       where s.acc = :new.acc;
      
      if ( sql%rowcount = 0 )
      then
        insert
          into SPECPARAM ( acc, nkd ) 
        values ( :new.acc, to_char(:new.rnk)||'_'||to_char(sysdate,'ddmmyyyy')||'_'||to_char(sysdate,'HH24MISS'));
      end if;
      
    end if;
    
  END IF;
  
  
  IF ((:NEW.dazs Is Null) AND (:OLD.dazs Is NOT Null))
  THEN -- реанімування рахунків
    
    CASE
      When ( :new.TIP in ('DEP','DEN','NL8') )
      Then -- реанімування рахунків депозитних портфелів заборонена!
        
        select case
                 -- депозитний портфель ФО
                 when EXISTS( select 1 from DPT_ACCOUNTS a, DPT_DEPOSIT d
                               where a.accid = :new.acc
                                 and a.dptid = d.deposit_id )
                 then 1
                 -- депозитний портфель ЮО
                 when EXISTS( select 1 from DPU_ACCOUNTS a, DPU_DEAL    d
                               where a.accid = :new.acc
                                 and a.dpuid = d.dpu_id
                                 and d.closed = 0 )
                 then 1
                 --
                 else 0
               end
          into l_active
          from dual;
      
        if (l_active = 0)
        then
          raise_application_error( -20444, 'Заборонено реанімувати рахунок, що належить закритому депозитному договору!', true );
        end if;
      
      When ( :new.NBS = '9129' OR :new.NBS Like '35__' OR :new.NBS Like '2___' )
      Then -- Заборонено реанімувати рахунки закритого договору БПК
        
        select case
                 when EXISTS( select 1
                                from V_W4_ND_ACC a
                                join W4_ACC n
                                  on ( N.ND = a.ND )
                               where a.ACC = :new.ACC
                                 and N.DAT_CLOSE Is Not Null )
                 then 0
                 --
                 else 1
               end
          into l_active
          from dual;
      
        if (l_active = 0)
        then
          raise_application_error( -20444, 'Заборонено реанімувати рахунок, що належить закритому картковому договору!', true );
        end if;
        
      Else
        null;
        
    END CASE;
    
  END IF;

END TBU_ACCOUNTS_DAZS;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_DAZS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_DAZS.sql =========*** E
PROMPT ===================================================================================== 
