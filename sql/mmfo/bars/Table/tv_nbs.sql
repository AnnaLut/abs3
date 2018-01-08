

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TV_NBS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TV_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TV_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TV_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TV_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TV_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TV_NBS 
   (	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TV_NBS ***
 exec bpa.alter_policies('TV_NBS');


COMMENT ON TABLE BARS.TV_NBS IS '';
COMMENT ON COLUMN BARS.TV_NBS.NBS IS '';




PROMPT *** Create  constraint R_PS_TV_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TV_NBS ADD CONSTRAINT R_PS_TV_NBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_TV_NBS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TV_NBS MODIFY (NBS CONSTRAINT NK_TV_NBS_NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TV_NBS ***
grant FLASHBACK,SELECT                                                       on TV_NBS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TV_NBS          to BARS_DM;
grant FLASHBACK,SELECT                                                       on TV_NBS          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TV_NBS.sql =========*** End *** ======
PROMPT ===================================================================================== 
