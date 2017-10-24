

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_PERCENRATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_PERCENRATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_PERCENRATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_PERCENRATE 
   (	ID NUMBER(11,0), 
	NAME VARCHAR2(60), 
	SERV_I_VA NUMBER(11,0), 
	SERV_DB_S VARCHAR2(25), 
	SERV_KR_S VARCHAR2(25), 
	PERCENVID NUMBER(11,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_PERCENRATE ***
 exec bpa.alter_policies('S6_S6_PERCENRATE');


COMMENT ON TABLE BARS.S6_S6_PERCENRATE IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENRATE.ID IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENRATE.NAME IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENRATE.SERV_I_VA IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENRATE.SERV_DB_S IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENRATE.SERV_KR_S IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENRATE.PERCENVID IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_PERCENRATE.sql =========*** End 
PROMPT ===================================================================================== 
