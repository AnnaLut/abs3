

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OBPC_TRANS_OUT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OBPC_TRANS_OUT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OBPC_TRANS_OUT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OBPC_TRANS_OUT 
   (	TRAN_TYPE CHAR(2), 
	TT CHAR(3), 
	DK NUMBER(1,0), 
	W4_MSGCODE VARCHAR2(100), 
	PAY_FLAG NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OBPC_TRANS_OUT ***
 exec bpa.alter_policies('TMP_OBPC_TRANS_OUT');


COMMENT ON TABLE BARS.TMP_OBPC_TRANS_OUT IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS_OUT.TRAN_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS_OUT.TT IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS_OUT.DK IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS_OUT.W4_MSGCODE IS '';
COMMENT ON COLUMN BARS.TMP_OBPC_TRANS_OUT.PAY_FLAG IS '';




PROMPT *** Create  constraint SYS_C00119212 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OBPC_TRANS_OUT MODIFY (TRAN_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119215 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OBPC_TRANS_OUT MODIFY (W4_MSGCODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119214 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OBPC_TRANS_OUT MODIFY (DK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119213 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OBPC_TRANS_OUT MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OBPC_TRANS_OUT.sql =========*** En
PROMPT ===================================================================================== 
