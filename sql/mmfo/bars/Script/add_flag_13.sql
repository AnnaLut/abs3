BEGIN
   FOR k IN (SELECT *
               FROM tts
              WHERE tt like 'IB%' or tt like 'CL%')
   LOOP
      UPDATE tts
         SET flags = SUBSTR (flags, 1, 13) || 1 || SUBSTR (flags, 15, 50)
      WHERE tt=k.tt;
   END LOOP;
END;
/

commit;