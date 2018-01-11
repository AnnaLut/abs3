

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOB_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOB_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOB_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOB_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOB_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOB_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOB_ACC 
   (	ACC26 NUMBER(*,0), 
	ACC35 NUMBER(*,0), 
	TARIF NUMBER(*,0), 
	NLS6 VARCHAR2(15), 
	ND VARCHAR2(20), 
	DATND DATE, 
	DATS DATE, 
	DATP DATE, 
	NAZN VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOB_ACC ***
 exec bpa.alter_policies('KOB_ACC');


COMMENT ON TABLE BARS.KOB_ACC IS '';
COMMENT ON COLUMN BARS.KOB_ACC.ACC26 IS '';
COMMENT ON COLUMN BARS.KOB_ACC.ACC35 IS '';
COMMENT ON COLUMN BARS.KOB_ACC.TARIF IS '';
COMMENT ON COLUMN BARS.KOB_ACC.NLS6 IS '';
COMMENT ON COLUMN BARS.KOB_ACC.ND IS '';
COMMENT ON COLUMN BARS.KOB_ACC.DATND IS '';
COMMENT ON COLUMN BARS.KOB_ACC.DATS IS '';
COMMENT ON COLUMN BARS.KOB_ACC.DATP IS '';
COMMENT ON COLUMN BARS.KOB_ACC.NAZN IS '';




PROMPT *** Create  constraint XPK_KOB_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOB_ACC ADD CONSTRAINT XPK_KOB_ACC PRIMARY KEY (ACC26)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KOB_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KOB_ACC ON BARS.KOB_ACC (ACC26) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KOB_ACC ***
grant SELECT                                                                 on KOB_ACC         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOB_ACC         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOB_ACC         to START1;
grant SELECT                                                                 on KOB_ACC         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOB_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
