

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_EWA_REF_SOS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_EWA_REF_SOS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_EWA_REF_SOS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_EWA_REF_SOS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_EWA_REF_SOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_EWA_REF_SOS 
   (	REF NUMBER, 
	ID_EWA NUMBER, 
	CRT_DATE DATE, 
	SOS NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_EWA_REF_SOS ***
 exec bpa.alter_policies('INS_EWA_REF_SOS');


COMMENT ON TABLE BARS.INS_EWA_REF_SOS IS 'Документы,для передачи состояния в ПО EWA ';
COMMENT ON COLUMN BARS.INS_EWA_REF_SOS.REF IS '';
COMMENT ON COLUMN BARS.INS_EWA_REF_SOS.ID_EWA IS '';
COMMENT ON COLUMN BARS.INS_EWA_REF_SOS.CRT_DATE IS '';
COMMENT ON COLUMN BARS.INS_EWA_REF_SOS.SOS IS '';
COMMENT ON COLUMN BARS.INS_EWA_REF_SOS.KF IS '';




PROMPT *** Create  constraint PK_INS_EWA_REF_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_EWA_REF_SOS ADD CONSTRAINT PK_INS_EWA_REF_SOS PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INS_EWA_REF_SOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INS_EWA_REF_SOS ON BARS.INS_EWA_REF_SOS (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_EWA_REF_SOS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INS_EWA_REF_SOS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INS_EWA_REF_SOS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_EWA_REF_SOS.sql =========*** End *
PROMPT ===================================================================================== 
