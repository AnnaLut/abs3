

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/UI_FUNC_HITS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to UI_FUNC_HITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''UI_FUNC_HITS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''UI_FUNC_HITS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''UI_FUNC_HITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table UI_FUNC_HITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.UI_FUNC_HITS 
   (	FUNC_ID NUMBER(38,0), 
	STAFF_ID NUMBER(38,0), 
	HITS NUMBER(38,0), 
	LAST_HIT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to UI_FUNC_HITS ***
 exec bpa.alter_policies('UI_FUNC_HITS');


COMMENT ON TABLE BARS.UI_FUNC_HITS IS 'Статистика вызова функций пользователем';
COMMENT ON COLUMN BARS.UI_FUNC_HITS.FUNC_ID IS 'Id функции в operlist';
COMMENT ON COLUMN BARS.UI_FUNC_HITS.STAFF_ID IS 'Id пользователя в staff';
COMMENT ON COLUMN BARS.UI_FUNC_HITS.HITS IS 'Кол-во вызовов';
COMMENT ON COLUMN BARS.UI_FUNC_HITS.LAST_HIT IS 'Дата последнего вызова';




PROMPT *** Create  constraint PK_UIFUNCRATING ***
begin   
 execute immediate '
  ALTER TABLE BARS.UI_FUNC_HITS ADD CONSTRAINT PK_UIFUNCRATING PRIMARY KEY (FUNC_ID, STAFF_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UIFUNCRATING_STAFFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.UI_FUNC_HITS MODIFY (STAFF_ID CONSTRAINT CC_UIFUNCRATING_STAFFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UIFUNCRATING_HITS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.UI_FUNC_HITS MODIFY (HITS CONSTRAINT CC_UIFUNCRATING_HITS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UIFUNCRATING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_UIFUNCRATING ON BARS.UI_FUNC_HITS (FUNC_ID, STAFF_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UI_FUNC_HITS ***
grant SELECT                                                                 on UI_FUNC_HITS    to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on UI_FUNC_HITS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on UI_FUNC_HITS    to BARS_DM;
grant SELECT                                                                 on UI_FUNC_HITS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/UI_FUNC_HITS.sql =========*** End *** 
PROMPT ===================================================================================== 
