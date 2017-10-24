

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAL_DEC8$BASE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAL_DEC8$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NAL_DEC8$BASE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NAL_DEC8$BASE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NAL_DEC8$BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAL_DEC8$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.NAL_DEC8$BASE 
   (	NLS8 VARCHAR2(15), 
	NLS VARCHAR2(15), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAL_DEC8$BASE ***
 exec bpa.alter_policies('NAL_DEC8$BASE');


COMMENT ON TABLE BARS.NAL_DEC8$BASE IS '';
COMMENT ON COLUMN BARS.NAL_DEC8$BASE.NLS8 IS '';
COMMENT ON COLUMN BARS.NAL_DEC8$BASE.NLS IS '';
COMMENT ON COLUMN BARS.NAL_DEC8$BASE.KF IS '';




PROMPT *** Create  constraint FK_NALDEC8$BASE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_DEC8$BASE ADD CONSTRAINT FK_NALDEC8$BASE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008785 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_DEC8$BASE MODIFY (NLS8 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NALDEC8$BASE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_DEC8$BASE MODIFY (KF CONSTRAINT CC_NALDEC8$BASE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NAL_DEC8$BASE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC8$BASE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NAL_DEC8$BASE   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC8$BASE   to NALOG;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC8$BASE   to NAL_DEC8$BASE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAL_DEC8$BASE   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to NAL_DEC8$BASE ***

  CREATE OR REPLACE PUBLIC SYNONYM NAL_DEC8$BASE FOR BARS.NAL_DEC8$BASE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAL_DEC8$BASE.sql =========*** End ***
PROMPT ===================================================================================== 
