update BARS.TTS
   set NLSK = '#(NBS_OB22(''6399'',''14''))'
 where TT = 'BM4';

COMMIT;

update BARS.TTS
   set NLSK = '#(NBS_OB22(''6510'',''A3''))'
 where TT = 'K67';

commit;
