

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCI.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCI'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCI'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCI'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCI ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCI 
   (	ACC NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	HIGH NUMBER, 
	PERS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCI ***
 exec bpa.alter_policies('ACCI');


COMMENT ON TABLE BARS.ACCI IS 'Счета электронных клиентов (доступ на дебет)';
COMMENT ON COLUMN BARS.ACCI.ACC IS '';
COMMENT ON COLUMN BARS.ACCI.KF IS '';
COMMENT ON COLUMN BARS.ACCI.HIGH IS 'Доступ вышестоящим';
COMMENT ON COLUMN BARS.ACCI.PERS IS 'Доступ себе';




PROMPT *** Create  constraint XPK_ACCI ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCI ADD CONSTRAINT XPK_ACCI PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCI_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCI MODIFY (KF CONSTRAINT CC_ACCI_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACCI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACCI ON BARS.ACCI (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCI ***
grant SELECT                                                                 on ACCI            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on ACCI            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCI            to BARS_DM;
grant SELECT                                                                 on ACCI            to OPERKKK;
grant DELETE,INSERT,SELECT                                                   on ACCI            to TECH_MOM1;
grant SELECT                                                                 on ACCI            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCI            to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ACCI ***

  CREATE OR REPLACE PUBLIC SYNONYM ACCI FOR BARS.ACCI;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCI.sql =========*** End *** ========
PROMPT ===================================================================================== 
