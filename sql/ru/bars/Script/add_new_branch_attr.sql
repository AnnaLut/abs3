BEGIN
    BEGIN
        EXECUTE IMMEDIATE
            'insert into branch_tags (tag, name) values (''BEK_BOSS_FIO'', ''БЕК: Друк заяви на видалення тікету ПІБ керівника бек-офісу'')';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE
            'insert into branch_tags (tag, name) values (''BEK_BOSS_POS'', ''БЕК: Друк заяви на видалення тікету Посада керівника бек-офісу'')';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN
            NULL;
    END;

    COMMIT;
END;
/