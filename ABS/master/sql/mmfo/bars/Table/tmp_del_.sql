

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DEL_.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DEL_ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DEL_ ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DEL_ 
   (	NEXTVAL NUMBER(*,0), 
	OBJ_ID NUMBER, 
	OBJ_TYPE NUMBER, 
	ST NUMBER, 
	WW CHAR(1), 
	USERID NUMBER, 
	US CHAR(25), 
	D DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DEL_ ***
 exec bpa.alter_policies('TMP_DEL_');


COMMENT ON TABLE BARS.TMP_DEL_ IS '';
COMMENT ON COLUMN BARS.TMP_DEL_.NEXTVAL IS '';
COMMENT ON COLUMN BARS.TMP_DEL_.OBJ_ID IS '';
COMMENT ON COLUMN BARS.TMP_DEL_.OBJ_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_DEL_.ST IS '';
COMMENT ON COLUMN BARS.TMP_DEL_.WW IS '';
COMMENT ON COLUMN BARS.TMP_DEL_.USERID IS '';
COMMENT ON COLUMN BARS.TMP_DEL_.US IS '';
COMMENT ON COLUMN BARS.TMP_DEL_.D IS '';



PROMPT *** Create  grants  TMP_DEL_ ***
grant SELECT                                                                 on TMP_DEL_        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DEL_.sql =========*** End *** ====
PROMPT ===================================================================================== 
