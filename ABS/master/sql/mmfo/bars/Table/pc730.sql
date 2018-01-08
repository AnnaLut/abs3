

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PC730.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PC730 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PC730'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PC730'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PC730'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PC730 ***
begin 
  execute immediate '
  CREATE TABLE BARS.PC730 
   (	NLS VARCHAR2(18), 
	KV NUMBER, 
	OST NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PC730 ***
 exec bpa.alter_policies('PC730');


COMMENT ON TABLE BARS.PC730 IS '';
COMMENT ON COLUMN BARS.PC730.NLS IS '';
COMMENT ON COLUMN BARS.PC730.KV IS '';
COMMENT ON COLUMN BARS.PC730.OST IS '';



PROMPT *** Create  grants  PC730 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PC730           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PC730           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PC730.sql =========*** End *** =======
PROMPT ===================================================================================== 
