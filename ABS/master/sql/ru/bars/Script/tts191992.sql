BEGIN
   bc.home;

   UPDATE tts
      SET nlsk = '37391192', nlsb = '37391192'
    WHERE nlsk LIKE '191992%';
END;
/
COMMIT
/