

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/UI_FUNC_STATS_BUFF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to UI_FUNC_STATS_BUFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''UI_FUNC_STATS_BUFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''UI_FUNC_STATS_BUFF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''UI_FUNC_STATS_BUFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table UI_FUNC_STATS_BUFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.UI_FUNC_STATS_BUFF 
   (	ID NUMBER(38,0), 
	STAT_DATE DATE, 
	STAFF_ID NUMBER(38,0), 
	FUNC_URL VARCHAR2(4000), 
	USER_DATA VARCHAR2(1024)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to UI_FUNC_STATS_BUFF ***
 exec bpa.alter_policies('UI_FUNC_STATS_BUFF');


COMMENT ON TABLE BARS.UI_FUNC_STATS_BUFF IS 'Буфферная таблица статистики вызова функций АБС';
COMMENT ON COLUMN BARS.UI_FUNC_STATS_BUFF.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.UI_FUNC_STATS_BUFF.STAT_DATE IS 'Дата/время';
COMMENT ON COLUMN BARS.UI_FUNC_STATS_BUFF.STAFF_ID IS 'ID пользователья';
COMMENT ON COLUMN BARS.UI_FUNC_STATS_BUFF.FUNC_URL IS 'УРЛ функции';
COMMENT ON COLUMN BARS.UI_FUNC_STATS_BUFF.USER_DATA IS 'Данные хоста';



PROMPT *** Create  grants  UI_FUNC_STATS_BUFF ***
grant SELECT                                                                 on UI_FUNC_STATS_BUFF to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on UI_FUNC_STATS_BUFF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on UI_FUNC_STATS_BUFF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/UI_FUNC_STATS_BUFF.sql =========*** En
PROMPT ===================================================================================== 
