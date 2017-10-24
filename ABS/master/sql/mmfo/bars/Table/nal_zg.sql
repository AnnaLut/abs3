

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAL_ZG.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAL_ZG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NAL_ZG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NAL_ZG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NAL_ZG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAL_ZG ***
begin 
  execute immediate '
  CREATE TABLE BARS.NAL_ZG 
   (	ACC NUMBER, 
	ACCC NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAL_ZG ***
 exec bpa.alter_policies('NAL_ZG');


COMMENT ON TABLE BARS.NAL_ZG IS 'Раб таблица для хранения связей 6,7->8(НУ)';
COMMENT ON COLUMN BARS.NAL_ZG.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.NAL_ZG.ACCC IS 'Внутренний номер счета консолидации';




PROMPT *** Create  constraint SYS_C0012272 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_ZG ADD PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004898 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_ZG MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012272 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012272 ON BARS.NAL_ZG (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NAL_ZG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_ZG          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_ZG          to START1;



PROMPT *** Create SYNONYM  to NAL_ZG ***

  CREATE OR REPLACE PUBLIC SYNONYM NAL_ZG FOR BARS.NAL_ZG;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAL_ZG.sql =========*** End *** ======
PROMPT ===================================================================================== 
