

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_DATA_TRANSFER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_DATA_TRANSFER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_DATA_TRANSFER ("ID", "MFO", "REQ_ID", "TRANSFER_TYPE", "TRANSFER_TYPE_NAME", "TRANSFER_DATE", "TRANSFER_RESULT", "COMM") AS 
  SELECT id,
            mfo,
            req_id,
            transfer_type,
            SUBSTR (
               CASE
                  WHEN transfer_type = 1
                  THEN
                     'Встановлення індикативних курсів валют та курсів обміну'
                  WHEN transfer_type = 2
                  THEN
                     'Створення заявки'
                  WHEN transfer_type = 3
                  THEN
                     'Візування заявки'
                  WHEN transfer_type = 4
                  THEN
                     'Встановлення фактичних курсів'
                  WHEN transfer_type = 5
                  THEN
                     'Задоволення заявки'
                  WHEN transfer_type = 6
                  THEN
                     'Інформація щодо передачі коштів на заявку'
                  WHEN transfer_type = 7
                  THEN
                     'Інформація щодо проходження заявки'
                  WHEN transfer_type = 8
                  THEN
                     'Зміни заявки'
                  WHEN transfer_type = 9
                  THEN
                     'Візування заявки'
                  WHEN transfer_type = 10
                  THEN
                     'Інформація щодо надходжень'
                  WHEN transfer_type = 11
                  THEN
                     'Повернення з обробки ділером'
                  ELSE
                     NULL
               END,
               1,
               254),
            transfer_date,
            transfer_result,
            SUBSTR (comm, 1, 254)
       FROM zay_data_transfer
      WHERE    (kf = f_ourmfo () AND f_ourmfo () <> '300465')
            OR f_ourmfo () = '300465'
   ORDER BY 1 DESC;

PROMPT *** Create  grants  V_ZAY_DATA_TRANSFER ***
grant SELECT                                                                 on V_ZAY_DATA_TRANSFER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_DATA_TRANSFER to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_DATA_TRANSFER.sql =========*** En
PROMPT ===================================================================================== 
