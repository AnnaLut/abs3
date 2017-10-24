
SET DEFINE OFF;
delete from BARS.OTC_RISK_S580
 where r020 in ( '3043','3044','3049', '3143','3144',
                 '9208','9358','9359' );


Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3043', '1', '1',   '0', '1');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3043', '1', '2', '100', '5');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3044', '1', '1',   '0', '1');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3044', '1', '2', '100', '5');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3049', '1', '1',   '0', '1');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3049', '1', '2', '100', '5');

Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3143', '1', '1',   '0', '1');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3143', '1', '2', '100', '5');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3144', '1', '1',   '0', '1');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('3144', '1', '2', '100', '5');

Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('9208', '1', '1',  '0',  '1');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('9208', '1', '2', '50',  '4');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('9358', '1', '1',  '0',  '1');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('9358', '1', '2', '50',  '4');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('9359', '1', '1',  '0',  '1');
Insert into BARS.OTC_RISK_S580  (R020, T020, R013, KOEF, S580)  Values  ('9359', '1', '2', '50',  '4');

COMMIT;

