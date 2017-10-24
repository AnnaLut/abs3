

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOMINAL_CHECK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOMINAL_CHECK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOMINAL_CHECK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NOMINAL_CHECK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NOMINAL_CHECK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOMINAL_CHECK ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOMINAL_CHECK 
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




PROMPT *** ALTER_POLICIES to NOMINAL_CHECK ***
 exec bpa.alter_policies('NOMINAL_CHECK');


COMMENT ON TABLE BARS.NOMINAL_CHECK IS 'Таблиця номiналiв дорожнiх чекiв';
COMMENT ON COLUMN BARS.NOMINAL_CHECK.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.NOMINAL_CHECK.NOMINAL IS 'Значення номiналу';




PROMPT *** Create  constraint PK_NOMINAL_CH_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOMINAL_CHECK ADD CONSTRAINT PK_NOMINAL_CH_KV PRIMARY KEY (KV, NOMINAL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOMINAL_CH_KV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOMINAL_CH_KV ON BARS.NOMINAL_CHECK (KV, NOMINAL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOMINAL_CHECK ***
grant SELECT                                                                 on NOMINAL_CHECK   to ABS_ADMIN;
grant SELECT                                                                 on NOMINAL_CHECK   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOMINAL_CHECK   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOMINAL_CHECK.sql =========*** End ***
PROMPT ===================================================================================== 
