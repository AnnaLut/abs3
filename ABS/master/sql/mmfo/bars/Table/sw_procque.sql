

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_PROCQUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_PROCQUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_PROCQUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_PROCQUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_PROCQUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_PROCQUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_PROCQUE 
   (	SWREF NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	 CONSTRAINT PK_SWPROCQUE PRIMARY KEY (SWREF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_PROCQUE ***
 exec bpa.alter_policies('SW_PROCQUE');


COMMENT ON TABLE BARS.SW_PROCQUE IS 'Очередь исходящих сообщений';
COMMENT ON COLUMN BARS.SW_PROCQUE.SWREF IS 'Реф. сообщения';
COMMENT ON COLUMN BARS.SW_PROCQUE.KF IS '';




PROMPT *** Create  constraint CC_SWPROCQUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_PROCQUE MODIFY (KF CONSTRAINT CC_SWPROCQUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWPROCQUE_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_PROCQUE MODIFY (SWREF CONSTRAINT CC_SWPROCQUE_SWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWPROCQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_PROCQUE ADD CONSTRAINT PK_SWPROCQUE PRIMARY KEY (SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWPROCQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWPROCQUE ON BARS.SW_PROCQUE (SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_PROCQUE ***
grant SELECT                                                                 on SW_PROCQUE      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_PROCQUE      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_PROCQUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
