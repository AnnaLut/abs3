

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/REGIONS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table REGIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.REGIONS 
   (	ID NUMBER, 
	KF VARCHAR2(6), 
	NAME VARCHAR2(64), 
	PCODE VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.REGIONS IS 'Довідник регіонів';
COMMENT ON COLUMN BARS_DM.REGIONS.PCODE IS 'Телефонний код регіона';
COMMENT ON COLUMN BARS_DM.REGIONS.ID IS 'Код регіона';
COMMENT ON COLUMN BARS_DM.REGIONS.KF IS 'МФО регіона';
COMMENT ON COLUMN BARS_DM.REGIONS.NAME IS 'Назва регіона';




PROMPT *** Create  constraint PK_REGIONS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.REGIONS ADD CONSTRAINT PK_REGIONS_KF PRIMARY KEY (KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REGIONS_KF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_REGIONS_KF ON BARS_DM.REGIONS (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REGIONS ***
grant SELECT                                                                 on REGIONS         to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/REGIONS.sql =========*** End *** ==
PROMPT ===================================================================================== 
