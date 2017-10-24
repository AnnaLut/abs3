

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KRES_980.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KRES_980 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KRES_980 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KRES_980 
   (	CC_ID NUMBER(9,0), 
	KV NUMBER(9,0), 
	SDATE DATE, 
	LIMIT NUMBER(23,8), 
	IR NUMBER(15,8), 
	WDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KRES_980 ***
 exec bpa.alter_policies('KRES_980');


COMMENT ON TABLE BARS.KRES_980 IS '';
COMMENT ON COLUMN BARS.KRES_980.CC_ID IS '';
COMMENT ON COLUMN BARS.KRES_980.KV IS '';
COMMENT ON COLUMN BARS.KRES_980.SDATE IS '';
COMMENT ON COLUMN BARS.KRES_980.LIMIT IS '';
COMMENT ON COLUMN BARS.KRES_980.IR IS '';
COMMENT ON COLUMN BARS.KRES_980.WDATE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KRES_980.sql =========*** End *** ====
PROMPT ===================================================================================== 
