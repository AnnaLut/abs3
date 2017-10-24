

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IGRAK.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IGRAK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IGRAK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IGRAK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IGRAK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IGRAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.IGRAK 
   (	KV NUMBER(*,0), 
	RATE_O NUMBER(12,6), 
	BSUM NUMBER(38,0), 
	VDATE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IGRAK ***
 exec bpa.alter_policies('IGRAK');


COMMENT ON TABLE BARS.IGRAK IS '';
COMMENT ON COLUMN BARS.IGRAK.KV IS '';
COMMENT ON COLUMN BARS.IGRAK.RATE_O IS '';
COMMENT ON COLUMN BARS.IGRAK.BSUM IS '';
COMMENT ON COLUMN BARS.IGRAK.VDATE IS '';




PROMPT *** Create  constraint NK_IGRAK_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.IGRAK MODIFY (KV CONSTRAINT NK_IGRAK_KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IGRAK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on IGRAK           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IGRAK           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on IGRAK           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IGRAK.sql =========*** End *** =======
PROMPT ===================================================================================== 
