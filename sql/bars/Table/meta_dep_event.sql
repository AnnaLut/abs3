

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_DEP_EVENT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_DEP_EVENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_DEP_EVENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_DEP_EVENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_DEP_EVENT 
   (	EVENT VARCHAR2(100), 
	DESCRIPTION VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_DEP_EVENT ***
 exec bpa.alter_policies('META_DEP_EVENT');


COMMENT ON TABLE BARS.META_DEP_EVENT IS '';
COMMENT ON COLUMN BARS.META_DEP_EVENT.EVENT IS '“ËÔ ÔÓ‰≥ø';
COMMENT ON COLUMN BARS.META_DEP_EVENT.DESCRIPTION IS '';




PROMPT *** Create  constraint PK_META_DEP_EVENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEP_EVENT ADD CONSTRAINT PK_META_DEP_EVENT PRIMARY KEY (EVENT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003215275 ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEP_EVENT MODIFY (EVENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_META_DEP_EVENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_META_DEP_EVENT ON BARS.META_DEP_EVENT (EVENT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_DEP_EVENT ***
grant SELECT                                                                 on META_DEP_EVENT  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_DEP_EVENT.sql =========*** End **
PROMPT ===================================================================================== 
