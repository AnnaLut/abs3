

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TAMOZHDOC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TAMOZHDOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TAMOZHDOC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TAMOZHDOC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TAMOZHDOC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TAMOZHDOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TAMOZHDOC 
   (	IDT NUMBER, 
	NAME VARCHAR2(35), 
	PID NUMBER, 
	ID NUMBER, 
	RNK NUMBER, 
	DATEDOC DATE, 
	S NUMBER, 
	KV NUMBER, 
	KURS NUMBER, 
	IDR NUMBER, 
	DAT DATE, 
	ID_PARENT NUMBER, 
	IMPEXP NUMBER, 
	DAT91 DATE, 
	KURS_PL NUMBER, 
	PP_F36 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TAMOZHDOC ***
 exec bpa.alter_policies('TAMOZHDOC');


COMMENT ON TABLE BARS.TAMOZHDOC IS 'Таможенные декларации';
COMMENT ON COLUMN BARS.TAMOZHDOC.IDT IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.NAME IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.PID IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.ID IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.RNK IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.DATEDOC IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.S IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.KV IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.KURS IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.IDR IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.DAT IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.ID_PARENT IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.IMPEXP IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.DAT91 IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.KURS_PL IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC.PP_F36 IS '';




PROMPT *** Create  constraint PK_TAMOZHDOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC ADD CONSTRAINT PK_TAMOZHDOC PRIMARY KEY (IDT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_TAMOZHDOC_IDT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC MODIFY (IDT CONSTRAINT NK_TAMOZHDOC_IDT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TAMOZHDOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TAMOZHDOC ON BARS.TAMOZHDOC (IDT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TAMOZHDOC ***
grant SELECT                                                                 on TAMOZHDOC       to BARSREADER_ROLE;
grant SELECT                                                                 on TAMOZHDOC       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TAMOZHDOC       to BARS_DM;
grant SELECT                                                                 on TAMOZHDOC       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TAMOZHDOC       to WR_ALL_RIGHTS;
grant SELECT                                                                 on TAMOZHDOC       to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TAMOZHDOC.sql =========*** End *** ===
PROMPT ===================================================================================== 
