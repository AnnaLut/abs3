begin
   Insert into BARS.CC_TAG   (TAG, NAME, TAGTYPE, TABLE_NAME, TYPE, NOT_TO_EDIT, CODE)
                    Values   ('ZAL_LIZ', 'Вид забезпечення для фін.лізінга', 'CCK', 'V_CC_PAWN_LIZING', 'N', 0, 'ZAL');
   COMMIT;
exception
  when DUP_VAL_ON_INDEX then  null;
end;
/

