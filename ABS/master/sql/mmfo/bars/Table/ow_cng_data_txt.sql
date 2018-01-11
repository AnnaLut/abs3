

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CNG_DATA_TXT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CNG_DATA_TXT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CNG_DATA_TXT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_CNG_DATA_TXT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CNG_DATA_TXT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CNG_DATA_TXT 
   (	ID NUMBER, 
	IDN NUMBER, 
	KF VARCHAR2(6), 
	NLS VARCHAR2(15), 
	ACC_PK NUMBER, 
	DAT_BAL DATE, 
	NBS_OW VARCHAR2(15), 
	OST NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CNG_DATA_TXT ***
 exec bpa.alter_policies('OW_CNG_DATA_TXT');


COMMENT ON TABLE BARS.OW_CNG_DATA_TXT IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA_TXT.ID IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA_TXT.IDN IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA_TXT.KF IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA_TXT.NLS IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA_TXT.ACC_PK IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA_TXT.DAT_BAL IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA_TXT.NBS_OW IS '';
COMMENT ON COLUMN BARS.OW_CNG_DATA_TXT.OST IS '';




PROMPT *** Create  index IDX_OW_CNG_DATA_TXT_ACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_OW_CNG_DATA_TXT_ACC ON BARS.OW_CNG_DATA_TXT (ACC_PK, NBS_OW, OST) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CNG_DATA_TXT ***
grant SELECT                                                                 on OW_CNG_DATA_TXT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CNG_DATA_TXT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_CNG_DATA_TXT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CNG_DATA_TXT.sql =========*** End *
PROMPT ===================================================================================== 
