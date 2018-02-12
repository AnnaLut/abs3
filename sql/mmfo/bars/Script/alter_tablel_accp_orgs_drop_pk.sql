PROMPT Удаляем ключ по ОКПО
BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE BARS.ACCP_ORGS DROP PRIMARY KEY DROP INDEX';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -02441 THEN
            NULL;
        ELSE
            RAISE;
        END IF;
END;
/
PROMPT Готово

PROMPT Уникальный ключ по номеру договора
begin
    EXECUTE IMMEDIATE 'ALTER TABLE BARS.ACCP_ORGS ADD CONSTRAINT UC_ACCPORGS_NDOG UNIQUE (NDOG)';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -02261 THEN
            NULL;
        ELSE
            RAISE;
        END IF;
END;
/
PROMPT Готово