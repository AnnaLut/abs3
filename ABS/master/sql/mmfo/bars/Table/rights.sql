

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RIGHTS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RIGHTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RIGHTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RIGHTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RIGHTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RIGHTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.RIGHTS 
   (	COD NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RIGHTS ***
 exec bpa.alter_policies('RIGHTS');


COMMENT ON TABLE BARS.RIGHTS IS '';
COMMENT ON COLUMN BARS.RIGHTS.COD IS '';
COMMENT ON COLUMN BARS.RIGHTS.NAME IS '';




PROMPT *** Create  constraint XPK_RIGHTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.RIGHTS ADD CONSTRAINT XPK_RIGHTS PRIMARY KEY (COD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009116 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RIGHTS MODIFY (COD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_RIGHTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_RIGHTS ON BARS.RIGHTS (COD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RIGHTS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RIGHTS          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RIGHTS          to RIGHTS;
grant FLASHBACK,SELECT                                                       on RIGHTS          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RIGHTS.sql =========*** End *** ======
PROMPT ===================================================================================== 
