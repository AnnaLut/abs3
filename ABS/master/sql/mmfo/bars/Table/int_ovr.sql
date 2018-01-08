

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_OVR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_OVR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_OVR'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_OVR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INT_OVR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_OVR ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_OVR 
   (	DNI NUMBER(*,0), 
	IR NUMBER, 
	KV NUMBER(*,0), 
	ID NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_OVR ***
 exec bpa.alter_policies('INT_OVR');


COMMENT ON TABLE BARS.INT_OVR IS 'Ранжирование плавающей % ставки';
COMMENT ON COLUMN BARS.INT_OVR.DNI IS 'Период (дни) беспрерывного пользования';
COMMENT ON COLUMN BARS.INT_OVR.IR IS '% ставка';
COMMENT ON COLUMN BARS.INT_OVR.KV IS 'Код вал';
COMMENT ON COLUMN BARS.INT_OVR.ID IS 'Номер шкали';
COMMENT ON COLUMN BARS.INT_OVR.KF IS '';




PROMPT *** Create  constraint XPK_INT_OVR ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_OVR ADD CONSTRAINT XPK_INT_OVR PRIMARY KEY (KF, ID, DNI, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTOVR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_OVR MODIFY (KF CONSTRAINT CC_INTOVR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_INT_OVR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_INT_OVR ON BARS.INT_OVR (KF, ID, DNI, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_OVR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OVR         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OVR         to BARS010;
grant SELECT                                                                 on INT_OVR         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_OVR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_OVR         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OVR         to REF0000;
grant INSERT                                                                 on INT_OVR         to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_OVR         to TECH006;
grant SELECT                                                                 on INT_OVR         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_OVR         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on INT_OVR         to WR_REFREAD;



PROMPT *** Create SYNONYM  to INT_OVR ***

  CREATE OR REPLACE PUBLIC SYNONYM INT_OVR FOR BARS.INT_OVR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_OVR.sql =========*** End *** =====
PROMPT ===================================================================================== 
