PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_ROLE_HISTORY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_ROLE_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_ROLE_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_ROLE_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_ROLE_HISTORY 
   (	USER_ID NUMBER, 
	OPERS_REVOKED VARCHAR2(2000), 
	OPERS_GRANTED VARCHAR2(2000), 
	OPERS_INSERTED VARCHAR2(2000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_ROLE_HISTORY ***
 exec bpa.alter_policies('TELLER_ROLE_HISTORY');


COMMENT ON TABLE BARS.TELLER_ROLE_HISTORY IS '';
COMMENT ON COLUMN BARS.TELLER_ROLE_HISTORY.USER_ID IS '';
COMMENT ON COLUMN BARS.TELLER_ROLE_HISTORY.OPERS_REVOKED IS '';
COMMENT ON COLUMN BARS.TELLER_ROLE_HISTORY.OPERS_GRANTED IS '';
COMMENT ON COLUMN BARS.TELLER_ROLE_HISTORY.OPERS_INSERTED IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_ROLE_HISTORY.sql =========*** E
PROMPT ===================================================================================== 
