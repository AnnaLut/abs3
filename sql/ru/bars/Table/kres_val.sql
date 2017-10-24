

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KRES_VAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KRES_VAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KRES_VAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.KRES_VAL 
   (	CC_ID NUMBER(9,0), 
	SDATE DATE, 
	LIMIT NUMBER(12,0), 
	IR NUMBER(14,8), 
	WDATE DATE, 
	KV NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KRES_VAL ***
 exec bpa.alter_policies('KRES_VAL');


COMMENT ON TABLE BARS.KRES_VAL IS '';
COMMENT ON COLUMN BARS.KRES_VAL.CC_ID IS '';
COMMENT ON COLUMN BARS.KRES_VAL.SDATE IS '';
COMMENT ON COLUMN BARS.KRES_VAL.LIMIT IS '';
COMMENT ON COLUMN BARS.KRES_VAL.IR IS '';
COMMENT ON COLUMN BARS.KRES_VAL.WDATE IS '';
COMMENT ON COLUMN BARS.KRES_VAL.KV IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KRES_VAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
