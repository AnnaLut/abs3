update BARS.TTS
   set NLSK = q'[#(NBS_OB22('6399','14'))]'
 where TT in ('BKB','BM4','BN4');

commit;

update BARS.TTS
   set NLSK = q'[#(NBS_OB22('6399','14'))]'
     , NLSB = q'[#(NBS_OB22('6399','14'))]'
 where TT in ('M09','MF9');

commit;

update BARS.TTS
   set NLSK = '#(NBS_OB22(''6510'',''A3''))'
 where TT = 'K67';

commit;

update BARS.TTS
   set NLSK = q'[#(NBS_OB22('6399','D2'))]'
 where TT in ('D3N','D3I');

commit;

update BARS.TTS
   set NLSK = q'[#(NBS_OB22('6399','01'))]'
     , NLSB = q'[#(NBS_OB22('6399','01'))]'
 where TT in ('202','222');

commit;

update BARS.TTS
   set NLSM = q'[#(NBS_OB22('6399','01'))]'
     , NLSA = q'[#(NBS_OB22('6399','01'))]'
 where TT in ('201','221');

commit;
