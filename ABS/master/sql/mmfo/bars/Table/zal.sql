

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAL.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAL 
   (	NU VARCHAR2(14), 
	NS VARCHAR2(15), 
	KV CHAR(10), 
	VID NUMBER(15,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAL ***
 exec bpa.alter_policies('ZAL');


COMMENT ON TABLE BARS.ZAL IS '';
COMMENT ON COLUMN BARS.ZAL.NU IS '';
COMMENT ON COLUMN BARS.ZAL.NS IS '';
COMMENT ON COLUMN BARS.ZAL.KV IS '';
COMMENT ON COLUMN BARS.ZAL.VID IS '';



PROMPT *** Create  grants  ZAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAL             to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAL             to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAL.sql =========*** End *** =========
PROMPT ===================================================================================== 
