

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_SPY_NBS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_SPY_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_SPY_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_SPY_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_SPY_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_SPY_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_SPY_NBS 
   (	CODE NUMBER(1,0), 
	NBS VARCHAR2(254)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_SPY_NBS ***
 exec bpa.alter_policies('DPA_SPY_NBS');


COMMENT ON TABLE BARS.DPA_SPY_NBS IS '';
COMMENT ON COLUMN BARS.DPA_SPY_NBS.CODE IS '';
COMMENT ON COLUMN BARS.DPA_SPY_NBS.NBS IS '';




PROMPT *** Create  constraint XPK_DPA_SPY_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_SPY_NBS ADD CONSTRAINT XPK_DPA_SPY_NBS PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DPA_SPY_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DPA_SPY_NBS ON BARS.DPA_SPY_NBS (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_SPY_NBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_SPY_NBS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPA_SPY_NBS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_SPY_NBS     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_SPY_NBS.sql =========*** End *** =
PROMPT ===================================================================================== 
