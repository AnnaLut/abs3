

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLOP_CREF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLOP_CREF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLOP_CREF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KLOP_CREF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLOP_CREF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLOP_CREF ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLOP_CREF 
   (	REF NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SAB VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLOP_CREF ***
 exec bpa.alter_policies('KLOP_CREF');


COMMENT ON TABLE BARS.KLOP_CREF IS 'Рефы док-тов, которые были уже отсланы эл. клиентам в текущей выписке С';
COMMENT ON COLUMN BARS.KLOP_CREF.REF IS '';
COMMENT ON COLUMN BARS.KLOP_CREF.KF IS '';
COMMENT ON COLUMN BARS.KLOP_CREF.SAB IS '';




PROMPT *** Create  constraint XPK_KLOPCREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLOP_CREF ADD CONSTRAINT XPK_KLOPCREF PRIMARY KEY (KF, REF, SAB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLOPCREF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLOP_CREF MODIFY (KF CONSTRAINT CC_KLOPCREF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KLOPCREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KLOPCREF ON BARS.KLOP_CREF (KF, REF, SAB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLOP_CREF ***
grant SELECT                                                                 on KLOP_CREF       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLOP_CREF       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLOP_CREF.sql =========*** End *** ===
PROMPT ===================================================================================== 
