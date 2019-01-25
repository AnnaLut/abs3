update bars.CHKLIST_TTS set sqlval = '(KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE) >=15000000)'  where tt = 'CCK' and idchk = 7;

commit;