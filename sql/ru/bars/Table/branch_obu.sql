

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_OBU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_OBU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_OBU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_OBU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_OBU ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_OBU 
   (	BRANCH VARCHAR2(25), 
	RID NUMBER(4,0), 
	RU VARCHAR2(20), 
	NAME VARCHAR2(100), 
	TYPE VARCHAR2(5), 
	OPENDATE VARCHAR2(10), 
	CLOSEDATE VARCHAR2(10), 
	CODE VARCHAR2(20), 
	BRANCHID NUMBER(8,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_OBU ***
 exec bpa.alter_policies('BRANCH_OBU');


COMMENT ON TABLE BARS.BRANCH_OBU IS 'Підрозділи банку';
COMMENT ON COLUMN BARS.BRANCH_OBU.BRANCH IS 'Код підрозділу';
COMMENT ON COLUMN BARS.BRANCH_OBU.RID IS 'Ід. РУ';
COMMENT ON COLUMN BARS.BRANCH_OBU.RU IS 'Назва РУ';
COMMENT ON COLUMN BARS.BRANCH_OBU.NAME IS 'Назва підрозділу';
COMMENT ON COLUMN BARS.BRANCH_OBU.TYPE IS '';
COMMENT ON COLUMN BARS.BRANCH_OBU.OPENDATE IS '';
COMMENT ON COLUMN BARS.BRANCH_OBU.CLOSEDATE IS '';
COMMENT ON COLUMN BARS.BRANCH_OBU.CODE IS '';
COMMENT ON COLUMN BARS.BRANCH_OBU.BRANCHID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_OBU.sql =========*** End *** ==
PROMPT ===================================================================================== 
