

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SCALE_IMMOBILE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SCALE_IMMOBILE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SCALE_IMMOBILE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SCALE_IMMOBILE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SCALE_IMMOBILE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SCALE_IMMOBILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SCALE_IMMOBILE 
   (	KV NUMBER, 
	VAL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SCALE_IMMOBILE ***
 exec bpa.alter_policies('SCALE_IMMOBILE');


COMMENT ON TABLE BARS.SCALE_IMMOBILE IS '';
COMMENT ON COLUMN BARS.SCALE_IMMOBILE.KV IS '';
COMMENT ON COLUMN BARS.SCALE_IMMOBILE.VAL IS '';




PROMPT *** Create  constraint PK_SCALE_IMMOBILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SCALE_IMMOBILE ADD CONSTRAINT PK_SCALE_IMMOBILE PRIMARY KEY (KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SCALE_IMMOBILE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SCALE_IMMOBILE ON BARS.SCALE_IMMOBILE (KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SCALE_IMMOBILE ***
grant INSERT,SELECT,UPDATE                                                   on SCALE_IMMOBILE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SCALE_IMMOBILE  to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on SCALE_IMMOBILE  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SCALE_IMMOBILE.sql =========*** End **
PROMPT ===================================================================================== 
