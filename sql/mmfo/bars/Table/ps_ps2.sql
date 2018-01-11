

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PS_PS2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PS_PS2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PS_PS2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PS_PS2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PS_PS2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PS_PS2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.PS_PS2 
   (	NBS CHAR(4), 
	NBS2 CHAR(4)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PS_PS2 ***
 exec bpa.alter_policies('PS_PS2');


COMMENT ON TABLE BARS.PS_PS2 IS '';
COMMENT ON COLUMN BARS.PS_PS2.NBS IS '';
COMMENT ON COLUMN BARS.PS_PS2.NBS2 IS '';



PROMPT *** Create  grants  PS_PS2 ***
grant SELECT                                                                 on PS_PS2          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PS_PS2          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PS_PS2          to START1;
grant SELECT                                                                 on PS_PS2          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PS_PS2.sql =========*** End *** ======
PROMPT ===================================================================================== 
