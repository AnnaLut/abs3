

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEB_REG_NBS_NBU.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEB_REG_NBS_NBU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEB_REG_NBS_NBU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEB_REG_NBS_NBU'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEB_REG_NBS_NBU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEB_REG_NBS_NBU ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEB_REG_NBS_NBU 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEB_REG_NBS_NBU ***
 exec bpa.alter_policies('DEB_REG_NBS_NBU');


COMMENT ON TABLE BARS.DEB_REG_NBS_NBU IS '';
COMMENT ON COLUMN BARS.DEB_REG_NBS_NBU.NBS IS '';




PROMPT *** Create  constraint SYS_C009325 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_REG_NBS_NBU MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEB_REG_NBS_NBU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DEB_REG_NBS_NBU to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEB_REG_NBS_NBU to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEB_REG_NBS_NBU to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEB_REG_NBS_NBU.sql =========*** End *
PROMPT ===================================================================================== 
