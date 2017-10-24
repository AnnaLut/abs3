

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_NAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_NAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_NAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_NAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_NAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_NAL 
   (	ACC NUMBER(*,0), 
	KV NUMBER(3,0), 
	NLS VARCHAR2(15), 
	OST_NAL NUMBER(24,0), 
	TOBO VARCHAR2(30), 
	S080 CHAR(1), 
	CUSTTYPE NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_NAL ***
 exec bpa.alter_policies('TMP_REZ_NAL');


COMMENT ON TABLE BARS.TMP_REZ_NAL IS '';
COMMENT ON COLUMN BARS.TMP_REZ_NAL.ACC IS '';
COMMENT ON COLUMN BARS.TMP_REZ_NAL.KV IS '';
COMMENT ON COLUMN BARS.TMP_REZ_NAL.NLS IS '';
COMMENT ON COLUMN BARS.TMP_REZ_NAL.OST_NAL IS '';
COMMENT ON COLUMN BARS.TMP_REZ_NAL.TOBO IS '';
COMMENT ON COLUMN BARS.TMP_REZ_NAL.S080 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_NAL.CUSTTYPE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_NAL.sql =========*** End *** =
PROMPT ===================================================================================== 
