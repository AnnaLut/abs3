

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_PARAMS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_PARAMS 
   (	DAT DATE, 
	ID NUMBER, 
	ACC NUMBER, 
	R013 VARCHAR2(1), 
	S270 VARCHAR2(2), 
	ISTVAL NUMBER(1,0), 
	S090 VARCHAR2(1), 
	OB22 VARCHAR2(2), 
	S370 VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_PARAMS ***
 exec bpa.alter_policies('TMP_REZ_PARAMS');


COMMENT ON TABLE BARS.TMP_REZ_PARAMS IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PARAMS.DAT IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PARAMS.ID IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PARAMS.ACC IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PARAMS.R013 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PARAMS.S270 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PARAMS.ISTVAL IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PARAMS.S090 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PARAMS.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_REZ_PARAMS.S370 IS '';




PROMPT *** Create  constraint PK_TMP_REZ_PARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_PARAMS ADD CONSTRAINT PK_TMP_REZ_PARAMS PRIMARY KEY (DAT, ID, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_REZ_PARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_REZ_PARAMS ON BARS.TMP_REZ_PARAMS (DAT, ID, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REZ_PARAMS ***
grant SELECT                                                                 on TMP_REZ_PARAMS  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_PARAMS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_PARAMS  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_PARAMS  to RCC_DEAL;
grant SELECT                                                                 on TMP_REZ_PARAMS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REZ_PARAMS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_PARAMS.sql =========*** End **
PROMPT ===================================================================================== 
