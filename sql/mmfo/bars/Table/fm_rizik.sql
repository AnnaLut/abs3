

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_RIZIK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_RIZIK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_RIZIK'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''FM_RIZIK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_RIZIK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_RIZIK ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_RIZIK 
   (	ID NUMBER, 
	NAME VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_RIZIK ***
 exec bpa.alter_policies('FM_RIZIK');


COMMENT ON TABLE BARS.FM_RIZIK IS 'Рівень ризику ФМ';
COMMENT ON COLUMN BARS.FM_RIZIK.ID IS '';
COMMENT ON COLUMN BARS.FM_RIZIK.NAME IS '';




PROMPT *** Create  constraint PK_FM_RIZIK_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_RIZIK ADD CONSTRAINT PK_FM_RIZIK_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FM_RIZIK_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FM_RIZIK_ID ON BARS.FM_RIZIK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_RIZIK ***
grant SELECT                                                                 on FM_RIZIK        to BARSREADER_ROLE;
grant SELECT                                                                 on FM_RIZIK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_RIZIK        to BARS_DM;
grant SELECT                                                                 on FM_RIZIK        to CUST001;
grant SELECT                                                                 on FM_RIZIK        to FINMON01;
grant SELECT                                                                 on FM_RIZIK        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_RIZIK.sql =========*** End *** ====
PROMPT ===================================================================================== 
