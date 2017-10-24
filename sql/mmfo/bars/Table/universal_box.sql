

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/UNIVERSAL_BOX.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to UNIVERSAL_BOX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''UNIVERSAL_BOX'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''UNIVERSAL_BOX'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''UNIVERSAL_BOX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table UNIVERSAL_BOX ***
begin 
  execute immediate '
  CREATE TABLE BARS.UNIVERSAL_BOX 
   (	ID NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to UNIVERSAL_BOX ***
 exec bpa.alter_policies('UNIVERSAL_BOX');


COMMENT ON TABLE BARS.UNIVERSAL_BOX IS '';
COMMENT ON COLUMN BARS.UNIVERSAL_BOX.ID IS '';




PROMPT *** Create  constraint FK_UNIVERSALBOX_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.UNIVERSAL_BOX ADD CONSTRAINT FK_UNIVERSALBOX_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009633 ***
begin   
 execute immediate '
  ALTER TABLE BARS.UNIVERSAL_BOX MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UNIVERSAL_BOX_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.UNIVERSAL_BOX ADD CONSTRAINT UNIVERSAL_BOX_PK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UNIVERSAL_BOX_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UNIVERSAL_BOX_PK ON BARS.UNIVERSAL_BOX (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UNIVERSAL_BOX ***
grant INSERT,SELECT,UPDATE                                                   on UNIVERSAL_BOX   to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on UNIVERSAL_BOX   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on UNIVERSAL_BOX   to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on UNIVERSAL_BOX   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on UNIVERSAL_BOX   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on UNIVERSAL_BOX   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/UNIVERSAL_BOX.sql =========*** End ***
PROMPT ===================================================================================== 
