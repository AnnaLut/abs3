UPDATE tts
   SET flags = '1' || SUBSTR (flags, 2)
WHERE tt = 'OW4';

UPDATE chklist_tts
   SET sqlval = NULL
WHERE tt = 'PKD' AND idchk = 11;

DELETE FROM ps_tts
      WHERE tt = 'PKD' AND nbs IN ('2630', '2635');

commit;	  