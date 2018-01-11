

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/IMP_SHEDULER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table IMP_SHEDULER ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.IMP_SHEDULER 
   (	ID NUMBER(38,0), 
	RUN_DATE DATE, 
	IMP_TYPEID VARCHAR2(100), 
	STATUS VARCHAR2(20), 
	COMM VARCHAR2(500)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.IMP_SHEDULER IS '';
COMMENT ON COLUMN BARS_DM.IMP_SHEDULER.ID IS '';
COMMENT ON COLUMN BARS_DM.IMP_SHEDULER.RUN_DATE IS '';
COMMENT ON COLUMN BARS_DM.IMP_SHEDULER.IMP_TYPEID IS '';
COMMENT ON COLUMN BARS_DM.IMP_SHEDULER.STATUS IS '';
COMMENT ON COLUMN BARS_DM.IMP_SHEDULER.COMM IS '';



PROMPT *** Create  grants  IMP_SHEDULER ***
grant SELECT                                                                 on IMP_SHEDULER    to BARSREADER_ROLE;
grant SELECT                                                                 on IMP_SHEDULER    to BARSUPL;
grant SELECT                                                                 on IMP_SHEDULER    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/IMP_SHEDULER.sql =========*** End *
PROMPT ===================================================================================== 
