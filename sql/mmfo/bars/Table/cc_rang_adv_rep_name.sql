

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_RANG_ADV_REP_NAME.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_RANG_ADV_REP_NAME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_RANG_ADV_REP_NAME'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_RANG_ADV_REP_NAME'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_RANG_ADV_REP_NAME'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_RANG_ADV_REP_NAME ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_RANG_ADV_REP_NAME 
   (	BLK NUMBER, 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_RANG_ADV_REP_NAME ***
 exec bpa.alter_policies('CC_RANG_ADV_REP_NAME');


COMMENT ON TABLE BARS.CC_RANG_ADV_REP_NAME IS 'Період погашения платежей';
COMMENT ON COLUMN BARS.CC_RANG_ADV_REP_NAME.BLK IS 'Ідентификатор';
COMMENT ON COLUMN BARS.CC_RANG_ADV_REP_NAME.NAME IS 'Тип способу періодичності';




PROMPT *** Create  constraint CC_RANG_ADV_REP_NAME_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_RANG_ADV_REP_NAME ADD CONSTRAINT CC_RANG_ADV_REP_NAME_PK PRIMARY KEY (BLK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_RANG_ADV_REP_NAME_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_RANG_ADV_REP_NAME_PK ON BARS.CC_RANG_ADV_REP_NAME (BLK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_RANG_ADV_REP_NAME ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RANG_ADV_REP_NAME to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_RANG_ADV_REP_NAME to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_RANG_ADV_REP_NAME to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_RANG_ADV_REP_NAME.sql =========*** 
PROMPT ===================================================================================== 
