

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/UI_FUNC_STATS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to UI_FUNC_STATS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''UI_FUNC_STATS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''UI_FUNC_STATS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''UI_FUNC_STATS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table UI_FUNC_STATS ***
begin 
  execute immediate '
  CREATE TABLE BARS.UI_FUNC_STATS 
   (	ID NUMBER(38,0), 
	STAT_DATE DATE, 
	STAFF_ID NUMBER(38,0), 
	FUNC_URL VARCHAR2(4000), 
	FUNC_ID NUMBER(38,0), 
	USER_DATA VARCHAR2(1024)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
  PARTITION BY RANGE (STAT_DATE) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION P0  VALUES LESS THAN (TO_DATE('' 2013-11-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to UI_FUNC_STATS ***
 exec bpa.alter_policies('UI_FUNC_STATS');


COMMENT ON TABLE BARS.UI_FUNC_STATS IS 'Статистика вызова функций АБС';
COMMENT ON COLUMN BARS.UI_FUNC_STATS.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.UI_FUNC_STATS.STAT_DATE IS 'Дата/время';
COMMENT ON COLUMN BARS.UI_FUNC_STATS.STAFF_ID IS 'ID пользователья';
COMMENT ON COLUMN BARS.UI_FUNC_STATS.FUNC_URL IS 'УРЛ функции';
COMMENT ON COLUMN BARS.UI_FUNC_STATS.FUNC_ID IS 'ID функции в operlist';
COMMENT ON COLUMN BARS.UI_FUNC_STATS.USER_DATA IS '';




PROMPT *** Create  constraint PK_UIFUNCSTATS ***
begin   
 execute immediate '
  ALTER TABLE BARS.UI_FUNC_STATS ADD CONSTRAINT PK_UIFUNCSTATS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UIFUNCSTATS_STAFFDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.UI_FUNC_STATS MODIFY (STAT_DATE CONSTRAINT CC_UIFUNCSTATS_STAFFDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UIFUNCSTATS_STAFFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.UI_FUNC_STATS MODIFY (STAFF_ID CONSTRAINT CC_UIFUNCSTATS_STAFFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UIFUNCSTATS_FUNCURL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.UI_FUNC_STATS MODIFY (FUNC_URL CONSTRAINT CC_UIFUNCSTATS_FUNCURL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UIFUNCSTATS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_UIFUNCSTATS ON BARS.UI_FUNC_STATS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UI_FUNC_STATS ***
grant SELECT                                                                 on UI_FUNC_STATS   to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on UI_FUNC_STATS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on UI_FUNC_STATS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/UI_FUNC_STATS.sql =========*** End ***
PROMPT ===================================================================================== 
