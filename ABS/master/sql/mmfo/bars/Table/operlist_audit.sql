

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OPERLIST_AUDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OPERLIST_AUDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OPERLIST_AUDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OPERLIST_AUDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OPERLIST_AUDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OPERLIST_AUDIT 
   (	REC_DARE DATE, 
	ID NUMBER, 
	FUNCNAME VARCHAR2(1000), 
	NAME VARCHAR2(1000), 
	USERID NUMBER, 
	CHANGE_TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OPERLIST_AUDIT ***
 exec bpa.alter_policies('OPERLIST_AUDIT');


COMMENT ON TABLE BARS.OPERLIST_AUDIT IS 'Аудит перечня функций';
COMMENT ON COLUMN BARS.OPERLIST_AUDIT.REC_DARE IS '';
COMMENT ON COLUMN BARS.OPERLIST_AUDIT.ID IS '';
COMMENT ON COLUMN BARS.OPERLIST_AUDIT.FUNCNAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_AUDIT.NAME IS '';
COMMENT ON COLUMN BARS.OPERLIST_AUDIT.USERID IS '';
COMMENT ON COLUMN BARS.OPERLIST_AUDIT.CHANGE_TYPE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OPERLIST_AUDIT.sql =========*** End **
PROMPT ===================================================================================== 
