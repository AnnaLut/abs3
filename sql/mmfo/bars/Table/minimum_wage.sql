

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MINIMUM_WAGE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MINIMUM_WAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MINIMUM_WAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MINIMUM_WAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MINIMUM_WAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MINIMUM_WAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.MINIMUM_WAGE 
   (	DAT_WAGE DATE, 
	SUM_WAGE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MINIMUM_WAGE ***
 exec bpa.alter_policies('MINIMUM_WAGE');


COMMENT ON TABLE BARS.MINIMUM_WAGE IS 'Розмір мінімальної заробітної плати';
COMMENT ON COLUMN BARS.MINIMUM_WAGE.DAT_WAGE IS 'Дата встановлення';
COMMENT ON COLUMN BARS.MINIMUM_WAGE.SUM_WAGE IS 'Розмір мін.зарплати (в копійках)';




PROMPT *** Create  constraint PK_MINIMUMWAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.MINIMUM_WAGE ADD CONSTRAINT PK_MINIMUMWAGE PRIMARY KEY (DAT_WAGE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MINIMUMWAGE_DATWAGE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MINIMUM_WAGE MODIFY (DAT_WAGE CONSTRAINT CC_MINIMUMWAGE_DATWAGE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MINIMUMWAGE_SUMWAGE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MINIMUM_WAGE MODIFY (SUM_WAGE CONSTRAINT CC_MINIMUMWAGE_SUMWAGE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MINIMUMWAGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MINIMUMWAGE ON BARS.MINIMUM_WAGE (DAT_WAGE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MINIMUM_WAGE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MINIMUM_WAGE    to ABS_ADMIN;
grant SELECT                                                                 on MINIMUM_WAGE    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MINIMUM_WAGE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MINIMUM_WAGE    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MINIMUM_WAGE    to DPT_ADMIN;
grant SELECT                                                                 on MINIMUM_WAGE    to START1;
grant SELECT                                                                 on MINIMUM_WAGE    to UPLD;
grant FLASHBACK,SELECT                                                       on MINIMUM_WAGE    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MINIMUM_WAGE.sql =========*** End *** 
PROMPT ===================================================================================== 
