PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_OPER_HISTORY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_OPER_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_OPER_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_OPER_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_OPER_HISTORY 
   (	OP_REF NUMBER, 
	OLD_STATUS VARCHAR2(2), 
	NEW_STATUS VARCHAR2(2), 
	USER_REF NUMBER, 
	DT_CHANGE DATE, 
	ID NUMBER, 
	HOST VARCHAR2(100) DEFAULT null
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_OPER_HISTORY ***
 exec bpa.alter_policies('TELLER_OPER_HISTORY');


COMMENT ON TABLE BARS.TELLER_OPER_HISTORY IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_HISTORY.OP_REF IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_HISTORY.OLD_STATUS IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_HISTORY.NEW_STATUS IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_HISTORY.USER_REF IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_HISTORY.DT_CHANGE IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_HISTORY.ID IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_HISTORY.HOST IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_OPER_HISTORY.sql =========*** E
PROMPT ===================================================================================== 
