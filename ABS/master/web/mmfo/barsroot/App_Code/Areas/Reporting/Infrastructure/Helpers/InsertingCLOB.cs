//using System;
//using System.IO;
//using System.Data;
//using Oracle.DataAccess.Types;
//using Oracle.DataAccess.Client;
//using System.Text;
//// LobExample
//public class LobExample
//{
//   public static int Main(string[] args)
//   {
//      //Create a connection.
//      OracleConnection conn = new OracleConnection(
//         "Data Source=Oracle8i;Integrated Security=yes");
//      using(conn)
//      {
//         //Open a connection.
//         conn.Open();
//         OracleCommand cmd = conn.CreateCommand();

//         //Create the table and schema.
//         CreateTable(cmd);

//         //Read example.
//         ReadLobExample(cmd);

//         //Write example
//         WriteLobExample(cmd);
//      }

//      return 1;
//   }

//   // ReadLobExample
//   public static void ReadLobExample(OracleCommand cmd)
//   {
//      int actual = 0;

//      // Table Schema:
//      // "CREATE TABLE tablewithlobs (a int, b BLOB, c CLOB, d NCLOB)";
//      // "INSERT INTO tablewithlobs values (1, 'AA', 'AAA', N'AAAA')";
//      // Select some data.
//      cmd.CommandText = "SELECT * FROM tablewithlobs";
//      OracleDataReader reader = cmd.ExecuteReader();
//      using(reader)
//      {
//         //Obtain the first row of data.
//         reader.Read();
         
//         //Obtain the LOBs (all 3 varieties).
     

//         //Example - Reading binary data (in chunks).
//         byte[] buffer = new byte[100];
//         while((actual = blob.Read(buffer, 0, buffer.Length)) >0)
//            Console.WriteLine(blob.LobType + ".Read(" + buffer + ", " + 
//              buffer.Length + ") => " + actual);
//          OracleClob clob;
//         // Example - Reading CLOB/NCLOB data (in chunks).
//         // Note: You can read character data as raw Unicode bytes 
//         // (using OracleLob.Read as in the above example).
//         // However, because the OracleLob object inherits directly 
//         // from the .Net stream object, 
//         // all the existing classes that manipluate streams can 
//         // also be used. For example, the 
//         // .Net StreamReader makes it easier to convert the raw bytes 
//         // into actual characters.
//         StreamReader streamreader = 
//           new StreamReader(clob, Encoding.Unicode);
//         char[] cbuffer = new char[100];
//         while((actual = streamreader.Read(cbuffer, 
//           0, cbuffer.Length)) >0)
//            Console.WriteLine(clob.LobType + ".Read(
//              " + new string(cbuffer, 0, actual) + ", " + 
//              cbuffer.Length + ") => " + actual);

//         // Example - Reading data (all at once).
//         // You could use StreamReader.ReadToEnd to obtain 
//         // all the string data, or simply
//         // call OracleLob.Value to obtain a contiguous allocation 
//         // of all the data.
//         Console.WriteLine(nclob.LobType + ".Value => " + nclob.Value);
//      }
//   }

//   // WriteLobExample
//   public static void WriteLobExample(OracleCommand cmd)
//   {
//      //Note: Updating LOB data requires a transaction.
//      cmd.Transaction = cmd.Connection.BeginTransaction();
      
//      // Select some data.
//      // Table Schema:
//      // "CREATE TABLE tablewithlobs (a int, b BLOB, c CLOB, d NCLOB)";
//      // "INSERT INTO tablewithlobs values (1, 'AA', 'AAA', N'AAAA')";
//      cmd.CommandText = "SELECT * FROM tablewithlobs FOR UPDATE";
//      OracleDataReader reader = cmd.ExecuteReader();
//      using(reader)
//      {
//         // Obtain the first row of data.
//         reader.Read();

//         // Obtain a LOB.
//         OracleLob blob = reader.GetOracleLob(1/*0:based ordinal*/);

//         // Perform any desired operations on the LOB 
//         // (read, position, and so on).

//         // Example - Writing binary data (directly to the backend).
//         // To write, you can use any of the stream classes, or write
//         // raw binary data using 
//         // the OracleLob write method. Writing character vs. binary 
//         // is the same;
//         // however note that character is always in terms of 
//         // Unicode byte counts
//         // (for example, even number of bytes - 2 bytes for every
//         // Unicode character).
//         byte[] buffer = new byte[100];
//         buffer[0] = 0xCC;
//         buffer[1] = 0xDD;
//         blob.Write(buffer, 0, 2);
//         blob.Position = 0;
//         Console.WriteLine(blob.LobType + ".Write(
//           " + buffer + ", 0, 2) => " + blob.Value);
         
//         // Example - Obtaining a temp LOB and copying data 
//         // into it from another LOB.
//         OracleLob templob = CreateTempLob(cmd, blob.LobType);
//         long actual = blob.CopyTo(templob);
//         Console.WriteLine(blob.LobType + ".CopyTo(
//            " + templob.Value + ") => " + actual);

//         // Commit the transaction now that everything succeeded.
//         // Note: On error, Transaction.Dispose is called 
//         // (from the using statement)
//         // and will automatically roll back the pending transaction.
//         cmd.Transaction.Commit();
//      }
//   }

//   // CreateTempLob
//   public static OracleLob CreateTempLob(
//     OracleCommand cmd, OracleType lobtype)
//   {
//      //Oracle server syntax to obtain a temporary LOB.
//      cmd.CommandText = "DECLARE A " + lobtype + "; "+
//                     "BEGIN "+
//                        "DBMS_LOB.CREATETEMPORARY(A, FALSE); "+
//                        ":LOC := A; "+
//                     "END;";
      
//      //Bind the LOB as an output parameter.
//      OracleParameter p = cmd.Parameters.Add("LOC", lobtype);
//      p.Direction = ParameterDirection.Output;

//      //Execute (to receive the output temporary LOB).
//      cmd.ExecuteNonQuery();

//      //Return the temporary LOB.
//      return (OracleLob)p.Value;
//   }

//   // CreateTable
//   public static void CreateTable(OracleCommand cmd)
//   {
//      // Table Schema:
//      // "CREATE TABLE tablewithlobs (a int, b BLOB, c CLOB, d NCLOB)";
//      // "INSERT INTO tablewithlobs VALUES (1, 'AA', 'AAA', N'AAAA')";
//      try
//      {
//         cmd.CommandText   = "DROP TABLE tablewithlobs";
//         cmd.ExecuteNonQuery();
//      }
//      catch(Exception)
//      {
//      }
      
//      cmd.CommandText = 
//        "CREATE TABLE tablewithlobs (a int, b BLOB, c CLOB, d NCLOB)";
//      cmd.ExecuteNonQuery();
//      cmd.CommandText = 
//        "INSERT INTO tablewithlobs VALUES (1, 'AA', 'AAA', N'AAAA')";
//      cmd.ExecuteNonQuery();
//   }
//}