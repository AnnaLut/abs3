

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BU1.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BU1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BU1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BU1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BU1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BU1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BU1 
   (	ID NUMBER, 
	NAMBER NUMBER, 
	KOD VARCHAR2(35), 
	NAME VARCHAR2(60), 
	KOEF_PLAN NUMBER(6,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BU1 ***
 exec bpa.alter_policies('BU1');


COMMENT ON TABLE BARS.BU1 IS '';
COMMENT ON COLUMN BARS.BU1.ID IS 'ID';
COMMENT ON COLUMN BARS.BU1.NAMBER IS '';
COMMENT ON COLUMN BARS.BU1.KOD IS '';
COMMENT ON COLUMN BARS.BU1.NAME IS 'Наименование статей';
COMMENT ON COLUMN BARS.BU1.KOEF_PLAN IS 'приращения плана бюджета';




PROMPT *** Create  constraint PK_BU1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BU1 ADD CONSTRAINT PK_BU1 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BU1_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BU1 ADD CONSTRAINT CC_BU1_ID_NN CHECK (ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BU1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BU1 ON BARS.BU1 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BU1 ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BU1             to ABS_ADMIN;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BU1             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BU1             to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BU1             to BU;
grant SELECT                                                                 on BU1             to SALGL;
grant SELECT                                                                 on BU1             to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BU1             to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BU1             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BU1.sql =========*** End *** =========
PROMPT ===================================================================================== 
