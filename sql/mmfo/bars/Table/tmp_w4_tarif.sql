

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_TARIF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_TARIF 
   (	PRODUCT_GROUPS VARCHAR2(30), 
	TARIF_CODE VARCHAR2(30), 
	TARIF_NAME VARCHAR2(500), 
	VELCTR_MAESTRO_MELCTR VARCHAR2(300), 
	VCLASSDOM VARCHAR2(300), 
	VCLASS VARCHAR2(300), 
	MSTNDDEB VARCHAR2(300), 
	VGOLD_MGOLD VARCHAR2(300), 
	MGOLDDEB VARCHAR2(300), 
	VBSNS VARCHAR2(300), 
	VBSNSELCTR VARCHAR2(300), 
	MCORP VARCHAR2(300), 
	VPLAT VARCHAR2(300), 
	MPLAT VARCHAR2(300), 
	MPLATDEB VARCHAR2(300), 
	MSIGN VARCHAR2(300), 
	VVIRTUAL VARCHAR2(300), 
	MSTND VARCHAR2(300), 
	MWORLD VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_TARIF ***
 exec bpa.alter_policies('TMP_W4_TARIF');


COMMENT ON TABLE BARS.TMP_W4_TARIF IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.PRODUCT_GROUPS IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.TARIF_CODE IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.TARIF_NAME IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.VELCTR_MAESTRO_MELCTR IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.VCLASSDOM IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.VCLASS IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.MSTNDDEB IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.VGOLD_MGOLD IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.MGOLDDEB IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.VBSNS IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.VBSNSELCTR IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.MCORP IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.VPLAT IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.MPLAT IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.MPLATDEB IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.MSIGN IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.VVIRTUAL IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.MSTND IS '';
COMMENT ON COLUMN BARS.TMP_W4_TARIF.MWORLD IS '';




PROMPT *** Create  constraint SYS_C00119210 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_TARIF MODIFY (PRODUCT_GROUPS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119211 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_TARIF MODIFY (TARIF_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_W4_TARIF ***
grant SELECT                                                                 on TMP_W4_TARIF    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_W4_TARIF    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_TARIF.sql =========*** End *** 
PROMPT ===================================================================================== 
