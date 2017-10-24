
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/doc_is_valid.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DOC_IS_VALID (REF_ NUMBER, COND_ VARCHAR2) RETURN NUMBER

-- Функция проверяет удовлетворяет ли документ из опер с рефернсом
-- REF_ условию COND_.
-- Подразумевается, что условие составлено с использованием алиаса О
-- для таблицы OPER
-- Функция работает в режиме автономной транзакции и пригодна для
-- использования в триггеруемых событиях на таблице опер.

IS
    PRAGMA AUTONOMOUS_TRANSACTION;

    NRES    NUMBER;
    C       NUMBER;
    SQLSTMT VARCHAR2(4096);
    RET     NUMBER;
BEGIN

    NRES := 1;

    IF COND_ IS NOT NULL THEN

        C := DBMS_SQL.OPEN_CURSOR;

        IF REF_ IS NOT NULL THEN
            SQLSTMT := '
               SELECT COUNT(*)
                 FROM OPER O
                WHERE O.REF=:bind2 AND (' || COND_ || ')';
            DBMS_SQL.PARSE( C, SQLSTMT, 1 );
            DBMS_SQL.BIND_VARIABLE( C, ':bind2', REF_ );
            DBMS_SQL.DEFINE_COLUMN( C, 1, NRES );

            BEGIN
                RET := DBMS_SQL.EXECUTE( C );
                IF DBMS_SQL.FETCH_ROWS( C ) > 0 THEN
                    DBMS_SQL.COLUMN_VALUE( C, 1, NRES );
                ELSE
                    NRES := 0;
                END IF;
            EXCEPTION
                WHEN OTHERS THEN
                    NRES := 0;
            END;
        ELSE
            NRES := 0;
        END IF;
        DBMS_SQL.CLOSE_CURSOR( C );
    END IF;

    RETURN NRES;
END;
 
/
 show err;
 
PROMPT *** Create  grants  DOC_IS_VALID ***
grant EXECUTE                                                                on DOC_IS_VALID    to ABS_ADMIN;
grant EXECUTE                                                                on DOC_IS_VALID    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DOC_IS_VALID    to START1;
grant EXECUTE                                                                on DOC_IS_VALID    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/doc_is_valid.sql =========*** End *
 PROMPT ===================================================================================== 
 