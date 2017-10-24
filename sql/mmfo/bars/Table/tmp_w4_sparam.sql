

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_SPARAM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_SPARAM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_SPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_SPARAM 
   (	GRP_CODE VARCHAR2(32), 
	TIP CHAR(3), 
	NBS CHAR(4), 
	SP_ID NUMBER(22,0), 
	VALUE VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_SPARAM ***
 exec bpa.alter_policies('TMP_W4_SPARAM');


COMMENT ON TABLE BARS.TMP_W4_SPARAM IS '';
COMMENT ON COLUMN BARS.TMP_W4_SPARAM.GRP_CODE IS '';
COMMENT ON COLUMN BARS.TMP_W4_SPARAM.TIP IS '';
COMMENT ON COLUMN BARS.TMP_W4_SPARAM.NBS IS '';
COMMENT ON COLUMN BARS.TMP_W4_SPARAM.SP_ID IS '';
COMMENT ON COLUMN BARS.TMP_W4_SPARAM.VALUE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_SPARAM.sql =========*** End ***
PROMPT ===================================================================================== 
