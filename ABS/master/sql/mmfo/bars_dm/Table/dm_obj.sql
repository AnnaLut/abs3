

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/DM_OBJ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table DM_OBJ ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.DM_OBJ 
   (	OBJ_NAME VARCHAR2(30), 
	IMP_TYPE VARCHAR2(10), 
	OBJ_PROC VARCHAR2(30), 
	IMP_ORDER NUMBER(2,0), 
	ACTIVE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.DM_OBJ IS '';
COMMENT ON COLUMN BARS_DM.DM_OBJ.OBJ_NAME IS '';
COMMENT ON COLUMN BARS_DM.DM_OBJ.IMP_TYPE IS '';
COMMENT ON COLUMN BARS_DM.DM_OBJ.OBJ_PROC IS '';
COMMENT ON COLUMN BARS_DM.DM_OBJ.IMP_ORDER IS '';
COMMENT ON COLUMN BARS_DM.DM_OBJ.ACTIVE IS '';




PROMPT *** Create  constraint PK_DM_OBJ ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_OBJ ADD CONSTRAINT PK_DM_OBJ PRIMARY KEY (OBJ_NAME, IMP_TYPE, ACTIVE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DM_OBJ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_DM_OBJ ON BARS_DM.DM_OBJ (OBJ_NAME, IMP_TYPE, ACTIVE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DM_OBJ ***
grant SELECT                                                                 on DM_OBJ          to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/DM_OBJ.sql =========*** End *** ===
PROMPT ===================================================================================== 
