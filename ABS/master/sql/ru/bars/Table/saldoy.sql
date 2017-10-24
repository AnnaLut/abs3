

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDOY.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDOY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDOY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SALDOY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDOY ***
begin 
  execute immediate '
  CREATE TABLE BARS.SALDOY 
   (	ACC NUMBER, 
	FDAT DATE, 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDOY ***
 exec bpa.alter_policies('SALDOY');


COMMENT ON TABLE BARS.SALDOY IS '';
COMMENT ON COLUMN BARS.SALDOY.ACC IS '';
COMMENT ON COLUMN BARS.SALDOY.FDAT IS '';
COMMENT ON COLUMN BARS.SALDOY.DOS IS '';
COMMENT ON COLUMN BARS.SALDOY.KOS IS '';
COMMENT ON COLUMN BARS.SALDOY.DOSQ IS '';
COMMENT ON COLUMN BARS.SALDOY.KOSQ IS '';




PROMPT *** Create  constraint XPK_SALDOY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOY ADD CONSTRAINT XPK_SALDOY PRIMARY KEY (FDAT, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002999618 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOY MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002999617 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOY MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002999616 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOY MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002999615 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOY MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002999614 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOY MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_SALDOY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAK_SALDOY ON BARS.SALDOY (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SALDOY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SALDOY ON BARS.SALDOY (FDAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SALDOY ***
grant SELECT                                                                 on SALDOY          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALDOY          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDOY.sql =========*** End *** ======
PROMPT ===================================================================================== 
