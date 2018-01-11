

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LIE_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LIE_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LIE_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LIE_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''LIE_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LIE_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.LIE_NBS 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LIE_NBS ***
 exec bpa.alter_policies('LIE_NBS');


COMMENT ON TABLE BARS.LIE_NBS IS '';
COMMENT ON COLUMN BARS.LIE_NBS.NBS IS '';




PROMPT *** Create  constraint PK_LIE_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIE_NBS ADD CONSTRAINT PK_LIE_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LIE_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LIE_NBS ON BARS.LIE_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LIE_NBS ***
grant SELECT                                                                 on LIE_NBS         to BARSREADER_ROLE;
grant SELECT                                                                 on LIE_NBS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LIE_NBS         to BARS_DM;
grant SELECT                                                                 on LIE_NBS         to START1;
grant SELECT                                                                 on LIE_NBS         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LIE_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
