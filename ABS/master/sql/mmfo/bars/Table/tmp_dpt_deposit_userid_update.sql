

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_DEPOSIT_USERID_UPDATE.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_DEPOSIT_USERID_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_DEPOSIT_USERID_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_DEPOSIT_USERID_UPDATE 
   (	DEPOSIT_ID NUMBER(38,0), 
	REDUNDANT_ID NUMBER(38,0), 
	CURRENT_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_DEPOSIT_USERID_UPDATE ***
 exec bpa.alter_policies('TMP_DPT_DEPOSIT_USERID_UPDATE');


COMMENT ON TABLE BARS.TMP_DPT_DEPOSIT_USERID_UPDATE IS '';
COMMENT ON COLUMN BARS.TMP_DPT_DEPOSIT_USERID_UPDATE.DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_DEPOSIT_USERID_UPDATE.REDUNDANT_ID IS '';
COMMENT ON COLUMN BARS.TMP_DPT_DEPOSIT_USERID_UPDATE.CURRENT_ID IS '';




PROMPT *** Create  constraint SYS_C00132342 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_DEPOSIT_USERID_UPDATE MODIFY (DEPOSIT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132343 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPT_DEPOSIT_USERID_UPDATE MODIFY (CURRENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DPT_DEPOSIT_USERID_UPDATE ***
grant SELECT                                                                 on TMP_DPT_DEPOSIT_USERID_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_DEPOSIT_USERID_UPDATE.sql ====
PROMPT ===================================================================================== 
