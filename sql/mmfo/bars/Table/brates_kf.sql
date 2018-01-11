

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRATES_KF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRATES_KF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRATES_KF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BRATES_KF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRATES_KF ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRATES_KF 
   (	KF VARCHAR2(6), 
	BR_ID NUMBER(38,0), 
	NEW_BR_ID NUMBER(38,0), 
	ROWS_QTY NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRATES_KF ***
 exec bpa.alter_policies('BRATES_KF');


COMMENT ON TABLE BARS.BRATES_KF IS '';
COMMENT ON COLUMN BARS.BRATES_KF.KF IS '';
COMMENT ON COLUMN BARS.BRATES_KF.BR_ID IS '';
COMMENT ON COLUMN BARS.BRATES_KF.NEW_BR_ID IS '';
COMMENT ON COLUMN BARS.BRATES_KF.ROWS_QTY IS '';



PROMPT *** Create  grants  BRATES_KF ***
grant SELECT                                                                 on BRATES_KF       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRATES_KF.sql =========*** End *** ===
PROMPT ===================================================================================== 
