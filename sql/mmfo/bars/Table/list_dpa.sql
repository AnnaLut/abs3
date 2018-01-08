

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LIST_DPA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LIST_DPA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LIST_DPA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LIST_DPA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''LIST_DPA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LIST_DPA ***
begin 
  execute immediate '
  CREATE TABLE BARS.LIST_DPA 
   (	KOD VARCHAR2(10), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(38), 
	DAT_VKL DATE, 
	C_REG NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LIST_DPA ***
 exec bpa.alter_policies('LIST_DPA');


COMMENT ON TABLE BARS.LIST_DPA IS '';
COMMENT ON COLUMN BARS.LIST_DPA.KOD IS '';
COMMENT ON COLUMN BARS.LIST_DPA.RNK IS '';
COMMENT ON COLUMN BARS.LIST_DPA.NMK IS '';
COMMENT ON COLUMN BARS.LIST_DPA.DAT_VKL IS '';
COMMENT ON COLUMN BARS.LIST_DPA.C_REG IS '';




PROMPT *** Create  constraint XPK_LIST_DPA ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_DPA ADD CONSTRAINT XPK_LIST_DPA PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_LIST_DPA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_LIST_DPA ON BARS.LIST_DPA (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LIST_DPA ***
grant FLASHBACK,SELECT                                                       on LIST_DPA        to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on LIST_DPA        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LIST_DPA.sql =========*** End *** ====
PROMPT ===================================================================================== 
