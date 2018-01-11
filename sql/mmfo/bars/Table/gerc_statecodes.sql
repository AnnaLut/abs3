

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GERC_STATECODES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GERC_STATECODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GERC_STATECODES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GERC_STATECODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GERC_STATECODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.GERC_STATECODES 
   (	ID NUMBER(*,0), 
	STATE VARCHAR2(70)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GERC_STATECODES ***
 exec bpa.alter_policies('GERC_STATECODES');


COMMENT ON TABLE BARS.GERC_STATECODES IS 'Код обработки операций ГЕРЦ';
COMMENT ON COLUMN BARS.GERC_STATECODES.ID IS 'Код';
COMMENT ON COLUMN BARS.GERC_STATECODES.STATE IS 'Описние кода обработки';




PROMPT *** Create  constraint PK_GERC_STATECODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GERC_STATECODES ADD CONSTRAINT PK_GERC_STATECODES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GERC_STATECODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GERC_STATECODES ON BARS.GERC_STATECODES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GERC_STATECODES ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on GERC_STATECODES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GERC_STATECODES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GERC_STATECODES.sql =========*** End *
PROMPT ===================================================================================== 
