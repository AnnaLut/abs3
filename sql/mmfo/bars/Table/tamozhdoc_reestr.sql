

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TAMOZHDOC_REESTR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TAMOZHDOC_REESTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TAMOZHDOC_REESTR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TAMOZHDOC_REESTR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TAMOZHDOC_REESTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TAMOZHDOC_REESTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TAMOZHDOC_REESTR 
   (	IDR NUMBER, 
	NAME VARCHAR2(50), 
	DATER DATE, 
	PID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TAMOZHDOC_REESTR ***
 exec bpa.alter_policies('TAMOZHDOC_REESTR');


COMMENT ON TABLE BARS.TAMOZHDOC_REESTR IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC_REESTR.IDR IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC_REESTR.NAME IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC_REESTR.DATER IS '';
COMMENT ON COLUMN BARS.TAMOZHDOC_REESTR.PID IS '';




PROMPT *** Create  constraint PK_TAMOZHDOCREESTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC_REESTR ADD CONSTRAINT PK_TAMOZHDOCREESTR PRIMARY KEY (IDR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TAMOZHDOCREESTR_CONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC_REESTR ADD CONSTRAINT FK_TAMOZHDOCREESTR_CONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TAMOZHDOCREESTR_IDR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC_REESTR MODIFY (IDR CONSTRAINT CC_TAMOZHDOCREESTR_IDR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TAMOZHDOCREESTR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC_REESTR MODIFY (NAME CONSTRAINT CC_TAMOZHDOCREESTR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TAMOZHDOCREESTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TAMOZHDOCREESTR ON BARS.TAMOZHDOC_REESTR (IDR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TAMOZHDOC_REESTR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TAMOZHDOC_REESTR to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TAMOZHDOC_REESTR to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TAMOZHDOC_REESTR.sql =========*** End 
PROMPT ===================================================================================== 
