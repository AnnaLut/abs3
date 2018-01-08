

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NI.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NI ***
begin 
  execute immediate '
  CREATE TABLE BARS.NI 
   (	NBS CHAR(4)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NI ***
 exec bpa.alter_policies('NI');


COMMENT ON TABLE BARS.NI IS '';
COMMENT ON COLUMN BARS.NI.NBS IS '';




PROMPT *** Create  constraint XPK_NI ***
begin   
 execute immediate '
  ALTER TABLE BARS.NI ADD CONSTRAINT XPK_NI PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PS_NI ***
begin   
 execute immediate '
  ALTER TABLE BARS.NI ADD CONSTRAINT R_PS_NI FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009949 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NI MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NI ON BARS.NI (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NI ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NI              to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NI              to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NI.sql =========*** End *** ==========
PROMPT ===================================================================================== 
