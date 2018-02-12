/* зміна черги запуску ф-кцій старту/фінішу дня в ЗБД для функцій
Овердрафт,БЭК-супровід,Фініш (289) та Овердрафт,БЭК-супровід,Старт (58) */
BEGIN
    UPDATE bars.tms_task
       SET SEQUENCE_NUMBER = 289
     WHERE id = 243; /*Овердрафт,БЭК-супровід,Старт*/

    UPDATE bars.tms_task
       SET SEQUENCE_NUMBER = 58
     WHERE id = 242; /*Овердрафт,БЭК-супровід,Фініш*/
END;
/
COMMIT;
/