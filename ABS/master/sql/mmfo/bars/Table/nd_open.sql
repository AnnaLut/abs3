

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_OPEN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_OPEN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_OPEN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_OPEN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_OPEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_OPEN 
   (	FDAT DATE, 
	ND NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_OPEN ***
 exec bpa.alter_policies('ND_OPEN');


COMMENT ON TABLE BARS.ND_OPEN IS 'Діючі угоди';
COMMENT ON COLUMN BARS.ND_OPEN.FDAT IS 'Звітна дата';
COMMENT ON COLUMN BARS.ND_OPEN.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.ND_OPEN.KF IS '';




PROMPT *** Create  constraint PK_ND_OPEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_OPEN ADD CONSTRAINT PK_ND_OPEN PRIMARY KEY (FDAT, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDOPEN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_OPEN MODIFY (KF CONSTRAINT CC_NDOPEN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ND_OPEN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ND_OPEN ON BARS.ND_OPEN (FDAT, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_OPEN ***
grant SELECT                                                                 on ND_OPEN         to BARSREADER_ROLE;
grant SELECT                                                                 on ND_OPEN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_OPEN         to RCC_DEAL;
grant SELECT                                                                 on ND_OPEN         to START1;
grant SELECT                                                                 on ND_OPEN         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_OPEN.sql =========*** End *** =====
PROMPT ===================================================================================== 
