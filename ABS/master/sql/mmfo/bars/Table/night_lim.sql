

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NIGHT_LIM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NIGHT_LIM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NIGHT_LIM'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NIGHT_LIM'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NIGHT_LIM'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NIGHT_LIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.NIGHT_LIM 
   (	KV NUMBER(*,0), 
	NLS VARCHAR2(15), 
	LIM NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NIGHT_LIM ***
 exec bpa.alter_policies('NIGHT_LIM');


COMMENT ON TABLE BARS.NIGHT_LIM IS 'Ночной лимит';
COMMENT ON COLUMN BARS.NIGHT_LIM.KV IS 'Вал';
COMMENT ON COLUMN BARS.NIGHT_LIM.NLS IS 'Счет';
COMMENT ON COLUMN BARS.NIGHT_LIM.LIM IS 'Сумма лимита в коп.';
COMMENT ON COLUMN BARS.NIGHT_LIM.KF IS '';




PROMPT *** Create  constraint PK_NIGHTLIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.NIGHT_LIM ADD CONSTRAINT PK_NIGHTLIM PRIMARY KEY (KV, NLS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NIGHTLIM_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NIGHT_LIM MODIFY (KF CONSTRAINT CC_NIGHTLIM_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NIGHTLIM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NIGHTLIM ON BARS.NIGHT_LIM (KV, NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NIGHT_LIM ***
grant SELECT                                                                 on NIGHT_LIM       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NIGHT_LIM       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NIGHT_LIM       to PYOD001;
grant SELECT                                                                 on NIGHT_LIM       to UPLD;
grant FLASHBACK,SELECT                                                       on NIGHT_LIM       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NIGHT_LIM.sql =========*** End *** ===
PROMPT ===================================================================================== 
