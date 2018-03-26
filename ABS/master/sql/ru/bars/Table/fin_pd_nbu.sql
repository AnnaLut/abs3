

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_PD_NBU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_PD_NBU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_PD_NBU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_PD_NBU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_PD_NBU ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_PD_NBU 
   (	IDF NUMBER(*,0), 
	FIN NUMBER(2,0), 
	VED NUMBER, 
	K_MIN NUMBER, 
	K_MAX NUMBER, 
	K_AVER NUMBER, 
	DATE_BEGIN DATE, 
	DATE_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_PD_NBU ***
 exec bpa.alter_policies('FIN_PD_NBU');


COMMENT ON TABLE BARS.FIN_PD_NBU IS '';
COMMENT ON COLUMN BARS.FIN_PD_NBU.IDF IS '';
COMMENT ON COLUMN BARS.FIN_PD_NBU.FIN IS '';
COMMENT ON COLUMN BARS.FIN_PD_NBU.VED IS '';
COMMENT ON COLUMN BARS.FIN_PD_NBU.K_MIN IS '';
COMMENT ON COLUMN BARS.FIN_PD_NBU.K_MAX IS '';
COMMENT ON COLUMN BARS.FIN_PD_NBU.K_AVER IS '';
COMMENT ON COLUMN BARS.FIN_PD_NBU.DATE_BEGIN IS '';
COMMENT ON COLUMN BARS.FIN_PD_NBU.DATE_CLOSE IS '';




PROMPT *** Create  constraint PK_FIN_PD_NBU ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_PD_NBU ADD CONSTRAINT PK_FIN_PD_NBU PRIMARY KEY (IDF, FIN, VED, DATE_BEGIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FIN_PD_NBU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FIN_PD_NBU ON BARS.FIN_PD_NBU (IDF, FIN, VED, DATE_BEGIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_PD_NBU.sql =========*** End *** ==
PROMPT ===================================================================================== 
