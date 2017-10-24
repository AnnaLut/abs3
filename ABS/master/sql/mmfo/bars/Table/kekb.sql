

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KEKB.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KEKB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KEKB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KEKB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KEKB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KEKB ***
begin 
  execute immediate '
  CREATE TABLE BARS.KEKB 
   (	KEK CHAR(7), 
	KEKB NUMBER(38,0), 
	NAME VARCHAR2(60)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KEKB ***
 exec bpa.alter_policies('KEKB');


COMMENT ON TABLE BARS.KEKB IS '';
COMMENT ON COLUMN BARS.KEKB.KEK IS '';
COMMENT ON COLUMN BARS.KEKB.KEKB IS '';
COMMENT ON COLUMN BARS.KEKB.NAME IS '';




PROMPT *** Create  constraint SYS_C009781 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEKB MODIFY (KEKB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_KEKB ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEKB ADD CONSTRAINT XPK_KEKB PRIMARY KEY (KEKB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KEKB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KEKB ON BARS.KEKB (KEKB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KEKB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KEKB            to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KEKB            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KEKB.sql =========*** End *** ========
PROMPT ===================================================================================== 
