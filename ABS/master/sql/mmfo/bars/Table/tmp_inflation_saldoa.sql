

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INFLATION_SALDOA.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INFLATION_SALDOA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_INFLATION_SALDOA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_INFLATION_SALDOA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_INFLATION_SALDOA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INFLATION_SALDOA ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_INFLATION_SALDOA 
   (	ACC NUMBER(*,0), 
	FDAT DATE, 
	OSTF NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INFLATION_SALDOA ***
 exec bpa.alter_policies('TMP_INFLATION_SALDOA');


COMMENT ON TABLE BARS.TMP_INFLATION_SALDOA IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SALDOA.ACC IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SALDOA.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SALDOA.OSTF IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SALDOA.DOS IS '';
COMMENT ON COLUMN BARS.TMP_INFLATION_SALDOA.KOS IS '';




PROMPT *** Create  constraint TMPI_SALDOA_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INFLATION_SALDOA MODIFY (ACC CONSTRAINT TMPI_SALDOA_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint TMPI_SALDOA_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INFLATION_SALDOA MODIFY (FDAT CONSTRAINT TMPI_SALDOA_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint TMPI_SALDOA_OSTF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INFLATION_SALDOA MODIFY (OSTF CONSTRAINT TMPI_SALDOA_OSTF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint TMPI_SALDOA_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INFLATION_SALDOA MODIFY (DOS CONSTRAINT TMPI_SALDOA_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint TMPI_SALDOA_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INFLATION_SALDOA MODIFY (KOS CONSTRAINT TMPI_SALDOA_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_INFLATION_SALDOA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_INFLATION_SALDOA ON BARS.TMP_INFLATION_SALDOA (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_INFLATION_SALDOA ***
grant SELECT                                                                 on TMP_INFLATION_SALDOA to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_INFLATION_SALDOA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INFLATION_SALDOA.sql =========*** 
PROMPT ===================================================================================== 
