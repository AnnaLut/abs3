

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ0.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ0 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ0'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ0'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ0'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ0 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(60), 
	PR_NV NUMBER(5,2), 
	PR_IV NUMBER(5,2), 
	NAM1 VARCHAR2(40), 
	OST0 NUMBER, 
	OST1 NUMBER, 
	OST0F NUMBER, 
	OST1F NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ0 ***
 exec bpa.alter_policies('REZ0');


COMMENT ON TABLE BARS.REZ0 IS '';
COMMENT ON COLUMN BARS.REZ0.ID IS 'Код групи';
COMMENT ON COLUMN BARS.REZ0.NAME IS 'Назва групи';
COMMENT ON COLUMN BARS.REZ0.PR_NV IS '% резерву для ГРН';
COMMENT ON COLUMN BARS.REZ0.PR_IV IS '% резерву для ВАЛ';
COMMENT ON COLUMN BARS.REZ0.NAM1 IS '';
COMMENT ON COLUMN BARS.REZ0.OST0 IS '';
COMMENT ON COLUMN BARS.REZ0.OST1 IS '';
COMMENT ON COLUMN BARS.REZ0.OST0F IS '';
COMMENT ON COLUMN BARS.REZ0.OST1F IS '';




PROMPT *** Create  constraint XPK_REZ0 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ0 ADD CONSTRAINT XPK_REZ0 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_REZ0_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ0 MODIFY (ID CONSTRAINT NK_REZ0_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REZ0 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REZ0 ON BARS.REZ0 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ0 ***
grant SELECT                                                                 on REZ0            to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ0            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ0.sql =========*** End *** ========
PROMPT ===================================================================================== 
