-- В этом скрипте :
prompt .........................................................................................................
prompt  1) Создание промежуточной таблицы  маркированных документов TEST_OPER_frs9 и индекса к ней IDX_OPERfrs9
prompt     Это просто часть таблицы OPER,  она создается один раз на ММФО,  и один раз на каждом их лок.РУ.
prompt     На ММФО она уже есть , и ее пересоздание на ММФО может быть вызвано только тем, 
prompt     что в выходные дни  добавлены ДВА новых РУ, которые переход на МСФЗ-9 делали еще автономно, но в ХД будут отгружаться уже, как участники ММФО.
prompt .........................................................................................................

begin   execute immediate  'Drop INDEX BARS.IDX_OPERfrs9 ' ;
exception when others then if sqlcode = - 01418 then null; else raise; end if ;   -- ORA-01418: specified index does not exist
end;
/

begin   execute immediate  'Drop TABLE BARS.TEST_OPER_frs9  ' ;
exception when others then if sqlcode = - 00942 then null; else raise; end if ;   -- ORA-00942: table or view does not exist
end;
/


begin  
 execute immediate  'CREATE TABLE BARS.TEST_OPER_frs9 AS SELECT * FROM BARS.OPER WHERE ND LIKE ''FRS9%'' AND SOS =5 AND PDAT > TO_DATE(''22-06-2018'', ''DD-MM-YYYY'') ';
 execute immediate  'CREATE INDEX BARS.IDX_OPERfrs9   ON BARS.TEST_OPER_frs9 (kf, vdat, REF) ' ;
exception when others then         if sqlcode=-955 then null; else raise; end if ; 
end;
/

