PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_TT_HISTORY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_TT_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_TT_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_TT_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_TT_HISTORY 
   (	USER_ID NUMBER, 
	WORK_DATE DATE, 
	ACTION VARCHAR2(1), 
	TT_REC BARS.T_STAFF_TTS 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_TT_HISTORY ***
 exec bpa.alter_policies('TELLER_TT_HISTORY');


COMMENT ON TABLE BARS.TELLER_TT_HISTORY IS '';
COMMENT ON COLUMN BARS.TELLER_TT_HISTORY.USER_ID IS '';
COMMENT ON COLUMN BARS.TELLER_TT_HISTORY.WORK_DATE IS '';
COMMENT ON COLUMN BARS.TELLER_TT_HISTORY.ACTION IS '';
COMMENT ON COLUMN BARS.TELLER_TT_HISTORY.TT_REC IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_TT_HISTORY.sql =========*** End
PROMPT ===================================================================================== 
