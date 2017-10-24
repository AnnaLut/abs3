prompt ----------------------------------------
prompt  создание java source IMPORT_FLAT_FILE 
prompt ----------------------------------------
/
CREATE OR REPLACE AND RESOLVE JAVA SOURCE NAMED BARS.IMPORT_FLAT_FILE as 
        import java.sql.CallableStatement;
        import java.sql.Connection;
        import java.sql.DriverManager;
        import java.sql.SQLException;
        import java.sql.Types;

        import oracle.sql.ARRAY;
        import oracle.sql.ArrayDescriptor;
        import oracle.sql.STRUCT;
        import oracle.sql.StructDescriptor;
        import oracle.jdbc.driver.*;
        import oracle.sql.CLOB;
        import java.io.*;

        import java.util.*;
        import java.util.Arrays;
        import java.util.List;

        import java.io.BufferedReader;
        import java.io.Reader;
        import java.io.StringReader;
        import java.lang.*;

public class ImportFile {

    public static void importf(oracle.sql.CLOB cont) throws SQLException,IOException {
        Connection con = null;
        CallableStatement callableStatement = null;
        try {
            StringBuffer buf;
            int length;
            String content;


            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = new OracleDriver().defaultConnection();
            String insertStoreProc = "{call insert_rows(?)}";
            callableStatement = con.prepareCall(insertStoreProc);
            String prev_line_split_result = "";
            final StructDescriptor structDescriptor = StructDescriptor.createDescriptor("FLAT_FILE_LINE", con);

            List<STRUCT> struct1 = new ArrayList<STRUCT>();
            if (cont != null) {
                Reader is = cont.getCharacterStream();
                BufferedReader bufReader = new BufferedReader(is);
                String line;
                int i = 0;
                while((line=bufReader.readLine()) != null){
                    STRUCT tmp = new STRUCT(structDescriptor,con,new Object[]{i, line});
                    struct1.add(tmp);
                    i++;
                    if (i%100000 == 0) {
                        write(con, callableStatement, struct1);
                    }
                }
                write(con, callableStatement, struct1);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                callableStatement.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private static void write(Connection con, CallableStatement callableStatement, List<STRUCT> struct1) throws SQLException {
        STRUCT[] struct_arr = struct1.toArray(new STRUCT[struct1.size()]);
        struct1.clear();
        ArrayDescriptor arrayDescriptor = ArrayDescriptor.createDescriptor("FLAT_FILE_LIST", con);
        ARRAY array_to_pass = new ARRAY(arrayDescriptor, con, struct_arr);
        callableStatement.setObject(1, array_to_pass, Types.ARRAY);
        callableStatement.execute();
    }
}
/
GRANT EXECUTE ON JAVA SOURCE BARS.IMPORT_FLAT_FILE TO bars_access_defrole;
/