

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_SPN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_SPN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_SPN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_SPN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_SPN ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_SPN 
   (	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	S NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_SPN ***
 exec bpa.alter_policies('REZ_SPN');


COMMENT ON TABLE BARS.REZ_SPN IS '';
COMMENT ON COLUMN BARS.REZ_SPN.KF IS '';
COMMENT ON COLUMN BARS.REZ_SPN.ACC IS '';
COMMENT ON COLUMN BARS.REZ_SPN.NLS IS '';
COMMENT ON COLUMN BARS.REZ_SPN.KV IS '';
COMMENT ON COLUMN BARS.REZ_SPN.S IS '';




PROMPT *** Create  constraint PK_REZ_SPN_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_SPN ADD CONSTRAINT PK_REZ_SPN_ACC PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZSPN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_SPN MODIFY (KF CONSTRAINT CC_REZSPN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_SPN_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_SPN_ACC ON BARS.REZ_SPN (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_SPN ***
grant SELECT                                                                 on REZ_SPN         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_SPN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_SPN         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_SPN         to START1;
grant SELECT                                                                 on REZ_SPN         to UPLD;
grant FLASHBACK,SELECT                                                       on REZ_SPN         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_SPN.sql =========*** End *** =====
PROMPT ===================================================================================== 
