BEGIN
   INSERT INTO BARS.DICT_EXCTXT (ID, NAME, USE)
           VALUES (
                     16,
                     'р≥шенн€ суду або р≥шенн€ ≥нших орган≥в (посадових ос≥б), €ке п≥дл€гаЇ примусовому виконанню',
                     2);
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      NULL;
END;
/

COMMIT;