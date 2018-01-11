

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LIC_NBS_DKSU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LIC_NBS_DKSU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LIC_NBS_DKSU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''LIC_NBS_DKSU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LIC_NBS_DKSU ***
begin 
  execute immediate '
  CREATE TABLE BARS.LIC_NBS_DKSU 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LIC_NBS_DKSU ***
 exec bpa.alter_policies('LIC_NBS_DKSU');


COMMENT ON TABLE BARS.LIC_NBS_DKSU IS '';
COMMENT ON COLUMN BARS.LIC_NBS_DKSU.NBS IS 'аюк.явер';




PROMPT *** Create  constraint PK_NBS_DKSU ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIC_NBS_DKSU ADD CONSTRAINT PK_NBS_DKSU PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBS_DKSU_LIC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBS_DKSU_LIC ON BARS.LIC_NBS_DKSU (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LIC_NBS_DKSU ***
grant INSERT,SELECT,UPDATE                                                   on LIC_NBS_DKSU    to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on LIC_NBS_DKSU    to START1;
grant SELECT                                                                 on LIC_NBS_DKSU    to UPLD;
grant FLASHBACK,SELECT                                                       on LIC_NBS_DKSU    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LIC_NBS_DKSU.sql =========*** End *** 
PROMPT ===================================================================================== 
