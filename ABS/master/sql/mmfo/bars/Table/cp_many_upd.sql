

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_MANY_UPD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_MANY_UPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_MANY_UPD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_MANY_UPD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CP_MANY_UPD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_MANY_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_MANY_UPD 
   (	U_ID NUMBER(*,0), 
	U_DAT DATE, 
	REF NUMBER(*,0), 
	FDAT DATE, 
	SS1 NUMBER, 
	SDP NUMBER, 
	SN2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_MANY_UPD ***
 exec bpa.alter_policies('CP_MANY_UPD');


COMMENT ON TABLE BARS.CP_MANY_UPD IS '';
COMMENT ON COLUMN BARS.CP_MANY_UPD.U_ID IS '';
COMMENT ON COLUMN BARS.CP_MANY_UPD.U_DAT IS '';
COMMENT ON COLUMN BARS.CP_MANY_UPD.REF IS '';
COMMENT ON COLUMN BARS.CP_MANY_UPD.FDAT IS '';
COMMENT ON COLUMN BARS.CP_MANY_UPD.SS1 IS '';
COMMENT ON COLUMN BARS.CP_MANY_UPD.SDP IS '';
COMMENT ON COLUMN BARS.CP_MANY_UPD.SN2 IS '';




PROMPT *** Create  constraint PK_CPMANYUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_MANY_UPD ADD CONSTRAINT PK_CPMANYUPD PRIMARY KEY (U_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CPMANYUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CPMANYUPD ON BARS.CP_MANY_UPD (U_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CPMANYUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CPMANYUPD ON BARS.CP_MANY_UPD (U_DAT, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_MANY_UPD ***
grant SELECT                                                                 on CP_MANY_UPD     to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_MANY_UPD     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_MANY_UPD     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_MANY_UPD     to START1;
grant SELECT                                                                 on CP_MANY_UPD     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_MANY_UPD.sql =========*** End *** =
PROMPT ===================================================================================== 
