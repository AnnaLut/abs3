

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACC_MSG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACC_MSG ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACC_MSG ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACC_MSG 
   (	MSG_ID NUMBER(*,0), 
	CHANGE_TIME DATE, 
	RNK NUMBER(*,0), 
	ACC NUMBER(*,0), 
	OSTC NUMBER, 
	DOS_DELTA NUMBER, 
	KOS_DELTA NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACC_MSG ***
 exec bpa.alter_policies('TMP_ACC_MSG');


COMMENT ON TABLE BARS.TMP_ACC_MSG IS '';
COMMENT ON COLUMN BARS.TMP_ACC_MSG.MSG_ID IS '';
COMMENT ON COLUMN BARS.TMP_ACC_MSG.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.TMP_ACC_MSG.RNK IS '';
COMMENT ON COLUMN BARS.TMP_ACC_MSG.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACC_MSG.OSTC IS '';
COMMENT ON COLUMN BARS.TMP_ACC_MSG.DOS_DELTA IS '';
COMMENT ON COLUMN BARS.TMP_ACC_MSG.KOS_DELTA IS '';




PROMPT *** Create  constraint SYS_C00119319 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_MSG MODIFY (MSG_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119321 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_MSG MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119320 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_MSG MODIFY (CHANGE_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACC_MSG.sql =========*** End *** =
PROMPT ===================================================================================== 
