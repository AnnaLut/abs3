BEGIN
        EXECUTE IMMEDIATE
            'insert into PARAMS$GLOBAL (par, val, comm) values (''OWENABLEEA'', 0, ''Друк PDF для ДКБО (1-PDF, 0-DOC)'')';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN
            NULL;
END;
/
COMMIT;	
