

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLPACC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLPACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLPACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLPACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLPACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLPACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLPACC 
   (	ACC NUMBER, 
	NEOM NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLPACC ***
 exec bpa.alter_policies('KLPACC');


COMMENT ON TABLE BARS.KLPACC IS '';
COMMENT ON COLUMN BARS.KLPACC.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.KLPACC.NEOM IS '';
COMMENT ON COLUMN BARS.KLPACC.KF IS '';




PROMPT *** Create  constraint CC_KLPACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPACC MODIFY (KF CONSTRAINT CC_KLPACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_KLPACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPACC ADD CONSTRAINT XPK_KLPACC PRIMARY KEY (ACC, NEOM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KLPACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KLPACC ON BARS.KLPACC (ACC, NEOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_NEOM_KLPACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_NEOM_KLPACC ON BARS.KLPACC (NEOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_ACC_KLPACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_ACC_KLPACC ON BARS.KLPACC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLPACC ***
grant SELECT                                                                 on KLPACC          to BARSAQ with grant option;
grant SELECT                                                                 on KLPACC          to BARSAQ_ADM with grant option;
grant SELECT                                                                 on KLPACC          to BARSREADER_ROLE;
grant SELECT                                                                 on KLPACC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLPACC          to BARS_DM;
grant SELECT                                                                 on KLPACC          to START1;
grant SELECT                                                                 on KLPACC          to TECH_MOM1;
grant SELECT                                                                 on KLPACC          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLPACC          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLPACC ***

  CREATE OR REPLACE PUBLIC SYNONYM KLPACC FOR BARS.KLPACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLPACC.sql =========*** End *** ======
PROMPT ===================================================================================== 
