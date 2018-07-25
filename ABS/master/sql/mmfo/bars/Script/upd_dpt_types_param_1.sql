begin
UPDATE DPT_TYPES_PARAM
   SET DESCRIPTION_EN =
          'The period is 3,6,9,12,18 months. The minimum deposit amount is 1000 UAH, 100 USD, Euro. Interest payment - monthly or interest capitalization. Automatic renewal',
       DESCRIPTION_RU =
          'Срок - 3,6,9,12,18 месяцев. Минимальная сумма депозита - 1000 грн, 100 долл.США, Евро. Выплата процентов - ежемесячно или капитализация процентов. Автопролонгация',
       TOPUPAMOUNT_EN =
           'with replenishment from 200 UAH, 10 USD, Euro',
       TOPUPAMOUNT_RU =
          'с пополнением от 200 грн, 10 долл.США, Евро',
       EARLYCLOSE_EN = 
          'without the possibility of early withdrawal',
       EARLYCLOSE_RU =
          'без возможности досрочного изъятия',
       WITHDRAWAL_EN =
          'without the possibility of partial removal',
       WITHDRAWAL_RU =
          'без возможности частичного снятия'
  WHERE type_id = 47;
 update DPT_TYPES_PARAM  
   set DESCRIPTION_EN = 
          'Opening of the deposit if the depositor has a pension certificate. The period is 3,6,9,12,18 months. The minimum deposit amount is 1000 UAH, 100 USD, Euro. Interest payment - monthly or interest capitalization. Automatic renewal',
       DESCRIPTION_RU = 
          'Открытие депозита при наличии у вкладчика пенсионного удостоверения. Срок - 3,6,9,12,18 месяцев. Минимальная сумма депозита - 1000 грн, 100 долл. США, Евро. Выплата процентов - ежемесячно или капитализация процентов. Автопролонгация',
       TOPUPAMOUNT_EN =
          'with replenishment from 200 UAH, 10 USD, Euro',
       TOPUPAMOUNT_RU = 
          'с пополнением от 200 грн, 10 долл.США, Евро',
       EARLYCLOSE_EN = 
          'without the possibility of early withdrawal',
       EARLYCLOSE_RU =
          'без возможности досрочного изъятия',
       WITHDRAWAL_EN = 
          'without the possibility of partial removal',
       WITHDRAWAL_RU = 
          'без возможности частичного снятия'
  where type_id=48;
 update DPT_TYPES_PARAM 
   set DESCRIPTION_EN = 
          'The term - 3,6,9,12,18 months. The minimum deposit amount is -1 000 000 UAH, 40 000 USD, Euro. Interest payment - monthly or interest capitalization. Automatic renewal',
       DESCRIPTION_RU = 
          'Срок - 3,6,9,12,18 месяцев. Минимальная сумма депозита -1 000 000 грн, 40 000 долл.США, Евро. Выплата процентов - ежемесячно или капитализация процентов. Автопролонгация',
       TOPUPAMOUNT_EN = 
          'with replenishment from 1000 UAH, 100 USD, Euro',
       TOPUPAMOUNT_RU = 
          'с пополнением от 1000 грн, 100 долл.США, Евро',
       EARLYCLOSE_EN = 
          'without the possibility of early withdrawal',
       EARLYCLOSE_RU = 
          'без возможности досрочного изъятия',
       WITHDRAWAL_EN = 
          'without the possibility of partial removal',
       WITHDRAWAL_RU = 
          'без возможности частичного снятия'
   where type_id=49;
end;
/
commit; 