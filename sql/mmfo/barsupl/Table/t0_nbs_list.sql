

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/T0_NBS_LIST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table T0_NBS_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.T0_NBS_LIST 
   (	NBS CHAR(4), 
	OB22 CHAR(2), 
	 CONSTRAINT UK_T0NBSLIST PRIMARY KEY (NBS, OB22) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSUPLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.T0_NBS_LIST IS '';
COMMENT ON COLUMN BARSUPL.T0_NBS_LIST.NBS IS '';
COMMENT ON COLUMN BARSUPL.T0_NBS_LIST.OB22 IS '';




PROMPT *** Create  constraint UK_T0NBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.T0_NBS_LIST ADD CONSTRAINT UK_T0NBSLIST PRIMARY KEY (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_T0NBSLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.UK_T0NBSLIST ON BARSUPL.T0_NBS_LIST (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  T0_NBS_LIST ***
grant SELECT                                                                 on T0_NBS_LIST     to BARS;
grant SELECT                                                                 on T0_NBS_LIST     to BARSREADER_ROLE;
grant SELECT                                                                 on T0_NBS_LIST     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/T0_NBS_LIST.sql =========*** End **
PROMPT ===================================================================================== 
