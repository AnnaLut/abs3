

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNK_ND_PORT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNK_ND_PORT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNK_ND_PORT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RNK_ND_PORT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNK_ND_PORT ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNK_ND_PORT 
   (	TIP VARCHAR2(4), 
	RNK NUMBER(*,0), 
	ND NUMBER(*,0), 
	S250 NUMBER(*,0), 
	GRP NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNK_ND_PORT ***
 exec bpa.alter_policies('RNK_ND_PORT');


COMMENT ON TABLE BARS.RNK_ND_PORT IS 'Портфельный метод';
COMMENT ON COLUMN BARS.RNK_ND_PORT.TIP IS 'Тип актива';
COMMENT ON COLUMN BARS.RNK_ND_PORT.RNK IS 'РНК';
COMMENT ON COLUMN BARS.RNK_ND_PORT.ND IS 'Реф.документа';
COMMENT ON COLUMN BARS.RNK_ND_PORT.S250 IS 'Портфельный метод';
COMMENT ON COLUMN BARS.RNK_ND_PORT.GRP IS 'Группа портфельного метода';
COMMENT ON COLUMN BARS.RNK_ND_PORT.KF IS '';




PROMPT *** Create  constraint PK_RNK_ND_PORT ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK_ND_PORT ADD CONSTRAINT PK_RNK_ND_PORT PRIMARY KEY (RNK, ND, TIP, GRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RNKNDPORT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK_ND_PORT MODIFY (KF CONSTRAINT CC_RNKNDPORT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RNK_ND_PORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RNK_ND_PORT ON BARS.RNK_ND_PORT (RNK, ND, TIP, GRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNK_ND_PORT ***
grant SELECT                                                                 on RNK_ND_PORT     to BARSREADER_ROLE;
grant SELECT                                                                 on RNK_ND_PORT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RNK_ND_PORT     to RCC_DEAL;
grant SELECT                                                                 on RNK_ND_PORT     to START1;
grant SELECT                                                                 on RNK_ND_PORT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNK_ND_PORT.sql =========*** End *** =
PROMPT ===================================================================================== 
