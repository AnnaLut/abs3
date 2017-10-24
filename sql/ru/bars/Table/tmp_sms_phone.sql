

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SMS_PHONE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SMS_PHONE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SMS_PHONE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SMS_PHONE 
   (	PHONE CHAR(13), 
	MFO VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SMS_PHONE ***
 exec bpa.alter_policies('TMP_SMS_PHONE');


COMMENT ON TABLE BARS.TMP_SMS_PHONE IS '';
COMMENT ON COLUMN BARS.TMP_SMS_PHONE.PHONE IS '';
COMMENT ON COLUMN BARS.TMP_SMS_PHONE.MFO IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SMS_PHONE.sql =========*** End ***
PROMPT ===================================================================================== 
