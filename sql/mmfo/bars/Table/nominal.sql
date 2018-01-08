

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOMINAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOMINAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOMINAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NOMINAL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOMINAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOMINAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOMINAL 
   (	KV NUMBER(3,0), 
	NOMINAL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOMINAL ***
 exec bpa.alter_policies('NOMINAL');


COMMENT ON TABLE BARS.NOMINAL IS 'Таблиця номіналів';
COMMENT ON COLUMN BARS.NOMINAL.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.NOMINAL.NOMINAL IS 'Значення номіналу';




PROMPT *** Create  constraint PK_NOMINAL_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOMINAL ADD CONSTRAINT PK_NOMINAL_KV PRIMARY KEY (KV, NOMINAL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOMINAL_KV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOMINAL_KV ON BARS.NOMINAL (KV, NOMINAL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOMINAL ***
grant SELECT                                                                 on NOMINAL         to ABS_ADMIN;
grant SELECT                                                                 on NOMINAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOMINAL         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOMINAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
