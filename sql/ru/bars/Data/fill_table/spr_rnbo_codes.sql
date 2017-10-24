
DELETE FROM SPR_RNBO_CODES;

Insert into BARS.SPR_RNBO_CODES  (CODE, TXT)
         Values  ('01', 'блокування активів');

Insert into BARS.SPR_RNBO_CODES  (CODE, TXT)
         Values  ('02', 'зупинення фінансових операцій');

Insert into BARS.SPR_RNBO_CODES  (CODE, TXT)
         Values  ('03', 'запобігання виведенню капіталів за межі України');

Insert into BARS.SPR_RNBO_CODES  (CODE, TXT)
         Values  ('04', 'зупинення виконання економічних та фінансових операцій');

Insert into BARS.SPR_RNBO_CODES  (CODE, TXT)
         Values  ('05', 'зупинення виконання економічних та фінансових зобов''язань');

Insert into BARS.SPR_RNBO_CODES  (CODE, TXT)
         Values  ('99', 'інші санкції');

commit;

