

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_BAOP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_BAOP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_BAOP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_BAOP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_BAOP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_BAOP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_BAOP 
   (	ID NUMBER(38,0), 
	TIPKB NUMBER(2,0), 
	KOD NUMBER(2,0), 
	TEXTBACK VARCHAR2(160), 
	IDENTKB VARCHAR2(16), 
	FNAMEKB VARCHAR2(12), 
	OTM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_BAOP ***
 exec bpa.alter_policies('ZAY_BAOP');


COMMENT ON TABLE BARS.ZAY_BAOP IS '¬озвраты за€вок и валютных документов';
COMMENT ON COLUMN BARS.ZAY_BAOP.ID IS '';
COMMENT ON COLUMN BARS.ZAY_BAOP.TIPKB IS '';
COMMENT ON COLUMN BARS.ZAY_BAOP.KOD IS '';
COMMENT ON COLUMN BARS.ZAY_BAOP.TEXTBACK IS '';
COMMENT ON COLUMN BARS.ZAY_BAOP.IDENTKB IS '';
COMMENT ON COLUMN BARS.ZAY_BAOP.FNAMEKB IS '';
COMMENT ON COLUMN BARS.ZAY_BAOP.OTM IS '';




PROMPT *** Create  constraint XPK_ZAY_BAOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_BAOP ADD CONSTRAINT XPK_ZAY_BAOP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAY_BAOP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAY_BAOP ON BARS.ZAY_BAOP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_BAOP ***
grant SELECT                                                                 on ZAY_BAOP        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_BAOP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_BAOP        to BARS_DM;
grant INSERT                                                                 on ZAY_BAOP        to OPERKKK;
grant DELETE,SELECT,UPDATE                                                   on ZAY_BAOP        to TECH_MOM1;
grant SELECT                                                                 on ZAY_BAOP        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_BAOP        to WR_ALL_RIGHTS;
grant INSERT                                                                 on ZAY_BAOP        to ZAY;



PROMPT *** Create SYNONYM  to ZAY_BAOP ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_BAOP FOR BARS.ZAY_BAOP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_BAOP.sql =========*** End *** ====
PROMPT ===================================================================================== 
