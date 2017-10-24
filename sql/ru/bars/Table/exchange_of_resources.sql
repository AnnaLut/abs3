

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EXCHANGE_OF_RESOURCES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EXCHANGE_OF_RESOURCES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EXCHANGE_OF_RESOURCES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EXCHANGE_OF_RESOURCES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EXCHANGE_OF_RESOURCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.EXCHANGE_OF_RESOURCES 
   (	MFO VARCHAR2(6), 
	NLS2 VARCHAR2(14), 
	NLS_3902 VARCHAR2(14), 
	NLS_3903 VARCHAR2(14), 
	NLS_CCK_SOURCE VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EXCHANGE_OF_RESOURCES ***
 exec bpa.alter_policies('EXCHANGE_OF_RESOURCES');


COMMENT ON TABLE BARS.EXCHANGE_OF_RESOURCES IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.MFO IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.NLS2 IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.NLS_3902 IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.NLS_3903 IS '';
COMMENT ON COLUMN BARS.EXCHANGE_OF_RESOURCES.NLS_CCK_SOURCE IS 'Транзит 3739 для кредитных ресурсов';




PROMPT *** Create  constraint PK_EXCHANGE_OF_RESOURCES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EXCHANGE_OF_RESOURCES ADD CONSTRAINT PK_EXCHANGE_OF_RESOURCES PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EXCHANGE_OF_RESOURCES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EXCHANGE_OF_RESOURCES ON BARS.EXCHANGE_OF_RESOURCES (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EXCHANGE_OF_RESOURCES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EXCHANGE_OF_RESOURCES to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EXCHANGE_OF_RESOURCES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EXCHANGE_OF_RESOURCES.sql =========***
PROMPT ===================================================================================== 
