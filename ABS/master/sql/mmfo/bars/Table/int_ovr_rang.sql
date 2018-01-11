

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_OVR_RANG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_OVR_RANG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_OVR_RANG'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_OVR_RANG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INT_OVR_RANG'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_OVR_RANG ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_OVR_RANG 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(35), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_OVR_RANG ***
 exec bpa.alter_policies('INT_OVR_RANG');


COMMENT ON TABLE BARS.INT_OVR_RANG IS 'Плаваючi % ставки Овердрафту. Шкали.';
COMMENT ON COLUMN BARS.INT_OVR_RANG.ID IS 'Код шкали';
COMMENT ON COLUMN BARS.INT_OVR_RANG.NAME IS 'Найменування шкали';
COMMENT ON COLUMN BARS.INT_OVR_RANG.KF IS '';




PROMPT *** Create  constraint XPK_INT_OVR_RANG ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_OVR_RANG ADD CONSTRAINT XPK_INT_OVR_RANG PRIMARY KEY (KF, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTOVRRANG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_OVR_RANG MODIFY (KF CONSTRAINT CC_INTOVRRANG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_INT_OVR_RANG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_INT_OVR_RANG ON BARS.INT_OVR_RANG (KF, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_OVR_RANG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OVR_RANG    to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OVR_RANG    to BARS009;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OVR_RANG    to BARS010;
grant SELECT                                                                 on INT_OVR_RANG    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_OVR_RANG    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_OVR_RANG    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OVR_RANG    to REF0000;
grant INSERT                                                                 on INT_OVR_RANG    to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OVR_RANG    to TECH006;
grant SELECT                                                                 on INT_OVR_RANG    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_OVR_RANG    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on INT_OVR_RANG    to WR_REFREAD;



PROMPT *** Create SYNONYM  to INT_OVR_RANG ***

  CREATE OR REPLACE PUBLIC SYNONYM INT_OVR_RANG FOR BARS.INT_OVR_RANG;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_OVR_RANG.sql =========*** End *** 
PROMPT ===================================================================================== 
