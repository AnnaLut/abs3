BEGIN
   FOR k IN (SELECT *
               FROM tts
              WHERE tt IN ('IB1',
                           'IB2',
                           'IB3',
                           'IB4',
                           'IB5',
                           'IB6',
                           'CL1',
                           'CL2',
                           'CL5'))
   LOOP
      UPDATE tts
         SET flags = SUBSTR (flags, 1, 13) || 1 || SUBSTR (flags, 15, 50)
      WHERE tt=k.tt;
   END LOOP;
END;
/

commit;