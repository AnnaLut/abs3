

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T383.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T383 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T383'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''T383'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T383'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T383 ***
begin 
  execute immediate '
  CREATE TABLE BARS.T383 
   (	ACC NUMBER, 
	NLS VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T383 ***
 exec bpa.alter_policies('T383');


COMMENT ON TABLE BARS.T383 IS '';
COMMENT ON COLUMN BARS.T383.ACC IS '';
COMMENT ON COLUMN BARS.T383.NLS IS '';



PROMPT *** Create  grants  T383 ***
grant SELECT                                                                 on T383            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on T383            to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on T383            to START1;
grant SELECT                                                                 on T383            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T383.sql =========*** End *** ========
PROMPT ===================================================================================== 
