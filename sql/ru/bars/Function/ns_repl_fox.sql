
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ns_repl_fox.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NS_REPL_FOX (sql_ IN VARCHAR2, tpv_ in number:=0)
   -- versions 04/06/2009
   RETURN VARCHAR2
IS
   repl_   VARCHAR2 (1000) := UPPER(TRIM (sql_));
   col_    VARCHAR2 (100);
   pos_    NUMBER;
   pos1_   NUMBER;
   pos2_   NUMBER;
BEGIN
   repl_ := REPLACE (repl_, '#', '<>');
   repl_ := REPLACE (repl_, '''', '''''');
   repl_ := REPLACE (repl_, '[', '''');
   repl_ := REPLACE (repl_, ']', '''');
   repl_ := REPLACE (repl_, '.AND.', ' AND ');
   repl_ := REPLACE (repl_, '.OR.', ' OR ');
   repl_ := REPLACE (repl_, '.NOT.', ' NOT ');
   repl_ := REPLACE (repl_, '.T.', ' 1=1 ');
   repl_ := REPLACE (repl_, '.F.', ' 1<>1 ');
   repl_ := REPLACE (repl_, '"', '''');

   if tpv_ = 1 then -- если строковый тип, то + - это конкатенация
      repl_ := REPLACE (repl_, '+', '||');
   end if;

   pos_ := INSTR (repl_, '!EMPT(');

   IF pos_ > 0
   THEN
      pos1_ := INSTR (repl_, ')', pos_);

      IF pos1_ > 0
      THEN
         col_ := SUBSTR (repl_, pos_ + 6, pos1_ - pos_ - 6);
         repl_ := substr(repl_, 1, pos_ - 1) || col_ || ' IS NOT NULL ' || SUBSTR (repl_, pos1_ + 1);
      END IF;
   END IF;

   pos_ := INSTR (repl_, 'EMPT(');

   IF pos_ > 0
   THEN
      pos1_ := INSTR (repl_, ')', pos_);

      IF pos1_ > 0
      THEN
         col_ := SUBSTR (repl_, pos_ + 5, pos1_ - pos_ - 5);
         repl_ := substr(repl_, 1, pos_ - 1) || col_ || ' IS NULL ' || SUBSTR (repl_, pos1_ + 1);
      END IF;
   END IF;

   pos_ := INSTR (repl_, '!EMPTY(');

   IF pos_ > 0
   THEN
      pos1_ := INSTR (repl_, ')', pos_);

      IF pos1_ > 0
      THEN
         col_ := SUBSTR (repl_, pos_ + 7, pos1_ - pos_ - 7);
         repl_ := substr(repl_, 1, pos_ - 1) || col_ || ' IS NOT NULL ' || SUBSTR (repl_, pos1_ + 1);
      END IF;
   END IF;

   pos_ := INSTR (repl_, 'EMPTY(');

   IF pos_ > 0
   THEN
      pos1_ := INSTR (repl_, ')', pos_);

      IF pos1_ > 0
      THEN
         col_ := SUBSTR (repl_, pos_ + 6, pos1_ - pos_ - 6);
         repl_ := substr(repl_, 1, pos_ - 1) || col_ || ' IS NULL ' || SUBSTR (repl_, pos1_ + 1);
      END IF;
   END IF;

   repl_ := REPLACE (repl_, 'AT(', 'FOX_AT(');

   repl_ := REPLACE (repl_, 'SUBS(', 'SUBSTR(');
   repl_ := REPLACE (repl_, 'VAL(', 'TO_NUMBER(');

   pos_ := INSTR (repl_, 'STR(');

   IF pos_ > 0
   THEN
      pos1_ := INSTR (repl_, ',', pos_);
      pos2_ := INSTR (repl_, ')', pos1_);

      IF pos1_ > 0
      THEN
         col_ := SUBSTR (repl_, pos_ + 4, pos1_ - pos_ - 4);
         repl_ := substr(repl_, 1, pos_ - 1) || 'TO_CHAR('|| col_ || ') ' || SUBSTR (repl_, pos2_ + 1);
      END IF;
   END IF;

   RETURN repl_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ns_repl_fox.sql =========*** End **
 PROMPT ===================================================================================== 
 