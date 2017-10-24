

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_TT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_TT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_TT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TELLER_TT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_TT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_TT 
   (	TT VARCHAR2(60), 
	NAME VARCHAR2(80)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_TT ***
 exec bpa.alter_policies('TELLER_TT');


COMMENT ON TABLE BARS.TELLER_TT IS '';
COMMENT ON COLUMN BARS.TELLER_TT.TT IS 'Операція';
COMMENT ON COLUMN BARS.TELLER_TT.NAME IS 'Назва операції';




PROMPT *** Create  constraint TT_UN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_TT ADD CONSTRAINT TT_UN UNIQUE (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003125440 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_TT MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index TT_UN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.TT_UN ON BARS.TELLER_TT (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TELLER_TT ***
grant INSERT,SELECT,UPDATE                                                   on TELLER_TT       to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on TELLER_TT       to START1;
grant FLASHBACK,SELECT                                                       on TELLER_TT       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_TT.sql =========*** End *** ===
PROMPT ===================================================================================== 
