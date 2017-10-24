

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_DATA_TRANSFER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_DATA_TRANSFER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_DATA_TRANSFER ("ID", "MFO", "REQ_ID", "TRANSFER_TYPE", "TRANSFER_TYPE_NAME", "TRANSFER_DATE", "TRANSFER_RESULT", "COMM") AS 
  select id, mfo, req_id, transfer_type, substr(
       case when transfer_type = 1 then 'Встановлення індикативних курсів валют та курсів обміну'
            when transfer_type = 2 then 'Створення заявки'
            when transfer_type = 3 then 'Візування заявки'
            when transfer_type = 4 then 'Встановлення фактичних курсів'
            when transfer_type = 5 then 'Задоволення заявки'
            when transfer_type = 6 then 'Інформація щодо передачі коштів на заявку'
            when transfer_type = 7 then 'Інформація щодо проходження заявки'
            when transfer_type = 8 then 'Зміни заявки'
            when transfer_type = 9 then 'Візування заявки'
            when transfer_type = 10 then 'Інформація щодо надходжень'
            when transfer_type = 11 then 'Повернення з обробки ділером'
            else null
       end, 1, 254),
       transfer_date, transfer_result, substr(comm, 1, 1024)
  from zay_data_transfer;

PROMPT *** Create  grants  V_ZAY_DATA_TRANSFER ***
grant SELECT                                                                 on V_ZAY_DATA_TRANSFER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_DATA_TRANSFER to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_DATA_TRANSFER.sql =========*** En
PROMPT ===================================================================================== 
