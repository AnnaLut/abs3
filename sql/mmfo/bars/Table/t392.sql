

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T392.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T392 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T392'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''T392'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T392'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T392 ***
begin 
  execute immediate '
  CREATE TABLE BARS.T392 
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




PROMPT *** ALTER_POLICIES to T392 ***
 exec bpa.alter_policies('T392');


COMMENT ON TABLE BARS.T392 IS '';
COMMENT ON COLUMN BARS.T392.ACC IS '';
COMMENT ON COLUMN BARS.T392.NLS IS '';



PROMPT *** Create  grants  T392 ***
grant SELECT                                                                 on T392            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on T392            to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on T392            to START1;
grant SELECT                                                                 on T392            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T392.sql =========*** End *** ========
PROMPT ===================================================================================== 
