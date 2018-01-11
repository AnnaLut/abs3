

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DJER_ND.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DJER_ND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DJER_ND'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DJER_ND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DJER_ND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DJER_ND ***
begin 
  execute immediate '
  CREATE TABLE BARS.DJER_ND 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(500), 
	KV NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DJER_ND ***
 exec bpa.alter_policies('DJER_ND');


COMMENT ON TABLE BARS.DJER_ND IS 'Характеристика джерел надходження коштів для нерезидентів';
COMMENT ON COLUMN BARS.DJER_ND.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.DJER_ND.NAME IS 'Назва джерела';
COMMENT ON COLUMN BARS.DJER_ND.KV IS 'Код валюти застовування';




PROMPT *** Create  constraint DJER_ND_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DJER_ND ADD CONSTRAINT DJER_ND_PK PRIMARY KEY (ID, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DJER_ND_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DJER_ND MODIFY (ID CONSTRAINT CC_DJER_ND_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DJER_ND_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DJER_ND MODIFY (NAME CONSTRAINT CC_DJER_ND_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DJER_ND_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DJER_ND MODIFY (KV CONSTRAINT CC_DJER_ND_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DJER_ND_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DJER_ND_PK ON BARS.DJER_ND (ID, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DJER_ND ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DJER_ND         to ABS_ADMIN;
grant SELECT                                                                 on DJER_ND         to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DJER_ND         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DJER_ND         to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DJER_ND         to START1;
grant SELECT                                                                 on DJER_ND         to UPLD;
grant FLASHBACK,SELECT                                                       on DJER_ND         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DJER_ND.sql =========*** End *** =====
PROMPT ===================================================================================== 
