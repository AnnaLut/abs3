PROMPT start update currency in SCALE_IMMOBILE
UPDATE SCALE_IMMOBILE
   SET val = 0
 WHERE kv <> 980;
 UPDATE SCALE_IMMOBILE
      SET val = 10000
   WHERE kv = 980;
commit;
/
PROMPT end update SCALE_IMMOBILE