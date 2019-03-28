

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REGCAPITAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REGCAPITAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REGCAPITAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REGCAPITAL'', ''WHOLE'' , null, null, null, null);
           end; 
          '; 
END; 
/

PROMPT *** Create  table REGCAPITAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.REGCAPITAL 
   (DAT DATE, 
	SUMRK 	NUMBER(24,0),
	SUM_H9 	NUMBER(24,0)
   ) 
  SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to REGCAPITAL ***
 exec bpa.alter_policies('REGCAPITAL');


COMMENT ON TABLE BARS.REGCAPITAL IS 'Регулятивный капитал банка за предыдущий день';
COMMENT ON COLUMN BARS.REGCAPITAL.FDAT IS '';
COMMENT ON COLUMN BARS.REGCAPITAL.SUMRK IS '';

begin
    execute immediate 'ALTER TABLE BARS.REGCAPITAL ADD SUM_H9 NUMBER(24,0)';
exception
    when others then null;
end;
/    

COMMENT ON COLUMN BARS.REGCAPITAL.SUM_H9 IS 'Сума для Н9 (ОК+ДК-В1)';


PROMPT *** Create  constraint SYS_C004988 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REGCAPITAL MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint XPK_REGCAPITAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.REGCAPITAL ADD CONSTRAINT XPK_REGCAPITAL PRIMARY KEY (FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index XPK_REGCAPITAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REGCAPITAL ON BARS.REGCAPITAL (FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  REGCAPITAL ***
grant SELECT                                                                 on REGCAPITAL      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REGCAPITAL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REGCAPITAL      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REGCAPITAL      to REGCAPITAL;
grant SELECT                                                                 on REGCAPITAL      to UPLD;
grant FLASHBACK,SELECT                                                       on REGCAPITAL      to WR_REFREAD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REGCAPITAL.sql =========*** End *** ==
PROMPT ===================================================================================== 
