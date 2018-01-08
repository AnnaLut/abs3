

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TYPECOMM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TYPECOMM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TYPECOMM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TYPECOMM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TYPECOMM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TYPECOMM ***
begin 
  execute immediate '
  CREATE TABLE BARS.TYPECOMM 
   (	TYPECOMM NUMBER(*,0), 
	NAME VARCHAR2(35), 
	TYPE NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TYPECOMM ***
 exec bpa.alter_policies('TYPECOMM');


COMMENT ON TABLE BARS.TYPECOMM IS '';
COMMENT ON COLUMN BARS.TYPECOMM.TYPECOMM IS '';
COMMENT ON COLUMN BARS.TYPECOMM.NAME IS '';
COMMENT ON COLUMN BARS.TYPECOMM.TYPE IS '';




PROMPT *** Create  constraint XPK_TYPECOMM ***
begin   
 execute immediate '
  ALTER TABLE BARS.TYPECOMM ADD CONSTRAINT XPK_TYPECOMM PRIMARY KEY (TYPECOMM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005146 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TYPECOMM MODIFY (TYPECOMM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TYPECOMM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TYPECOMM ON BARS.TYPECOMM (TYPECOMM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TYPECOMM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TYPECOMM        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TYPECOMM        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TYPECOMM.sql =========*** End *** ====
PROMPT ===================================================================================== 
