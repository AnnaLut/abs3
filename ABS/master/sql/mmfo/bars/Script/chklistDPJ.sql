UPDATE chklist_tts
   SET sqlval =
          '( ( ( SUBSTR(NLSA,1,4)=''2620'' AND f_get_ob22(kv, nlsa)<>''30'' ) AND ( SUBSTR(NLSB,1,4)=''2620'' AND f_get_ob22(kv, nlsb)<>''30'' ) ) and kv<>980 and ID_A<>ID_B )'
 WHERE tt = 'DPJ' AND idchk = '7';

COMMIT;